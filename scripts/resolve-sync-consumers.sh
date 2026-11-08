#!/usr/bin/env bash
# Resolve the consumer repositories that sync-consumers.yml should update.
#
# Input (environment):
#   OWNER                 repository owner (github.repository_owner)
#   SYNC_CONSUMERS_JSON   optional JSON array of {"repository": "<name>", "platform": "<macos|windows|browser|website>"}
#                         (from the DESIGN_SYSTEM_SYNC_CONSUMERS repository variable). Empty -> default.
#   GH_TOKEN              read-only token used only to confirm each repository is reachable.
# Output: a compact JSON matrix array on stdout. Exits non-zero, with an explanation,
# when the configuration is malformed or a configured repository is missing or not
# accessible, so a bad target is reported instead of silently skipped.
set -euo pipefail

# This fork has a single consumer: the macOS app at <owner>/1132-fixer.
DEFAULT_CONSUMERS='[{"repository":"1132-fixer","platform":"macos"}]'

: "${OWNER:?OWNER is required}"
config="${SYNC_CONSUMERS_JSON:-}"
[[ -n "${config//[[:space:]]/}" ]] || config="$DEFAULT_CONSUMERS"

matrix="$(CONFIG="$config" python3 - <<'PY'
import json, os, re, sys
try:
    data = json.loads(os.environ["CONFIG"])
except json.JSONDecodeError as exc:
    sys.exit(f"DESIGN_SYSTEM_SYNC_CONSUMERS is not valid JSON: {exc}")
if not isinstance(data, list) or not data:
    sys.exit("DESIGN_SYSTEM_SYNC_CONSUMERS must be a non-empty JSON array")
seen, out = set(), []
for entry in data:
    if not isinstance(entry, dict):
        sys.exit("Each consumer must be an object with repository and platform")
    repo, platform = entry.get("repository"), entry.get("platform")
    if not isinstance(repo, str) or not re.fullmatch(r"[A-Za-z0-9._-]+", repo) or repo in (".", ".."):
        sys.exit(f"Invalid consumer repository name: {repo!r} (name only, no owner)")
    if platform not in ("macos", "windows", "browser", "website"):
        sys.exit(f"Invalid platform for {repo}: {platform!r}")
    if repo in seen:
        sys.exit(f"Duplicate consumer repository: {repo}")
    seen.add(repo)
    out.append({"repository": repo, "platform": platform})
print(json.dumps(out, separators=(",", ":")))
PY
)"

missing=0
while IFS= read -r repo; do
  if ! gh api "repos/$OWNER/$repo" --jq .full_name >/dev/null 2>&1; then
    echo "Consumer $OWNER/$repo was not found or is not readable with the workflow token." >&2
    missing=1
  fi
done < <(MATRIX="$matrix" python3 -c 'import json,os; [print(e["repository"]) for e in json.loads(os.environ["MATRIX"])]')

if [[ $missing -ne 0 ]]; then
  echo "Fix DESIGN_SYSTEM_SYNC_CONSUMERS (or the default in scripts/resolve-sync-consumers.sh)." >&2
  exit 1
fi
printf '%s\n' "$matrix"
