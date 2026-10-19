# Icons

## Source

In-UI icons (status marks, section headers, checklist rows) use **Lucide** — consistent stroke weight (2px) and 24×24 grid out of the box, matches the rounded-but-technical feel of the product. Don't mix in another icon set for UI chrome.

The brand gear mark (`assets/gear.png`) is separate from Lucide and is not used as a generic UI icon — see rules below and [`01-brand.md`](01-brand.md).

## Export sizes per platform (app/extension icon, not UI icons)

| Platform | Sizes needed |
|---|---|
| macOS app icon | 16, 32, 64, 128, 256, 512, 1024 (`.icns`, generated from the 1024 source in `assets/`) |
| macOS menu bar (template image) | 16, 32 (@1x/@2x) — monochrome, alpha-only, derived from `gear.png` simplified to a single-color glyph |
| Windows app icon | 16, 24, 32, 48, 256 (`.ico`, multi-resolution) |
| Windows system tray | 16, 20, 24, 32 |
| Chrome extension (MV3 `action` icon) | 16, 32, 48, 128 (`.png`), sourced from `gear.png` — see rule below |
| Website favicon | 16, 32, 48, 180 (apple-touch-icon), 512 (PWA/OG fallback) |

**Chrome extension exception:** always generate the MV3 action icon from `assets/gear.png`, never the full app-icon badge. Extension icons render at 16–32px in the toolbar, too small for the "1132 FIXER" wordmark to stay legible — `gear.png` alone holds up at that size.

## Rules

- In-UI icons (checkmarks, status icons, section header icons) are functional, not branded — Lucide, sized to match adjacent text (`body`/`label`), colored with `text-primary`, `success`, `warning`, or `error` per [`02-colors.md`](02-colors.md) state rules.
- **macOS platform exception:** the native macOS SwiftUI app uses **SF Symbols** for functional controls and status indicators so symbols scale natively with SF Pro weights and accessibility sizes. Do not place ornamental/decorative icons beside section headings, and always pair status symbols with explicit words. See [`platforms/macos.md`](platforms/macos.md).
- The brand gear mark is reserved for app/extension icons and menu-bar/tray glyphs — never substitute it for a Lucide or SF Symbol icon inside product UI.
