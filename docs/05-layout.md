# Layout

## Desktop apps (Windows / macOS)

- Minimum window size: 720×640 — below this, card content in `08-components.md` patterns (two-column checklist rows) starts wrapping badly.
- Default window size: 900×760, matching the proportions in `screenshots/mac/main.png`.
- **macOS Repair Record layout:**
  - Single content column capped at `960pt` maximum width with `24pt` outer margins.
  - Native macOS titlebar and traffic-light placement preserved; no sidebar or tab bar.
  - Summary header and persistent primary action bar remain pinned/usable while the central repair record scrolls.
  - Responsive repair-record rows: at content width `840pt` or wider, rows align 4 columns (`sequence`, `operation`, `effect`, `outcome`); below `840pt`, the `effect` description stacks below `operation` while retaining a trailing `outcome` column.
  - Record rows have a `44pt` minimum height (growing with content), square corners (`0pt` radius) separated by `1pt` `border` rules, and interactive controls use `6pt` corner radius. Native sheets retain native macOS framing.
- **Windows exception:** the shipped Windows app is a compact single-task panel — default 520×600, minimum 440×520, one centered column capped at 420px, single-column checklist rows. See [`platforms/windows.md`](platforms/windows.md).

## Chrome extension

- Popup: fixed width **420px**, height range **480–600px** (scrolls internally past 600px rather than growing further — popups can't exceed the visible viewport reliably across screen sizes).
- Options page (if/when needed): behaves like a scaled-down website page, not a popup — full-width layout, use website breakpoints below.

## Website

- Breakpoints: `640px` (mobile → tablet), `1024px` (tablet → desktop), `1280px` (max content width).
- Content max-width: `1280px`, matching desktop margins.
- Grid: single column below `640px`, 12-column grid at `1024px`+.

## Shared rule

Every surface uses the same [`04-spacing.md`](04-spacing.md) scale for internal spacing — only the outer container constraints differ per platform.
