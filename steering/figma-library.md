---
inclusion: always
---

# AOX Figma Component Library Reference

AOX-specific component keys, icon mappings, and font fixes for use in **every** Figma bridge push. This is the authoritative source for component library facts; all projects reference this when filling in their project-specific `FIGMA-BRIDGE.md`.

## Library Files

| Role | File | Key |
|---|---|---|
| Component library (import from here) | Design System 2025 | `vKoPePlSP1xhVxOuFXTJdB` |

**Prerequisite:** Both the working file (pushes land here) and `Design System 2025` must have the **Desktop Bridge plugin** running. `figma.importComponentByKeyAsync(key)` in the working file pulls DS 2025 components across; both files being connected is what makes the keys resolve.

## Component Map (DS 2025 publish keys)

| HTML element | DS 2025 component | Key |
|---|---|---|
| `[data-aods="nav"]` full retail header + price-match bar | Header / Type=Mobile Default (375×108, resize to 390) | `02327ec58ac804ee8a854abf00f3a3dd7c8da860` |
| `[data-aods="nav"]` desktop header (search + categories + proposition) | Header / Type=Desktop 1200px (1440×175; also Desktop 990px = `97ba6001871aab0ebd5d11ca638a4eb31baed091`) | `98db250944bc3ae6ee087ec101c8e06a31f3bba6` |
| `.btn` primary CTA | Primary CTA / Type=No-Icon, State=Default, Large=False | `2b4fadbdacf9d9c043235bc46314be88a88bfd9c` |
| `.btn` primary CTA (large, icon) | Primary CTA / Type=Icon-Center, State=Default, Large=True | `cb454d83b0df939f4b6355e50ba9bc9644801bbc` |
| `.btn-secondary` | Button / Secondary (prop-based: `Button label`, `icon_left`, `icon_right` bools; renders blue) | `ca7abf3dd987005051ea37f69fc7ba97de689ab5` |
| `.toggle-item` styled radio card | Complex Radio Button (**set**, use `importComponentSetByKeyAsync`). Variant props `Checked` (True/False) + `Disabled`. Inner text nodes: `Title` + `Supporting text` only — **no price/cost field, no tag.** Fold cost into supporting text; draw any "recommended" tag as an ABSOLUTE sibling | `96502bada9b123b1d59b32b8340a8334de4b14f9` |

## Icon Map (Strata icons → DS 2025 keys)

| Strata class | DS 2025 key | Component |
|---|---|---|
| `ico-ao-logo` | `c0e0be1324e58865096a52aae84805bc6663b04e` | AO Logo / ao-logo-48px |
| `ico-lock` | `9afbad97ae727342455dbc35d5cb036ff5c09cb9` | Icons_Medium / lock |
| `ico-mobile-phones` | `3abe1d4c7a089dffc5d4f7002f644d43b344bd9b` | Icons_Medium / mobile-phones |
| `ico-protection` | `d74931242808f1633677dae67e0684ae155caad4` | Icons_Medium / protection |
| `ico-chevron-down` | `65e742c53f226f536af64a7e2e86eb169a79782c` | Icons_Small / chevron-down |
| `ico-chevron-right` | `0bb31f43f24fba8ab52726711b85f69f8cc120fa` | Icons_Small / chevron-right |

**General icons** (`ico-list`, `ico-refresh`, `ico-returns`, `ico-account`, `ico-delivery`, `ico-card`, `ico-exit`, `ico-picture`, `ico-info`): The `icons_Med` set (`1047611129c44ecbad62a8bce10bf21ed228f1fa`) holds **only 4 ClickCollect glyphs** — NOT a general icon library. These icons are published individually in DS 2025; **resolve each by name via `figma_search_components` before a push**, or draw a simple glyph and flag it in your project's `FIGMA-BRIDGE.md`.

**⚠️ Known workaround:** `ico-tick-circle` (Controls/tick-circle) renders NAVY, invisible on dark text contexts. **Do not use.** Draw instead: green ellipse (#12C35A) + white ✓ (Inter Bold) or vector check.

## Font Map

| HTML | Figma fontName | Gotcha |
|---|---|---|
| `'SmileyFace'` woff (700) | `{ family: 'Smiley Face', style: 'Bold' }` | **Space in the family name.** `'SmileyFace'` fails to load |
| Inter 400 | `{ family: 'Inter', style: 'Regular' }` | |
| Inter 600 | `{ family: 'Inter', style: 'Semi Bold' }` | **Space**: `'SemiBold'` fails |
| Inter 700 | `{ family: 'Inter', style: 'Bold' }` | |

**Usage:** Smiley Face carries headings, card/line/stub names, CTA labels. Inter carries everything else. Never Inter on a heading.

## Colour Map (hex → role)

```
#f8f9fa gray-10 page bg      #12c35a ON Green (decorative/ticks only, fails 3:1 as text)
#f0f2f2 gray-20 thumb bg     #befcc8 Light Green (drench surfaces, tints)
#e2e7e8 gray-30 divider      #02422b Dark Green (headings on light surfaces)
#d6dddf gray-40 border       #011f44 navy (names, demo bar)
#abb1b4 gray-60 chevron      #212121 body   #595d5e tertiary
#00893e CTA green            #0564c2 secondary action (Stay here)
Full palette (decorative only): #ffa878 Toast · #f96155 Heat · #c8d1ff Steam · #4a6dce Ice
```

Refer to `design.md` § Token Reference for the complete token-to-hex mapping.

## No DS 2025 component exists for

**Draw these as primitives and flag them in your project's `FIGMA-BRIDGE.md`:**

- Card surface
- Breadcrumb
- Notification/notice (a `Status alerts` set exists only in the separate *Design System Components* library `f2c65606e42d4934e4bf13d6f5c7de272f5e5eb0`)
- Progress bar
- Success tag/pill
- Account-nav pills
- Demo bar

When a new project first flags one of these, record it in the project's `FIGMA-BRIDGE.md` § Known Issues, and consider whether it should be drawn once and added to DS 2025 upstream (escalate via the `design.md` §7a exception protocol if it's a real, sanctioned pattern rather than a one-off).
