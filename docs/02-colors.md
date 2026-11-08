# Colors

Dark theme only — 1132 Fixer does not support a light theme. All values live in [`../tokens/colors.json`](../tokens/colors.json); this page is the only place hex values should be written. Everywhere else, reference the token name.

## Palette

| Token | Hex | Role |
|---|---|---|
| `background` | `#0F1724` | App window / page background |
| `surface` | `#202B3D` | Cards, panels, list rows |
| `surface-modal` | `#2A2530` | Modals/dialogs — a distinct, warmer elevation tier (see note below) |
| `primary` | `#2E78D6` | CTAs, links, active/focused states, selection |
| `success` | `#3CCF6E` | Passed checks, "supported" tags, positive status |
| `warning` | `#FFB547` | Caution states, non-blocking issues |
| `error` | `#EF5350` | Failed checks, "unsupported" tags, destructive actions |
| `text-primary` | `#F5F7FA` | Primary text on `background`/`surface` |
| `text-secondary` | `#9AA5B4` | Secondary/muted text, captions, placeholders |
| `border` | `#33415A` | Card/input borders, dividers |
| `overlay` | `rgba(15,23,36,0.72)` | Scrim behind modals |
| `gradient-brand-start` / `gradient-brand-end` | `#FFD24C` / `#E8552A` | Logo wordmark gradient — logo/icon use only, never UI |

`text-primary` on `background` and `surface` both exceed WCAG AA (4.5:1) for body text; verify any new color pairing against [`09-accessibility.md`](09-accessibility.md) before shipping.

## `surface-modal`: why it's separate

The shipped Report-a-bug dialog uses a warmer, slightly plum-toned dark (`#2A2530`) instead of the app's navy `surface`. This is treated as an **intentional elevation tier** — modals sit visually apart from the main window — rather than normalized away. Any new modal/dialog should use `surface-modal`, not `surface`.

## Usage rules

- `primary` is reserved for interactive elements (buttons, links, focus rings, active tab/selection). Never use it for large decorative fills.
- `success` / `warning` / `error` communicate **status only** — a check result, a tag, a validation message. Don't use them as generic accent colors.
- `gradient-brand-*` tokens exist only for reproducing the logo wordmark in icons/marketing assets. Never apply the gradient to UI text, buttons, or backgrounds.

## States

Derive interactive states from base tokens rather than adding new hardcoded colors:

- **Hover**: `primary` at 90% opacity, or `surface` lightened ~6%.
- **Pressed**: `primary` at 80% opacity, or `surface` lightened ~3%.
- **Disabled**: `text-secondary` for label, `border` for outline, no fill.
- **Focus ring**: 2px `primary`, see [`09-accessibility.md`](09-accessibility.md).

## Windows shipped palette

The Windows app ([`platforms/windows.md`](platforms/windows.md)) ships a
navy-only overlay of this palette, recorded in
[`../tokens/windows.json`](../tokens/windows.json). It keeps every role above
but uses two navy surface tiers instead of the plum `surface-modal`, and
slightly brighter interactive and status values for contrast on the darker
surfaces. These are the only other hex values allowed outside this file's
palette table.

| Windows token | Hex | Role |
|---|---|---|
| `background` | `#0F1724` | Window background (same as `background`) |
| `surface` | `#172235` | Panels, summary strips, dialogs |
| `surface-2` | `#1D2A3F` | Second elevation tier; modal surface on Windows |
| `surface-hover` / `surface-pressed` | `#243550` / `#293D5B` | Hover and pressed fills |
| `border` / `border-strong` | `#2B3D57` / `#3B5578` | Dividers, control outlines / emphasis |
| `text-primary` / `text-secondary` / `text-muted` | `#F5F7FB` / `#A8B5C7` / `#7F8DA1` | Body, secondary, quiet text |
| `primary` / `primary-hover` / `primary-pressed` | `#337FDB` / `#3B8AE8` / `#286BC2` | Fix now and links |
| `focus` | `#71AFFF` | Focus ring colour (2px ring on a 2px `background` gap) |
| `success` / `warning` / `error` | `#2BC66D` / `#F3B84A` / `#F05D67` | Status only |
| `overlay` | `rgba(15,23,36,0.72)` | Scrim (same as `overlay`) |

Contrast (WCAG 2.x relative luminance): `text-secondary` `#A8B5C7` is 8.6:1
on `background` and 7.7:1 on `surface`; `text-muted` `#7F8DA1` is 5.3:1 on
`background` and 4.7:1 on `surface` — all at or above AA (4.5:1) for body
text. White on `primary` is 4.0:1, so `primary` fills carry 14px/600 labels
(large-text threshold 3:1) and are never used for body-size regular text.

## macOS shipped palette

The macOS app ([`platforms/macos.md`](platforms/macos.md)) ships a dedicated
overlay for **The Repair Record** workspace with the **Signal** skin: warm
graphite surfaces and one restrained amber accent, recorded in
[`../tokens/macos.json`](../tokens/macos.json). The overlay is macOS-only and
does not change Windows, website, or extension appearance. Every text and status
role meets WCAG AA (`>= 4.5:1`) on all four surfaces, and the control boundary
meets `>= 3:1` (checked by `SignalPaletteTests` in the macOS app).

| macOS token | Hex | Role |
|---|---|---|
| `background` | `#121214` | Main window background |
| `surface` | `#1C1B20` | Record rows, panels, secondary surfaces |
| `surface-modal` | `#24232A` | Sheets and modal surfaces |
| `surface-hover` / `surface-pressed` | `#2B2A31` / `#17161A` | Row and secondary control hover / pressed fills |
| `surface-recessed` | `#0E0E10` | Recessed wells (log body) |
| `text-primary` / `text-secondary` | `#F4F1EC` / `#A9A49D` | Primary and secondary copy |
| `border` / `border-control` | `#34323A` / `#7A746D` | Structural rule dividers / interactive control boundary |
| `primary` / `primary-hover` / `primary-pressed` | `#FF9A3C` / `#FFAD5C` / `#E8842C` | Amber fill for the one primary action per context |
| `on-primary` | `#1A1206` | Ink on amber fills (`>= 6.8:1` on every fill state) |
| `link` / `focus` | `#FFB25C` | Inline links, active-status text and 2pt focus ring |
| `success` / `warning` / `error` | `#3DDC97` / `#FFC24B` / `#FF7A85` | Semantic status only (always paired with symbol + text) |
| `overlay` | `rgba(18,18,20,0.72)` | Modal scrim |
| `gradient-brand-start` / `gradient-brand-end` | `#FFD24C` / `#E8552A` | Approved brand wordmark / icon asset only |

Usage notes: amber is reserved for the primary action, focus, links and the
status accent rule; never tint large surfaces with it. The primary fill may
carry a soft static amber halo; only its hover change animates, and not under
Reduce Motion.

## Future light theme

Not planned currently — product ships dark-only. If a light theme is requested later, derive it as a parallel token set (`background-light`, `surface-light`, etc.) rather than replacing dark values.
