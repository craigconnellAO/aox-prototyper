---
inclusion: always
---

# AOX-Prototyper — Onboarding Flow

This file has two parts, and they gate independently:

- **The questionnaire** (most of this file) is dormant unless the spec-file condition below is met.
- **[Installing skills, hooks and the component sheet](#installing-skills-hooks-and-the-component-sheet)** applies whenever the user asks for it, at any point in a project's life. Onboarding offers it in Batch 4, but it is not owned by onboarding — if someone asks six months later why `/ideate-mode` isn't available, that section is the answer.

## When the questionnaire applies — read this gate first

**The questionnaire is dormant unless a specific condition is met. Check it before doing anything else here, and if it isn't met, ignore everything down to *Writing the files* — do not mention onboarding, do not offer it, do not let it colour your response.** (The install section below the questionnaire is separate and always available; see the two-part note above.)

The condition: at the workspace root, one or more of `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md` is either

- **missing**, or
- **present but still carries the marker** `AOX-PROTOTYPER: This template is unfilled`.

If all three exist and none carry the marker, the questionnaire is done — skip to *Installing skills, hooks and the component sheet* and read no further into the batches.

If the condition *is* met, offer onboarding **once**, at the top of your first reply in the session. If the user declines or ignores it, don't raise it again that session.

> "Before we start — I can see this project's spec files aren't filled in yet. Want me to run a quick onboarding questionnaire to populate them? Takes about two minutes, and it's what makes the prototypes I generate actually match your project. Or say *skip* and I'll leave them to you."

If the user says skip: confirm the files are ready for manual editing, create `STATUS.md` (see below) so progress tracking still works, and move on to whatever they actually asked for.

---

## How the files get created

The Kiro Power installer copies only `POWER.md`, `steering/`, and `mcp.json` into a workspace — **`templates/` is not delivered automatically**. So:

- If `templates/` *is* present in the workspace (the user cloned the repo), copy from there and fill in place.
- If it isn't, **write the files yourself** from the outlines in this document. Don't send the user off to fetch a repo mid-conversation.

Either way, the finished file must not contain the `AOX-PROTOTYPER: This template is unfilled` marker — its absence is what signals onboarding is complete.

---

## Instructions

1. Be warm, concise, and conversational — match AO's tone.
2. Ask in batches of 2-3, not one question at a time. Respect the user's time.
3. After each batch, reflect back what you captured before moving on.
4. If the user says "skip onboarding" at any point, stop immediately — mid-batch is fine. Write whatever you've already gathered, don't discard it.
5. Never block on an unanswered question. If they don't know yet, write *"[open — to confirm]"* and carry on. An unfilled field is not a failure state.
6. Write all files in one pass at the end, not incrementally between batches.

---

## Question flow

### Batch 1 — Discovery (→ `DISCOVERY.md`)

- "What's this project called, and who owns it?"
- "In a sentence or two — what problem are you solving, and for whom?"
- "Any hard constraints I should know upfront? Tech stack, timeline, accessibility level, brand sub-rules."

Populates: **At a Glance** table (project, owner, date = today, problem, primary users, constraints) and the **Target Users** table. Seed *Project Context* and *Problem Statement* from the same answers; leave *Research Themes*, *Key UX Hypotheses*, and *Research Log* empty — those are earned later, not invented now.

### Batch 2 — Product shape (→ `PRODUCT.md`)

- "What are the 3-5 key things a user needs to be able to do?"
- "Walk me through the main happy path — what screens does someone move through?"
- "Anything explicitly out of scope this iteration?"

Populates: **At a Glance**, **User Stories**, **Flows**, **Screens**, **Out of Scope**. Infer the Screens table from the flow rather than asking again. Leave *Brand Personality*, *What [Product] Is Not*, *Commercial Goals*, and *Vision* for the user to fill later — flag them as worth a pass once the shape settles.

### Batch 3 — Design direction (→ `DESIGN.md`)

- "Any strong feelings on layout? Single-column focused, two-column with sidebar, full-width immersive?"
- "Any AOX components you already know you'll need? Toggle cards, checkout steps, product tiles?"
- "Anything already decided that I shouldn't revisit or offer alternatives for?"

Populates: **At a Glance**, **Layout**, **Components in Use**, **Locked Decisions**. Default the accessibility target to WCAG 2.1 AA unless they say otherwise. Anything they sound genuinely unsure about goes in **Open Questions** with status *open* — not into a section above it as though it were settled.

### Batch 4 — Tools

- "Do you have a Figma access token set up? Only needed if you want to push prototypes into Figma."
- "Want me to install the workflow skills and the design-system hooks into this workspace? Kiro's Power installer doesn't copy those, so it's a one-time script — about ten seconds. It gets you `/ideate-mode`, the Figma bridge, and a free compliance scan on save."

**Only ask the install question if the pieces aren't already there** — check for `.kiro/skills/ideate-mode/` and `.kiro/hooks/design-system-scan.kiro.hook` first. If both exist, say so in passing and move on.

If they say yes, follow [Installing skills, hooks and the component sheet](#installing-skills-hooks-and-the-component-sheet) below, then check the matching `STATUS.md` boxes. If they decline, leave the boxes unchecked and mention it's a one-liner whenever they want it — don't push, and don't re-offer later in the session.

**Regardless of the answer, write `FIGMA-BRIDGE.md` in the final writing pass** (see below) — same mechanism as `DISCOVERY.md`/`PRODUCT.md`/`DESIGN.md`. The target Figma file row starts as a placeholder (`[Project File Name]` / `[file_key]`); that's expected, not a gap, and gets filled in once the user has a working file to push to. This removes the old "copy the template in yourself before your first push" step — there's no technical reason `FIGMA-BRIDGE.md` should need manual copying when the other spec files don't; onboarding writes files itself, it doesn't rely on the installer.

**Before asking about impeccable, check whether it's already there** — look for `~/.kiro/skills/impeccable/` or an `impeccable` entry in the workspace's skills. Don't offer to install something the user already has.

- **Already installed** → don't offer an install. Say so, and offer the reference card instead: *"You've already got impeccable — want me to drop in a reference card for what it can do alongside the design system?"*
- **Not installed** → "Want me to install **impeccable**? It's a companion skill for production-quality polish — `npx impeccable`, nothing heavy."

Act on the answers:

- If they want it installed, run `npx impeccable`. If the install fails, say so plainly and carry on — onboarding does not depend on it.
- **If impeccable ends up present either way, write `IMPECCABLE.md` to the project root.** Copy `templates/IMPECCABLE.md` if it's available; otherwise generate it by reading the installed skill's `scripts/command-metadata.json` for the real command list — do not recall the commands from memory, they change between versions.
- Check the matching `STATUS.md` boxes.
- If they decline, leave it unchecked, write no `IMPECCABLE.md`, and mention it's available whenever.

One thing worth telling them when `IMPECCABLE.md` gets written: `/impeccable init` and `/impeccable document` write `PRODUCT.md` and `DESIGN.md`, the same filenames this power uses. Impeccable always asks before overwriting, but its `DESIGN.md` follows a different schema — the card explains which prompts to decline.
### Batch 5 — References (only if not already covered)

- "Any Figma files, competitor references, or inspiration links I should look at?"

Goes into `DESIGN.md` → **Reference & Inspiration**.

---

## Writing the files

1. **`DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`** — populated, marker removed. Preserve every section heading from the template even where empty; the empty ones are prompts for later, and deleting them quietly removes the thinking they were there to provoke.
2. **`STATUS.md`** — create it, check off "Project templates filled in" plus anything confirmed in Batch 4, and set the *Last updated* line to today.
3. **`FIGMA-BRIDGE.md`** — create it, always, regardless of whether the user has a Figma token yet. Copy `templates/FIGMA-BRIDGE.md` if it's available in the workspace; otherwise generate it from the outline in that template (Target Files, Component/Icon/Font/Colour Maps, Conventions, Known Issues, Push Log). Leave the working-file row as its placeholder — don't invent a file name or key. The Design System 2025 library row is a fixed AOX default; write it in regardless.
4. **`QUICKSTART.md`** — create it as the user's command reference. If `templates/QUICKSTART.md` is available, copy it. If not, generate it: build commands, the skills and how to invoke them, a design-system-at-a-glance table (pull the real values from `design.md` — do not recall them from memory), and what each project file is for.
5. **`IMPECCABLE.md`** — only if impeccable is installed. See Batch 4 above for how to source the command list.
6. Open `QUICKSTART.md` in the editor if you can.
7. Close out:

> "You're set up. Here's what I captured: *[brief recap]*.
>
> I've written your **QUICKSTART.md** — commands and design-system rules at a glance. **STATUS.md** tracks progress as you go. I've also written **FIGMA-BRIDGE.md** with a placeholder target file — fill that in whenever you're ready to push to Figma.
>
> Ready when you are — ask me to build any screen from your flows, or run an ideation round first if you'd rather explore."

If you wrote `IMPECCABLE.md`, add a line to that recap: *"and **IMPECCABLE.md**, which covers what impeccable can do alongside the design system — including the two commands that'll try to overwrite your spec files."*

If you installed the skills and hooks, add: *"Skills and hooks are in — `/ideate-mode` and the Figma bridge are available now. A free scan runs on every HTML save; the **Design System Review** hook is the one that costs credits, so run it when a screen's finished rather than as you go. I'll offer it at the right moments."*

---

## Installing skills, hooks and the component sheet

**This section is not gated by onboarding.** Use it whenever the user asks to install the skills or hooks, asks why `/ideate-mode` or the Figma bridge isn't available, or asks about the design-system scan.

Kiro's Power installer copies `POWER.md`, `steering/` and `mcp.json` and nothing else — there's no install-script hook in a Power. So `skills/`, `hooks/`, `scripts/` and `assets/strata-component-sheet/` need one deliberate copy into the workspace. The repo ships a script that does it.

### 1. Find the repo

The Power's full checkout is normally kept at `~/.kiro/powers/repos/aox-prototyper/` even though only part of it is copied out. Look there first, then for any `*aox-prototyper*` directory under `~/.kiro/powers/`, then in the workspace itself (the user may have cloned it). The script does this search itself — you only need the path if you want to name it explicitly.

### 2. Run it

```bash
bash ~/.kiro/powers/repos/aox-prototyper/scripts/install-aox-power.sh
```

Run it from the workspace root; it installs into the current directory. Useful flags: `--dry-run` to preview, `--target <dir>` to install elsewhere, `--only skills,hooks` to install a subset, `--agent claude` for a Claude Code workspace, `--uninstall` to reverse it. It is idempotent, and it backs up anything it would overwrite rather than clobbering it.

If no local checkout exists, the script clones one itself — so the command above still works with a different path, or with `--source` pointed anywhere. **Show the user the command before running it**, and show them its output afterwards; it reports exactly what it copied.

### 3. If the script can't run

On Windows without Git Bash or WSL, or anywhere `bash` isn't available, do the copies yourself with your file tools. It's a plain copy, four destinations:

| From (the repo) | To (the workspace) |
|---|---|
| `skills/figma-bridge/`, `skills/ideation/`, `skills/ideate-mode/` | `.kiro/skills/` |
| `hooks/*.kiro.hook` | `.kiro/hooks/` |
| `scripts/ds-scan.sh` | `.kiro/scripts/` |
| `assets/strata-component-sheet/` | `assets/strata-component-sheet/` |

The component sheet goes to the **workspace root**, not under `.kiro/` — `steering/aox-design-system.md` Protocol 1 refers to it as `assets/strata-component-sheet/index.html`, and that path has to resolve.

If a `design-system-guard.kiro.hook` from v1.2 or earlier is present, retire it — rename it to `.replaced` or delete it. It ran a full agent review on every HTML save; the scan + review pair replaces it, and leaving both installed means paying for the old behaviour anyway.

### 4. Tell them what they got

Two hooks, and the difference between them is the whole point:

- **Design System Scan** — fires on every `.html` save, runs a shell script, costs nothing and takes milliseconds. Writes `.kiro/ds-guard-report.md`.
- **Design System Review** — manual, from the Agent Hooks panel. This is the one that costs credits, so it's theirs to trigger when a screen or flow is actually ready.
- There's a third, **Design System Review (automatic)**, shipped disabled. It runs the review once per agent turn instead of on demand, and exits free when the scan is clean. Mention it only if they say they'd rather not remember to click.

Then check the `STATUS.md` boxes for whatever landed.

### 5. Offer the review at the right moment

Once the hooks are installed, this is yours to remember on the user's behalf: when a screen or flow is finished — not after each edit — say so and offer the review. *"That's the checkout flow done. Want me to run the design-system review over it?"* One review over finished work catches more than a dozen reviews over half-written work, at a fraction of the cost. Never trigger it yourself mid-build.

---

## Keeping `STATUS.md` current

You maintain this file — there's no script and no hook behind it. Update it as these events happen, and re-read it before editing so you never clobber a box the user set by hand.

| Event | Check off |
|---|---|
| Onboarding writes the templates | Project templates filled in |
| User confirms their Figma token | Figma access token set |
| `install-aox-power.sh` run, or the copies made by hand | Skills copied · Design-system hooks copied · Component sheet copied |
| Design System Review run over a finished screen or flow | Ran a design-system review |
| impeccable installed, or found already present | Impeccable installed |
| User confirms the Bridge plugin is running | Figma Desktop Bridge plugin running |
| First `.html` prototype written | Built first screen prototype |
| A prototype passes a compliance pass | Prototype uses tokens, Strata icons, `data-aods` |
| User fills in their real Figma target file in `FIGMA-BRIDGE.md` | `FIGMA-BRIDGE.md` target file filled in |
| figma-bridge push succeeds | Pushed a prototype to Figma |
| ideation skill used | Ran ideation session |
| `/ideate-mode` invoked | Entered ideate-mode |
| A row lands in DESIGN.md → Locked Decisions | Locked a design decision |

Always refresh the *Last updated* line when you change anything. Don't announce routine `STATUS.md` updates — do them quietly and mention it only if the user asks or a milestone genuinely matters.

---

## Tone

Good:

- "Let's get your project set up — a few quick batches, about two minutes."
- "Got it. Here's what I've captured so far: *[summary]*. Sound right?"
- "Nice — that's everything I need. Writing your files now."
- "Want me to install impeccable? Companion skill for polish. Quick install, nothing heavy."

Bad:

- "Please provide the following information in structured format..."
- "Step 1 of 7: Project Name (required)"
- "MANDATORY: You must install impeccable before proceeding."
