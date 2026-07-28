# Figma Bridge — [Project Name]

> The translation layer between this project's HTML prototypes and Figma builds.
> Fill in this file once at project start (Target File, Library File), then update it whenever a push discovers a new mapping, workaround, or project-specific component tweak. This file is the memory that stops every future push from rediscovering the same facts.

## Target Files

| Role | File | Key | Notes |
|---|---|---|---|
| Working file (pushes land here) | ✏️ [Project File Name] | [file_key] | Replace with your working Figma file |
| Component library (import from here) | Design System 2025 | `vKoPePlSP1xhVxOuFXTJdB` | AOX default — do not change |

**Prerequisites:**
- Both files must have the **Figma Desktop Bridge plugin** running
- `FIGMA_ACCESS_TOKEN` must be set in your environment
- Before pushing, confirm the connection is live via `figma_get_status` or similar

**Component import:** `figma.importComponentByKeyAsync(key)` in the working file pulls DS 2025 components across; both files being connected is what makes the keys resolve.

## Component Map

**Start with AOX defaults from `steering/figma-library.md`; add project-specific overrides below if any.**

| HTML element | Component | Key | Notes |
|---|---|---|---|
| | | | — Add project-specific mappings here, or copy rows from `steering/figma-library.md` if overriding |

## Icon Map

**Start with AOX defaults from `steering/figma-library.md`; note project-specific ones below.**

| Strata class | Component | Key | Notes |
|---|---|---|---|
| | | | — Add or override as needed |

## Font Map

**AOX defaults (do not change unless this project uses different fonts):**

| HTML | Figma fontName | Gotcha |
|---|---|---|
| `'SmileyFace'` woff (700) | `{ family: 'Smiley Face', style: 'Bold' }` | Space in family name |
| Inter 400 | `{ family: 'Inter', style: 'Regular' }` | |
| Inter 600 | `{ family: 'Inter', style: 'Semi Bold' }` | Space in style name |
| Inter 700 | `{ family: 'Inter', style: 'Bold' }` | |

**Project overrides:**

| HTML | Figma fontName | Reason |
|---|---|---|
| | | — Add if this project uses different fonts |

## Colour Map

**AOX defaults (see `steering/figma-library.md` for the full palette):**

Refer to `design.md` and `steering/figma-library.md` for the authoritative hex-to-role map.

**Project overrides (if any design-system exception is flagged):**

| Hex | Role | Reason |
|---|---|---|
| | | — Add if this project introduces non-standard colours |

## Conventions (method, not project-specific)

See `skills/figma-bridge/SKILL.md` § Core Conventions for the full list. Summary:

1. **Rotation sign flips.** Figma rotation is counterclockwise-positive: `figma_rotation = −css_rotate_deg`.
2. **Order = paint order.** CSS `column-reverse` stacks bottom-up; in Figma, array/child order is top-to-bottom.
3. **Frame naming.** Name frames `<n> · <state>` (e.g. `1 · After checkout`), grouped in a Section named `<letter> · <CONCEPT NAME>`.
4. **Component search before hand-drawing.** Use `figma_search_components`, `figma_get_library_components`, or the `search_design_system` MCP tool to resolve a component key before drawing a primitive. See `steering/figma-library.md` for known AOX components.
5. **Library instances that fight you.** Replace with drawn primitives and record the workaround here.

## Known Issues / Workarounds

**Project-specific issues and their resolutions:**

| Issue | Workaround | Notes |
|---|---|---|
| | | — Add as pushes discover non-standard patterns |

**AOX-wide known gaps:** See `steering/figma-library.md` § No DS 2025 component exists for (card, breadcrumb, notice, progress bar, tag/pill, account-nav pills, demo bar). Draw these as primitives.

## Design-System Conflicts Flagged

**Any time a push introduces a colour, component, or pattern not in `design.md` or `steering/figma-library.md`, record it here and decide whether to escalate or resolve.**

| Conflict | Context | Resolution | Date |
|---|---|---|---|
| | | — Refer to `design.md` §7a for the exception protocol | |

## Push Log

| Date | Concept / Section | Frames | Components Used | Status | Notes |
|---|---|---|---|---|---|
| | | | | | — Add a row per push |
