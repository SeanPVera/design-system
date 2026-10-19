# Accessibility

## Contrast

All `text-primary`/`text-secondary` on `background`/`surface`/`surface-modal` combinations must meet WCAG AA (4.5:1 for body text, 3:1 for large text ≥24px). Verify any new color pairing against [`02-colors.md`](02-colors.md) tokens before shipping — don't introduce a new text color to fix a contrast issue; adjust which token is used instead.

Status color alone is never sufficient — every `success`/`warning`/`error` state must also carry a text label or icon (already true of shipped checklist rows: icon + label + value, not just a colored dot).

## Keyboard

- Every interactive element (buttons, inputs, disclosures, links) must be reachable via Tab in visual order (Full Keyboard Access).
- `Enter`/`Space` activates buttons; `Esc` closes modals/sheets (Repair review, Activity Log, System check details, Report a bug). In multiline text editors, `Enter` inserts a newline and must never unexpectedly start or send an operation.
- Focus ring: 2px solid `focus` (`#8DBCF2` on macOS, `#71AFFF` on Windows, or `primary` on web), offset with a 2px `background` gap, visible on every focusable element — never suppressed without an accessible replacement.
- Primary buttons and interactive controls on macOS pair their fill with `border-control` (`#718399`, `>= 3:1` against dark surfaces) so boundaries remain clear in both standard and increased-contrast modes.

## Platform-specific notes

- **Windows (Narrator)**: label all icon-only buttons with accessible names; system tray icon needs a tooltip/name distinct from the app name.
- **macOS (VoiceOver & Dynamic Text)**:
  - Native titlebar and controls (see [`platforms/macos.md`](platforms/macos.md)) inherit VoiceOver support — preserve native control semantics and disabled states.
  - Status always includes explicit words alongside a symbol (`Differentiate Without Color`).
  - Retain full accessible file paths even when visually abbreviated, and never clip multiline warning or recovery instructions.
  - Restore keyboard focus predictably after dismissing sheets, and announce meaningful validation/submission errors.
- **Chrome extension**: popup DOM must have a logical heading structure (`h1`/`h2`) since some accessibility trees announce popups without a page title otherwise.
- **Website**: standard web a11y — semantic HTML, alt text on all screenshots/marketing imagery, skip-to-content link if nav grows past a simple header.

## Motion

Respect `prefers-reduced-motion` and macOS `accessibilityReduceMotion` — see [`07-motion.md`](07-motion.md).
