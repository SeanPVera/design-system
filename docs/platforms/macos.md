# macOS

Primary native utility platform. The macOS app (`1132 Fixer`) implements **The Repair Record** single-workspace design specified below and in [`../tokens/macos.json`](../tokens/macos.json). Historical screenshots (`screenshots/mac/main.png`, `screenshots/mac/report-bug.png`) record the earlier card-based baseline.

## Workspace composition ("The Repair Record")

One main window (`900×760` pt default, `720×640` pt minimum, single content column capped at `960pt` with `24pt` outer margins) with supporting native sheets, ordered vertically:
1. **Compact native identity and Help access** (`16/22` Semibold title, version badge, update availability, Help menu/popover with GitHub and Website links).
2. **Readiness summary or current repair outcome** (`24/30` Semibold heading + contextual summary, pinned above scrolling records).
3. **Selected Zoom installation** (`Choose…`, conditional `Use default`, off-UI-thread `Verifying Zoom…`, selectable full path, and local rejection notice).
4. **Ordered 9-step repair record** (`validate`, `closeZoom`, `backup`, `network`, `resetData`, `dns`, `updaters`, `mediaAccess`, `launch`) with expandable detail, `44pt` minimum row height, `0pt` row corner radius separated by `1pt` `border` rules, and responsive 4-column layout at `>= 840pt` content width (stacking effect below operation below `840pt`).
5. **Persistent action area** (`Run checks` secondary with *"Checks only; no repair changes."*, `Review repair…` primary with disabled reason when blocked, `Stop repair` / `Stopping…` during active repair, and per-run backup provenance with `Reveal Backup`).
6. **Support access bar** (`System check details`, `Activity Log`, `Export Diagnostics`, and `Report a Bug`).

Do not use oversized identity banners, large action cards, static compatibility pills, a permanently expanded empty log panel, sidebars, tab bars, decorative gradients, or glass effects.

## Chrome

- **Native titlebar** — preserve the standard macOS window titlebar and traffic-light controls.
- **Native menus & sheets** — place GitHub and Website in the macOS `Help` menu (as well as compact in-window Help access) and use native `.sheet` presentation (`surface-modal` `#2A2530`) for repair review, system check details, activity log, and bug reporting.

## Tokens & static Swift mirror

- Canonical macOS token overlay lives in [`../tokens/macos.json`](../tokens/macos.json) (see [`../02-colors.md`](../02-colors.md) § macOS shipped palette and [`../03-typography.md`](../03-typography.md) § macOS Repair Record scale).
- The SwiftUI executable mirrors these tokens statically in `Sources/1132Fixer/Theme.swift` without runtime JSON loading, verified by automated tests against `design-system/tokens/macos.json`.

## Icons

- **SF Symbols exception:** functional macOS controls and status indicators use native **SF Symbols** paired with explicit text labels (see [`../06-icons.md`](../06-icons.md)). Remove decorative section-heading icons.
- **Brand assets:** Dock/app icon uses `assets/1132-Fixer-App-Icon-1024x1024@1x.png` (`Sources/1132Fixer/Resources/AppIcon.png`).

## Sandboxing / security boundaries

The app verifies `zoom.us.app` (bundle name, strict codesign, Team ID `BJ4HAAB9B3`, executable containment, symlink checks), validates the exact required `sandbox-exec` profile before closing or mutating Zoom, performs unprivileged local data backup and reset in the user's home directory, scopes `osascript` administrator privileges strictly to network identity and DNS cache operations, and always launches Zoom via `sandbox-exec`.
