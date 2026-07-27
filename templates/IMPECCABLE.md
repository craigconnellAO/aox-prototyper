# Impeccable — What You Can Ask For

You've got **impeccable** installed alongside AOX-Prototyper. This is your reference for what it does and when to reject its suggestions.

The short version: **AOX-Prototyper decides what's correct. Impeccable decides what's good.** The design system is the constraint; impeccable is the craft layer working inside it. When they disagree, the design system wins — unless you've deliberately entered `/ideate-mode`.

---

## Read this first — two commands can overwrite your spec files

`/impeccable init` and `/impeccable document` write `PRODUCT.md` and `DESIGN.md` at the project root — the same filenames AOX-Prototyper uses.

Impeccable is well-behaved about it: it never overwrites silently, and it will ask whether to refresh, overwrite, or merge. **Say no for `DESIGN.md`.** Impeccable's version follows the Google Stitch DESIGN.md spec — YAML token frontmatter plus six fixed, non-renameable sections — which is a different schema from the AOX one. Accepting it replaces your locked decisions, colour strategy, and open-questions register with a file the AOX steering can't read properly.

`PRODUCT.md` is friendlier. Impeccable wants target users, product purpose, brand personality, anti-references, and design principles — which is very nearly the AOX `PRODUCT.md` section list already. If it offers to add a `## Register` or `## Platform` section, that's harmless and makes impeccable work better. Let it.

You almost certainly don't need `/impeccable init` at all: onboarding already did that job.

---

## Commands

### Plan and build

| Command | What it does |
|---|---|
| `/impeccable shape [feature]` | Plan UX and UI before any code |
| `/impeccable craft [feature]` | Full brief-then-build flow — discovery, then build with visual iteration |
| `/impeccable live` | Interactive live variant mode — iterate on a running UI in the browser |

### Review

| Command | What it does |
|---|---|
| `/impeccable critique [area]` | UX evaluation — hierarchy, information architecture, cognitive load, with scoring, persona testing, and anti-pattern detection |
| `/impeccable audit [area]` | Technical quality — accessibility, performance, theming, responsive, anti-patterns |

Both are safe on AOX work and the best place to start. `audit` overlaps usefully with the design-system guard: it catches the accessibility and responsive issues the guard doesn't look at.

### Clarify and tighten

| Command | What it does |
|---|---|
| `/impeccable clarify [target]` | Fix unclear copy, error messages, microcopy, labels |
| `/impeccable typeset [target]` | Font choices, hierarchy, sizing, weight, readability |
| `/impeccable layout [target]` | Layout, spacing, visual rhythm |
| `/impeccable distill [target]` | Strip to essence — remove unnecessary complexity |

Check `typeset` and `layout` output against `design.md` before accepting. They're strong on craft but don't know the AOX type scale or the 4px spacing grid, so they'll occasionally suggest values that aren't in the system.

### Production readiness

| Command | What it does |
|---|---|
| `/impeccable harden [target]` | Error handling, i18n, text overflow, edge cases, resilience under real data |
| `/impeccable optimize [target]` | Loading speed, rendering, animation, images, bundle size |
| `/impeccable polish [target]` | Final pass — alignment, spacing, consistency, micro-detail |
| `/impeccable adapt [target] [context]` | Adapt across screen sizes, devices, platforms |
| `/impeccable onboard [target]` | Onboarding flows, first-run experiences, empty states |
| `/impeccable extract [target]` | Pull repeated patterns and tokens back into a consistent system |

`harden` is the highest-value one here for AOX prototypes — edge cases and text overflow are exactly what a prototype built from a happy-path flow tends to miss.

### Expression — `/ideate-mode` territory

| Command | What it does |
|---|---|
| `/impeccable bolder [target]` | Amplify safe or boring designs |
| `/impeccable colorize [target]` | Add strategic colour to monochromatic interfaces |
| `/impeccable delight [target]` | Moments of joy, personality, unexpected touches |
| `/impeccable animate [target]` | Purposeful animation, micro-interactions, motion |
| `/impeccable overdrive [target]` | Shaders, spring physics, scroll-driven reveals, 60fps |
| `/impeccable quieter [target]` | Tone down overstimulating designs |

**These push away from the locked design system by design** — that's the point of them. Running one inside a locked AOX project will produce output that violates `design.md`: colours outside the palette, motion the system doesn't sanction, type treatments off the scale.

That's not a reason to avoid them. It's a reason to invoke `/ideate-mode` first, so the exploration lands in `IDEATION.md` rather than leaking into your locked `DESIGN.md`. `quieter` is the exception — it usually moves *toward* system compliance, not away.

---

## A sensible sequence

1. Build the screen with AOX-Prototyper as normal
2. `/impeccable critique` — find out what's actually weak
3. `/impeccable harden` — the edge cases the happy path missed
4. `/impeccable polish` — final alignment and micro-detail
5. Re-check against `design.md` before it goes anywhere

Anything from the expression group goes through `/ideate-mode` first.

---

*Command list generated from the installed impeccable skill. Run `/impeccable` with no arguments to see what your installed version offers if this looks out of date.*
