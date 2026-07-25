# Figma Bridge

> The translation layer between HTML prototypes (this repo) and Figma builds.
> Read this BEFORE pushing any prototype to Figma. Update it whenever a push
> discovers a new mapping, workaround, or library key — this file is the
> memory that stops every push from rediscovering the same facts.

## Files

| Role | File | Key |
|---|---|---|
| Working file (pushes land here) | ✏️ Scratchpad | `Uub5706lK72mNADafbZusu` |
| Component library (import from here) | Design System 2025 | `vKoPePlSP1xhVxOuFXTJdB` |

Both need the **Desktop Bridge plugin** running (figma-console MCP, WebSocket).
`figma.importComponentByKeyAsync(key)` in the working file pulls DS 2025
components across; both files being connected is what makes the keys resolve.

Trust-bridge pushes land on the **`receipt output`** page, one named Section
per concept, placed to the right of existing content — never overlapping.

## Component map (DS 2025 publish keys)

| HTML element | DS 2025 component | Key |
|---|---|---|
| `[data-aods="nav"]` full retail header + price-match bar | Header / Type=Mobile Default (375×108, resize to 390) | `02327ec58ac804ee8a854abf00f3a3dd7c8da860` |
| `[data-aods="nav"]` desktop header (search + categories + proposition) | Header / Type=Desktop 1200px (1440×175; also Desktop 990px = `97ba6001871aab0ebd5d11ca638a4eb31baed091`) | `98db250944bc3ae6ee087ec101c8e06a31f3bba6` |
| `.btn` primary CTA | Primary CTA / Type=No-Icon, State=Default, Large=False | `2b4fadbdacf9d9c043235bc46314be88a88bfd9c` |
| `.btn` primary CTA (large, icon) | Primary CTA / Type=Icon-Center, State=Default, Large=True | `cb454d83b0df939f4b6355e50ba9bc9644801bbc` |
| `.btn-secondary` | Button / Secondary (prop-based: `Button label`, `icon_left`, `icon_right` bools; renders blue) | `ca7abf3dd987005051ea37f69fc7ba97de689ab5` |
| `.toggle-item` styled radio card | Complex Radio Button (**set**, use `importComponentSetByKeyAsync`). Variant props `Checked` (True/False) + `Disabled`. Inner text nodes: `Title` + `Supporting text` only — **no price/cost field, no tag.** Fold cost into supporting text; draw any "recommended" tag as an ABSOLUTE sibling | `96502bada9b123b1d59b32b8340a8334de4b14f9` |
| `ico-ao-logo` | AO Logo / ao-logo-48px | `c0e0be1324e58865096a52aae84805bc6663b04e` |
| `ico-lock` | Icons_Medium / lock | `9afbad97ae727342455dbc35d5cb036ff5c09cb9` |
| `ico-mobile-phones` | Icons_Medium / mobile-phones | `3abe1d4c7a089dffc5d4f7002f644d43b344bd9b` |
| `ico-protection` | Icons_Medium / protection | `d74931242808f1633677dae67e0684ae155caad4` |
| `ico-chevron-down` | Icons_Small / chevron-down | `65e742c53f226f536af64a7e2e86eb169a79782c` |
| `ico-chevron-right` | Icons_Small / chevron-right | `0bb31f43f24fba8ab52726711b85f69f8cc120fa` |
| `ico-tick-circle` | ⚠️ Controls/tick-circle (`16d21ee…`) renders NAVY, invisible on dark text contexts. **Do not use.** Draw instead: green ellipse (#12C35A) + white ✓ (Inter Bold) or vector check | — |
| general account/UI icons (`ico-list`, `ico-refresh`, `ico-returns`, `ico-account`, `ico-delivery`, `ico-card`, `ico-exit`, `ico-picture`, `ico-info`) | ⚠️ `icons_Med` set (`1047611129c44ecbad62a8bce10bf21ed228f1fa`) holds **only 4 ClickCollect glyphs** — NOT a general icon library. These icons are published individually; resolve each by name via `search_design_system` before a push, or draw a simple glyph and flag | — |

**No DS 2025 component exists for:** card surface, breadcrumb, notification/notice (a `Status alerts` set exists only in the separate *Design System Components* library `f2c65606e42d4934e4bf13d6f5c7de272f5e5eb0`), progress bar, success tag/pill, account-nav pills, demo bar. Draw these as primitives and flag.

## Font map

| HTML | Figma fontName | Gotcha |
|---|---|---|
| `'SmileyFace'` woff (700) | `{ family: 'Smiley Face', style: 'Bold' }` | **Space in the family name.** `'SmileyFace'` fails to load |
| Inter 400 | `{ family: 'Inter', style: 'Regular' }` | |
| Inter 600 | `{ family: 'Inter', style: 'Semi Bold' }` | **Space**: `'SemiBold'` fails |
| Inter 700 | `{ family: 'Inter', style: 'Bold' }` | |

Smiley Face carries: headings, card/line/stub names, CTA labels — same as the
HTML. Inter carries everything else. Never Inter on a heading.

## Colour map (hex → role, from design.md tokens)

```
#f8f9fa gray-10 page bg      #12c35a ON Green (decorative/ticks only, fails 3:1 as text)
#f0f2f2 gray-20 thumb bg     #befcc8 Light Green (drench surfaces, tints)
#e2e7e8 gray-30 divider      #02422b Dark Green (headings on light surfaces)
#d6dddf gray-40 border       #011f44 navy (names, demo bar)
#abb1b4 gray-60 chevron      #212121 body   #595d5e tertiary
#00893e CTA green            #0564c2 secondary action (Stay here)
Full palette (decorative only): #ffa878 Toast · #f96155 Heat · #c8d1ff Steam · #4a6dce Ice
```

## Conventions (the "language")

1. **Rotation sign flips.** Figma rotation is counterclockwise-positive.
   `figma_rotation = −css_rotate_deg` (CSS `rotate(-2deg)` → Figma `rotation: 2`).
2. **Order = paint order.** CSS `column-reverse` stacks bottom-up; in Figma,
   array/child order is top-to-bottom. Re-derive visual order before building.
3. **Frames are 390×844**, named `<n> · <state>` (e.g. `1 · After checkout`),
   grouped in a Section named `<letter> · <CONCEPT NAME>`.
4. **Receipt teeth** = row of 14×8 white polygons along the paper edge
   (rotate the row for vertical/stub edges).
5. **Countdown ring on CTA** = 20px donut-segment ellipse (arcData innerRadius
   ~0.62) in white, overlaid right of the label.
6. **Demo bar** = navy (#011f44) pill, radius 40, Inter Bold ~12, gray-50 tag +
   white state. It is prototype chrome; keep it so Figma frames match the HTML 1:1.
7. **Animations can't cross.** Represent one-shot moments (bursts, draws) at
   their most legible mid-frame and annotate the frame (a small note outside
   the frame or in the section description) with duration + easing.
8. **Dashed dividers**: strokes with `dashPattern: [3, 3]`, gray-40/gray-30.
9. **Long scripts time out.** Default figma_execute timeout is 5s; pass
   `timeout: 30000` and build ONE frame per call. Re-import components by key
   in each call (imports are cheap once cached).
10. **Library instances that fight you** (locked fills, wrong theme): replace
    with drawn primitives and record the workaround here (see tick-circle).
11. **Primary CTA hugs its label** (~208px natural). `resizeWithoutConstraints`
    silently fails; a second plain `resize(320, 52)` after the label edit takes.
    Verify `cta.width` afterwards — don't trust the call.
12. **Clone-then-retext collapses style runs.** Setting `.characters` on a
    mixed-style text node inherits the first run's style across the whole
    string when lengths change. After any retext of a mixed node: reset the
    full range to base style/colour, THEN re-apply bold/colour ranges.
13. **State variants: build frame 1 fully, then `clone()` + patch text** per
    state. One build call, one clone call — far faster than three builds.

## Push log

| Concept | Frames | Status |
|---|---|---|
| B · Receipt stack | `1/2/3 ·` on receipt output | pushed, patched (header, SmileyFace, ticks) |
| D · One receipt | — | not yet pushed |
| G · Ta da! ticket | Section `G · TA DA! TICKET` on receipt output (frames `75:5253` / `75:6048` / `75:6456`) | pushed 2026-07-05 ✓ |
| H · Switch24 account hub | Section `H · SWITCH24 ACCOUNT HUB` on page `designMD v3`. Frame `1 · Switch24 hub` (`107:2`, 390×1557 mobile) + frame `2 · Switch24 hub (desktop)` (`111:170`, 1440-wide, centered 1200 grid: 280px sidebar + 880px main, two-column choice grid). Library used: mobile + Desktop 1200px Header, 3× Complex Radio Button, Primary CTA No-Icon, mobile-phones icon. Drawn/flagged: purple sub-brand, card, breadcrumb, sidebar/pill nav (icon slots are placeholders — per-icon library instances not mapped), progress bar, success tag, notice, demo bar | pushed 2026-07-09 ✓ |

## ⚠️ Design-system conflict flagged (account-switch-hub.html)

`account-switch-hub.html` introduces a **`--switch-purple` (#8023BD) sub-brand** — used on the banner, the active Switch24 nav pill/accent, the progress-bar fill and the white banner button's text. This **directly contradicts DESIGN.md → Color Strategy** (locked): *"Switch does not introduce new colours… AO brand green as primary identity, no additional accent."* Purple is not in the colour map above. It was reproduced faithfully in the push (to match the HTML) but **should be resolved against DESIGN.md before this is treated as settled** — either fold the purple decision into DESIGN.md or re-skin these elements to AO green.
