# Components

Every component below follows the checklist structure defined in [`../examples/component-checklist.md`](../examples/component-checklist.md) — see that file for a fully worked example (Button). New components must be run through the same checklist before shipping.

Specs are based directly on the shipped macOS UI (`screenshots/mac/main.png`, `screenshots/mac/report-bug.png`) — treat these as the reference implementation, not just inspiration.

## Button

- **Primary** (e.g. "Choose Location…"): `primary` fill, `text-primary` label, `radius.md`, `spacing.12`/`spacing.16` padding.
- **Panel/card button** (e.g. "Start Zoom", "Dry Run"): full-card hit area, `surface` background with `primary` border when active/selected (see "Start Zoom" panel in `main.png`), icon + `subheading` title + `body` description stacked, trailing arrow icon (Lucide `arrow-right`).
- **Secondary/ghost** (e.g. "Copy", "Clear", "Cancel"): `surface` fill, `border` outline, `text-primary` label.
- States: hover/pressed/disabled per [`02-colors.md`](02-colors.md) state rules; transitions use `fast` from [`07-motion.md`](07-motion.md).

## Input (text field)

- `surface-modal` or `surface` background (matches parent container — modal inputs use `surface-modal`, as seen in the Report-a-bug email field), `border` outline, `radius.md`.
- Focus state: `primary` border/ring, per [`09-accessibility.md`](09-accessibility.md).
- Placeholder text uses `text-secondary`.
- Multi-line variant (Report-a-bug "Message" field): same rules, min-height ~4 lines, resizable.

## Card

- `surface` background, `radius.lg`, `spacing.16` internal padding, `spacing.24` gap between sibling cards.
- Optional header: icon chip (small rounded square, `surface` background) + `heading` text, left-aligned.

## Modal / Dialog

- `surface-modal` background (not `surface` — see [`02-colors.md`](02-colors.md) for why this is a distinct token), `overlay` scrim behind it, `radius.lg`.
- Title (`heading`), optional description (`body`, `text-secondary`), form content, action row (secondary button left, primary button right).
- Opens/closes with `base` duration from [`07-motion.md`](07-motion.md). Dismissible via `Esc` and scrim click.

## Status pill / tag

- Pill shape (`radius.xl` or fully rounded), `caption`-size text, `spacing.4`/`spacing.8` padding.
- `success` background tint + `success` text for supported/passed (e.g. "Intel", "Apple Silicon", "Wi-Fi").
- `error` background tint + `error` text for unsupported/failed (e.g. "VPN").
- Never rely on color alone — label text is required (see [`09-accessibility.md`](09-accessibility.md)).

## Checklist row

- Pattern: leading status icon (checkmark in `success`, or pending/error equivalent) + `label`-weight key (e.g. "macOS:") + `body`-weight value (e.g. "macOS 26.5.0").
- Two-column layout on wide containers (as in `main.png`'s Preflight Checks card), single column below the [`05-layout.md`](05-layout.md) minimum window width.

## Activity log panel

- `surface` background, `mono` typography role (see [`03-typography.md`](03-typography.md)) for all log content.
- Header row: title (`heading`) + action buttons (Copy, Clear, expand/collapse) right-aligned, using the secondary/ghost button style.
- Empty state: `text-secondary` `body` text ("No logs yet. Run an action to see output.") — no illustration, no animation.
- New lines append instantly — see [`07-motion.md`](07-motion.md) motion rule against animating logs.

## Nav / header

- App header: in-app glyph (see [`01-brand.md`](01-brand.md)) + `display` product name + `caption` subtitle, left-aligned; utility links (GitHub, Website, Report a bug, Export Diagnostics) right-aligned as ghost buttons.

## Website component catalog

The specs below extend the catalog for website use. They define permitted components, not a requirement to add every component to every page. Existing app specs above remain the reference for shipped app controls.

All new components use the dark theme and existing token keys. Color keys come from [`../tokens/colors.json`](../tokens/colors.json); `spacing.*`, `radius.*`, and typography roles come from their matching token files. Focus, contrast, and target sizes follow [`09-accessibility.md`](09-accessibility.md). State transitions use `fast`; panel transitions use `base` from [`07-motion.md`](07-motion.md). Respect reduced motion. No component requires animation.

For small screens, use the website layout in [`05-layout.md`](05-layout.md). Mobile behavior here applies to websites viewed on phones; it does not add a native mobile app. For native platforms, use native controls with equivalent names, states, and keyboard behavior. Web-specific HTML and ARIA apply to the website and extension.

### Accordion / disclosure

**Purpose**
Show or hide related details, such as answers about VPN checks or Zoom app data resets.

**Variants**
Single disclosure; grouped FAQ. Each item opens independently. Use `surface`, `border`, `radius.md`, and `spacing.16`. Use `subheading` for the trigger and `body` for content.

**States**
Closed, open, hover, pressed, focused. Keep the label unchanged. Show expansion with a chevron from the icon set in `06-icons.md`. Hidden content must leave the focus order.

**Keyboard behavior**
Tab reaches each trigger. Enter or Space toggles it. Opening one item does not close another.

**Accessibility**
On web surfaces, prefer `details` with a `summary`. For custom controls, use a heading with a button, `aria-expanded`, and `aria-controls`. Give the content a stable ID. Do not put links or other buttons inside the trigger.

**Mobile behavior**
Wrap trigger text. Keep the full trigger row easy to tap. Content uses the container width.

**Desktop behavior**
Use the same stacked layout. Long answers must wrap.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use for FAQs and repair details. Keep critical warnings visible outside collapsed content.

### Link

**Purpose**
Navigate to a page, a page section, a download, or an external resource.

**Variants**
Inline link; navigation link; download link. Use `text-primary` with an underline for inline links. Use `label` for navigation links. Use existing Button styles for prominent download links, while keeping link semantics.

**States**
Default, hover, focused, current, visited. Keep links identifiable without color. A current navigation link uses `primary` as an indicator and keeps `text-primary` text. Do not show an unavailable download as an active link.

**Keyboard behavior**
Tab focuses. Enter follows the link. Keep browser shortcuts and context menus available.

**Accessibility**
Use an anchor with a real destination on web surfaces. Give links clear names, such as “Download for Windows”. Use `aria-current="page"` or `aria-current="location"` when applicable. State when a link opens a new tab.

**Mobile behavior**
Allow labels to wrap. Space adjacent links so touch targets do not overlap.

**Desktop behavior**
Keep pointer and keyboard focus states visible.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use section links for page navigation. Download labels must name the platform and match the actual file.

### Website navigation

**Purpose**
Give access to downloads, repair details, and support pages.

**Variants**
Expanded header; collapsible header. Use `background`, `border`, `spacing.16`, and `spacing.24`. Reuse Link and Button. Use only real brand assets.

**States**
Current destination, hovered link, focused link; collapsed or expanded navigation on narrow screens.

**Keyboard behavior**
Tab follows document order. Enter or Space toggles the navigation button. Escape closes an expanded navigation panel and returns focus to its button. Keep Tab in normal page order.

**Accessibility**
Use a labelled `nav` landmark. The toggle has `aria-expanded` and `aria-controls`. Closed navigation links must leave the focus order. Use ordinary links, not application menu roles. Include a skip-to-content link.

**Mobile behavior**
Collapse links when they no longer fit. Show a labelled navigation button. Opening the panel pushes page content down; it does not cover content.

**Desktop behavior**
Show links in one row when space permits. Keep the current destination clear.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use the marketing mark per `01-brand.md`. Keep the site header distinct from the app header above.

### Hero / download section

**Purpose**
Explain what 1132 Fixer checks and give access to platform downloads.

**Variants**
Text with downloads; text with a real product screenshot. Use `display`, `body`, `text-primary`, `text-secondary`, and `spacing.32`. Reuse Link, Button, and Status pill.

**States**
Download available, unavailable, or loading. State which platform each download supports. Show failure text if release details cannot load.

**Keyboard behavior**
Only links and buttons enter the focus order. Keep their order consistent with reading order.

**Accessibility**
Use a section with the page heading. Give screenshots useful alt text. Describe download requirements in text. Do not make the whole hero clickable.

**Mobile behavior**
Stack text, download actions, and optional screenshot. Keep both platform choices visible.

**Desktop behavior**
Text and screenshot may sit side by side. Follow website grid rules.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use concrete copy such as “Check network, VPN, and DNS state”. OS detection may reorder downloads; it must not remove the other platform.

### Alert / notice

**Purpose**
Keep warnings, errors, and repair guidance visible near affected content.

**Variants**
Information, success, warning, error. Use `surface`, `border`, `radius.md`, `spacing.16`, and `body`. Use `text-primary` for the message. Use the matching status token for an icon, with a text label.

**States**
Visible; dismissed only for optional notices. Critical repair warnings remain visible. Add a retry action only when an actual retry is available.

**Keyboard behavior**
Text is not focusable. Actions follow normal Button or Link behavior. If dismissal removes the focused button, move focus to the next relevant control.

**Accessibility**
Static notices need no live announcement. Use `role="status"` for new non-urgent results and `role="alert"` for new urgent errors. Never rely on color or an icon alone.

**Mobile behavior**
Stack actions below text when needed. Let the message wrap.

**Desktop behavior**
Actions may share a row with text if the message stays readable.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use for download failures, VPN guidance, or warnings about Zoom app data. Keep required guidance outside accordions.

### Tabs

**Purpose**
Switch between related views in the same context, such as platform-specific instructions.

**Variants**
Horizontal tab list. Use `surface`, `border`, `spacing.12`, and `label`. Active tabs use a `primary` indicator and `text-primary` label. Panels use `body`.

**States**
Inactive, selected, hover, focused, disabled. Only the selected panel is visible and available to assistive technology.

**Keyboard behavior**
Tab enters the selected tab, then leaves the tab list. Left and Right Arrow move focus, wrapping at ends. Home and End focus first and last tabs. Enter or Space selects the focused tab. Selection uses manual activation.

**Accessibility**
Use `tablist`, `tab`, and `tabpanel` roles on web surfaces. Connect tabs and panels with stable IDs, `aria-controls`, and `aria-labelledby`. Set `aria-selected` and roving `tabindex`. A panel with no focusable content gets `tabindex="0"`.

**Mobile behavior**
Keep tabs in one row with horizontal scrolling if needed. Scroll the focused tab into view. Never clip its label.

**Desktop behavior**
Place the tab list above its panel. Keep content aligned when panels change.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use links for navigation to separate pages. Do not hide mandatory download requirements in an inactive panel.

### Form field / selection controls

**Purpose**
Collect repair reports and explicit choices, such as a platform or permission to include diagnostic data.

**Variants**
Text field and multi-line field reuse Input. Add native select, checkbox, and radio controls. Group related radios in a fieldset. Use `label`, `body`, `caption`, `spacing.8`, and `spacing.16`. Text and select controls use `surface`, `border`, and `radius.md`.

**States**
Empty, filled, focused, disabled, invalid; checked or unchecked for choices. Errors use `text-primary` with an `error` icon and clear text. Keep entered values after a failed submit.

**Keyboard behavior**
Use native control keyboard behavior. Space toggles a checkbox. Arrow keys move between radios in a group. Do not intercept select keyboard commands.

**Accessibility**
Use visible labels. Place help text before error text. Connect both with `aria-describedby`; mark invalid fields with `aria-invalid`. Use `fieldset` and `legend` for choice groups. Identify required fields in text. After failed submission, focus the first invalid field.

**Mobile behavior**
Stack fields and actions. Keep labels visible and make checkbox/radio labels clickable.

**Desktop behavior**
Use multiple columns only when reading order stays clear.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use browser-native selection controls with dark color scheme. Do not build custom select menus. Explain what diagnostic data is included before asking for consent.

### Data / comparison table

**Purpose**
Compare supported platforms or list check results with clear row and column labels.

**Variants**
Platform comparison; diagnostic results. Use `surface`, `border`, `spacing.12`, and `body`. Headers use `label` and `text-primary`. Reuse Status pill for results.

**States**
Populated, empty, loading, failed. Explain empty or failed results in text. Rows are static unless they contain a Link or Button.

**Keyboard behavior**
Static cells do not enter the Tab order. Controls inside cells use their normal keyboard behavior. A scroll region must be keyboard reachable when needed.

**Accessibility**
Use a semantic table with a caption and header cells with correct scope. Keep statuses in text. Label a horizontal scroll region. Do not use grid roles for a read-only table.

**Mobile behavior**
Allow horizontal scrolling inside the table container. Keep the page itself within the viewport. Preserve header associations.

**Desktop behavior**
Show all columns when they fit. Align text consistently. Do not imply sorting if no sorting action exists.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
List only verified support and check results. Use a table for comparison data, not page layout.

### Pagination

**Purpose**
Move through multiple pages of release notes or repair guides.

**Variants**
Previous/next links; numbered page links. Use Link with `label`, `spacing.8`, and `spacing.12`. Current page uses `surface` and a `primary` indicator.

**States**
Current, available, hover, focused. At the start or end, omit the unavailable destination or show plain text without an active link.

**Keyboard behavior**
Tab reaches available links. Enter opens the destination. Do not add arrow-key handling.

**Accessibility**
Use a labelled navigation landmark and `aria-current="page"` for the current page. Give numbered links clear names such as “Page 2”. Ellipses are plain text.

**Mobile behavior**
Prefer previous/next links and a current-page label when numbers do not fit.

**Desktop behavior**
Show numbered pages when useful. Avoid a long row of every page.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Use real page destinations that work without scripts. Retain filters in destination URLs when filters exist.

### Footer

**Purpose**
Provide secondary site navigation, support, and ownership information.

**Variants**
Compact footer; grouped links. Use `background`, `border`, `spacing.24`, `spacing.32`, `caption`, and `text-secondary`. Reuse Link for destinations.

**States**
Static content plus normal Link states. No collapsed groups by default.

**Keyboard behavior**
Tab visits links in reading order. No special keyboard behavior.

**Accessibility**
Use a page-level `footer`. Label any navigation groups. Link names must remain clear outside their visual group.

**Mobile behavior**
Stack groups and allow text to wrap.

**Desktop behavior**
Groups may share a row. Preserve the same document order.

**Windows notes**
Use these defaults when this component is needed. Follow `platforms/windows.md` for native layout and controls.

**macOS notes**
Use these defaults when this component is needed. Follow `platforms/macos.md` for native layout and controls.

**Chrome Extension notes**
Use these defaults when this component is needed. Follow `platforms/chrome-extension.md` for popup constraints. Stack content within the popup.

**Website notes**
Include only real support, source, and policy destinations. Do not add empty social links or invented legal claims.

---

## macOS Repair Record Components

The macOS utility ([`platforms/macos.md`](platforms/macos.md)) implements **The Repair Record** single-workspace architecture using tokens from [`../tokens/macos.json`](../tokens/macos.json). Every component below follows the [`../examples/component-checklist.md`](../examples/component-checklist.md) structure.

### Readiness summary
- **Purpose:** Answers whether this Mac can attempt the repair, or summarizes the active/completed repair outcome at the top of the workspace while retaining prior repair receipt timestamps when checks are rerun.
- **Tokens used:** `surface`, `border`, `text-primary`, `text-secondary`, `success`, `warning`, `error`, `main-outcome` (`24/30` Semibold), `body` (`14/20` Regular), `metadata` (`12/16` Regular), `spacing.16`, `spacing.12`, `spacing.8`.
- **Variants:** Checking (`Checking readiness…`), Ready (`Ready to repair`), Ready with limitations (`Ready with limitations`), Blocked (`Checks complete. Repair blocked.`), Active execution (`Repairing Zoom…`, `Stopping…`), Completed outcomes (`Zoom launched`, `Zoom launched · 1 warning`, `Zoom launch could not be confirmed`, `Repair stopped`, `Repair failed`).
- **States:** Default, loading (native indeterminate spinner), warning, error, receipt-preserved notice when new checks run after a completed repair.
- **Accessibility:** Combined header element announcing status symbol + main outcome heading + explanatory subtitle; never relies on color alone.
- **Platform notes:** Remains visible/usable above the scrolling operation record.

### Check row
- **Purpose:** Displays an individual environment/readiness observation inside the System check details sheet or readiness breakdown, differentiating blocking errors, nonblocking limitations, informational prompts (admin password, first-time media permission), and verified passes.
- **Tokens used:** `surface`, `border`, `text-primary`, `text-secondary`, `success`, `warning`, `error`, `label` (`13/18` Semibold), `body` (`14/20` Regular), `mono` (`13/20` Regular), `spacing.8`, `spacing.12`.
- **Variants:** Passed (`OK`), Informational (`INFO`), Nonblocking limitation (`LIMITATION` / `WARN`), Blocking requirement failure (`BLOCKED`).
- **States:** Static read-only row with selectable value/detail text.
- **Accessibility:** Announces check label, explicit severity word (`Passed`, `Informational`, `Limitation`, `Blocking`), and value.
- **Platform notes:** Replaces static compatibility pills (`Intel`, `Apple Silicon`, `Wi-Fi`, `VPN`) with concrete observations.

### Repair-record row
- **Purpose:** Represents one of the 9 ordered repair operations (`validate`, `closeZoom`, `backup`, `network`, `resetData`, `dns`, `updaters`, `mediaAccess`, `launch`) across planned, live-running, and completed receipt states with stable identity and position.
- **Tokens used:** `surface`, `surface-hover`, `surface-pressed`, `border`, `text-primary`, `text-secondary`, `success`, `warning`, `error`, `focus`, `label` (`13/18` Semibold), `body` (`14/20` Regular), `metadata` (`12/16` Regular), `mono` (`13/20` Regular), `window.rowMinHeight` (`44pt`), `radius.row` (`0pt`).
- **Variants:**
  - Wide layout (`>= 840pt` content width): 4 aligned columns — tabular sequence number (`01`–`09`), operation name, anticipated or actual effect, and trailing outcome status (symbol + word).
  - Compact layout (`< 840pt` content width): effect text stacks below the operation name while retaining the leading sequence number and trailing outcome column.
- **States:** Planned, Running (single native indeterminate `ProgressView` + optional `Waiting for macOS administrator authorization…` or permission wait detail), Succeeded, Warning (auto-expanded or expandable with recovery instructions), Skipped (intentionally skipped with reason), Failed (expanded with retained-state boundary guidance), Interrupted (stopped while running; effect unverified), Unstarted (never reached after earlier stop/failure), Hover/Pressed/Focused when expandable.
- **Accessibility:** Minimum `44pt` height, grows vertically without truncating warning/recovery copy to two lines; keyboard-focusable disclosure with `2pt` `focus` ring (`#8DBCF2`) on `2pt` `background` gap; announces step sequence, title, effect, and outcome word.
- **Platform notes:** Square (`0pt` radius), separated by `1pt` `border` horizontal rules; disclosure uses `200ms` `ease-in-out` unless Reduce Motion is enabled.

### Persistent action area
- **Purpose:** Houses the primary and secondary workflow actions (`Run checks`, `Review repair…`, `Stop repair` / `Stopping…`), disabled-state explanation, backup provenance (`Backup created for this repair` vs `Previous backup available` + `Reveal Backup`), and support sheet triggers (`System check details`, `Activity Log`, `Export Diagnostics`, `Report a Bug`).
- **Tokens used:** `surface`, `background`, `border`, `border-control` (`#718399`), `primary` (`#235FA8`), `primary-hover` (`#286AB5`), `primary-pressed` (`#1D508D`), `surface-hover` (`#26344A`), `surface-pressed` (`#1B2636`), `text-primary`, `text-secondary`, `focus`, `button` (`14/20` Semibold), `body` (`14/20` Regular), `metadata` (`12/16` Regular), `radius.control` (`6pt`), `spacing.8`, `spacing.12`, `spacing.16`.
- **Variants:**
  - Idle / Ready / Completed: Secondary `Run checks` button (*"Checks only; no repair changes."*) + Primary filled `Review repair…` button (or disabled with adjacent reason text).
  - Running checks: Disabled primary action + active status indicator.
  - Running repair: `Stop repair` control (or disabled `Stopping…` while waiting for privileged process exit before releasing ownership).
- **States:** Default, hover (`150ms` `ease-out`), pressed, focused (`2pt` `focus` ring with `2pt` `background` gap), disabled (native disabled trait exposed + readable `text-secondary` label + explicit reason text).
- **Accessibility:** Full Keyboard Access Tab order; only one filled `primary` button per context; `border-control` (`#718399`) ensures `>= 3:1` boundary contrast on primary and secondary controls.
- **Platform notes:** Pinned below the scrollable record so primary actions never scroll out of reach.

### Outcome notice
- **Purpose:** Contextual inline banner for partial-state recovery guidance, post-launch sign-in verification instructions, plan-revalidation notices, or diagnostics export confirmation/errors.
- **Tokens used:** `surface`, `border`, `text-primary`, `text-secondary`, `success`, `warning`, `error`, `body` (`14/20` Regular), `label` (`13/18` Semibold), `mono` (`13/20` Regular), `radius.control` (`6pt`), `spacing.12`, `spacing.16`.
- **Variants:** Informational/Receipt notice, Warning/Limitation recovery notice, Failure boundary / Retained-state notice, Export result notice.
- **States:** Static or dismissible where appropriate; multiline text wraps completely without line-limit clipping.
- **Accessibility:** Grouped accessibility element or polite announcement on state transition; includes symbol + status word + actionable instruction.
- **Platform notes:** Used for concrete operational feedback rather than decorative callouts.

### Installation selector
- **Purpose:** Displays the active verified Zoom bundle path and allows selecting a custom `zoom.us.app` via `NSOpenPanel` or reverting to `/Applications/zoom.us.app`.
- **Tokens used:** `surface`, `border`, `border-control`, `text-primary`, `text-secondary`, `error`, `label` (`13/18` Semibold), `mono` (`13/20` Regular), `body` (`14/20` Regular), `radius.control` (`6pt`), `spacing.8`, `spacing.12`, `spacing.16`.
- **Variants:** Default path (`/Applications/zoom.us.app`), Custom verified path (neutral information, reveals `Use default`), Verifying off-UI-thread (`Verifying Zoom…` while retaining previous valid selection), Rejected selection (inline error beside row with actionable explanation while previous valid target remains active).
- **States:** Default, verifying, rejected-error, disabled while a repair or check owns execution.
- **Accessibility:** Full path is text-selectable and exposed in full to VoiceOver; `Choose…` and `Use default` buttons expose clear labels and disabled traits during active runs.
- **Platform notes:** Uses native `NSOpenPanel`; cancelling the panel leaves selection and error state unchanged.

### Repair review sheet
- **Purpose:** Plan-driven confirmation sheet presented by `Review repair…` that previews all 9 operations in execution order and requires deliberate `Start Repair` activation before any mutation.
- **Tokens used:** `surface-modal` (`#2A2530`), `surface`, `border`, `border-control`, `primary`, `text-primary`, `text-secondary`, `warning`, `section-heading` (`16/22` Semibold), `label` (`13/18` Semibold), `body` (`14/20` Regular), `mono` (`13/20` Regular), `metadata` (`12/16` Regular), `radius.control` (`6pt`), `spacing.12`, `spacing.16`, `spacing.24`.
- **Variants:** Standard plan review; Plan-changed revalidation notice (when target or network conditions changed before execution and require renewed approval).
- **States:** Default, Paths disclosure expanded (showing exact backed-up and cleared paths, plus note that deleted local logs are excluded from the backup), Cancel (`Esc`), Start Repair (`primary` button).
- **Accessibility:** Native macOS `.sheet` framing and focus trap; `Esc` cancels; restores focus on dismissal; lists all 9 steps with their specific anticipated effects (leave active meeting warning, backup/reset paths, actual network strategy & interface interruption, admin prompts for network/DNS, session-only updater unload, `1132 Fixer` camera/mic grant ownership, and sandbox launch limits).
- **Platform notes:** Derived from the exact `RepairPlan` struct that drives execution.

### Log viewer
- **Purpose:** On-demand sheet presenting the session Activity Log (up to 5,000 entries with stable sequence IDs) without cluttering the main workspace when empty.
- **Tokens used:** `surface-modal`, `surface`, `border`, `border-control`, `text-primary`, `text-secondary`, `section-heading` (`16/22` Semibold), `mono` (`13/20` Regular), `metadata` (`12/16` Regular), `radius.control` (`6pt`), `spacing.8`, `spacing.12`, `spacing.16`.
- **Variants:** Empty state (*"No activity recorded in this session."*), Populated scrolling log with `Follow latest` toggle, `Copy`, `Clear`, and `Close`.
- **States:** Following latest (auto-scrolls on new sequence numbers even after the 5,000-entry ring buffer is full), Paused (when user scrolls up or toggles off `Follow latest`), Copied confirmation.
- **Accessibility:** Monospaced selectable log lines; explicit button labels; clearing display logs never erases structured repair status, backup provenance, or readiness state.
- **Platform notes:** Presented as a native macOS sheet from the support bar.

### Report attachment review
- **Purpose:** Frozen diagnostics draft and attachment inspector inside the `Report a Bug` sheet, guaranteeing byte-for-byte parity between previewed, saved, and uploaded diagnostics.
- **Tokens used:** `surface-modal`, `surface`, `border`, `border-control`, `primary`, `text-primary`, `text-secondary`, `warning`, `error`, `success`, `section-heading` (`16/22` Semibold), `label` (`13/18` Semibold), `body` (`14/20` Regular), `mono` (`13/20` Regular), `metadata` (`12/16` Regular), `radius.control` (`6pt`), `spacing.8`, `spacing.12`, `spacing.16`.
- **Variants:** Draft ready, Over-limit message (`> 4,000` characters preserved in editor with excess counter and disabled Send), Truncated attachment (`1,048,576`-byte UTF-8-safe limit applied and labeled), Sending, Submission failed / timed out (draft retained + `Save Attachment…` offered), Sent confirmation (`Report sent`).
- **States:** Attachment preview collapsed/expanded, refreshing (`Refresh Diagnostics` explicit action), saving (`NSSavePanel`), submitting.
- **Accessibility:** Explicit labels for required Message (`TextEditor` where `Enter` inserts a newline and never submits), optional Email or Telegram contact, capture timestamp, byte size, truncation badge, and privacy disclosure explaining that home paths are shortened to `~` while activity output may still contain network service names and addresses.
- **Platform notes:** Never silently truncates pasted message text; never exposes internal environment variable names in primary user-facing error copy.

