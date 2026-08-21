# Token Map — SDS → AO

How Figma's Simple Design System was re-pointed at AO's design system, what
was approximated, and what is deliberately missing.

Read this before changing anything in `src/styles/`. Most of the decisions
below are load-bearing, and two of them are counter-intuitive.

**Authority:** `steering/design.md` (AO Design Tokens). Code follows it.
This is a *code-first* project — Figma variables get generated from these
files, not the other way round. See README § Figma.

---

## The three layers

| Layer | File | May contain | Consumed by |
|---|---|---|---|
| 1 · Primitives | `ao-primitives.css` | **hex values** — the only file that may | layer 2 only |
| 2 · Semantic | `ao-theme.css` | `var()` into layer 1 | components |
| 3 · Components | `ui/primitives/*/*.css` | `var()` into layer 2 | — |

A component reaching past layer 2 into a primitive is a bug. It is how a
rebrand ends up 90% applied — the 10% surfaces months later on a screen
nobody re-checked.

**Coverage:** all **136** SDS semantic roles are mapped. Verified by set
comparison against upstream `sds/src/theme.css`, not by eye — zero missing,
zero extra. A missing role fails silently as an unstyled element, so this
check is worth re-running after any edit:

```bash
# from the repo root, with sds checked out alongside
diff <(sed -n '97,376p' ../sds/src/theme.css | grep -o '^  --sds-color-[a-z0-9-]*' | sed 's/^  //' | sort -u) \
     <(grep -o '^  --sds-color-[a-z0-9-]*' src/styles/ao-theme.css | sed 's/^  //' | sort -u)
```

---

## The two mappings that matter

### 1 · SDS `brand` → AO **action-primary**, not AO brand green

SDS paints primary CTAs with `background-brand-*`. AO keeps *brand* green
(`#12c35a`) and *action* green (`#00893e`) deliberately separate.

Mapping brand→brand would have been the literal reading, and it would have
put `#12c35a` on every button in the library — breaking AO's action
hierarchy everywhere at once, in a way that looks plausible enough to ship.
The functional mapping is the correct one:

| SDS role | AO token |
|---|---|
| `background-brand-default` | `--ao-action-primary-base` `#00893e` |
| `background-brand-hover` | `--ao-action-primary-hover` `#00560b` |
| `background-brand-secondary` | `--ao-brand-primary-light` `#befcc8` |

AO's brand green survives as `--ao-brand-primary-base`, used for borders and
accents where a brand mark is wanted rather than an action.

### 2 · SDS `neutral` → AO **navy**, and AO's blue has no SDS home

SDS `neutral` is a dark slate for high-contrast surfaces → AO's
`--ao-ui-dark-base` (`#011f44`).

AO's secondary action blue (`#0564c2`, "Action Main") has **no SDS role at
all** — SDS has no secondary-action intent. Rather than force it into an
ill-fitting role, it is added as an AO extension:

```css
--ao-x-accent-default   /* #0564c2 — AO secondary CTA */
--ao-x-inverse-default  /* #ffffff — AO btn-white, on navy/photography */
--ao-x-inactive-default /* #727677 — "unavailable", ≠ :disabled */
```

The `--ao-x-*` prefix marks "AO needs this, SDS never had it". Anything under
that prefix will need a matching Figma variable created by hand — it will not
come across from an SDS import.

---

## Contrast

Every colour pair the mapping creates was measured against WCAG 2.1 AA, not
assumed. Three failures were found on the first pass; two were real bugs and
were fixed.

| Pair | Before | After | Note |
|---|---|---|---|
| Text on warning **accent** | 2.41 ✗ | **7.96 ✓** | fixed → `--ao-type-primary` |
| Tag warning (`notice-warning-bg`) | 4.01 ✗ | **13.29 ✓** | fixed → `--ao-type-primary` |
| Disabled label on `gray-30` | 3.68 | 3.68 | **left alone** — see below |

**The warning family is the one genuinely narrow part of AO's palette.**
`--ui-warning-contrast` (`#ad5a00`) is tuned for the *pale* warning surface
(`#fff4e6`, 4.56:1). Put it on the saturated accent (`#ff9e36`) and it falls
to 2.41 — worse than the 3:1 large-text floor. Anywhere the warning
background is saturated, text switches to `--ao-type-primary`. If you add a
warning variant, measure it; don't pattern-match off the others.

**Disabled at 3.68 is intentional.** WCAG 2.1 §1.4.3 exempts inactive
controls from the contrast minimum, and raising it makes disabled read as
enabled — a worse accessibility outcome than the number suggests. Documented
rather than "fixed".

Re-run the audit after any palette change: `node scripts/contrast-audit.mjs`.
It resolves pairs through the real CSS rather than a hardcoded list, so it
catches a regression introduced by editing `ao-theme.css`.

### Known AO-level gap — control borders

`design.md` specifies `--gray-50` (`#c1c7c9`) for form-control borders
(`.field-input`). Against white that is **1.71:1**, below the **3:1** WCAG
2.1 §1.4.11 requires for the visual boundary of a UI component. Of AO's
neutrals only `--gray-70` (4.59:1) clears it.

This library **follows the spec and flags it** rather than silently
substituting a darker grey. Deviating from `design.md` on our own authority
is the exact failure the AOX Power exists to prevent, and a component
library quietly disagreeing with the design system is worse than a
documented disagreement.

The audit reports this row as `AO-GAP` on every run — visible, but not
failing the build, because the fix belongs to AO's design-system owners.

**Worth raising.** If they accept it, one token change in `design.md`
propagates through this whole library with no component edits — which is
itself a decent demonstration of why the layering is set up this way.

---

## Gaps and approximations

Where AO has no value for a step SDS expects, the **nearest real AO token**
is used. No hex was invented — inventing a ramp step is the exact failure
this design system exists to prevent, and a plausible-looking wrong green is
harder to catch than a missing one.

| SDS expects | AO reality | Resolution |
|---|---|---|
| 2 light steps per intent (`secondary` + `tertiary`) | AO ships one pale surface + one notice surface | notice → `secondary`, pale → `tertiary`. `brand` reuses `ui-success-base` for both. |
| `background-neutral-hover` | AO has no "navy hover" | `--ao-action-secondary-active` `#001876` |
| `utilities-blanket` / `overlay` / `scrim` | AO defines `--shadow-overlay` but no alpha overlays | built as `rgb(1 22 48 / …)` from AO's overlay navy |
| 10-step ramps per hue | AO ships purposeful tokens, not ramps | ramps not reconstructed; roles point at real tokens |
| `radius-600` / `radius-800` | — | **AO additions** (24px, 40px). SDS has no equivalent. |

### Deliberately excluded

- **Switch24 purple** (`#8023bd`) — a sanctioned sub-brand exception
  (design.md §7a), not core. Belongs to a project, not the library.
- **Food palette** (`--palette-bread`, `--palette-toast`, …) — marked
  *decorative only* in design.md. Add per-project if a campaign needs it.

---

## Known collision

`--action-primary-base` and `--ui-success-accent` are **the same green**
(`#00893e`) in AO. So `background-brand-default` and
`background-positive-default` resolve identically, and a green button next
to a green success state is indistinguishable by colour.

This is AO's property, not a mapping error. Components must separate "this
is the action" from "this succeeded" by shape, icon, and position — never by
colour alone. Worth raising with the design-system owners; it is the kind of
thing that is invisible until a user hits it.

---

## Typography

| Role | Family | Rule |
|---|---|---|
| Headings, display | SmileyFace | `--sds-typography-heading-font-family` |
| **Button / CTA labels** | **SmileyFace Bold** | `--ao-font-cta` |
| Body, UI labels, form fields | Inter | `--sds-typography-body-font-family` |

SDS shipped Inter for everything, including buttons. AO splits the roles, and
**a CTA set in Inter is the single most common tell of off-brand AO UI** —
it looks fine in isolation and wrong beside real AO.

`@font-face` is verbatim from design.md, loading from `media.ao.com`. Off the
AO network SmileyFace falls back to Georgia, so `preview.html` will look
wrong locally and correct in situ. That is expected; don't "fix" it by
substituting a web font.
