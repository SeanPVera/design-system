# Typography

Values live in [`../tokens/typography.json`](../tokens/typography.json).

## Font stack per platform

| Platform | Stack |
|---|---|
| Windows | `Segoe UI Variable`, `Segoe UI`, system-ui, sans-serif |
| macOS | `SF Pro Text`, -apple-system, system-ui, sans-serif |
| Website | `Inter`, system-ui, -apple-system, sans-serif |
| Chrome extension | `Inter`, system-ui, -apple-system, sans-serif |
| Diagnostic/log output (all platforms) | `SF Mono` / `Cascadia Mono` / `JetBrains Mono`, ui-monospace, monospace |

Always use the platform's native system font first — never ship a bundled web font (Inter) inside the native apps; Inter is for website/extension only, where a native system font isn't guaranteed to look consistent across a user's browser/OS.

## Scale

| Role | Size | Weight | Line height | Use |
|---|---|---|---|---|
| `display` | 28 | 700 | 34 | App/product name, hero headings |
| `heading` | 20 | 700 | 26 | Section headings ("Preflight Checks") |
| `subheading` | 16 | 600 | 22 | Card titles ("Start Zoom", "Dry Run") |
| `body` | 14 | 400 | 20 | Default UI text, descriptions |
| `label` | 13 | 600 | 18 | Field labels, list item keys ("macOS:", "VPN:") |
| `caption` | 12 | 400 | 16 | Helper text, timestamps, tag pill text |
| `mono` | 13 | 400 | 20 | Activity Log output, diagnostic values, file paths |

## Rules

- Use `mono` for any output the user might copy for support purposes (log lines, diagnostic values, file paths like `/Applications/zoom.us.app`) — this is already how the shipped Activity Log panel is meant to read once populated.
- Never mix more than 3 weights on one screen — the shipped UI uses regular (400) and bold (700) headings with semibold (600) labels; stay within that range.
- Headings don't use the brand gradient — gradient is logo-only (see [`02-colors.md`](02-colors.md)).

## macOS Repair Record scale

The macOS app ([`platforms/macos.md`](platforms/macos.md)) uses native `SF Pro` and `SF Mono` (never a bundled web font) with sentence case, tabular numerals (`monospacedDigit()`) for aligned numeric values, and at most two weights (`Regular` 400 and `Semibold` 600), recorded in [`../tokens/macos.json`](../tokens/macos.json):

| Role | Size / Line height (pt) | Weight | Font |
|---|---|---|---|
| `main-outcome` | `24 / 30` | Semibold (`600`) | `SF Pro` |
| `compact-identity` | `16 / 22` | Semibold (`600`) | `SF Pro` |
| `section-heading` | `16 / 22` | Semibold (`600`) | `SF Pro` |
| `body` (and substantive warnings / recovery instructions) | `14 / 20` | Regular (`400`) | `SF Pro` |
| `button` | `14 / 20` | Semibold (`600`) | `SF Pro` |
| `label` (field or row label) | `13 / 18` | Semibold (`600`) | `SF Pro` |
| `metadata` | `12 / 16` | Regular (`400`) | `SF Pro` |
| `mono` (paths and diagnostics) | `13 / 20` | Regular (`400`) | `SF Mono` |

Let content grow vertically rather than clipping or truncating to enforce a nominal line height.
