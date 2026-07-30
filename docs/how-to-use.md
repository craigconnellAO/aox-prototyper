# How to use AOX-Prototyper

A walkthrough for a designer installing this Power for the first time and starting a new project with it.

## 1. Install the Power

<img width="1570" height="898" alt="image" src="https://github.com/user-attachments/assets/256f33df-511d-43a2-af64-51fdaf130630" />

<sub>In Kiro: Powers panel → Add Custom Power → Import power from a folder (local testing) or from GitHub (once this repo is pushed/shared). Kiro reads `POWER.md` for the manifest and loads `steering/*.md` automatically.</sub>

The installer copies exactly three things into your environment: `POWER.md`, `steering/`, and `mcp.json`. You can confirm this yourself — look in `~/.kiro/powers/installed/aox-prototyper/`. The full repo stays at `~/.kiro/powers/repos/aox-prototyper/`, but nothing else is copied out of it. That's why steps 3 and 6 below exist.

Using Claude Code instead of Kiro? There's no install step — just work with this folder open (or copy `steering/`, `skills/`, and `templates/` into your project's `.claude/` equivalents). The content is tool-agnostic; only the installation mechanism differs.

## 2. Confirm it's active

Ask: *"What colour token would I use for a primary CTA?"*

A correctly-loaded Power answers `--action-primary-base` (or similar, from `steering/design.md`) — not a guessed hex value. If you get a guess, the steering isn't loading; check that `steering/` is where Kiro expects it relative to `POWER.md`.

## 3. Install the skills and hook (all optional for now)

Powers don't yet auto-install skills or hooks (this is a current Kiro limitation, not a choice made here). Copy manually, once:

```bash
cp -r skills/figma-bridge skills/ideation skills/ideate-mode <your-workspace>/.kiro/skills/
cp hooks/design-system-guard.kiro.hook <your-workspace>/.kiro/hooks/
```

The guard hook is optional — the design-system rules are enforced by steering regardless. It's a second line of defence on save, aimed at the one failure mode that steering alone has historically not caught: a hand-drawn `<svg>` standing in for a real Strata icon.

## 4. Install impeccable (optional)

`impeccable` is the frontend-craft skill this Power's templates and `ideate-mode` are built to work alongside — it reads a project's `PRODUCT.md` and `DESIGN.md` before doing any work. Install it via its own current instructions (`npx impeccable`, or your workspace's existing `.kiro/skills/impeccable/` or `.claude/skills/impeccable/` if already present). This Power doesn't vendor a copy, so you always get the current version.

Onboarding checks whether you already have it before offering to install, and writes an `IMPECCABLE.md` reference card into your project when it's present — what each command does, and which ones belong behind `/ideate-mode` because they deliberately push away from the locked system.

**One thing to know up front:** impeccable doesn't only read `PRODUCT.md` and `DESIGN.md` — `/impeccable init` and `/impeccable document` *write* them. It always asks before overwriting, so nothing is lost silently, but its `DESIGN.md` follows the Google Stitch spec (YAML token frontmatter, six fixed sections) rather than the AOX shape. Decline that one. Its `PRODUCT.md` is near-identical to the AOX section list and is safe to let it extend.

## 5. Set your Figma token

```bash
export FIGMA_ACCESS_TOKEN="figd_..."
```

Generate one from Figma → Settings → Security → Personal access tokens. Without this, `mcp.json`'s `figma-console` server won't connect and the `figma-bridge` skill can't push anything.

## 6. Start a new project

Two ways, and they end in the same place.

**Guided (recommended).** Open your new project folder and start a session. Kiro sees the spec files aren't there and offers a five-batch onboarding questionnaire — project and problem, user stories and flows, layout and locked decisions, tools, references. About two minutes. It writes `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`, `STATUS.md`, `QUICKSTART.md`, and `FIGMA-BRIDGE.md` for you, then you're building.

You can say "skip onboarding" at any point, including mid-flow — whatever's been gathered gets written, and the rest is yours to fill in.

**By hand.** Copy the templates in — keep the exact filenames, they're what `impeccable` and `ideate-mode` look for:

```bash
mkdir my-new-project
cp templates/DISCOVERY.md templates/PRODUCT.md templates/DESIGN.md my-new-project/
```

Each template opens with an **At a Glance** section — the fast facts that let the AI build a correct screen. Fill that first. The deeper sections below it are the reasoning behind each line, and they're worth a pass once the shape settles.

Then fill them in, in this order:

1. **`DISCOVERY.md` first** — the research, problem statement, hypotheses. Everything else should trace back to this.
2. **`PRODUCT.md` second** — users, purpose, commercial goals, brand personality, and (important) what the product explicitly is *not*.
3. **`DESIGN.md` last, and lightly at first** — only fill in what's genuinely locked. Leave open questions for `IDEATION.md` (create it when you first need it, following `example-switch24/IDEATION.md`'s structure) rather than guessing early.

Use `example-switch24/` as your reference throughout — it's the same three files, filled in for a real shipped flow, plus the ideation history and Figma push log that came out of actually building it.

## 7. Build

Ask for a screen or flow as normal. The AI should:

- Pull tokens/components from `steering/design.md`, never invent values
- Pull the exact header/icon/logo markup from `assets/strata-component-sheet/index.html` before writing anything (this is Protocol 1 in `steering/aox-design-system.md` — the single biggest source of rework in earlier sessions)
- Run a visual verification pass before calling anything done, or say explicitly what's unverified (Protocol 2)
- Stay in locked mode by default — if you want to explore something outside the current `DESIGN.md`, say so, or invoke `/ideate-mode` yourself

## 8. Push to Figma (optional)

`FIGMA-BRIDGE.md` is already in your project — onboarding writes it with a placeholder target file, whether or not you had a Figma token at the time. Confirm the Figma Desktop Bridge plugin is running and connected in your target file, then:

1. Fill in your real target Figma file name and key in `FIGMA-BRIDGE.md` (leave the library row as-is, it points to AOX's Design System 2025)
2. Consult `steering/figma-library.md` for the AOX component keys, icon mappings, and font gotchas
3. Invoke the `figma-bridge` skill — it'll read your project's `FIGMA-BRIDGE.md` and update it with whatever the push discovers

If you built your project by hand instead of through onboarding, copy `templates/FIGMA-BRIDGE.md` in first.

## 9. Explore multiple directions (optional)

For a genuinely open design question — several plausible structural approaches, not just visual variants — invoke `/ideate-mode` to enter exploratory mode, then use the `ideation` skill to run a structured divergence/scoring/convergence round. See `example-switch24/IDEATION.md` for what a full round looks like end to end, including a round that caught its own internal contradiction and led to a follow-up round.

## Troubleshooting

- **AI is guessing colours/hand-drawing icons** → steering isn't loaded, or it's not being told to check `assets/strata-component-sheet/index.html` first. Point it there explicitly once; if it keeps happening, check the `design-system-guard` hook installed correctly.
- **Figma push keeps failing or losing progress** → check `FIGMA_ACCESS_TOKEN` is set and the Desktop Bridge plugin shows connected *before* starting a multi-frame build, not after. See the resilient-push protocol in `skills/figma-bridge/SKILL.md`.
- **AI wrote an exploratory idea straight into `DESIGN.md`** → that's the exact failure `ideate-mode` exists to prevent. Ask it to move the content to `IDEATION.md` and mark it `Status: open`.
