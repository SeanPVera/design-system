# Brand

## Positioning

1132 Fixer is a **Zoom diagnostic & repair utility** — not a general-purpose PC cleaner. Every surface should read as precise and technical: it checks specific things (network interface, VPN, MAC spoofing, DNS cache, Zoom install path) and reports specific results. Avoid vague "boost your PC" marketing language; prefer concrete, checkable claims.

## Voice and tone

- **Precise over friendly.** Say "VPN: Not detected", not "Looking good!".
- **Trustworthy over playful.** The product runs system-level fixes (resets app data, changes network state) — copy should never undersell that.
- **Action-first.** Buttons and headings describe what happens ("Start Zoom", "Dry Run — check system state without making any changes"), not vague verbs like "Go" or "Fix now".

## Logo system

Two distinct marks exist. Do not substitute one for the other.

### 1. App icon / marketing mark
`assets/1132-Fixer-App-Icon-1024x1024@1x.png` and `assets/gear.png` — a navy/blue gear with "1132" in an orange-to-yellow gradient (`gradient-brand-start` → `gradient-brand-end`) and "FIXER" in light gray below.

Use for: app icons (Dock, taskbar, Start menu), website favicon/OG images, marketing materials.

> **Windows exports refresh (owner ruling 2026-08-23):** the Windows-facing
> gear exports (`assets/exports/windows/icon.png`, `icon.ico`,
> `logo-transparent.png`, `1132-fixer-logo-transparent.png`, and the new
> in-app header mark `app-mark.png`) were regenerated from the owner's
> updated transparent gear master (`16.png`, navy gear 1000×1000).
> `open-source-badge.png` (hex badge shown in the app's trust line) was
> added the same day from owner-supplied artwork. The people/arrow mark
> remains exclusively the desktop-shortcut icon
> (`1132-helper-shortcut.png/.ico`) — never product identity.

- `gear.png` (transparent background) for anything rendering small — Chrome extension icon (16–32px toolbar size), menu-bar/tray glyphs. The full badge's wordmark isn't legible at these sizes.
- The full 1024×1024 badge for anything requiring the dark rounded-square backing at larger sizes (app store listings, Dock, installer).

### 2. In-app header glyph
A simplified glyph shown in the product's own header (see `screenshots/mac/main.png`) — small, in a rounded dark chip, not the full gear+wordmark badge.

Use for: in-product UI chrome only (window header, menu items). Never use the full gear badge inline in UI text or headers — it's too detailed at small sizes and competes with the wordmark.

### Don't

- Don't recolor the gradient wordmark ("1132") — the orange→yellow gradient is fixed brand equity.
- Don't place the gear badge on a light background without its dark rounded-square backing.
- Don't stretch or skew either mark.
- Don't use the full marketing badge where the in-app glyph belongs, or vice versa.

## Open dependency

No dedicated wordmark-only (text, no gear) asset exists yet. If a text-only lockup is needed (e.g. narrow horizontal placements), it must be requested from brand — do not fabricate one.

## Platform identity: macOS

The macOS app intentionally carries its own identity: the graphite and amber Signal palette, and a minimal amber reset-mark icon (`assets/exports/macos/AppIcon.png`, sources in `assets/source/macos/`). The canonical palette, Windows and the website stay blue, and the cross-platform master icon is unchanged. Any other platform adopting amber or the new mark is a separate brand decision.
