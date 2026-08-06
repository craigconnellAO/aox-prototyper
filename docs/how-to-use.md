# How to use AOX-Prototyper

A walkthrough for a designer installing this Power for the first time and starting a new project with it.

## 1. Install the Power

<img width="1570" height="898" alt="image" src="https://github.com/user-attachments/assets/256f33df-511d-43a2-af64-51fdaf130630" />

### The installer copies three things into your environment:
- `POWER.md`
- `steering`
- `mcp.json`

<sub>In Kiro: Powers panel → Add Custom Power → Import power from a folder (local testing) or from GitHub (once this repo is pushed/shared). Kiro reads `POWER.md` for the manifest and loads `steering/*.md` automatically.</sub>

<sub>You can confirm this yourself — look in `~/.kiro/powers/installed/aox-prototyper/`. The full repo stays at `~/.kiro/powers/repos/aox-prototyper/`, but nothing else is copied out of it. That's why steps 3 and 6 below exist.</sub>

<sub>Using Claude Code instead of Kiro? There's no install step — just work with this folder open (or copy `steering/`, `skills/`, and `templates/` into your project's `.claude/` equivalents). The content is tool-agnostic; only the installation mechanism differs.</sub>

## 2. Confirm it's active

Ask: *"What colour token would I use for a primary CTA?"*

A correctly-loaded Power answers `--action-primary-base` (or similar, from `steering/design.md`) — not a guessed hex value. If you get a guess, the steering isn't loading; check that `steering/` is where Kiro expects it relative to `POWER.md`.

## 3. Install the skills, hooks and component sheet

Powers don't auto-install skills, hooks or assets (a current Kiro limitation, not a choice made here) — and a Power can't run an install script of its own either. So this repo ships one you run yourself. From your workspace root:

```bash
bash ~/.kiro/powers/repos/aox-prototyper/scripts/install-aox-power.sh
```

Or, easier: ask Kiro *"install the AOX skills and hooks"*. It knows where to look, and it'll show you the command and the output. **Onboarding offers this in Batch 4**, so on a new project you can just say yes there and skip this step entirely.

Preview it first with `--dry-run` if you'd rather see what it touches. It's idempotent, so re-running it after a Power update is the normal way to pick up new hooks, and it backs up anything it would overwrite. `--uninstall` reverses it. Other flags: `--only skills,hooks`, `--target <dir>`, `--agent claude`.

On Windows without Git Bash or WSL, ask Kiro to make the copies with its file tools instead — the source→destination table is in `steering/onboarding-flow.md`.

### What lands where, and why

| | |
|---|---|
| `.kiro/skills/` | `figma-bridge`, `ideation`, `ideate-mode` — without these, `/ideate-mode` and the Figma push simply aren't available |
| `.kiro/hooks/` | the design-system scan and review (next section) |
| `.kiro/scripts/ds-scan.sh` | what the save-time hook runs |
| `assets/strata-component-sheet/` | **the one most people miss.** Protocol 1 tells Kiro to resolve headers, icons and the logo from `assets/strata-component-sheet/index.html` before writing any screen. Until that file is in your workspace, the instruction points at nothing — and hand-drawn icons are exactly what you get. |

### The two hooks, and why there are two

The old single guard hook fired a full agent review on every HTML save — including every save Kiro made itself, mid-build. On a normal session that's dozens of reviews of half-finished work. It's now split:

- **Design System Scan** — on save. A shell script. No agent turn, no credits, ~50ms. It greps for raw hex outside the `:root` block and for inline `<svg>`, and writes `.kiro/ds-guard-report.md`.
- **Design System Review** — on demand, from the Agent Hooks panel. Reads that report, decides which findings are real, and adds what a grep can't check: header variant, typography, spacing scale, `data-aods` coverage. **This is the one that costs you something**, which is why it's yours to trigger — when a screen or flow is done, not while it's being written. Kiro will offer it at those moments.

Legitimate SVGs — a brand logo, a sprite sheet, an illustration — stop being flagged once marked:

```html
<svg data-ds-allow="brand logo" viewBox="0 0 132 34">…</svg>
```

A third hook, **Design System Review (automatic)**, ships disabled. It runs the review once per agent turn instead of on demand and exits free when the scan is clean — enable it in `.kiro/hooks/design-system-review-on-stop.kiro.hook` if you'd rather not remember to click.

**Upgrading?** If you already have `design-system-guard.kiro.hook` from v1.2 or earlier, the installer retires it for you. If you copied it in by hand, delete it — leaving it there means still paying for the old behaviour.

### If your Kiro uses the newer hook format

Newer Kiro builds moved hooks to PascalCase trigger names (`PostFileSave`, `Stop`, …) with `trigger`/`action` fields instead of `when`/`then`. The hooks here use the `when`/`then` form. If yours don't load, the save-time scan translates directly:

```json
{
  "version": "v1",
  "hooks": [{
    "name": "Design System Scan",
    "trigger": "PostFileSave",
    "matcher": "\\.html$",
    "action": { "type": "command", "command": "bash .kiro/scripts/ds-scan.sh --quiet || true" }
  }]
}
```

The newer format has no manual trigger, so **use the `/design-review` skill** for the review pass rather than a hook — same review, invoked by name. That's the reason it ships as a skill as well as a hook, and it's also how this works in Claude Code, where `.kiro.hook` files don't apply at all.

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

- **AI is guessing colours/hand-drawing icons** → first check the component sheet is actually in your workspace (`ls assets/strata-component-sheet/`). Protocol 1 points at that path, and if it isn't there the instruction resolves to nothing — this is the most common cause by a distance. Run the installer (§3) if it's missing. If it *is* there, point Kiro at it explicitly once, then run the Design System Review over the file.
- **The design-system hook keeps firing and burning credits** → you're on the pre-v1.3 `design-system-guard.kiro.hook`, which ran an agent review on every save. Delete it from `.kiro/hooks/` and run the installer to get the scan + review pair. Re-running the installer retires the old hook for you.
- **The scan reports things that are fine** → it's meant to flag candidates, not verdicts. Mark the settled ones `data-ds-allow="reason"` and they stop appearing. Hex inside `:root` and `@font-face`, and hex in comments, are already exempt.
- **Figma push keeps failing or losing progress** → check `FIGMA_ACCESS_TOKEN` is set and the Desktop Bridge plugin shows connected *before* starting a multi-frame build, not after. See the resilient-push protocol in `skills/figma-bridge/SKILL.md`.
- **AI wrote an exploratory idea straight into `DESIGN.md`** → that's the exact failure `ideate-mode` exists to prevent. Ask it to move the content to `IDEATION.md` and mark it `Status: open`.
