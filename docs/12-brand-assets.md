# Brand Asset Distribution

`assets/` and `assets/exports/` are the only sources of shipped brand artwork. Consumer repositories must not edit exported copies directly.

Each consumer keeps a `.brand-assets.tsv` mapping from a canonical file in this repository to every shipped destination. Run this from the consumer root after updating the submodule:

```sh
design-system/scripts/brand-assets.sh sync . .brand-assets.tsv
```

CI runs the same command in `check` mode. It fails when the submodule or either base asset is missing or empty, when a mapped surface is missing, when any byte differs from its canonical export, or when a likely brand asset is tracked without a manifest entry.

All favicons, app icons, header logos, installer icons, social images, and future branded surfaces must be added here first, then mapped in the consumer manifest. Brand and design paths are CODEOWNED; repository branch protection must require Code Owner approval for the default branch.

## Consumer update automation

`.github/workflows/sync-consumers.yml` runs after each push to `main` and can also be started manually. It pins each consumer to the triggering design-system commit, synchronizes their mapped assets, and opens or updates an `automation/design-system-sync` pull request. Review and consumer CI remain required before merge.

**Consumers.** In this repository (`SeanPVera/design-system`) the only consumer is the macOS app, `SeanPVera/1132-fixer` (public). The Windows, browser and website apps are not part of this fork. To add consumers, set the repository variable `DESIGN_SYSTEM_SYNC_CONSUMERS` to a JSON array, for example `[{"repository":"1132-fixer","platform":"macos"}]` (repository names only; the owner is this repository's owner; `platform` is `macos`, `windows`, `browser` or `website`). The `resolve` job checks every configured repository exists and is readable before any checkout, and fails with an explanation otherwise (`scripts/resolve-sync-consumers.sh`, tested by `scripts/tests/resolve-sync-consumers.test.sh`). Each consumer's `design-system` submodule must point at this repository.

**Credentials.** Preparation reads public consumers without credentials. Publishing needs write access to another repository, which the default `GITHUB_TOKEN` cannot provide, so it uses a GitHub App. Install it on this repository and every consumer with **Contents: read and write** and **Pull requests: read and write**, then configure:

- Repository variable `DESIGN_SYSTEM_SYNC_APP_CLIENT_ID`
- Repository secret `DESIGN_SYSTEM_SYNC_APP_PRIVATE_KEY`

If changes are ready but these are not configured, the publish job fails with an explicit error instead of attempting the push.

The built-in `GITHUB_TOKEN` is intentionally not used because it is limited to this repository.
