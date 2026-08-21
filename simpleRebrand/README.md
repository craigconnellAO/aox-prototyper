# simpleRebrand

Figma's [Simple Design System](https://github.com/figma/sds) rebranded to AO —
a component library to work from in code and in Figma.

Not a fork you patch. SDS's three-layer token architecture is kept intact and
re-pointed at AO's real tokens, so AO's design system stays the authority and
SDS supplies the structure.

---

## Status

**First slice.** Token layer complete; five proof components built.

| | |
|---|---|
| Token layer | ✅ all **136** SDS semantic roles mapped to AO |
| Typography | ✅ SmileyFace + Inter, correct role split |
| Components | ✅ Button, Input, Select, Tag, Card — **5 of 28** |
| Contrast | ✅ AA on every pair this library controls |
| Design-system scan | ✅ clean |
| Figma library | ⏳ not started — needs `FIGMA_ACCESS_TOKEN` |
| Storybook | ⏳ not wired up |

Remaining 23 SDS primitives — Accordion, Avatar, Checkbox, Dialog, Fieldset,
Icon, IconButton, Image, Link, ListBox, Logo, Menu, Navigation, Notification,
Pagination, Radio, Search, Slider, Switch, Tab, Table, Textarea, Tooltip —
are unported. They will inherit the AO look automatically once ported,
because the token layer they consume is already done.

---

## Look at it

`preview.html` is a static page — no build, no install:

```bash
open preview.html          # macOS
xdg-open preview.html      # Linux
```

Every component, every variant, with the token each colour resolves through.

> SmileyFace loads from `media.ao.com`. Off the AO network it falls back to
> Georgia, so headings and CTA labels will look wrong locally and correct in
> situ. Don't "fix" this by substituting a web font.

## Use it in code

```bash
npm install
```

```tsx
import { Button, Card, CardTitle, CardBody, Tag } from "./src/ui/primitives";
import "./src/styles/index.css";

<Card elevated>
  <CardTitle>Next-day delivery</CardTitle>
  <CardBody>Order before 8pm.</CardBody>
  <Tag intent="positive">In stock</Tag>
  <Button variant="primary">Choose</Button>
</Card>
```

Every component carries `data-aods`, so engineers can map a rendered element
back to its React component — the same convention the AOX Power's prototypes
use.

## Check it

```bash
node scripts/contrast-audit.mjs    # WCAG 2.1 AA over the token mapping
bash ../.claude/scripts/ds-scan.sh # AO design-system scan (raw hex, inline svg)
```

Run both before any commit that touches `src/styles/`.

---

## How it fits together

```
src/styles/
  ao-primitives.css   AO's raw values — the ONLY file with hex in it
  ao-theme.css        136 SDS roles -> AO primitives — no hex
  ao-size.css         radius / spacing / stroke / elevation
  ao-typography.css   SmileyFace + Inter, @font-face verbatim from design.md
  index.css           entry point; import order is load-bearing

src/ui/primitives/    components — consume roles only, never primitives
scripts/              contrast-audit.mjs
preview.html          static proof page
TOKEN-MAP.md          what maps to what, what was approximated, what's missing
```

**The rule that keeps a rebrand honest:** a component may only reference
layer 2. Reaching past it into a primitive is how a rebrand ends up 90%
applied, with the last 10% surfacing months later on a screen nobody
re-checked.

Two mapping decisions are counter-intuitive and both are explained in
[`TOKEN-MAP.md`](TOKEN-MAP.md) — start there before editing tokens:

- **SDS `brand` → AO action-primary**, *not* AO brand green. AO separates
  brand colour from action colour on purpose.
- **AO's secondary blue has no SDS role**, so it is added as `--ao-x-accent-*`
  rather than forced into an ill-fitting one.

---

## Figma

Not started. This is a **code-first** project: `design.md` is the authority,
and Figma variables get generated from these files rather than the reverse.

When `FIGMA_ACCESS_TOKEN` is set and the Desktop Bridge plugin is running:

1. Generate a Figma variable collection from `ao-primitives.css` +
   `ao-theme.css` — the two layers map onto Figma's primitive/semantic
   variable modes almost one-to-one.
2. Build the components as Figma component sets, variant props matching the
   React prop names (`variant`, `size`, `intent`).
3. Wire up `@figma/code-connect` so a Figma component links to its React
   source.

Anything under the `--ao-x-*` prefix needs a Figma variable created by hand —
it has no SDS ancestor to inherit from.

`simpleRebrand` is a **parallel greenfield** library: AO's existing
Design System 2025 Figma library (`vKoPePlSP1xhVxOuFXTJdB`) is untouched.
Nothing here disturbs work in flight.

---

## Provenance

Structure and token architecture from [figma/sds](https://github.com/figma/sds)
(MIT). Token values, typography, and component rules from AO's `design.md`
and `brand.md` via the [AOX-Prototyper](../README.md) Power.
