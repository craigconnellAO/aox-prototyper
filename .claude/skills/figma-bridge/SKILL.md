---
name: figma-bridge
description: Push an HTML prototype (built from this design system) into Figma via the figma-console MCP / Desktop Bridge, translating CSS/HTML conventions into Figma's node model. Trigger when the user asks to push, build, or recreate a prototype/screen/flow in Figma, or wants an HTML prototype turned into editable Figma frames. Read this before every push. Update a project's own FIGMA-BRIDGE.md whenever a push discovers a new mapping, workaround, or library key — that file is the memory that stops every future push from rediscovering the same facts.
user-invocable: true
argument-hint: "[prototype file or flow name] [target Figma page/section]"
---

# Figma Bridge: HTML → Figma translation

The translation layer between HTML prototypes built under this design system and Figma builds, using the `figma-console` MCP (Desktop Bridge, WebSocket) declared in this Power's `mcp.json`.

This skill carries the **method** — the conventions that hold for any project. Project-specific facts (which Figma file/page to push to, the running push log, any project-specific component tweaks) belong in that project's own `FIGMA-BRIDGE.md`. Read the project's file first if one exists; create it from `templates/FIGMA-BRIDGE.md` if this is a new project's first push. **AOX-specific facts** (component keys, icon mappings, font gotchas, known gaps) live in `steering/figma-library.md` — reference it, don't copy it into each project.

## Before every push

1. **Confirm the connection is live** — the Figma MCP and Desktop Bridge plugin must both be running and the working file + component-library file must be connected (so `importComponentByKeyAsync` resolves). See `steering/aox-design-system.md` Protocol 3 (resilient-Figma) — don't start a heavy build without checking this first.
2. **Resolve components before drawing primitives.** Use `figma_search_components`, `figma_get_library_components`, or the `search_design_system` MCP tool to find an existing component before hand-drawing a card, notice, or button. For AOX projects, start by consulting `steering/figma-library.md` — it carries the known component keys and icon mappings. Record in the project's `FIGMA-BRIDGE.md` when no library component exists for something — that becomes the standing "draw as primitive" list for next time.
3. **Never reuse node IDs across sessions** — they're session-specific and go stale. Re-search/re-resolve each session.

## Core conventions (apply to any project)

1. **Rotation sign flips.** Figma rotation is counterclockwise-positive. `figma_rotation = −css_rotate_deg` (CSS `rotate(-2deg)` → Figma `rotation: 2`).
2. **Order = paint order.** CSS `column-reverse` stacks bottom-up; in Figma, array/child order is top-to-bottom. Re-derive visual order before building, don't assume it carries over.
3. **Frame naming.** Name frames `<n> · <state>` (e.g. `1 · After checkout`), grouped in a Section named `<letter> · <CONCEPT NAME>` or equivalent project convention.
4. **Fonts have exact Figma names that differ from CSS.** A bold family with a space in its name (e.g. `Smiley Face` not `SmileyFace`) will silently fail to load if you use the CSS font-family string verbatim. For AOX projects, consult `steering/figma-library.md` § Font Map — it lists the exact Figma `fontName` objects. Record any project-specific font overrides in that project's `FIGMA-BRIDGE.md` font map.
5. **Animations can't cross into a static frame.** Represent one-shot moments (bursts, draws, transitions) at their most legible mid-frame, and annotate the frame (a small note outside the frame, or in the section description) with duration + easing.
6. **Dashed dividers**: use `dashPattern` on strokes, not a dashed-border hack.
7. **Long scripts time out.** Default `figma_execute` timeout is short (commonly 5s); pass an explicit longer `timeout` and build **one frame per call**. Re-import components by key in each call — imports are cheap once cached, and this avoids losing an entire multi-frame build to one timeout.
8. **Library instances that fight you** (locked fills, wrong theme, wrong colour rendering) — don't fight the instance. Replace with a drawn primitive and record the workaround in the project's `FIGMA-BRIDGE.md` so the next push doesn't rediscover it.
9. **Resize is not always trustworthy.** Some components (e.g. a CTA that hugs its label) silently ignore a resize call the first time. Verify the resulting dimension after the call — don't trust that the call succeeded just because it didn't error.
10. **Clone-then-retext can collapse mixed text styles.** Setting `.characters` on a mixed-style text node (e.g. partially bold) inherits the first run's style across the whole string when the length changes. After retexting a mixed node: reset the full range to base style/colour, then re-apply bold/colour ranges.
11. **State variants: build once, clone and patch.** Build frame 1 fully, then `clone()` + patch text/state per variant. One build call plus N clone calls beats N full builds.

## Resilient-push protocol

This exists because Figma Desktop Bridge disconnects, 403 auth errors, and session limits have repeatedly interrupted builds mid-flow and lost progress (see `steering/aox-design-system.md` Protocol 3).

- **Before starting a multi-frame push**, write a short checkpoint list of the planned frames/sections in your own working notes (not necessarily a file — a stated plan in the turn is enough for a small push; use a scratch file for a large one).
- **After each frame commits**, note it as done before moving to the next. If a call times out, drops connection, or 403s: don't retry silently more than a couple of times — say so, and either resume from the last confirmed frame or hand back control.
- **On resume** (new session, reconnect), re-verify which frames actually landed (list the target page/section) before re-running anything — don't assume the checkpoint list is still accurate after a disconnect.

## After a push

Update the project's `FIGMA-BRIDGE.md`:

- Add to the component/font/colour maps if this push resolved something new
- Add a row to the push log: concept, frames, status
- Flag any design-system conflict surfaced by the push (e.g. a colour or component used in the HTML that isn't sanctioned in `design.md`) — don't silently reproduce it without flagging; see `design.md` §7a for how a sub-brand exception gets resolved and promoted if it turns out to be a real, sanctioned decision rather than a one-off drift.
