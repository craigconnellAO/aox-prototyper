---
name: ideate-mode
description: Switch a project between locked (default) and ideate mode before starting screen, flow, or interaction-design work — and before writing anything into a project's DESIGN.md or PRODUCT.md. Trigger at the start of any screen-building, motion, or interaction-design task, especially work on a flow already marked "open" in IDEATION.md. Also trigger before /impeccable craft, shape, animate, delight, or overdrive touches a screen/flow that could change a settled DESIGN.md rule.
user-invocable: true
argument-hint: "[ideate|lock] [flow or screen name]"
---

# /ideate-mode: locked vs. ideate

Every project built with this Power defaults to **locked**: build strictly from the org `design.md`, `brand.md`, and this project's own `DESIGN.md` — approved variants only, no new decisions made on the fly. **`/ideate-mode` is how you deliberately step out of that** to explore freely, without committing.

Conflating the two causes real damage: exploratory motion/interaction choices get written into `DESIGN.md` as if they were settled rules, which then quietly constrains (or gets contradicted by) the next round of ideation. That happened once already on the Switch24 example project with the trust-bridge motion work (see `example-switch24/DESIGN.md` §Layout and §Motion, and the full history in `example-switch24/IDEATION.md` if present) — this skill exists to stop it happening again.

## When to ask

Ask via `AskUserQuestion` before starting substantive screen/flow/motion work, unless the mode is already obvious from the request itself. Signals that make it obvious (skip asking):

- Ideate is obvious: "just exploring", "quick experiment", "let's try a few options", "don't lock this in", "I'm not committing to this yet", or the user directly invokes `/ideate-mode`
- Locked is obvious: "lock this in", "make this final", "ship this", "update DESIGN.md with this"

If a flow already has an entry in the project's `IDEATION.md` marked `Status: open`, default to treating new work on it as **ideate** unless the user says otherwise — don't re-ask every turn, just carry the mode forward for that flow until the user signals a change (e.g. "ok, let's lock this in") or you reach a natural checkpoint worth confirming.

Ask like this:

```
question: "For this [screen/flow] work, are we in ideate mode or locked?"
options:
  - Ideate — explore freely, don't write constraints into DESIGN.md yet (Recommended default for early-stage work)
  - Locked — this is the final decision, update DESIGN.md/PRODUCT.md accordingly
```

## Ideate mode

- Build/iterate freely in the project's prototype output — that's fine to change as much as needed.
- Do **not** add or edit constraints in the project's `DESIGN.md` or `PRODUCT.md`.
- If a decision is worth remembering, record it in the project's `IDEATION.md` under a `##` heading for that flow (create the file using the ideation skill's method — see `skills/ideation/SKILL.md` — if the flow has no entry yet). Include: current state, reasoning so far, and an explicit "open questions" list. Never phrase entries as settled rules.
- If `DESIGN.md` already has a locked rule that the exploration is deliberately diverging from, leave the locked rule untouched and cross-reference it from `IDEATION.md` instead of editing it.

## Locked mode (default)

- Build strictly from `design.md`, `brand.md`, and the project's `DESIGN.md`/`PRODUCT.md`.
- If a decision genuinely needs to change: update `DESIGN.md`/`PRODUCT.md` following the convention — when a new decision replaces an old rule, keep the old rule's intent visible with a `Superseded <date>: <why>` note rather than silently deleting it.
- If the flow had an open entry in `IDEATION.md`, fold the finalized decision into `DESIGN.md`/`PRODUCT.md`, then remove that entry from `IDEATION.md` (or mark it `Status: locked — see DESIGN.md`) so the decision isn't tracked in two places.
- An org-wide token/rule change (not project-specific) goes into `steering/design.md` or `steering/brand.md` instead, following the pattern in `design.md` §7a (sub-brand exceptions) if it's a new exception rather than a correction.

## Relationship to /impeccable

This skill is a gate, not a replacement for `/impeccable`. Run this check first (or inline at the start of the turn), then proceed into `/impeccable`'s normal setup and command routing as usual. The mode chosen here determines whether `/impeccable`'s output gets written back into `DESIGN.md`/`PRODUCT.md` or into `IDEATION.md`.
