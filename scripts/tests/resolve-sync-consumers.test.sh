#!/usr/bin/env bash
# Fixture tests for resolve-sync-consumers.sh. A stub `gh` stands in for the API;
# only repositories listed in STUB_EXISTING "exist". No network access.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
script="$here/../resolve-sync-consumers.sh"
stub="$(mktemp -d)"; trap 'rm -rf "$stub"' EXIT
cat > "$stub/gh" <<'GH'
#!/usr/bin/env bash
# usage: gh api repos/<owner>/<name> --jq ...
name="${2##*/}"
for r in $STUB_EXISTING; do [[ "$r" == "$name" ]] && { echo "x/$name"; exit 0; }; done
echo '{"message":"Not Found"}' >&2; exit 1
GH
chmod +x "$stub/gh"
export PATH="$stub:$PATH" OWNER=SeanPVera
fails=0
expect_ok() { local want="$1"; shift; local got; if got="$(env "$@" "$script" 2>/dev/null)" && [[ "$got" == "$want" ]]; then echo "ok   $*"; else echo "FAIL $* -> ${got:-<error>}"; fails=1; fi; }
expect_err() { local pattern="$1"; shift; local err; if err="$(env "$@" "$script" 2>&1 >/dev/null)"; then echo "FAIL (expected error) $*"; fails=1; elif grep -q "$pattern" <<<"$err"; then echo "ok   error: $pattern"; else echo "FAIL wrong error: $err"; fails=1; fi; }

expect_ok '[{"repository":"1132-fixer","platform":"macos"}]' STUB_EXISTING=1132-fixer SYNC_CONSUMERS_JSON=
expect_ok '[{"repository":"1132-fixer","platform":"macos"}]' STUB_EXISTING=1132-fixer "SYNC_CONSUMERS_JSON=  "
expect_ok '[{"repository":"1132-fixer","platform":"macos"},{"repository":"win","platform":"windows"}]' "STUB_EXISTING=1132-fixer win" 'SYNC_CONSUMERS_JSON=[{"repository":"1132-fixer","platform":"macos"},{"repository":"win","platform":"windows"}]'
expect_err "SeanPVera/macos was not found" STUB_EXISTING=1132-fixer 'SYNC_CONSUMERS_JSON=[{"repository":"macos","platform":"macos"}]'
expect_err "1132-fixer was not found" STUB_EXISTING= SYNC_CONSUMERS_JSON=
expect_err "not valid JSON" STUB_EXISTING=1132-fixer 'SYNC_CONSUMERS_JSON=[oops'
expect_err "non-empty JSON array" STUB_EXISTING=1132-fixer 'SYNC_CONSUMERS_JSON=[]'
expect_err "Invalid consumer repository name" STUB_EXISTING=1132-fixer 'SYNC_CONSUMERS_JSON=[{"repository":"other/1132-fixer","platform":"macos"}]'
expect_err "Invalid platform" STUB_EXISTING=1132-fixer 'SYNC_CONSUMERS_JSON=[{"repository":"1132-fixer","platform":"linux"}]'
expect_err "Duplicate consumer" STUB_EXISTING=1132-fixer 'SYNC_CONSUMERS_JSON=[{"repository":"1132-fixer","platform":"macos"},{"repository":"1132-fixer","platform":"macos"}]'
exit $fails
