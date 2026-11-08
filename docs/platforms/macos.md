# macOS

Primary native utility platform. The macOS app (`1132 Fixer`) implements **The Repair Record** workspace in the **Signal** skin (graphite and amber), as specified below and in [`../tokens/macos.json`](../tokens/macos.json). Historical screenshots (`screenshots/mac/main.png`, `screenshots/mac/report-bug.png`) record the earlier card-based baseline, not the current design.

## Workspace composition ("The Repair Record", Signal)

One main window: `900×760` pt by default, `720×640` pt minimum, with `24pt` outer margins and the main column capped at `960pt`.

### Regions

| Region | Anatomy |
|---|---|
| **Preflight sidebar** (leading, `window.sidebarWidth` 264pt, `surface`) | `System checks` heading (re-running stays in the status summary's `Recheck`, so there is no duplicate control). One row per live check: a status symbol (pass `checkmark.circle.fill`, warning `exclamationmark.triangle.fill`, blocking `xmark.octagon.fill`), the label (`label`) and the value (`metadata`, 2 lines max). Then the `System check details` link, the Zoom installation panel, and the `Support` links (`Activity log (n)`, `Export diagnostics…`, `Report a bug…`). |
| **Stage header** (pinned at the top of the main column) | Compact identity: the app icon at `identity.iconSize` (28pt, loaded from the shipped `AppIcon.png` so it is correct even when unbundled), then the title, version and Help. Status summary with a 3pt accent rule and the `status-headline` serif line. Then the stage action row (see States). |
| **Record** (scrolling) | During a run only, the `Live activity` well. Then the ordered 9-step repair record (`validate`, `closeZoom`, `backup`, `network`, `resetData`, `dns`, `updaters`, `mediaAccess`, `launch`): `44pt` minimum rows separated by `1pt` `border` rules, 4 columns at `>= 560pt` content width (`window.recordFourColumnMinWidth`, sized so the main column beside the sidebar qualifies at the default `900pt` window: 900 − 264 − 1 − 48 = 587) and stacked below that. Then backup provenance with `Reveal Backup`. |
| **Guidance strip** (pinned at the bottom, `surface`) | One line saying what the actions will do, why they are unavailable, or the privileged-operation safety notice. |

**Narrow windows (`< window.sidebarBreakpoint`, 880pt):** the sidebar folds away. The Zoom panel moves to the top of the record, the support links move to a bar under the guidance strip, and check details stay available from the summary and the `System check details` sheet. No control is ever hidden.

### States

The stage is derived from the existing workflow state. It never changes workflow logic.

| Stage | When | Stage action row | Record |
|---|---|---|---|
| **Ready** | idle | `Preview steps` (secondary, read-only), `Launch in sandbox` (secondary), and `Review repair…` (primary amber, default action, disabled while a check is blocking) | The plan for the 9 steps |
| **Running** | any active step, or stopping | A determinate linear progress bar computed from step states (its accessibility value is `Step n of 9 · <step>`; the visible step text stays in the status summary; the bar turns `warning` and reads "Stopping after the current step" while stopping), plus `Stop repair` / `Stop launch` / `Stopping…` (destructive) | The `Live activity` well (last 6 log lines in `mono` on `surface-recessed`, plus `Open full log`), then the live record |
| **Results** | completed, completed with warnings, failed, stopped | After a repair run: the integrated retry `Review repair again…` (primary, `arrow.clockwise`). After a preview or sandbox launch, no repair has run yet, so it stays `Review repair…` (`play.fill`). Either way it reopens the repair review sheet first, never re-runs directly. The secondary actions stay available. | The finished record with per-step outcomes and backup provenance |

Only one primary (amber) control is visible at a time. Do not use oversized banners, large action cards, tab bars, demo or tabbed state switchers, decorative gradients, or glass effects.

### Motion

- Only the status accent rule colour animates (`ease-out`, `motion.controlFeedbackMs`). Status text, logs and layout update immediately, per [`../07-motion.md`](../07-motion.md). The primary hover changes fill and halo radius only.
- The progress bar moves only when step states change. Indeterminate native spinners are limited to three places: preflight loading (`Checking this Mac…`), the status summary glyph while a step runs, and the single running record row.
- When `accessibilityReduceMotion` is on, all animations are removed.

### Accessibility

- Each check row is one accessibility element with the value `Passed`, `Warning` or `Blocking`.
- The progress bar exposes its label as its accessibility value.
- Icon-only buttons carry labels and help text.
- Colour is never the only signal: every status pairs a symbol with text.

## Chrome

- **Native titlebar** — preserve the standard macOS window titlebar and traffic-light controls.
- **Native menus & sheets** — place GitHub and Website in the macOS `Help` menu (as well as compact in-window Help access) and use native `.sheet` presentation (`surface-modal` `#24232A`) for repair review, system check details, activity log, and bug reporting.

## Tokens & static Swift mirror

- Canonical macOS token overlay lives in [`../tokens/macos.json`](../tokens/macos.json) (see [`../02-colors.md`](../02-colors.md) § macOS shipped palette and [`../03-typography.md`](../03-typography.md) § macOS Repair Record scale).
- The SwiftUI executable mirrors these tokens statically in `Sources/1132Fixer/Theme.swift` without runtime JSON loading, verified by automated tests against `design-system/tokens/macos.json`.

## Icons

- **SF Symbols exception:** functional macOS controls and status indicators use native **SF Symbols** paired with explicit text labels (see [`../06-icons.md`](../06-icons.md)). Remove decorative section-heading icons.
- **Brand assets:** the macOS Dock/app icon is the minimal amber reset mark on a matte graphite tile, exported at `assets/exports/macos/AppIcon.png` (shipped as `Sources/1132Fixer/Resources/AppIcon.png`; `.icns` is generated from it). Vector sources: `assets/source/macos/AppIcon.svg` and `assets/source/macos/AppIcon-small-optical.svg` (heavier stroke for 16/32 px), with optical raster exports `assets/exports/macos/AppIcon-small-optical-*.png`. The consumer maps these in `.brand-assets.tsv` and uses them for the `icon_16x16`, `icon_16x16@2x` and `icon_32x32` slots of `AppIcon.icns`; every other size is downscaled from `AppIcon.png`. (`16x16@2x` and `32x32` are the same 32px drawing, kept as two files to match the iconset slots one-to-one.) The tile is a rounded rectangle, not Apple's exact squircle mask. The cross-platform master `assets/1132-Fixer-App-Icon-1024x1024@1x.png` is unchanged and still serves the other platforms.

## Sandboxing / security boundaries

The app verifies `zoom.us.app` (bundle name, strict codesign, Team ID `BJ4HAAB9B3`, executable containment, symlink checks), validates the exact required `sandbox-exec` profile before closing or mutating Zoom, performs unprivileged local data backup and reset in the user's home directory, scopes `osascript` administrator privileges strictly to network identity and DNS cache operations, and always launches Zoom via `sandbox-exec`.
