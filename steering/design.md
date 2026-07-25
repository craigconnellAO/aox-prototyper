# AOX Design System Reference

## About This Document

This is a single-file design system reference for generating AOX-compliant HTML prototypes. It consolidates all authoritative AOX design tokens, typography rules, icon guidance, component blueprints, page patterns, and anti-pattern rules into one agent-consumable document.

### Output Format Rules

Every generated prototype must follow these rules:

- **Single self-contained HTML file** with an inline `<style>` block
- **Mobile-first layout** with breakpoints: `sm: 544px`, `md: 768px`, `lg: 990px`, `xl: 1200px`
- **Strata icons stylesheet** must be included in `<head>`:
  ```html
  <link rel="stylesheet" href="https://assets.ao.com/design-system/assets/icons/latest/strata-icons.css">
  ```
- **`<script>` is permitted** for lightweight prototype interactions only: accordion expand/collapse, tab switching, modal open/close, inline form validation state toggling. Keep scripts small and self-contained. Never emit scripts that call external APIs, handle authentication, or simulate routing.

---

### Quick-Start Boilerplate

Copy this shell as the starting structure for every generated prototype. Fill in the token block and component CSS from the relevant sections below.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AO Prototype</title>
  <link rel="stylesheet" href="https://assets.ao.com/design-system/assets/icons/latest/strata-icons.css">
  <style>
    /* 1 · SmileyFace — @font-face declarations from the Typography section */

    /* 2 · Tokens — full :root block from the Tokens section */

    /* 3 · Base reset */
    *, *::before, *::after { box-sizing: border-box; }
    body { margin: 0; font-family: 'Inter', ui-sans-serif, system-ui, sans-serif;
           color: var(--type-secondary); font-size: 1rem; line-height: 1.625;
           -webkit-font-smoothing: antialiased; background: var(--gray-10); }
    img { max-width: 100%; display: block; }

    /* 4 · Typography scale — CSS block from the Typography section */

    /* 5 · Component CSS — paste from relevant component blueprints */
  </style>
</head>
<body>

  <!-- Prototype markup here -->

</body>
</html>
```

---

### Pre-flight Checklist

Before returning output, verify every point:

- [ ] `<head>` includes the Strata icons stylesheet link
- [ ] `<style>` contains the SmileyFace `@font-face` declarations
- [ ] `<style>` contains the full `:root` token block — no raw hex values anywhere
- [ ] All colours reference a CSS custom property — `var(--token-name)`, never `#hex` or `rgb()`
- [ ] All icons use `<i class="ico ico-{name}" aria-hidden="true"></i>` — no emoji or Unicode symbols
- [ ] Every component root carries its `data-aods="{name}"` attribute
- [ ] All type styles use `text-*` classes from the type scale — no ad-hoc `font-size` on text elements
- [ ] Spacing values are from the scale — no intermediate values (10px, 14px, 6px, 22px…)
- [ ] Layout is mobile-first: base styles are mobile, `@media (min-width: …)` adds desktop enhancements
- [ ] Any `<script>` block is limited to lightweight prototype interaction — no API calls or auth logic

---

### Section Index

- **[Tokens](#tokens)** — Colour, spacing, radius, and shadow design tokens
- **[Typography](#typography)** — Font loading, type scale, and text utilities
- **[Icons](#icons)** — Strata icon system, class names, and accessibility rules
- **[Components](#components)** — HTML + CSS blueprints for all AO components
- **[Patterns](#patterns)** — Multi-component page layout recipes
- **[Anti-Patterns](#anti-patterns)** — Refuse-and-replace rules to prevent AI drift

---

## Tokens

### AO Design Tokens

> Authoritative. Every colour, spacing value, radius, and shadow in your output must reference a token from this file. No raw hex. No invented values.

Tokens are organised into four layers. Pick from the **right layer for the job**:

| Layer | What it's for | Example |
|---|---|---|
| **Primitives** | Raw palette swatches — only used by the layers below | `gray-40`, `brand-primary-base`, `palette-toast` |
| **Typography** | Text colour roles | `type-primary` for headings, `type-secondary` for body |
| **Action** | Interactive states (buttons, links) | `action-primary-base`, `action-secondary-hover` |
| **UI Surface** | Semantic backgrounds, borders, validation states | `ui-success`, `ui-error`, `ui-highlight` |

If you're picking a colour by hex, you're doing it wrong — find the right token by intent.

---

#### 1 · Primitives

##### Neutrals — borders, backgrounds, secondary text

Cool-tinted gray scale anchored by deep navy.

| Token | Hex | Use |
|---|---|---|
| `gray-10` | `#f8f9fa` | Page background, subtle dividers |
| `gray-20` | `#f0f2f2` | Neutral surface backgrounds |
| `gray-30` | `#e2e7e8` | Hover states on neutral surfaces |
| `gray-40` | `#d6dddf` | Default borders, dividers |
| `gray-50` | `#c1c7c9` | Disabled borders |
| `gray-60` | `#abb1b4` | Placeholder text, muted icons |
| `gray-70` | `#727677` | Secondary icons, inactive labels |
| `gray-80` | `#595d5e` | Tertiary text |
| `gray-90` | `#3f4344` | Secondary text, subdued headings |
| `gray-100` | `#212121` | Primary body text on light backgrounds |

##### Brand green — primary CTAs and brand moments only

| Token | Hex | Use |
|---|---|---|
| `brand-primary-base` | `#12c35a` | Brand accent, glow states |
| `brand-primary-light` | `#befcc8` | Light green tints, success backgrounds |
| `brand-primary-dark` | `#02422b` | Dark green text on light green |

##### Food palette — decorative only

Never used for functional UI states. Named after food concepts. Use for illustration, campaign moments, or decorative accents.

| Token | Hex | Tone |
|---|---|---|
| `palette-bread` | `#ffe3c2` | Warm peach |
| `palette-toast` | `#ffa878` | Amber orange |
| `palette-jam` | `#422439` | Deep plum |
| `palette-simmer` | `#ffd8d2` | Pale blush |
| `palette-heat` | `#f96155` | Coral red |
| `palette-burn` | `#60222f` | Dark crimson |
| `palette-steam` | `#c8d1ff` | Soft periwinkle |
| `palette-ice` | `#4a6dce` | Medium blue |
| `palette-water` | `#011f44` | Deep navy |

> ⚠ Never reach for `palette-heat` to indicate an error. That's `ui-error`. Palette tokens are *decorative* — they don't communicate state.

##### Switch24 brand accent

Purple accent used exclusively in the Switch24 payment flow. Do not use for buttons or generic interactive states.

| Token | Hex | Use |
|---|---|---|
| `switch-purple` | `#8023bd` | Selected card border, logo accent, pod label colour |
| `switch-purple-bg` | `#f6ecfc` | Light tinted background (reserved) |
| `switch-purple-border` | `#e3cdf2` | Soft purple border tint |

---

#### 2 · Typography colours

Roles for text. Picks from the neutral primitives.

| Token | Hex | Use |
|---|---|---|
| `type-primary` | `#011f44` | Main headings, display text |
| `type-secondary` | `#212121` | Body text, default UI labels |
| `type-tertiary` | `#595d5e` | Supporting text, captions, helper copy |
| `shadow-overlay` | `#011630` | Scrim overlay base |

---

#### 3 · Action tokens — for interactive states

Each action role has `base`, `hover`, `focus`, `active`, `contrast` (text on the base), and `glow` (focus ring).

##### Primary — green — main CTAs

Strata class: `btn-primary`

| Token | Hex |
|---|---|
| `action-primary-base` | `#00893e` |
| `action-primary-hover` | `#00560b` |
| `action-primary-focus` | `#00893e` |
| `action-primary-active` | `#003d00` |
| `action-primary-contrast` | `#ffffff` |
| `action-primary-glow` | `#12c35a` |

##### Secondary — blue — supporting CTAs

Strata class: `btn-secondary`

| Token | Hex |
|---|---|
| `action-secondary-base` | `#0564c2` |
| `action-secondary-hover` | `#00318f` |
| `action-secondary-focus` | `#0564c2` |
| `action-secondary-active` | `#001876` |
| `action-secondary-contrast` | `#ffffff` |
| `action-secondary-glow` | `#40a1f8` |

##### Light — white on dark surfaces

Strata class: `btn-white`

| Token | Hex |
|---|---|
| `action-light-base` | `#ffffff` |
| `action-light-contrast` | `#011f44` |
| `action-light-glow` | `#40a1f8` |

##### Dark — navy on light surfaces

Strata class: `btn-dark`

| Token | Hex |
|---|---|
| `action-dark-base` | `#011f44` |
| `action-dark-contrast` | `#ffffff` |
| `action-dark-glow` | `#40a1f8` |

##### Inactive — disabled state

Strata class: `btn-inactive`

| Token | Hex |
|---|---|
| `action-inactive-base` | `#727677` |
| `action-inactive-contrast` | `#ffffff` |

---

#### 4 · UI surface tokens — for semantic state-driven surfaces

Each group has `base` (background), `contrast` (text), and `accent` (border / icon). Pre-validated for WCAG AA contrast.

| Group | Base | Contrast | Accent | Use |
|---|---|---|---|---|
| `ui-core` | `#ffffff` | `#212121` | `#d6dddf` | Default card / surface |
| `ui-neutral` | `#f0f2f2` | `#212121` | `#abb1b4` | Subdued surfaces |
| `ui-highlight` | `#edf2ff` | `#00318f` | `#00318f` | Selected, promoted, info |
| `ui-success` | `#f4fce3` | `#02422b` | `#00893e` | Confirmation, completion |
| `ui-warning` | `#fff4e6` | `#ad5a00` | `#ff9e36` | Caution only — never decoration |
| `ui-error` | `#fff0f6` | `#b50016` | `#b50016` | Validation errors, destructive |
| `ui-light` | `#ffffff` | `#011f44` | `#ffffff` | Light surface variant |
| `ui-dark` | `#011f44` | `#ffffff` | `#011f44` | Dark surface variant |

Strata class pattern: `text-ui-{group}`, `bg-ui-{group}`, `border-ui-{group}-accent`.

> ⚠ `ui-warning` is for caution states (limited stock, time-sensitive, requires attention). Never use it for decoration.

---

#### 5 · Spacing — 4px base unit

| Token | rem | px |
|---|---|---|
| `spacing-1` | 0.25rem | 4px |
| `spacing-2` | 0.5rem | 8px |
| `spacing-3` | 0.75rem | 12px |
| `spacing-4` | 1rem | 16px |
| `spacing-5` | 1.25rem | 20px |
| `spacing-6` | 1.5rem | 24px |
| `spacing-8` | 2rem | 32px |
| `spacing-10` | 2.5rem | 40px |
| `spacing-12` | 3rem | 48px |
| `spacing-14` | 3.5rem | 56px |
| `spacing-16` | 4rem | 64px |

**Component spacing conventions:**

| Context | Value |
|---|---|
| Default card padding | `1rem` (16px), `1.5rem` (24px) at `lg:` |
| Input padding | `0.75rem` (12px) |
| Button horizontal padding | `1rem` (16px) |
| Tag padding | `0.5rem 0.75rem` (8px / 12px) |
| Page container padding | `0.5rem` mobile, `1rem` `sm:` and up |
| Grid gutter | `1rem` (16px) total |

No intermediate values. If you want 14px, you actually want either 12 or 16.

---

#### 6 · Border radius

| Token | Value | Use |
|---|---|---|
| `--radius-xs` | `4px` | Tags, chips, small badges |
| `--radius-sm` | `8px` | Buttons, inputs, select |
| `--radius-md` | `16px` | Cards, modals, drawers |
| `--radius-xl` | `24px` | Large surface containers |
| `--radius-2xl` | `40px` | Pills, full-round tags |

---

#### 7 · Elevation

Four levels. Always use the CSS variable — never raw `box-shadow`. Shadow colour is derived from `shadow-overlay` (`#011630`, deep navy).

| Token | Use |
|---|---|
| `--shadow` | Cards, default surfaces |
| `--shadow-md` | Raised cards, dropdowns |
| `--shadow-lg` | Modals, drawers |
| `--shadow-xl` | Tooltips |

Focus ring: `0 0 0 4px var(--action-secondary-glow)` applied to all interactive elements. Don't suppress.

---

#### 7a · Sub-brand exceptions

The AO palette is closed by default — a project extending it must earn the exception explicitly, in writing, here.

**Switch24** is the one sanctioned sub-brand accent: `--switch-purple` (`#8023bd`), plus surface variants `--switch-purple-bg` (`#f6ecfc`) and `--switch-purple-border` (`#e3cdf2`). Use only for Switch24-owned surfaces — the account hub nav pill/accent, progress-bar fill, and related banner UI. It does not apply to the core Switch24 signup funnel (product, basket, checkout, setup, order-complete), which stays on AO green per the funnel's own locked decisions — see the project's `DESIGN.md`.

Do not introduce a new sub-brand colour without adding it here first, following this same pattern: token + hex + bg/border pair + the exact surfaces it's scoped to.

---

#### 8 · The single `:root` block — paste this into every generated stylesheet

```css
:root {
  /* Neutrals */
  --gray-10: #f8f9fa;  --gray-20: #f0f2f2;  --gray-30: #e2e7e8;
  --gray-40: #d6dddf;  --gray-50: #c1c7c9;  --gray-60: #abb1b4;
  --gray-70: #727677;  --gray-80: #595d5e;  --gray-90: #3f4344;  --gray-100: #212121;

  /* Brand green */
  --brand-primary-base: #12c35a;  --brand-primary-light: #befcc8;  --brand-primary-dark: #02422b;

  /* Sub-brand — Switch24 (sanctioned exception, see §7a) */
  --switch-purple: #8023bd;  --switch-purple-bg: #f6ecfc;  --switch-purple-border: #e3cdf2;

  /* Typography */
  --type-primary: #011f44;  --type-secondary: #212121;  --type-tertiary: #595d5e;
  --shadow-overlay: #011630;

  /* Action — primary (green) */
  --action-primary-base: #00893e;  --action-primary-hover: #00560b;
  --action-primary-focus: #00893e;  --action-primary-active: #003d00;
  --action-primary-contrast: #ffffff;  --action-primary-glow: #12c35a;

  /* Action — secondary (blue / Action Main) */
  --action-secondary-base: #0564c2;  --action-secondary-hover: #00318f;
  --action-secondary-focus: #0564c2;  --action-secondary-active: #001876;
  --action-secondary-contrast: #ffffff;  --action-secondary-glow: #40a1f8;

  /* Action — light / dark / inactive */
  --action-light-base: #ffffff;  --action-light-contrast: #011f44;  --action-light-glow: #40a1f8;
  --action-dark-base: #011f44;   --action-dark-contrast: #ffffff;   --action-dark-glow: #40a1f8;
  --action-inactive-base: #727677;  --action-inactive-contrast: #ffffff;

  /* UI surface groups (base / contrast / accent) */
  --ui-core-base: #ffffff;       --ui-core-contrast: #212121;       --ui-core-accent: #d6dddf;
  --ui-neutral-base: #f0f2f2;    --ui-neutral-contrast: #212121;    --ui-neutral-accent: #abb1b4;
  --ui-highlight-base: #edf2ff;  --ui-highlight-contrast: #00318f;  --ui-highlight-accent: #00318f;
  --ui-success-base: #f4fce3;    --ui-success-contrast: #02422b;    --ui-success-accent: #00893e;
  --ui-warning-base: #fff4e6;    --ui-warning-contrast: #ad5a00;    --ui-warning-accent: #ff9e36;
  --ui-error-base: #fff0f6;      --ui-error-contrast: #b50016;      --ui-error-accent: #b50016;
  --ui-light-base: #ffffff;      --ui-light-contrast: #011f44;      --ui-light-accent: #ffffff;
  --ui-dark-base: #011f44;       --ui-dark-contrast: #ffffff;       --ui-dark-accent: #011f44;

  /* Notice component surfaces (more saturated than generic ui-* surfaces) */
  --notice-warning-bg: #ffe3c2;
  --notice-success-bg: #befcc8;
  --notice-error-bg: #ffd8d2;

  /* Food palette — decorative only */
  --palette-bread: #ffe3c2;  --palette-toast: #ffa878;  --palette-jam: #422439;
  --palette-simmer: #ffd8d2; --palette-heat: #f96155;   --palette-burn: #60222f;
  --palette-steam: #c8d1ff;  --palette-ice: #4a6dce;    --palette-water: #011f44;

  /* Switch24 brand accent */
  --switch-purple: #8023bd;  --switch-purple-bg: #f6ecfc;  --switch-purple-border: #e3cdf2;

  /* Radius */
  --radius-xs: 4px;  --radius-sm: 8px;  --radius-md: 16px;
  --radius-xl: 24px; --radius-2xl: 40px;

  /* Shadow */
  --shadow:    0 1px 3px rgba(1,22,48,0.08), 0 1px 2px rgba(1,22,48,0.05);
  --shadow-md: 0 4px 8px rgba(1,22,48,0.10), 0 2px 4px rgba(1,22,48,0.06);
  --shadow-lg: 0 10px 28px rgba(1,22,48,0.13), 0 4px 8px rgba(1,22,48,0.07);
  --shadow-xl: 0 20px 48px rgba(1,22,48,0.18), 0 8px 16px rgba(1,22,48,0.10);
}
```


---

## Typography

### AO Typography

Two typefaces, strict role separation. Never swap them.

| Family | Role |
|---|---|
| **SmileyFace** | Headings, display text, **and all button labels (CTAs)**. |
| **Inter** | All body text, UI labels, helper copy, form fields. |

System fallback for Inter: `ui-sans-serif, system-ui, sans-serif`.

---

#### Loading SmileyFace — paste this `@font-face` block into every generated stylesheet

```css
@font-face {
  font-family: 'SmileyFace-Headline';
  font-display: swap;
  src: url('https://media.ao.com/fonts/smiley-face/SmileyFace-Headline.woff2') format('woff2'),
       url('https://media.ao.com/fonts/smiley-face/SmileyFace-Headline.woff') format('woff');
}
@font-face {
  font-family: 'SmileyFace';
  font-weight: 100;
  font-display: swap;
  src: url('https://media.ao.com/fonts/smiley-face/SmileyFace-Light.woff2') format('woff2'),
       url('https://media.ao.com/fonts/smiley-face/SmileyFace-Light.woff') format('woff');
}
@font-face {
  font-family: 'SmileyFace';
  font-weight: 400;
  font-display: swap;
  src: url('https://media.ao.com/fonts/smiley-face/SmileyFace-Regular.woff2') format('woff2'),
       url('https://media.ao.com/fonts/smiley-face/SmileyFace-Regular.woff') format('woff');
}
@font-face {
  font-family: 'SmileyFace';
  font-weight: 500;
  font-display: swap;
  src: url('https://media.ao.com/fonts/smiley-face/SmileyFace-Medium.woff2') format('woff2'),
       url('https://media.ao.com/fonts/smiley-face/SmileyFace-Medium.woff') format('woff');
}
@font-face {
  font-family: 'SmileyFace';
  font-weight: 700;
  font-display: swap;
  src: url('https://media.ao.com/fonts/smiley-face/SmileyFace-Bold.woff2') format('woff2'),
       url('https://media.ao.com/fonts/smiley-face/SmileyFace-Bold.woff') format('woff');
}
```

Loading Inter (Google Fonts):

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap">
```

---

#### Type scale

| Class | Font | Weight | Size | Line-height | Use |
|---|---|---|---|---|---|
| `text-display-headline` | SmileyFace-Headline | 800 | 2.5rem (40px) | 1.0 | Hero headlines, campaign display |
| `text-display-lg` | SmileyFace | 700 | 2rem (32px) | 1.25 | Large section headings |
| `text-display` | SmileyFace | 700 | 1.5rem (24px) | 1.25 | Standard page headings |
| `text-display-sm` | SmileyFace | 700 | 1.25rem (20px) | 1.25 | Sub-section display headings |
| `text-title-lg` | SmileyFace | 700 | 1.25rem (20px) | 1.25 | Card headings, section titles |
| `text-title` | SmileyFace | 700 | 1rem (16px) | 1.25 | Subsection headings |
| `text-title-sm` | SmileyFace | 700 | 0.875rem (14px) | 1.25 | Minimum SmileyFace size |
| `text-cta` | SmileyFace | 700 | 1rem (16px) | 1.25 | **All button labels** |
| `text-body` | Inter | 400 | 1rem (16px) | 1.625 | Default body copy |
| `text-body-sm` | Inter | 400 | 0.875rem (14px) | 1.625 | Supporting copy, helper text |
| `text-body-xs` | Inter | 400 | 0.75rem (12px) | 1.625 | Extra-small body copy |
| `text-caption` | Inter | 400 | 0.75rem (12px) | 1.625 | Captions, metadata, micro copy |
| `text-link` | Inter | 700 | 1rem (16px) | 1.625 | Inline links — no underline |
| `text-link-sm` | Inter | 700 | 0.875rem (14px) | 1.625 | Small inline links |

---

#### The single CSS block — paste this into every generated stylesheet

```css
body {
  font-family: 'Inter', ui-sans-serif, system-ui, sans-serif;
  color: var(--type-secondary);
  font-size: 1rem;
  line-height: 1.625;
  -webkit-font-smoothing: antialiased;
}

/* SmileyFace (headings + CTAs) */
.text-display-headline { font-family: 'SmileyFace-Headline', Georgia, serif; font-size: 2.5rem;   line-height: 1.0;  color: var(--type-primary); }
.text-display-lg      { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 2rem;    line-height: 1.25; color: var(--type-primary); }
.text-display         { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1.5rem;  line-height: 1.25; color: var(--type-primary); }
.text-display-sm      { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1.25rem; line-height: 1.25; color: var(--type-primary); }
.text-title-lg        { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1.25rem; line-height: 1.25; color: var(--type-primary); }
.text-title           { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1rem;    line-height: 1.25; color: var(--type-primary); }
.text-title-sm        { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 0.875rem; line-height: 1.25; color: var(--type-primary); }
.text-cta             { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1rem;    line-height: 1.25; }

/* Inter (body + UI) */
.text-body       { font-family: 'Inter', sans-serif; font-size: 1rem;    line-height: 1.625; }
.text-body-sm    { font-family: 'Inter', sans-serif; font-size: 0.875rem; line-height: 1.625; }
.text-body-xs    { font-family: 'Inter', sans-serif; font-size: 0.75rem;  line-height: 1.625; }
.text-caption    { font-family: 'Inter', sans-serif; font-size: 0.75rem;  line-height: 1.625; color: var(--type-tertiary); }
.text-link       { font-family: 'Inter', sans-serif; font-weight: 700; font-size: 1rem;    text-decoration: none; color: var(--action-secondary-base); }
.text-link-sm    { font-family: 'Inter', sans-serif; font-weight: 700; font-size: 0.875rem; text-decoration: none; color: var(--action-secondary-base); }
.text-secondary  { color: var(--type-tertiary); }
```

---

#### Typography rules

1. **Inter is never on a button.** Every `<button>` label uses `text-cta` (SmileyFace Bold). No exceptions.
2. **SmileyFace is never below 14px.** The minimum SmileyFace size is `text-title-sm` (14px). Below that, switch to Inter.
3. **Body line length: 65–75 characters.** Constrain wide text containers with `max-width: 65ch`.
4. **Colour by role:**
   - Headings → `type-primary` (#011f44, deep navy)
   - Body → `type-secondary` (#212121, near-black)
   - Supporting / captions → `type-tertiary` (mid-grey)
5. **Placeholder is not a label.** Always pair an `<input>` with a visible `<label>`.
6. **Links use Inter Bold (700).** Never Regular weight for clickable text links.

---

#### Anti-patterns

| ❌ Don't | ✅ Do |
|---|---|
| `font-family: Arial` | Use the loaded families: `SmileyFace`, `Inter` |
| Inter on a `<button>` | Always `text-cta` (SmileyFace Bold) |
| SmileyFace at 12px | Switch to Inter under 14px |
| `font-weight: 300` on body | Inter 400 is the minimum body weight |
| `font-weight: 400` on links | Links are Inter 700 (Bold) |
| `text-transform: uppercase` on CTAs | AO buttons are sentence-case verbs |
| Multiple display sizes in one section | One `text-display` or `text-title-lg` per section, then `text-body` |
| `line-height: 1.5` on body | Body line-height is now 1.625 |


---

## Icons

### AO Icon System — Strata Icons

> Icon font loaded from the AO CDN. Class-based usage matching the production `@ao/components` library.

#### Setup

Every generated HTML file must include this stylesheet link in the `<head>`:

```html
<link rel="stylesheet" href="https://assets.ao.com/design-system/assets/icons/latest/strata-icons.css">
```

#### Usage

Icons use an `<i>` element (or `<span>`) with two classes: the base `ico` class plus the icon name class.

```html
<i class="ico ico-basket" aria-hidden="true"></i>
```

##### Accessibility

- **Decorative icons** (paired with visible text): add `aria-hidden="true"`
- **Meaningful icons** (icon-only buttons): omit `aria-hidden`, add `aria-label` on the parent button

```html
<!-- Decorative — text provides meaning -->
<button class="btn btn-primary" data-aods="button">
  <i class="ico ico-basket" aria-hidden="true"></i>
  Add to basket
</button>

<!-- Meaningful — icon-only button -->
<button class="btn btn-tertiary btn-icon" data-aods="button" aria-label="Close">
  <i class="ico ico-close"></i>
</button>
```

#### Sizes

| Class | Scale | Use |
|-------|-------|-----|
| `ico-xs` | 0.75em | Inline with small text |
| `ico-sm` | 0.875em | Inline with body text |
| `ico-md` | 1em | Standard UI icons (named default) |
| `ico-lg` | 1.25em | Nav icons, card icons |
| `ico-xl` | 1.5em | Feature callouts |
| `ico-2x` | 2em | Hero features |
| `ico-3x` | 3em | Empty states, illustrations |

#### UI Icon Reference

Icons used in standard AO UI patterns. Use these names — don't substitute alternatives.

##### Navigation & Actions

| Icon | Class | Usage |
|------|-------|-------|
| AO Logo | `ico-ao-logo` | Header logo (the smiley-face "ao" mark) |
| Menu | `ico-menu` | Hamburger / mobile nav toggle |
| Search | `ico-search` | Search input, search button |
| Close | `ico-close` | Close/dismiss modals, drawers, notices |
| Account | `ico-account` | User account link |
| Basket | `ico-basket` | Shopping basket link |
| Track order | `ico-track-your-order` | Order tracking link |
| Home | `ico-home` | Home navigation |
| Chevron down | `ico-chevron-down` | Dropdowns, accordion expand |
| Chevron up | `ico-chevron-up` | Accordion collapse |
| Chevron right | `ico-chevron-right` | Breadcrumb separator, forward nav |
| Chevron left | `ico-chevron-left` | Back navigation |
| Settings | `ico-settings` | Settings/preferences |
| Share | `ico-share` | Share actions |
| Exit | `ico-exit` | Sign out |

##### Status & Feedback

| Icon | Class | Usage |
|------|-------|-------|
| Tick | `ico-tick` | Success confirmation inline |
| Tick circle | `ico-tick-circle` | Success notice, completed state |
| Warning | `ico-warning` | Warning notice |
| Info | `ico-info` | Information notice, tooltips |
| Cancel circle | `ico-cancel-circle` | ~~Error notice~~ (broken glyph in /latest Strata font — use `ico-cancel` instead) |
| Cancel | `ico-cancel` | Error notice; error inline |
| Question circle | `ico-question-circle` | Help / FAQ |

##### Commerce

| Icon | Class | Usage |
|------|-------|-------|
| Delivery | `ico-delivery` | Delivery information |
| Free delivery | `ico-free-delivery` | Free delivery badge |
| Next day delivery | `ico-next-day-delivery` | Next-day promise |
| Click and collect | `ico-click-and-collect` | Collection option |
| Returns | `ico-returns` | Returns policy |
| Calendar | `ico-calendar` | Date/slot picker |
| Card | `ico-card` | Payment method |
| Finance | `ico-finance-gbp` | Finance options |
| Gift | `ico-gift` | Gift/promo |
| Tag | `ico-tag` | Offer/promotion tag |
| Price match | `ico-price-match-gbp` | Price match promise |
| Recycling | `ico-recycling` | Recycling/take-back |
| Installation | `ico-installation` | Installation service |
| Protection | `ico-protection` | Warranty/care plan |

##### Communication

| Icon | Class | Usage |
|------|-------|-------|
| Call | `ico-call` | Phone contact |
| Mail | `ico-mail` | Email |
| Chat | `ico-chat` | Live chat |
| Live chat | `ico-live-chat` | Chat support |
| Notification | `ico-notification` | Alerts/notifications |

##### Content & Media

| Icon | Class | Usage |
|------|-------|-------|
| Play | `ico-play` | Video play |
| Picture | `ico-picture` | Image/gallery |
| Camera | `ico-camera` | Photo upload |
| Enlarge | `ico-enlarge` | Zoom/expand |
| 360 degrees | `ico-360-degrees` | 360° view |
| AR | `ico-ar` | Augmented reality |

##### Utility

| Icon | Class | Usage |
|------|-------|-------|
| Add | `ico-add` | Add/plus |
| Add circle | `ico-add-circle` | Add (circled) |
| Subtract | `ico-subtract` | Remove/minus |
| Subtract circle | `ico-subtract-circle` | Remove (circled) |
| Edit | `ico-amend-edit` | Edit/amend |
| Copy | `ico-copy` | Copy to clipboard |
| Delete | `ico-trashcan` | Delete/remove |
| Download | `ico-download` | Download file |
| Print | `ico-print` | Print |
| Refresh | `ico-refresh` | Reload/retry |
| Lock | `ico-lock` | Secure/locked |
| Show | `ico-show` | Show password/reveal |
| Hide | `ico-hide` | Hide password |
| Heart | `ico-heart` | Wishlist/favourite |
| Star | `ico-star` | Rating star |
| Compare | `ico-compare` | Compare products |
| Grid | `ico-grid` | Grid view |
| List | `ico-list` | List view |
| Location | `ico-location` | Store locator, address |
| Link | `ico-link` | External link |
| Document | `ico-document` | Document/PDF |
| Reviews | `ico-reviews` | Customer reviews |
| More | `ico-more` | Overflow/more actions |

#### Mapping from Legacy Emoji Placeholders

If you encounter emoji icons in older kit files or prototypes, replace them:

| Emoji | Replace with |
|-------|-------------|
| ☰ | `<i class="ico ico-menu" aria-hidden="true"></i>` |
| 🔍 | `<i class="ico ico-search" aria-hidden="true"></i>` |
| 👤 | `<i class="ico ico-account" aria-hidden="true"></i>` |
| 🛒 | `<i class="ico ico-basket" aria-hidden="true"></i>` |
| 📦 | `<i class="ico ico-track-your-order" aria-hidden="true"></i>` |
| ✓ | `<i class="ico ico-tick" aria-hidden="true"></i>` |
| ✕ / ✗ | `<i class="ico ico-close" aria-hidden="true"></i>` |
| ⚠ | `<i class="ico ico-warning" aria-hidden="true"></i>` |
| ℹ | `<i class="ico ico-info" aria-hidden="true"></i>` |
| ▼ | `<i class="ico ico-chevron-down" aria-hidden="true"></i>` |
| › | `<i class="ico ico-chevron-right" aria-hidden="true"></i>` |
| + | `<i class="ico ico-add" aria-hidden="true"></i>` |
| − | `<i class="ico ico-subtract" aria-hidden="true"></i>` |

#### Rules

- Never use raw emoji or Unicode symbols for icons in prototypes — always use Strata icon classes
- Icon colour inherits from the parent's `color` property. Override with utility classes or direct styling only when needed.
- Icons inside buttons sit before the label text with a `0.5rem` gap (handled by `.btn` flex gap)
- The icon font is decorative by default — always pair with `aria-hidden="true"` unless the icon is the sole communicator of meaning
- Don't use icons as the sole indicator of state — pair with text, weight, or colour (WCAG)


---

## Components

### AO Component Blueprints

> Authoritative HTML + CSS for every AO component. Use these verbatim — class names match Strata and the production `@ao/components` library. Every component root carries a `data-aods="component-name"` attribute for engineering parity.

The CSS in this file assumes the variables from [Tokens](#tokens) and the typography setup from [Typography](#typography) are already in the document's `:root`.

Components, in order:

1. [Button](#1--button)
2. [Field, Label, Input, InputMessage](#2--field-label-input-inputmessage)
3. [Select](#3--select)
4. [Textarea](#4--textarea)
5. [Checkbox / Radio (toggle items)](#5--checkbox--radio-toggle-items)
6. [Tag](#6--tag)
7. [Notice (info / success / warning / error)](#7--notice)
8. [Card](#8--card)
9. [Breadcrumb](#9--breadcrumb)
10. [Tabs](#10--tabs)
11. [Accordion](#11--accordion)
12. [Quantity stepper](#12--quantity-stepper)
13. [Loading spinner](#13--loading-spinner)
14. [Nav](#14--nav)
15. [Footer](#15--footer)
16. [Switch24 payment selectors](#16--switch24-payment-selectors)

---

#### 1 · Button

8px radius, SmileyFace Bold label, 1px border. The `primary` variant is reserved for the **one** main CTA per visual section.

**Variants:** `primary` (green) · `secondary` (blue, outlined) · `tertiary` (neutral outline) · `white` (on dark surfaces) · `dark` (alternative primary on light surfaces) · `inactive` (auto-applied when disabled).

**Sizes:** default · `btn-lg` · `btn-sm` · `btn-icon` (square, icon only) · `btn-full` (100% width).

##### HTML

```html
<button class="btn btn-primary" data-aods="button">Add to basket</button>
<button class="btn btn-secondary" data-aods="button">View details</button>
<button class="btn btn-tertiary" data-aods="button">Compare</button>
<button class="btn btn-dark" data-aods="button">Sign in</button>
<button class="btn btn-white" data-aods="button">Continue on dark</button>
<button class="btn btn-inactive" data-aods="button" disabled>Out of stock</button>

<!-- Sizes -->
<button class="btn btn-primary btn-lg" data-aods="button">Add to basket</button>
<button class="btn btn-primary btn-full" data-aods="button">Checkout</button>
<button class="btn btn-tertiary btn-icon" data-aods="button" aria-label="Close"><i class="ico ico-close"></i></button>
```

##### CSS

```css
.btn {
  display: inline-flex; align-items: center; justify-content: center; gap: 0.5rem;
  padding: 0.875rem 1.5rem; border-radius: var(--radius-sm);
  font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1rem; line-height: 1;
  border: 1px solid transparent; cursor: pointer; white-space: nowrap; text-decoration: none;
  transition: background 150ms, color 150ms, border-color 150ms, box-shadow 150ms, transform 150ms;
}
.btn:focus-visible { outline: 3px solid var(--action-secondary-glow); outline-offset: 2px; }
@media (prefers-reduced-motion: no-preference) {
  .btn:active:not(:disabled):not(.is-disabled) { transform: translateY(1px); box-shadow: var(--shadow); }
}

/* Primary */
.btn-primary   { background: var(--action-primary-base); color: var(--action-primary-contrast); border-color: var(--action-primary-base); }
.btn-primary:hover:not(:disabled):not(.is-disabled)   { background: var(--action-primary-hover); border-color: var(--action-primary-hover); }
.btn-primary:active:not(:disabled):not(.is-disabled)   { background: var(--action-primary-active); border-color: var(--action-primary-active); }
.btn-primary:disabled,
.btn-primary.is-disabled { background: var(--gray-30); color: var(--gray-70); border-color: var(--gray-30); cursor: not-allowed; transform: none; }
.btn-primary.is-loading { opacity: 0.7; pointer-events: none; }
.btn-primary.is-error { background: var(--ui-error-accent); border-color: var(--ui-error-accent); color: var(--action-primary-contrast); }
.btn-primary.is-success { background: var(--ui-success-accent); border-color: var(--ui-success-accent); color: var(--action-primary-contrast); }

/* Secondary: transparent default, Action Main (blue) border + text, Action Hover bg on hover */
.btn-secondary { background: transparent; color: var(--action-secondary-base); border-color: var(--action-secondary-base); }
.btn-secondary:hover:not(:disabled):not(.is-disabled) { background: var(--ui-highlight-base); border-color: var(--action-secondary-hover); color: var(--action-secondary-hover); }
.btn-secondary:active:not(:disabled):not(.is-disabled) { background: var(--ui-highlight-base); border-color: var(--action-secondary-active); color: var(--action-secondary-active); }
.btn-secondary:disabled,
.btn-secondary.is-disabled { background: var(--gray-30); color: var(--gray-70); border-color: var(--gray-30); cursor: not-allowed; transform: none; }
.btn-secondary.is-loading { opacity: 0.7; pointer-events: none; }

/* Tertiary: transparent default, Action Hover bg on hover (not green) */
.btn-tertiary  { background: transparent; color: var(--type-secondary); border-color: var(--gray-40); }
.btn-tertiary:hover:not(:disabled):not(.is-disabled)  { background: var(--gray-20); border-color: var(--gray-50); }
.btn-tertiary:active:not(:disabled):not(.is-disabled)  { background: var(--gray-30); border-color: var(--gray-60); }
.btn-tertiary:disabled,
.btn-tertiary.is-disabled { background: var(--gray-30); color: var(--gray-70); border-color: var(--gray-30); cursor: not-allowed; transform: none; }
.btn-tertiary.is-loading { opacity: 0.7; pointer-events: none; }

.btn-white     { background: var(--action-light-base); color: var(--action-light-contrast); border-color: var(--action-light-base); }
.btn-white:hover     { background: var(--gray-20); border-color: var(--gray-20); }

.btn-dark      { background: var(--action-dark-base); color: var(--action-dark-contrast); border-color: var(--action-dark-base); }
.btn-dark:hover      { background: var(--action-secondary-hover); border-color: var(--action-secondary-hover); }

.btn-inactive  { background: var(--gray-30); color: var(--gray-70); border-color: var(--gray-30); cursor: not-allowed; }

.btn-lg   { padding: 1.125rem 2rem; font-size: 1.0625rem; }
.btn-sm   { padding: 0.6875rem 1rem; font-size: 0.875rem; }
.btn-icon { padding: 0.6875rem; }
.btn-full { width: 100%; }
```

##### Rules

- One `btn-primary` per visual section.
- Verb-first labels: "Add to basket", "View details", "Save changes".
- Icon-only buttons require `aria-label`.
- Always use `<button>` for actions, `<a class="btn">` only for navigation. Polymorphic substitution is fine but the visual must stay identical.

---

#### 2 · Field, Label, Input, InputMessage

The accessibility-wired form pattern. Always wrap an input in a `.field` so the label, input, and message are vertically aligned and screen-reader-linked.

##### HTML

```html
<div class="field" data-aods="field">
  <label class="field-label" for="email">Email address</label>
  <input class="field-input" id="email" type="email" placeholder="you@example.com">
  <p class="field-msg is-helper">We'll send delivery updates to this address.</p>
</div>

<!-- Error state -->
<div class="field" data-aods="field">
  <label class="field-label" for="phone">Phone number</label>
  <input class="field-input is-error" id="phone" type="tel" aria-invalid="true" aria-describedby="phone-msg">
  <p class="field-msg is-error" id="phone-msg">Enter a valid UK mobile or landline number.</p>
</div>

<!-- Success state -->
<div class="field" data-aods="field">
  <label class="field-label" for="email2">Email address</label>
  <input class="field-input is-success" id="email2" type="email" value="craig@example.com">
  <p class="field-msg is-success"><i class="ico ico-tick" aria-hidden="true"></i> Valid email address.</p>
</div>

<!-- Required -->
<label class="field-label field-label-required" for="postcode">Postcode</label>
```

##### CSS

```css
.field { display: flex; flex-direction: column; gap: 0.25rem; }
.field-label { font-size: 0.875rem; font-weight: 400; color: var(--type-secondary); }
.field-label-required::after { content: ' *'; color: var(--ui-error-accent); }

.field-input {
  height: 48px;
  padding: 0 0.875rem;
  border: 1px solid var(--gray-50); border-radius: var(--radius-sm);
  font-family: 'Inter', sans-serif; font-size: 0.875rem; color: var(--type-secondary);
  background: var(--ui-core-base); outline: none; width: 100%;
  transition: border-color 150ms, box-shadow 150ms;
}
.field-input::placeholder { color: var(--gray-60); }
.field-input:focus-visible { border-color: var(--action-secondary-base); box-shadow: 0 0 0 3px rgba(5,100,194,0.15); }
.field-input:disabled { background: var(--gray-10); color: var(--gray-70); cursor: not-allowed; border-color: var(--gray-30); }

.field-input.is-error     { border-color: var(--ui-error-accent);     background: var(--ui-error-base); }
.field-input.is-success   { border-color: var(--ui-success-accent);   background: var(--ui-success-base); }
.field-input.is-highlight { border-color: var(--ui-highlight-accent); background: var(--ui-highlight-base); }

.field-msg { font-size: 0.8125rem; }
.field-msg.is-error     { color: var(--ui-error-contrast); }
.field-msg.is-success   { color: var(--ui-success-contrast); }
.field-msg.is-highlight { color: var(--ui-highlight-contrast); }
.field-msg.is-helper    { color: var(--type-tertiary); }
```

##### Rules

- `aria-invalid="true"` on error inputs. `aria-describedby` linking to the `.field-msg`'s `id`.
- Visible label always. Placeholder is **not** a label.
- Error messages start with a verb or describe the fix: "Enter a valid UK postcode" — not "Invalid postcode."

---

#### 3 · Select

Native `<select>` with a custom chevron overlay. Inherits the Input styles.

##### HTML

```html
<div class="field" data-aods="field">
  <label class="field-label" for="delivery">Delivery option</label>
  <div class="field-select-wrap">
    <select class="field-input" id="delivery">
      <option value="">Choose delivery option</option>
      <option value="standard">Standard (3–5 days)</option>
      <option value="express">Express (next day)</option>
    </select>
  </div>
</div>
```

##### CSS

```css
.field-select-wrap { position: relative; }
.field-select-wrap::after {
  content: ''; pointer-events: none;
  position: absolute; right: 0.75rem; top: 50%; transform: translateY(-50%);
  width: 0; height: 0;
  border-left: 5px solid transparent; border-right: 5px solid transparent;
  border-top: 6px solid var(--gray-70);
}
select.field-input { appearance: none; padding-right: 2.5rem; }
```

---

#### 4 · Textarea

Inherits all Input states. Use for multi-line input.

```html
<div class="field" data-aods="field">
  <label class="field-label" for="notes">Delivery notes</label>
  <textarea class="field-input" id="notes" rows="4" placeholder="Additional instructions for the driver"></textarea>
</div>
```

---

#### 5 · Checkbox / Radio (toggle items)

Card-style selection controls — generous tap target, blue selection theme, supports rich multi-line content. Use `RadioButtonGroup` for single-choice and `CheckboxGroup` for multi-choice.

**Naming:** matches AO Storybook — `data-aods="radio-button-group"` / `data-aods="radio-button"` (and `checkbox-group` / `checkbox`). The Figma Make output **must** use these names so prototypes wire up correctly.

**Variants:** default (square card) · `pill` (rounded card) · `inline` (horizontal row) · `full-width` (children stretch).
**States:** default · `:hover` · `:focus-visible` · `:checked` (selected) · `:disabled` (unavailable).

##### HTML — stacked (default)

```html
<fieldset data-aods="radio-button-group">
  <legend class="field-label" style="margin-bottom:0.5rem;">Delivery options</legend>
  <div class="toggle-group">
    <label class="toggle-item" data-aods="radio-button">
      <input type="radio" name="delivery" value="next" checked>
      <div class="toggle-item-body">
        <div class="toggle-item-label">Next day — Free</div>
        <div class="toggle-item-sub">Order before midnight</div>
      </div>
    </label>
    <label class="toggle-item" data-aods="radio-button">
      <input type="radio" name="delivery" value="named">
      <div class="toggle-item-body">
        <div class="toggle-item-label">Named day</div>
        <div class="toggle-item-sub">Choose your slot — £5.99</div>
      </div>
    </label>
    <label class="toggle-item is-disabled" data-aods="radio-button">
      <input type="radio" name="delivery" value="sat" disabled>
      <div class="toggle-item-body">
        <div class="toggle-item-label">Saturday</div>
        <div class="toggle-item-sub toggle-item-sub--xs">Unavailable</div>
      </div>
    </label>
  </div>
</fieldset>
```

##### HTML — inline pill row (with 3-line content)

Use when the user is picking from a small set of equal-weight, scannable options (e.g. day picker, size picker, slot picker).

```html
<fieldset data-aods="radio-button-group" class="toggle-group toggle-group--inline toggle-group--pill toggle-group--full">
  <legend class="visually-hidden">Choose a delivery day</legend>
  <label class="toggle-item" data-aods="radio-button">
    <input type="radio" name="day" value="sun" checked>
    <div class="toggle-item-body">
      <strong class="toggle-item-line">Sun</strong>
      <span   class="toggle-item-line toggle-item-sub">12th Oct</span>
      <strong class="toggle-item-line">£5.00</strong>
    </div>
  </label>
  <label class="toggle-item" data-aods="radio-button">
    <input type="radio" name="day" value="mon">
    <div class="toggle-item-body">
      <strong class="toggle-item-line">Mon</strong>
      <span   class="toggle-item-line toggle-item-sub">11th Oct</span>
      <strong class="toggle-item-line">Free</strong>
    </div>
  </label>
  <label class="toggle-item is-disabled" data-aods="radio-button">
    <input type="radio" name="day" value="tue" disabled>
    <div class="toggle-item-body">
      <strong class="toggle-item-line">Tues</strong>
      <span   class="toggle-item-line toggle-item-sub">13th Oct</span>
      <span   class="toggle-item-line toggle-item-sub--xs">Unavailable</span>
    </div>
  </label>
  <label class="toggle-item" data-aods="radio-button">
    <input type="radio" name="day" value="wed">
    <div class="toggle-item-body">
      <strong class="toggle-item-line">Wed</strong>
      <span   class="toggle-item-line toggle-item-sub">14th Oct</span>
      <strong class="toggle-item-line">Free</strong>
    </div>
  </label>
</fieldset>
```

##### HTML — checkbox group

```html
<div class="toggle-group" data-aods="checkbox-group">
  <label class="toggle-item" data-aods="checkbox">
    <input type="checkbox" value="warranty" checked>
    <div class="toggle-item-body">
      <div class="toggle-item-label">3-year AO guarantee</div>
      <div class="toggle-item-sub">Extend your cover — from £29</div>
    </div>
  </label>
</div>
```

##### HTML — recommended / highlighted card

The selected/recommended plan pattern. **Blue theme — never green.** Green is reserved for the primary CTA below it.

```html
<label class="toggle-item toggle-item--highlight" data-aods="radio-button" aria-current="true">
  <input type="radio" name="plan" value="25gb" checked class="visually-hidden">
  <span class="tag tag-recommended">Recommended</span>
  <div class="toggle-item-body">
    <div class="toggle-item-head">
      <strong class="toggle-item-title">25GB</strong>
      <strong class="toggle-item-price">£12<span class="toggle-item-price-unit">/month</span></strong>
    </div>
    <p class="toggle-item-desc">Plenty of data for streaming, social and everyday browsing.</p>
    <ul class="toggle-item-features">
      <li>UK 5G coverage included</li>
      <li>30-day rolling, cancel any time</li>
      <li>Roaming in 40+ EU countries</li>
    </ul>
  </div>
</label>
```

##### CSS

```css
/* Group layouts */
.toggle-group               { display: flex; flex-direction: column; gap: 0.5rem; border: 0; padding: 0; margin: 0; }
.toggle-group--inline       { flex-direction: row; flex-wrap: wrap; }
.toggle-group--inline > .toggle-item { flex: 1 1 0; min-width: 0; }
.toggle-group--full         { width: 100%; }

/* Item — default (square card) */
.toggle-item {
  position: relative;
  display: flex; align-items: flex-start; gap: 0.75rem;
  padding: 0.75rem 1rem; border-radius: var(--radius-sm);
  border: 1px solid var(--gray-50); background: var(--ui-core-base); cursor: pointer;
  transition: border-color 150ms, background 150ms, box-shadow 150ms;
}
.toggle-group--pill .toggle-item { border-radius: var(--radius-sm); padding: 0.75rem 1rem; }

/* Input — custom radio/checkbox styling (blue selection theme) */
.toggle-item input {
  appearance: none; -webkit-appearance: none;
  width: 20px; height: 20px; flex-shrink: 0; margin-top: 1px;
  border: 2px solid var(--gray-50); background: var(--ui-core-base); cursor: pointer;
  transition: border-color 150ms, background 150ms;
}
.toggle-item input[type="radio"] { border-radius: 50%; }
.toggle-item input[type="checkbox"] { border-radius: var(--radius-xs); }
.toggle-item input:checked {
  border-color: var(--ui-highlight-accent); background: var(--ui-highlight-accent);
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath d='M6.5 11.5L3 8l1-1 2.5 2.5 5-5 1 1z' fill='white'/%3E%3C/svg%3E");
  background-size: 14px; background-position: center; background-repeat: no-repeat;
}
.toggle-item input[type="radio"]:checked {
  background-image: none;
  box-shadow: inset 0 0 0 4px var(--ui-core-base);
}
.toggle-item input:focus-visible {
  box-shadow: 0 0 0 3px rgba(5,100,194,0.15);
  border-color: var(--action-secondary-base);
  outline: none;
}

/* Body */
.toggle-item-body  { display: flex; flex-direction: column; gap: 0.125rem; min-width: 0; flex: 1; }
.toggle-item-line  { display: block; }
.toggle-item-label { font-size: 0.9375rem; font-weight: 700; color: var(--type-secondary); }
.toggle-item-sub      { font-size: 0.8125rem; color: var(--type-tertiary); }
.toggle-item-sub--xs  { font-size: 0.75rem;   color: var(--type-tertiary); }

/* States */
.toggle-item:hover                { border-color: var(--gray-60); background: var(--gray-10); }
.toggle-item:has(:focus-visible)  { outline: 0; box-shadow: 0 0 0 4px var(--action-secondary-glow); border-color: var(--action-secondary-base); }
.toggle-item:has(:checked) {
  border-color: var(--ui-highlight-accent);
  background: var(--ui-highlight-base);
}
.toggle-item:has(:checked) .toggle-item-label,
.toggle-item:has(:checked) .toggle-item-sub,
.toggle-item:has(:checked) .toggle-item-line { color: var(--ui-highlight-contrast); }

.toggle-item.is-disabled,
.toggle-item:has(:disabled) {
  background: var(--gray-20); border-color: var(--gray-30);
  cursor: not-allowed; color: var(--gray-90);
}
.toggle-item.is-disabled .toggle-item-label { color: var(--gray-90); }

/* Highlighted / recommended card (blue — never green) */
.toggle-item--highlight {
  border-width: 2px;
  border-color: var(--ui-highlight-accent);
  background: var(--ui-highlight-base);
  border-radius: var(--radius-sm);
  padding: 1rem;
}
.toggle-item--highlight .tag-recommended {
  position: absolute; top: -0.625rem; left: 1rem;
  background: var(--ui-highlight-accent); color: var(--action-secondary-contrast);
  border-color: var(--ui-highlight-accent);
}
.toggle-item-head { display: flex; justify-content: space-between; align-items: baseline; }
.toggle-item-title { font-size: 1.25rem; color: var(--type-primary); }
.toggle-item-price { font-size: 1.25rem; color: var(--type-primary); }
.toggle-item-price-unit { font-size: 0.875rem; color: var(--type-tertiary); font-weight: 400; }
.toggle-item-desc { font-size: 0.9375rem; color: var(--type-secondary); margin: 0.5rem 0; }
.toggle-item-features { margin: 0.5rem 0 0; padding: 0; list-style: none; display: flex; flex-direction: column; gap: 0.25rem; }
.toggle-item-features li::before { content: "✓ "; color: var(--ui-highlight-accent); font-weight: 700; }

/* Visually hidden legend (for inline groups where the legend would crowd the layout) */
.visually-hidden { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0,0,0,0); white-space: nowrap; border: 0; }
```

##### Rules

- Groups use `<fieldset>` + `<legend>` for screen-reader grouping. Use `.visually-hidden` on the legend when an inline pill row would crowd it visually.
- Selection theme is **blue** (`action-secondary`). Never green — green is reserved for the primary CTA in the same view.
- Sub-label is optional but encouraged for radio groups with price, duration, or availability variants.
- Disabled options stay visible (greyed) so users understand *why* something isn't pickable — don't hide them. Show an `Unavailable` sub-line in `toggle-item-sub--xs`.
- For the inline row variant, use `flex: 1 1 0` so columns stay equal width even with different content lengths.
- The "recommended" / highlighted card is just a `.toggle-item--highlight` modifier — same component, not a separate one. The tag overhangs the top-left corner.
- `data-aods` attributes are required (`radio-button-group`, `radio-button`, `checkbox-group`, `checkbox`) so AO prototype tooling and Code Connect can map back to the real component.

---

#### 6 · Tag

Pill badges for status, categories, labels.

**Variants (always `ui-*` semantic):** `core` · `neutral` · `highlight` · `success` · `warning` · `error` · `dark`.
**Sizes:** default · `tag-lg`.

##### HTML

```html
<span class="tag tag-success" data-aods="tag"><i class="ico ico-tick ico-md" aria-hidden="true"></i> In stock</span>
<span class="tag tag-highlight" data-aods="tag">New</span>
<span class="tag tag-warning" data-aods="tag">Limited stock</span>
<span class="tag tag-error" data-aods="tag">Out of stock</span>
<span class="tag tag-neutral tag-lg" data-aods="tag">Energy A+++</span>
```

##### CSS

```css
.tag {
  display: inline-flex; align-items: center; gap: 0.25rem;
  padding: 0.5rem 1rem; border-radius: var(--radius-2xl);
  font-family: 'SmileyFace', Georgia, serif; font-size: 0.875rem; font-weight: 700; line-height: 1.25; border: 0;
}
.tag-success   { background: var(--ui-success-base);   color: var(--ui-success-contrast); }
.tag-highlight { background: var(--ui-highlight-base); color: var(--ui-highlight-contrast); }
.tag-neutral   { background: var(--ui-neutral-base);   color: var(--type-secondary); }
.tag-warning   { background: var(--ui-warning-base);   color: var(--ui-warning-contrast); }
.tag-error     { background: var(--ui-error-base);     color: var(--ui-error-contrast); }
.tag-dark      { background: var(--type-primary);      color: #fff; }
.tag-lg { padding: 0.5rem 1.25rem; font-size: 1rem; }
```

##### Rules

- Stick to `ui-*` semantic groups. No arbitrary colours.
- Labels use **SmileyFace Bold** at 14px minimum — the 14px SmileyFace floor applies here. No borders; the tinted fill alone signals the variant.
- `tag-warning` is for caution states only — never decoration.
- One tag style per concept. Don't mix variants in a single list (e.g. don't use `success` and `highlight` on adjacent product tiles unless they communicate genuinely different states).
- When an icon is included, use `ico-md` (1em = 14px at default tag size).

---

#### 7 · Notice

Inline feedback banners in four variants: info, success (confirmation), warning, error. Stacked layout with bold title on its own line, supporting body text below, and an optional action link. Icon top-aligned with the text block. Sits in-flow, smaller than a Card.

##### HTML

```html
<!-- Basic (no link) -->
<div class="notice notice-info" role="note" data-aods="notice">
  <i class="ico ico-info notice-icon" aria-hidden="true"></i>
  <div class="notice-content">
    <strong class="notice-title">Info alert</strong>
    <span class="notice-body">Some warm copy to complement it</span>
  </div>
</div>

<div class="notice notice-warning" role="note" data-aods="notice">
  <i class="ico ico-info notice-icon" aria-hidden="true"></i>
  <div class="notice-content">
    <strong class="notice-title">Warning alert</strong>
    <span class="notice-body">Some warm copy to complement it</span>
  </div>
</div>

<div class="notice notice-success" role="status" data-aods="notice">
  <i class="ico ico-tick-circle notice-icon" aria-hidden="true"></i>
  <div class="notice-content">
    <strong class="notice-title">Confirmation alert</strong>
    <span class="notice-body">Some warm copy to complement it</span>
  </div>
</div>

<div class="notice notice-error" role="alert" data-aods="notice">
  <i class="ico ico-cancel notice-icon" aria-hidden="true"></i>
  <div class="notice-content">
    <strong class="notice-title">Error alert</strong>
    <span class="notice-body">Some warm copy to complement it</span>
  </div>
</div>

<!-- With action link -->
<div class="notice notice-info" role="note" data-aods="notice">
  <i class="ico ico-info notice-icon" aria-hidden="true"></i>
  <div class="notice-content">
    <strong class="notice-title">Info alert</strong>
    <span class="notice-body">Some warm copy to complement it</span>
    <a href="#" class="notice-link">Call to action</a>
  </div>
</div>
```

##### CSS

```css
.notice {
  display: flex; gap: 0.5rem; align-items: flex-start;
  padding: 0.75rem; border-radius: var(--radius-sm);
  font-family: 'Inter', sans-serif;
  font-size: 0.75rem; line-height: 1.625;
}
.notice-icon { flex-shrink: 0; width: 1.5rem; height: 1.5rem; font-size: 1.5rem; line-height: 1; }
.notice-content { display: flex; flex-direction: column; align-items: flex-start; flex: 1; min-width: 0; }
.notice-title { font-weight: 700; color: var(--type-primary); display: block; }
.notice-body  { font-weight: 400; color: var(--type-tertiary); display: block; }
.notice-link  { font-weight: 700; color: var(--action-secondary-base); text-decoration: none; padding-top: 2px; }
.notice-link:hover { text-decoration: underline; }

.notice-info      { background: var(--ui-highlight-base); }
.notice-info .notice-icon { color: var(--action-secondary-base); }

.notice-warning   { background: var(--notice-warning-bg, #ffe3c2); }
.notice-warning .notice-icon { color: var(--ui-warning-accent); }

.notice-success   { background: var(--notice-success-bg, #befcc8); }
.notice-success .notice-icon { color: var(--action-primary-base); }

.notice-error     { background: var(--notice-error-bg, #ffd8d2); }
.notice-error .notice-icon { color: var(--ui-error-accent); }
```

##### Tokens (add to `:root`)

```css
--notice-warning-bg: #ffe3c2;
--notice-success-bg: #befcc8;
--notice-error-bg: #ffd8d2;
```

> Info uses the existing `--ui-highlight-base` (#edf2ff). The other three variants use purpose-built notice surface tokens because the production component backgrounds are more saturated than the generic `ui-*-base` surfaces.

##### Icons per variant

| Variant | Icon class | Colour token |
|---------|-----------|--------------|
| `notice-info` | `ico-info` | `--action-secondary-base` (blue) |
| `notice-warning` | `ico-info` | `--ui-warning-accent` (orange) |
| `notice-success` | `ico-tick-circle` | `--action-primary-base` (green) |
| `notice-error` | `ico-cancel` | `--ui-error-accent` (red) |

##### Rules

- `role="alert"` for errors (assertive announcement). `role="status"` for confirmations. `role="note"` for everything else.
- Layout is stacked: **title** on line 1, body on line 2, optional link on line 3.
- Icons are top-aligned with the text block (flex-start), not vertically centred.
- Icon size is 24×24px. All icons use filled circle variants.
- The action link uses `--action-secondary-base` (blue) with bold weight. It appears only when a CTA is needed.
- Keep notices to one or two sentences max. If you need more, use a Card.
- Warning uses the same `ico-info` icon as info — just in orange.

---

#### 8 · Card

The default surface. 16px radius, 1px border, 24px padding. Use `card-raised` for elevated surfaces (sticky panels, dropdowns).

##### HTML

```html
<div class="card" data-aods="card">
  <h3 class="text-title">Card title</h3>
  <p class="text-body">Card body text.</p>
</div>

<!-- Raised -->
<div class="card card-raised" data-aods="card">…</div>

<!-- State variants -->
<div class="card card-success" data-aods="card">Payment confirmed.</div>
<div class="card card-highlight" data-aods="card">Recommended option.</div>
<div class="card card-error" data-aods="card">Card declined.</div>

<!-- With a divider -->
<div class="card" data-aods="card">
  <h3 class="text-title">Order summary</h3>
  <div class="card-divider"></div>
  <p class="text-body">Subtotal · £499.00</p>
</div>
```

##### CSS

```css
.card {
  background: var(--ui-core-base); border: 1px solid var(--gray-40);
  border-radius: var(--radius-md); padding: 1.5rem;
}
.card-raised    { box-shadow: var(--shadow-md); }
.card-success   { background: var(--ui-success-base);   border-color: var(--ui-success-accent); }
.card-highlight { background: var(--ui-highlight-base); border-color: var(--ui-highlight-accent); }
.card-error     { background: var(--ui-error-base);     border-color: var(--ui-error-accent); }
.card-divider   { height: 1px; background: var(--gray-30); margin: 1rem -1.5rem; }
```

##### Rules

- 24px padding default; reduce to 16px on mobile only when space is tight.
- Don't nest cards more than one level deep.

---

#### 9 · Breadcrumb

```html
<nav aria-label="Breadcrumb" data-aods="breadcrumb">
  <ol class="crumb">
    <li><a href="/">Home</a><span class="crumb-sep" aria-hidden="true">›</span></li>
    <li><a href="/appliances">Appliances</a><span class="crumb-sep" aria-hidden="true">›</span></li>
    <li><span aria-current="page">Washing machines</span></li>
  </ol>
</nav>
```

```css
.crumb { display: flex; gap: 0.375rem; align-items: center; list-style: none; }
.crumb li { display: flex; align-items: center; gap: 0.375rem; }
.crumb a { color: var(--action-secondary-base); text-decoration: none; font-size: 0.8125rem; font-weight: 700; }
.crumb a:hover { text-decoration: underline; }
.crumb span { font-size: 0.8125rem; color: var(--type-tertiary); }
.crumb-sep { color: var(--gray-60); font-size: 0.75rem; }
```

Rules: last item is `aria-current="page"` and not a link. Separators are decorative (`aria-hidden`).

---

#### 10 · Tabs

Limit to 2–7 tabs. Use accordion pattern on narrow screens.

```html
<div data-aods="tabs">
  <div class="tab-list" role="tablist">
    <button class="tab-item active" role="tab" aria-selected="true">Description</button>
    <button class="tab-item" role="tab" aria-selected="false">Specifications</button>
    <button class="tab-item" role="tab" aria-selected="false">Reviews</button>
  </div>
  <div class="tab-panel" role="tabpanel">…</div>
</div>
```

```css
.tab-list { display: flex; border-bottom: 1px solid var(--gray-40); gap: 0; }
.tab-item {
  padding: 1rem; font-size: 1rem;
  color: var(--type-primary); cursor: pointer; border: none; background: transparent;
  font-family: 'SmileyFace', Georgia, serif; font-weight: 700;
  border-bottom: 3px solid transparent;
  margin-bottom: -1px; transition: color 150ms, border-color 150ms;
}
.tab-item:hover { color: var(--type-primary); border-bottom-color: var(--gray-40); }
.tab-item.active { color: var(--type-primary); border-bottom-color: var(--action-secondary-base); }
.tab-item:focus-visible { outline: 3px solid var(--action-secondary-glow); outline-offset: 2px; }
```

---

#### 11 · Accordion

Progressive disclosure for FAQ, product details, supplementary content. Not for primary navigation.

```html
<div class="accordion" data-aods="accordion">
  <div class="accordion-item">
    <button class="accordion-header" aria-expanded="true" aria-controls="acc-1">
      <span>Delivery information</span>
      <i class="ico ico-chevron-down accordion-chevron" aria-hidden="true"></i>
    </button>
    <div id="acc-1" class="accordion-body">We deliver within 2–3 working days.</div>
  </div>
  <div class="accordion-item">
    <button class="accordion-header" aria-expanded="false" aria-controls="acc-2">
      <span>Returns policy</span>
      <i class="ico ico-chevron-down accordion-chevron" aria-hidden="true"></i>
    </button>
    <div id="acc-2" class="accordion-body" hidden>Return within 30 days.</div>
  </div>
</div>
```

```css
.accordion { overflow: hidden; }
.accordion-item { border-bottom: 1px solid var(--gray-40); }
.accordion-item:last-child { border-bottom: none; }
.accordion-header {
  display: flex; align-items: center; justify-content: space-between;
  width: 100%; padding: 1rem; background: var(--ui-core-base); border: none; cursor: pointer;
  font-family: 'SmileyFace', Georgia, serif; font-size: 1rem; font-weight: 700; color: var(--type-primary);
  text-align: left; transition: background 150ms;
}
.accordion-header:hover,
.accordion-header[aria-expanded="true"] { background: var(--gray-10); }
.accordion-chevron { color: var(--gray-70); transition: transform 200ms; }
.accordion-header[aria-expanded="true"] .accordion-chevron { transform: rotate(180deg); }
.accordion-body[hidden] { display: none; }
```

---

#### 12 · Quantity stepper

```html
<div class="qty-control" data-aods="quantity">
  <button class="qty-btn" aria-label="Decrease">−</button>
  <span class="qty-val">1</span>
  <button class="qty-btn" aria-label="Increase">+</button>
</div>
```

```css
.qty-control {
  display: inline-flex; align-items: stretch;
  border: 1px solid var(--gray-40); border-radius: var(--radius-sm); overflow: hidden;
}
.qty-btn {
  width: 40px; height: 40px; background: var(--gray-10); border: none;
  font-size: 1.25rem; color: var(--type-secondary); cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  transition: background 150ms;
}
.qty-btn:hover { background: var(--gray-20); }
.qty-val {
  width: 48px; text-align: center; font-size: 1rem; font-weight: 500;
  line-height: 40px; color: var(--type-primary);
  border-left: 1px solid var(--gray-40); border-right: 1px solid var(--gray-40);
}
```

---

#### 13 · Loading spinner

Two variants: the **CSS ring** (lightweight, use for inline/button loaders) and the **AO brand loader** (full-page / section loads — the canonical `LoadingSpinner` component in Storybook).

##### CSS ring spinner

```html
<div class="spinner" role="status" aria-live="polite" data-aods="loading-spinner">
  <span class="sr-only">Loading…</span>
</div>

<!-- Small -->
<div class="spinner spinner-sm" role="status"></div>

<!-- On dark background -->
<div class="spinner spinner-white" role="status"></div>
```

```css
@keyframes spin { to { transform: rotate(360deg); } }
.spinner {
  display: inline-block; width: 32px; height: 32px;
  border: 3px solid var(--brand-primary-light);
  border-top-color: var(--action-primary-base);
  border-radius: 50%; animation: spin 0.75s linear infinite;
}
.spinner-sm    { width: 20px; height: 20px; border-width: 2px; }
.spinner-white { border-color: rgba(255,255,255,0.3); border-top-color: #fff; }
```

##### AO brand loader

The "ao" smiley mark inside a track ring with a sweeping green progress arc. Use for full-page and section-level loading states.

```html
<svg class="ao-loader" role="status" aria-live="polite" data-aods="loading-spinner" viewBox="0 0 72 72" xmlns="http://www.w3.org/2000/svg">
  <title>Loading…</title>
  <circle class="ao-loader__track"    cx="36" cy="36" r="31.885" fill="none" stroke-width="8.23" stroke-linecap="round"/>
  <circle class="ao-loader__progress" cx="36" cy="36" r="31.885" fill="none" stroke-width="8.23" stroke-linecap="round"
          stroke-dasharray="200.339" stroke-dashoffset="150" transform="rotate(-90 36 36)"/>
  <path class="ao-loader__mark" d="M25.1 33.8c0-5.9 4.8-10.7 10.7-10.7s10.7 4.8 10.7 10.7v4.5c0 5.9-4.8 10.7-10.7 10.7S25.1 44.2 25.1 38.3v-4.5z"/>
</svg>

<!-- Small (40px) -->
<svg class="ao-loader ao-loader--sm" role="status" viewBox="0 0 72 72" xmlns="http://www.w3.org/2000/svg">…</svg>
```

```css
.ao-loader { display: block; flex: 0 0 auto; width: 72px; height: 72px; }
.ao-loader--sm { width: 40px; height: 40px; }
.ao-loader__track    { stroke: var(--brand-primary-light); }
.ao-loader__progress { stroke: var(--brand-primary-base); stroke-dashoffset: 150; }
.ao-loader__mark     { fill: var(--brand-primary-base); }

@keyframes ao-loader-sweep { from { stroke-dashoffset: 200.339; } to { stroke-dashoffset: 0; } }
@media (prefers-reduced-motion: no-preference) {
  .ao-loader__progress { animation: ao-loader-sweep 1.4s linear infinite; }
}
```

**Tokens used:** `--brand-primary-light` (track), `--brand-primary-base` (arc + mark). No raw hex values.

**Reduced motion:** animation is off by default; gated behind `prefers-reduced-motion: no-preference`. A static partial arc (`stroke-dashoffset: 150`) shows when motion is off.

##### Rules

- Show after a 300ms delay; under 300ms, show nothing. For waits over 2s, use a skeleton screen.
- Use the **CSS ring** for inline states (buttons, small content areas). Use the **brand loader** for full-page or large section loads.
- Never use raw hex for the loader colours — always `--brand-primary-*` tokens.

---

---

#### 14 · Nav (Header)

White header with AO logo, icon navigation, search bar, and a green accent bar. Two main variants: the **Core Site Header** (used on browse/product/account pages) and the **Checkout Header** (used on checkout/basket flows). The core header is fully responsive — simplified icon bar + search row on mobile, full nav + search + categories on desktop.

**Variants:** `core` (full site header — mobile + desktop) · `checkout` (simplified, logo + phone info center + help/basket icons) · `basket` (simplified, logo + account + help + basket)

**When to use which:**
- PDP, category, search, account, homepage → **Core Site Header**
- Checkout, payment, order confirmation → **Checkout Header**
- Basket page → **Basket Header** (same as checkout but adds Account icon)

##### HTML — Core Site Header (Mobile)

```html
<header data-aods="nav">
  <nav class="nav-mobile">
    <a href="/" class="nav-logo" aria-label="AO Home">
      <i class="ico ico-ao-logo" aria-hidden="true"></i>
    </a>
    <button class="nav-icon" aria-label="Menu">
      <i class="ico ico-menu nav-icon-img" aria-hidden="true"></i>
      <span class="nav-icon-label">Menu</span>
    </button>
    <div class="nav-mobile-spacer"></div>
    <a href="/account" class="nav-icon">
      <i class="ico ico-account nav-icon-img" aria-hidden="true"></i>
      <span class="nav-icon-label">Sign In</span>
    </a>
    <a href="/basket" class="nav-icon nav-icon--badge" data-count="2" aria-label="Basket, 2 items">
      <i class="ico ico-basket nav-icon-img" aria-hidden="true"></i>
      <span class="nav-icon-label">Basket</span>
    </a>
  </nav>
  <div class="nav-search--mobile">
    <input class="nav-search-input" type="search" placeholder="Search products, brands or advice">
    <button class="nav-search-btn" aria-label="Search"><i class="ico ico-search" aria-hidden="true"></i></button>
  </div>
  <div class="nav-accent"></div>
  <div class="nav-proposition">
    <span class="nav-proposition-item"><i class="ico ico-five-star-membership" aria-hidden="true"></i> Join AO Five Star Membership and save</span>
  </div>
</header>
```

##### HTML — Core Site Header (Desktop)

```html
<header data-aods="nav">
  <div class="nav-desktop">
    <div class="nav-desktop-top">
      <a href="/" class="nav-logo" aria-label="AO Home">
        <i class="ico ico-ao-logo" aria-hidden="true"></i>
      </a>
      <div class="nav-search">
        <input class="nav-search-input" type="search" placeholder="Search products, brands or advice">
        <button class="nav-search-btn"><i class="ico ico-search" aria-hidden="true"></i> Let's Go!</button>
      </div>
      <div class="nav-desktop-icons">
        <a href="/track" class="nav-icon"><i class="ico ico-track nav-icon-img" aria-hidden="true"></i><span class="nav-icon-label">Track Order</span></a>
        <a href="/account" class="nav-icon"><i class="ico ico-account nav-icon-img" aria-hidden="true"></i><span class="nav-icon-label">Sign In</span></a>
        <a href="/basket" class="nav-icon nav-icon--badge" data-count="2" aria-label="Basket, 2 items"><i class="ico ico-basket nav-icon-img" aria-hidden="true"></i><span class="nav-icon-label">Basket</span></a>
      </div>
    </div>
    <nav class="nav-categories">
      <a href="/appliances">Appliances</a>
      <a href="/tv">TV &amp; Audio</a>
      <a href="/computing">Computing &amp; Gaming</a>
      <a href="/mobile">Mobile Phones</a>
      <a href="/smart-tech">Smart Tech</a>
      <a href="/floorcare">Floorcare</a>
      <a href="/deals" class="nav-categories-deals">Deals</a>
      <a href="/summer-of-football" class="nav-categories-promo">Summer of Football</a>
      <a href="/membership">AO Membership</a>
      <a href="/help" class="nav-categories-help">Help &amp; Advice</a>
    </nav>
  </div>
  <div class="nav-accent"></div>
  <div class="nav-proposition">
    <span class="nav-proposition-item"><i class="ico ico-price-match-gbp" aria-hidden="true"></i> Price Match Guarantee</span>
    <span class="nav-proposition-item"><i class="ico ico-next-day-delivery" aria-hidden="true"></i> Next day delivery, 7 days a week</span>
    <span class="nav-proposition-item"><i class="ico ico-five-star-approved" aria-hidden="true"></i> Rated Excellent</span>
    <span class="nav-proposition-item"><i class="ico ico-five-star-membership" aria-hidden="true"></i> Join AO Five Star Membership and save</span>
    <span class="nav-proposition-item"><i class="ico ico-finance-gbp" aria-hidden="true"></i> Pay with AO Finance</span>
  </div>
</header>
```

> **Note:** Mobile and desktop headers are both present in a single `<header data-aods="nav">` element. The CSS responsive rules show/hide the appropriate sections. See the full responsive pattern below.

##### HTML — Checkout Header

```html
<header data-aods="nav">
  <nav class="nav-mobile nav-checkout">
    <a href="/" class="nav-logo" aria-label="AO Home">
      <i class="ico ico-ao-logo" aria-hidden="true"></i>
    </a>
    <div class="nav-checkout-center">
      <p class="nav-checkout-phone"><strong>0161 470 1600</strong> Open weekdays <strong>8am - 7pm</strong> (sales open at 8:30am), weekends <strong>8am - 5pm</strong></p>
      <p class="nav-checkout-sub">We're here to help. Calls charged at standard rate, even on mobile</p>
    </div>
    <div class="nav-checkout-icons">
      <a href="/help" class="nav-icon nav-checkout-help" aria-label="Help">
        <i class="ico ico-call nav-icon-img" aria-hidden="true"></i>
        <span class="nav-icon-label">Help</span>
      </a>
      <a href="/basket" class="nav-icon nav-icon--badge" aria-label="Basket, 1 item" data-count="1">
        <i class="ico ico-basket nav-icon-img" aria-hidden="true"></i>
        <span class="nav-icon-label">Basket</span>
      </a>
    </div>
  </nav>
  <div class="nav-accent"></div>
</header>
```

> **Responsive behaviour:** `.nav-checkout-center` is hidden on mobile (`display: none`) and shown from `sm` (544px) upward. The Help icon (`.nav-checkout-help`) is shown on mobile and hidden on desktop (where the phone number replaces it).

##### HTML — Basket (simplified)

```html
<header data-aods="nav">
  <nav class="nav-mobile nav-checkout">
    <a href="/" class="nav-logo" aria-label="AO Home">
      <i class="ico ico-ao-logo" aria-hidden="true"></i>
    </a>
    <div class="nav-checkout-icons">
      <a href="/account" class="nav-icon">
        <i class="ico ico-account nav-icon-img" aria-hidden="true"></i>
        <span class="nav-icon-label">Account</span>
      </a>
      <a href="/help" class="nav-icon">
        <i class="ico ico-call nav-icon-img" aria-hidden="true"></i>
        <span class="nav-icon-label">Help</span>
      </a>
      <a href="/basket" class="nav-icon">
        <i class="ico ico-basket nav-icon-img" aria-hidden="true"></i>
        <span class="nav-icon-label">Basket</span>
      </a>
    </div>
  </nav>
  <div class="nav-accent"></div>
</header>
```

##### CSS

```css
/* Nav — Header */
[data-aods="nav"] { position: sticky; top: 0; z-index: 20; background: var(--ui-core-base); }

/* Mobile nav */
.nav-mobile {
  max-width: 1200px; margin: 0 auto;
  background: var(--ui-core-base);
  display: flex; align-items: center; gap: 0.75rem;
  padding: 0.75rem 1rem;
}
.nav-mobile-spacer { flex: 1; }

/* Mobile search row */
.nav-search--mobile {
  display: flex; padding: 0 1rem 0.75rem; background: #fff;
}
.nav-search--mobile .nav-search-input {
  flex: 1; padding: 0 1rem; height: 44px;
  border: 1px solid var(--gray-40); border-right: none;
  border-radius: var(--radius-md) 0 0 var(--radius-md);
  font-family: 'Inter', sans-serif; font-size: 0.875rem;
  color: var(--type-secondary); outline: none;
}
.nav-search--mobile .nav-search-input::placeholder { color: var(--gray-60); }
.nav-search--mobile .nav-search-btn {
  padding: 0 1.25rem; height: 44px;
  background: var(--action-primary-base); border: none;
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  cursor: pointer; display: flex; align-items: center; justify-content: center;
  color: #fff; font-size: 1.25rem;
}

/* Desktop nav */
.nav-desktop { background: #fff; }
.nav-desktop-top {
  display: flex; align-items: center;
  padding: 0.75rem 2rem; gap: 2rem;
}
.nav-desktop-top .nav-logo { flex-shrink: 0; }
.nav-desktop-top .nav-logo .ico { font-size: 3.5rem; color: var(--brand-primary-base); }
.nav-desktop-top .nav-search {
  flex: 1; max-width: 520px; margin: 0 auto; display: flex;
}
.nav-desktop-top .nav-search-input {
  flex: 1; padding: 0 1rem; height: 44px;
  border: 1px solid var(--gray-40); border-right: none;
  border-radius: var(--radius-md) 0 0 var(--radius-md);
  font-family: 'Inter', sans-serif; font-size: 0.875rem;
  color: var(--type-secondary); outline: none;
  transition: border-color 150ms;
}
.nav-desktop-top .nav-search-input:focus { border-color: var(--brand-primary-base); }
.nav-desktop-top .nav-search-input::placeholder { color: var(--gray-60); }
.nav-desktop-top .nav-search-btn {
  padding: 0 1.25rem; height: 44px;
  background: var(--action-primary-base); border: none;
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 0.375rem;
  font-family: 'SmileyFace', Georgia, serif; font-weight: 700;
  font-size: 0.875rem; color: #fff; white-space: nowrap;
}
.nav-desktop-top .nav-search-btn .ico { font-size: 1rem; }
.nav-desktop-icons { display: flex; gap: 1.75rem; flex-shrink: 0; align-items: flex-start; }

/* Nav icons (shared) */
.nav-icon {
  position: relative;
  display: flex; flex-direction: column; align-items: center;
  text-decoration: none; cursor: pointer; background: none; border: none;
  gap: 0.125rem;
}
.nav-icon:focus-visible {
  outline: 3px solid var(--action-secondary-glow); outline-offset: 2px;
  border-radius: var(--radius-sm);
}
.nav-icon-img { font-size: 1.75rem; color: var(--type-primary); }
.nav-icon-label {
  font-family: 'Inter', sans-serif; font-size: 0.6875rem; font-weight: 400;
  color: var(--type-primary); line-height: 1.25;
}

/* Badge (red notification dot with count) */
.nav-icon--badge::after {
  content: attr(data-count);
  position: absolute; top: -4px; right: -6px;
  min-width: 18px; height: 18px; padding: 0 4px;
  border-radius: 50%; background: #cf1a30; color: #fff;
  font-family: 'Inter', sans-serif; font-size: 0.6875rem; font-weight: 700;
  display: flex; align-items: center; justify-content: center;
}

/* Desktop icon labels — Inter (not SmileyFace, to stay above 14px minimum) */
@media (min-width: 991px) {
  .nav-icon-label { font-size: 0.8125rem; }
}

/* Logo */
.nav-logo { display: flex; align-items: center; text-decoration: none; flex-shrink: 0; }
.nav-logo .ico { font-size: 3rem; color: var(--brand-primary-base); }
.nav-logo:focus-visible {
  outline: 3px solid var(--action-secondary-glow); outline-offset: 2px;
  border-radius: var(--radius-sm);
}

/* Categories bar */
.nav-categories {
  display: flex; align-items: center; gap: 1.75rem;
  padding: 0.625rem 2rem;
  font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 0.875rem;
}
.nav-categories a { color: var(--type-primary); text-decoration: none; white-space: nowrap; }
.nav-categories a:hover { text-decoration: underline; }
.nav-categories-deals { color: #cf1a30; }
.nav-categories-promo { color: #cf1a30; }
.nav-categories-help { margin-left: auto; }

/* Checkout / Basket variant */
.nav-checkout { justify-content: space-between; }
.nav-checkout-center {
  flex: 1; text-align: center;
  font-family: 'Inter', sans-serif; line-height: 1.4;
  display: none;
}
@media (min-width: 544px) {
  .nav-checkout-center { display: block; }
  .nav-checkout-icons .nav-checkout-help { display: none; }
}
.nav-checkout-phone { font-size: 0.8125rem; color: var(--type-primary); margin: 0; }
.nav-checkout-sub { font-size: 0.75rem; color: var(--type-tertiary); margin: 2px 0 0; }
.nav-checkout-icons { display: flex; gap: 1.5rem; }

/* Green accent bar */
.nav-accent { height: 4px; background: var(--brand-primary-base); }

/* Proposition bar */
.nav-proposition {
  background: var(--gray-10);
  display: flex; align-items: center; justify-content: space-between;
  padding: 0.75rem 2rem;
  border-top: 1px solid var(--gray-30);
}
.nav-proposition-item {
  display: inline-flex; align-items: center; gap: 0.5rem;
  font-family: 'Inter', sans-serif; font-size: 0.875rem; color: var(--type-tertiary);
  white-space: nowrap;
}
.nav-proposition-item .ico { font-size: 1.25rem; }

/* Responsive — show/hide mobile vs desktop */
@media (max-width: 990px) {
  .nav-desktop { display: none; }
  .nav-proposition-item:not(:first-child) { display: none; }
}
@media (min-width: 991px) {
  .nav-mobile { display: none; }
  .nav-search--mobile { display: none; }
}
```

##### Rules

**Core Site Header:**
- Mobile: Logo (top-left, 3rem) + Menu icon + spacer + Sign In + Basket (with badge). Search bar as a separate full-width row below.
- Desktop: Logo (left, 3.5rem) + Search bar (flexible width, max 520px, gray-40 border, `var(--radius-md)` corners) + Track Order / Sign In / Basket icons right-aligned.
- Search button: green `action-primary-base` bg, "Let's Go!" text + search icon on desktop. Icon-only on mobile.
- Categories row: SmileyFace Bold 14px. "Deals" and promos = red `#cf1a30`. "Help & Advice" pushed right with `margin-left: auto`.
- Green accent bar (4px, `brand-primary-base`) separates header from proposition bar.
- Basket icon has red notification badge via `.nav-icon--badge` + `data-count` attribute.
- Proposition bar: `gray-10` bg, Inter 14px, each item prefixed with a Strata icon. Mobile shows one item; desktop shows all 5 with `justify-content: space-between`.
- Icon labels: Inter 11px (mobile), Inter 13px (desktop). Never SmileyFace — it would violate the 14px minimum.
- All interactive elements have `:focus-visible` outlines using `action-secondary-glow`.
- Header is `position: sticky; top: 0` with `z-index: 20`.

**Checkout Header:**
- Simplified: Logo (left) + phone info (center, hidden on mobile) + Help icon + Basket icon (right).
- `.nav-checkout-center` contains phone number and hours. Hidden below 544px; the Help icon is shown instead.
- At 544px+, center phone info is visible and the Help icon hides (redundant).
- No search bar, no categories, no proposition bar — checkout should feel focused and distraction-free.
- Green accent bar still present (brand continuity).

**Basket Header:**
- Same as checkout but adds an Account icon between Logo and Help.

---


#### 15 · Footer

Two-tone dark footer with link columns and legal copy.

##### HTML

```html
<footer class="footer" data-aods="footer">
  <div class="footer-links">
    <div class="footer-col">
      <a href="#">Contact us</a>
      <a href="#">Help & advice</a>
      <a href="#">About us</a>
      <a href="#">Privacy</a>
      <a href="#">Cookies</a>
    </div>
    <div class="footer-col">
      <a href="#">Our services</a>
      <a href="#">Track your order</a>
      <a href="#">My account</a>
      <a href="#">AO Care</a>
    </div>
  </div>
  <div class="footer-secondary">
    <div class="footer-col">
      <a href="#">Terms & Conditions</a>
      <a href="#">Careers</a>
      <a href="#">AO Life</a>
    </div>
    <div class="footer-col">
      <a href="#">Modern Slavery Statement</a>
      <a href="#">Affiliates</a>
      <a href="#">Partners</a>
    </div>
  </div>
  <div class="footer-legal">
    <p>ao.com is operated by AO Retail Limited, registered in England with company number 03914998 whose registered office is at 5a, The Parklands, Lostock, Bolton, BL6 4SD.</p>
    <p>The goods you buy from this site will be purchased from AO Retail Limited.</p>
    <p>Credit is provided by NewDay Ltd. AO Retail Limited acts as a credit broker for NewDay Ltd on an exclusive basis and is not a lender. Subject to status. Terms apply.</p>
  </div>
</footer>
```

##### CSS

```css
.footer { width: 100%; }
.footer-links {
  background: var(--gray-90);
  display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;
  padding: 1.5rem 1rem;
}
.footer-col {
  display: flex; flex-direction: column; gap: 1.5rem;
}
.footer-links a {
  font-family: 'SmileyFace', Georgia, serif; font-weight: 700;
  font-size: 0.875rem; color: #fff; text-decoration: none; line-height: 1.25;
}
.footer-links a:hover { text-decoration: underline; }

.footer-secondary {
  background: var(--gray-100);
  display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;
  padding: 1.5rem 1rem 1rem;
}
.footer-secondary a {
  font-family: 'Inter', sans-serif; font-size: 0.875rem;
  color: #fff; text-decoration: none; line-height: 1.625;
}
.footer-secondary a:hover { text-decoration: underline; }

.footer-legal {
  background: var(--gray-100);
  padding: 1rem;
  text-align: center;
}
.footer-legal p {
  font-family: 'Inter', sans-serif; font-size: 0.75rem;
  color: var(--gray-50); line-height: 1.625;
  margin: 0 0 1rem;
}

@media (min-width: 990px) {
  .footer-links { padding: 1rem 8.5rem; display: flex; justify-content: center; gap: 2rem; flex-wrap: wrap; }
  .footer-links .footer-col { flex-direction: row; gap: 2rem; }
  .footer-secondary { padding: 1.5rem 8.5rem; display: flex; justify-content: center; gap: 2rem; flex-wrap: wrap; }
  .footer-secondary .footer-col { flex-direction: row; gap: 2rem; }
  .footer-legal { padding: 1rem 9rem 2rem; }
}
```

##### Rules

- Footer link section uses SmileyFace Bold 14px (like category nav)
- Secondary links use Inter Regular 14px
- Legal copy uses Inter Regular 12px in gray-50
- Two background tones: gray-90 for primary links, gray-100 for secondary + legal
- Mobile: 2 columns. Desktop: 4 columns with wider padding
- `data-aods="footer"` on the root element


---

#### 16 · Switch24 payment selectors

Two-card payment option selector used on Switch24 product pages. Presents the Switch24 instalment plan alongside Pay in full in mutually exclusive radio-card style, with member/non-member pricing pods and payment provider logos.

**Variants:** `s24-option--switch` (Switch24 instalment) · `s24-option--full` (Pay in full). **States:** default (unselected, gray border) · `is-selected` (coloured border and radio fill — purple for Switch24, blue for Pay in full).

##### Tokens used

| Token | Purpose |
|---|---|
| `--switch-purple` | Switch24 selected border, logo accent, pod label colour |
| `--action-secondary-base` | Pay in full selected border and radio fill |
| `--ui-highlight-base` / `--ui-highlight-accent` | Member toggle selected label fill and border |
| `--gray-40` | Default unselected card border |
| `--gray-10` | "What happens after 24 months?" background |
| `--gray-30` | Breakdown row dividers |

##### SVG sprite symbols

Add once near `<body>`, referenced everywhere via `<use href="#…"/>`.

```html
<svg style="display:none" xmlns="http://www.w3.org/2000/svg">
  <!-- Switch24 logo -->
  <symbol id="ic-switch24" viewBox="0 0 132 34">
    <text x="0" y="26" font-size="25" font-weight="700" fill="#8023bd" style="font-family:'SmileyFace','Trebuchet MS',Verdana,sans-serif">Switch</text>
    <rect x="86" y="5" width="42" height="24" rx="8" fill="#8023bd"/>
    <text x="107" y="23" font-size="16" font-weight="700" fill="#ffffff" text-anchor="middle" style="font-family:'SmileyFace','Trebuchet MS',Verdana,sans-serif">24</text>
  </symbol>
  <!-- Payment provider logos (Pay in full) -->
  <symbol id="ic-visa" viewBox="0 0 780 500">
    <rect width="780" height="500" rx="40" fill="#1A1F71"/>
    <path d="M293 342L325 159h52L345 342h-52zm230-179c-10-4-27-8-47-8-52 0-89 27-89 65-1 28 26 44 45 53 20 10 27 16 27 25-1 13-16 19-31 19-21 0-32-3-49-10l-7-3-7 43c12 5 34 10 57 10 55 0 91-27 91-68 0-23-14-40-46-54-19-9-31-15-31-25 0-8 10-17 31-17 18-1 31 4 41 8l5 2 8-40zm136-3h-40c-13 0-22 4-28 17l-79 188h56l11-31h68l6 31h49l-43-205zm-65 138l21-55 10-28 5 28 15 55h-51zm-382-138l-52 140-5-29c-10-29-40-61-73-77l47 172h57l84-206h-58z" fill="#fff"/>
    <path d="M163 159h-87l-1 5c68 17 113 57 131 106l-19-94c-3-13-12-17-24-17z" fill="#F2AE14"/>
  </symbol>
  <symbol id="ic-mastercard" viewBox="0 0 131.39 86.9">
    <rect width="131.39" height="86.9" rx="7" fill="#252525"/>
    <circle cx="47.35" cy="43.45" r="27.45" fill="#EB001B"/>
    <circle cx="84.04" cy="43.45" r="27.45" fill="#F79E1B"/>
    <path d="M65.7 21.14a27.44 27.44 0 0 1 0 44.62 27.44 27.44 0 0 1 0-44.62z" fill="#FF5F00"/>
  </symbol>
  <symbol id="ic-maestro" viewBox="0 0 131.39 86.9">
    <rect width="131.39" height="86.9" rx="7" fill="#fff" stroke="#d6dddf" stroke-width="1.5"/>
    <circle cx="47.35" cy="43.45" r="27.45" fill="#EB001B"/>
    <circle cx="84.04" cy="43.45" r="27.45" fill="#00A2E5"/>
    <path d="M65.7 21.14a27.44 27.44 0 0 1 0 44.62 27.44 27.44 0 0 1 0-44.62z" fill="#7673C0"/>
  </symbol>
  <symbol id="ic-amex" viewBox="0 0 131.39 86.9">
    <rect width="131.39" height="86.9" rx="7" fill="#007BC1"/>
    <text x="65.7" y="50" text-anchor="middle" font-family="Arial,sans-serif" font-weight="700" font-size="22" letter-spacing="2" fill="#fff">AMEX</text>
  </symbol>
  <symbol id="ic-paypal" viewBox="0 0 124 33">
    <text x="0" y="24" font-size="22" font-weight="700" fill="#003087" style="font-family:Arial,sans-serif">Pay</text>
    <text x="42" y="24" font-size="22" font-weight="700" fill="#009CDE" style="font-family:Arial,sans-serif">Pal</text>
  </symbol>
</svg>
```

##### CSS

```css
/* Option card */
.s24-option {
  border: 2px solid var(--gray-40); border-radius: var(--radius-md);
  background: var(--ui-core-base); overflow: hidden; cursor: pointer; width: 100%;
}
.s24-option--switch.is-selected { border-color: var(--switch-purple); }
.s24-option--full.is-selected   { border-color: var(--action-secondary-base); }

/* Card header row */
.s24-option-head {
  display: flex; align-items: center; gap: 0.75rem; padding: 1rem; flex-wrap: wrap;
}
.s24-option-head .text-title-sm { flex: 0 0 auto; white-space: nowrap; margin-right: 0.25rem; }
.s24-logo      { flex: 0 0 auto; height: 28px; width: auto; }
.s24-head-meta { flex: 0 0 auto; white-space: nowrap; }

/* Radio button */
.s24-radio {
  flex-shrink: 0; appearance: none; width: 20px; height: 20px;
  border: 2px solid var(--gray-50); border-radius: 50%; background: var(--ui-core-base);
  cursor: pointer; transition: border-color 150ms;
}
.s24-option--switch .s24-radio:checked { border-color: var(--switch-purple); border-width: 6px; }
.s24-option--full   .s24-radio:checked { border-color: var(--action-secondary-base); border-width: 6px; }

/* Payment provider logos (Pay in full) */
.s24-providers {
  display: flex; align-items: center; gap: 0.5rem; flex: 0 1 auto; margin-left: auto;
}
@media (max-width: 768px) {
  .s24-providers { width: 100%; margin-left: 0; order: 10; }
}
.s24-providers .pay-logo { display: block; flex: 0 0 auto; height: 14px; width: auto; }
.s24-aofinance {
  display: inline-flex; align-items: center; padding: 0.25rem 0.5rem;
  background: var(--gray-20); border: 1px solid var(--gray-40);
  border-radius: var(--radius-sm); font-family: 'Inter', sans-serif; font-weight: 700;
  font-size: 0.6875rem; color: var(--type-secondary); white-space: nowrap;
}

/* Card body */
.s24-body { padding: 0 1rem 1rem; display: flex; flex-direction: column; gap: 0.75rem; }

/* Switch24: member/joining price pods */
.s24-pods { display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; }
.s24-pod {
  display: flex; flex-direction: column; gap: 0.25rem; padding: 0.75rem;
  border: 1px solid var(--gray-40); border-radius: var(--radius-sm);
}
.s24-pod-label { font-size: 0.75rem; color: var(--switch-purple); font-weight: 700; }
.s24-pod-price { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1.25rem; }
.s24-pod-price .u { font-size: 0.875rem; font-weight: 400; color: var(--type-secondary); }
.s24-pod-note  { font-size: 0.75rem; color: var(--type-secondary); }
.s24-upfront {
  font-size: 0.875rem; color: var(--type-primary); padding: 0.625rem 0.875rem;
  background: var(--gray-10); border: 1px solid var(--gray-30); border-radius: var(--radius-sm);
}
.s24-upfront b { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; color: var(--switch-purple); }

/* Pay in full: member / non-member price pods */
.s24-fullpods { display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; }
.s24-fullpod  {
  display: flex; flex-direction: column; gap: 0.25rem; padding: 0.75rem;
  border: 1px solid var(--gray-40); border-radius: var(--radius-sm);
}
.s24-fullpod.member { background: var(--ui-success-base); border-color: var(--ui-success-accent); }
.s24-fullpod-label  { font-size: 0.75rem; color: var(--type-secondary); font-weight: 400; }
.s24-fullpod-price  { font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 1.5rem; }
.s24-fullpod-save   { font-size: 0.875rem; color: var(--ui-success-contrast); font-weight: 700; }
.s24-fullpod-note   { font-size: 0.75rem; color: var(--type-secondary); }

/* Payment breakdown toggle */
.s24-breakdown-toggle {
  display: flex; align-items: center; gap: 0.375rem; width: 100%; background: none;
  border: 1px solid var(--gray-40); cursor: pointer; padding: 0.75rem 1rem;
  font-family: 'Inter', sans-serif; font-weight: 700; font-size: 0.875rem;
  color: var(--action-secondary-base); border-radius: var(--radius-sm); transition: background 150ms;
}
.s24-breakdown-toggle:hover { background: var(--gray-10); }
.s24-breakdown-toggle:focus-visible { outline: 3px solid var(--action-secondary-glow); outline-offset: 2px; }
.s24-breakdown-toggle .ico { transition: transform 200ms; margin-left: auto; }
.s24-breakdown-toggle[aria-expanded="true"] .ico { transform: rotate(180deg); }
.s24-breakdown[hidden] { display: none; }
.s24-breakdown { display: flex; flex-direction: column; gap: 0.75rem; padding: 0.5rem 0 0; }

/* Member toggle (Yes / No) */
.s24-bd-memberrow { display: flex; align-items: center; gap: 0.5rem; }
.s24-bd-memberrow .ask {
  flex: 1; display: flex; flex-direction: column; font-size: 0.875rem; color: var(--type-primary);
}
.member-toggle { display: flex; gap: 0.5rem; }
.member-toggle label {
  position: relative; min-width: 54px; text-align: center; padding: 0.625rem 0.75rem;
  border: 1px solid var(--gray-50); border-radius: var(--radius-sm); cursor: pointer;
  font-family: 'SmileyFace', Georgia, serif; font-weight: 700; font-size: 0.875rem;
  color: var(--type-primary); background: var(--ui-core-base);
}
.member-toggle input { position: absolute; opacity: 0; inset: 0; cursor: pointer; }
.member-toggle label:has(:checked) { background: var(--ui-highlight-base); border-color: var(--action-secondary-base); }
.member-toggle label:has(:focus-visible) { outline: 3px solid var(--action-secondary-glow); outline-offset: 2px; }

/* Breakdown line items */
.s24-bd-rows { padding: 0.25rem 0; display: flex; flex-direction: column; gap: 0.25rem; }
.s24-bd-row  { display: flex; justify-content: space-between; gap: 1rem; align-items: flex-start; }
.s24-bd-row .lbl { font-size: 0.875rem; flex: 1; }
.s24-bd-row .lbl strong { font-weight: 600; color: var(--type-primary); display: block; }
.s24-bd-row .lbl .sub { color: var(--type-secondary); font-weight: 400; font-size: 0.8125rem; line-height: 1.4; }
.s24-bd-row .lbl .sub .text-link-sm { font-size: inherit; }
.s24-bd-row .val {
  font-family: 'SmileyFace', Georgia, serif; font-weight: 400; font-size: 0.875rem;
  color: var(--type-primary); white-space: nowrap; flex-shrink: 0;
}
.s24-bd-row.total { border-top: 1px solid var(--gray-30); padding-top: 0.5rem; margin-top: 0.25rem; }
.s24-bd-row.total .lbl strong { font-weight: 700; color: var(--type-secondary); }
.s24-bd-row.total .val { font-weight: 700; }

/* "What happens after 24 months?" */
.s24-after {
  background: var(--gray-10); border-radius: var(--radius-sm); padding: 1rem;
  display: flex; flex-direction: column; gap: 1rem;
}
.s24-after h3 { margin: 0; }
.s24-after p { margin: 0; font-size: 0.8125rem; line-height: 1.5; color: var(--type-secondary); }
.s24-after .lede {
  font-family: 'Inter', sans-serif; font-weight: 700; font-size: 0.875rem;
  color: var(--type-primary); margin-bottom: 0.25rem;
}
.s24-after p .text-link-sm { font-size: inherit; }
```

##### JS

```js
function toggleBreakdown() {
  var toggle = document.getElementById('bd-toggle');
  var panel  = document.getElementById('bd-panel');
  if (toggle && panel) {
    var expanded = toggle.getAttribute('aria-expanded') === 'true';
    toggle.setAttribute('aria-expanded', String(!expanded));
    panel.hidden = expanded;
  }
}

function updateBreakdown() {
  var member       = document.querySelector('input[name="member"]:checked').value === 'yes';
  var instalmentEl = document.getElementById('bd-instalment');
  var feeRow       = document.getElementById('bd-feerow');
  var totalEl      = document.getElementById('bd-total');
  if (instalmentEl) instalmentEl.textContent = member ? '£17.00' : '£18.67';
  if (feeRow)       feeRow.hidden = member;
  if (totalEl)      totalEl.textContent = member ? '£799.00' : '£838.99';
}
```

##### HTML — Switch24 option (with breakdown)

```html
<div class="s24-option s24-option--switch is-selected" data-aods="s24-payment-selector">
  <div class="s24-option-head">
    <input class="s24-radio" type="radio" name="payopt" value="switch" checked
           aria-label="Pay with Switch24, 0% interest for 24 months">
    <svg class="s24-logo" viewBox="0 0 132 34" role="img" aria-label="Switch24">
      <use href="#ic-switch24"/>
    </svg>
    <span class="s24-head-meta">0% Interest for 24 months</span>
  </div>

  <div class="s24-body">
    <div class="s24-pods">
      <div class="s24-pod">
        <span class="s24-pod-label">Already a member?</span>
        <span class="s24-pod-price">£17.00 <span class="u">per month</span></span>
        <span class="s24-pod-note">Sign in to unlock member price</span>
      </div>
      <div class="s24-pod">
        <span class="s24-pod-label">Joining AO membership</span>
        <span class="s24-pod-price">£18.67 <span class="u">per month</span></span>
        <span class="s24-pod-note">£17.00 phone + £1.67 membership fee</span>
      </div>
    </div>

    <div class="s24-upfront"><b>£39.95</b> Upfront payment</div>
    <button class="btn btn-primary btn-full">Add to basket</button>

    <button class="s24-breakdown-toggle" id="bd-toggle"
            aria-expanded="false" aria-controls="bd-panel"
            onclick="toggleBreakdown()">
      Payment breakdown
      <i class="ico ico-chevron-down" aria-hidden="true"></i>
    </button>

    <div class="s24-breakdown" id="bd-panel" hidden>
      <div class="s24-bd-memberrow">
        <span class="ask">
          Already a member?
          <a href="#" class="text-link-sm">Sign in</a>
        </span>
        <div class="member-toggle" role="radiogroup" aria-label="Already a member?">
          <label><input type="radio" name="member" value="yes" checked onchange="updateBreakdown()"> Yes</label>
          <label><input type="radio" name="member" value="no"  onchange="updateBreakdown()"> No</label>
        </div>
      </div>

      <div class="s24-bd-rows">
        <div class="s24-bd-row">
          <span class="lbl"><strong>Upfront payment</strong></span>
          <span class="val">£39.95</span>
        </div>
        <div class="s24-bd-row">
          <span class="lbl"><strong>24 monthly instalments at 0%</strong></span>
          <span class="val" id="bd-instalment">£17.00</span>
        </div>
        <div class="s24-bd-row" id="bd-feerow" hidden>
          <span class="lbl">
            <span class="sub">Includes your first £39.99 AO Membership fee.
              <a href="#" class="text-link-sm">Terms apply</a></span>
          </span>
        </div>
        <div class="s24-bd-row">
          <span class="lbl">
            <strong>Final balance</strong>
            <span class="sub">Held on a Buy Now Pay Later plan with nothing to pay right now.
              After 24 months, upgrade or return your phone in good condition and this balance
              is cleared or keep the phone and repay at your standard purchase rate.</span>
          </span>
          <span class="val">£351.95</span>
        </div>
        <div class="s24-bd-row total">
          <span class="lbl"><strong>Total added to basket</strong></span>
          <span class="val" id="bd-total">£799.00</span>
        </div>
      </div>

      <div class="s24-after">
        <h3 class="text-title-sm">What happens after 24 months?</h3>
        <div>
          <p class="lede">Upgrade or return and pay nothing further.</p>
          <p>With your member Value lock you can send your phone back in good condition and
            your final balance is cleared. Learn more with our
            <a href="#" class="text-link-sm">good condition guide</a>.</p>
        </div>
        <div>
          <p class="lede">Want to keep your phone?</p>
          <p>Simply continue paying off your final balance at the standard purchase rate
            and the phone is yours to keep.</p>
        </div>
        <a href="#" class="text-link-sm">Learn more about Switch24</a>
      </div>
    </div>
  </div>
</div>
```

##### HTML — Pay in full option

```html
<div class="s24-option s24-option--full" data-aods="s24-payment-selector">
  <div class="s24-option-head">
    <input class="s24-radio" type="radio" name="payopt" value="full" aria-label="Pay in full">
    <span class="text-title-sm">Pay in full</span>
    <div class="s24-providers">
      <svg class="pay-logo" viewBox="0 0 780 500" role="img" aria-label="Visa"><use href="#ic-visa"/></svg>
      <svg class="pay-logo" viewBox="0 0 131.39 86.9" role="img" aria-label="Mastercard"><use href="#ic-mastercard"/></svg>
      <svg class="pay-logo" viewBox="0 0 131.39 86.9" role="img" aria-label="Maestro"><use href="#ic-maestro"/></svg>
      <svg class="pay-logo" viewBox="0 0 131.39 86.9" role="img" aria-label="American Express"><use href="#ic-amex"/></svg>
      <svg class="pay-logo" viewBox="0 0 124 33" role="img" aria-label="PayPal"><use href="#ic-paypal"/></svg>
      <span class="s24-aofinance">AO Finance</span>
    </div>
  </div>
  <div class="s24-body">
    <div class="s24-fullpods">
      <div class="s24-fullpod">
        <span class="s24-fullpod-label">Non-member price</span>
        <span class="s24-fullpod-price">£899</span>
        <span class="s24-fullpod-note">£911 with delivery</span>
      </div>
      <div class="s24-fullpod member">
        <span class="s24-fullpod-label">AO member price</span>
        <span class="s24-fullpod-price">£799 <span class="s24-fullpod-save">Save £100</span></span>
        <span class="s24-fullpod-note">Free delivery</span>
      </div>
    </div>
  </div>
</div>
```

##### Rules

- **Selection theming:** Switch24 uses `--switch-purple` for selected border and radio fill; Pay in full uses `--action-secondary-base`. Never interchange them.
- **Header row integrity:** radio input, logo/title, and meta text must always stay on one row — `white-space: nowrap` and `flex: 0 0 auto` on each. Only `.s24-providers` is allowed to reflow, dropping as a complete unit at ≤768px via `order: 10; width: 100%`.
- **Gap between title and providers:** exactly 1rem (0.75rem flex `gap` + 0.25rem `margin-right` on `.text-title-sm`).
- **Text links in breakdown:** always use `.text-link-sm`. Where a link sits inside `.sub` text (0.8125rem), add the context override `.s24-bd-row .lbl .sub .text-link-sm { font-size: inherit; }` — do not change the class itself.
- **Breakdown toggle:** `aria-expanded` and `hidden` are both required for accessibility — removing either breaks screenreader behaviour.
- **Member toggle selected state:** `ui-highlight-base` fill + `action-secondary-base` border, consistent with the CH-001 toggle-item selection convention.
- **`data-aods` attribute:** use `data-aods="s24-payment-selector"` on `.s24-option` root elements.

---

## Patterns

### AO Page Patterns

> Multi-component recipes for the screens designers build most often. Use these as the structural starting point — they encode the right component order, hierarchy, and breakpoints. Adapt the content, keep the structure.

Patterns covered:

1. [Sign in](#1--sign-in)
2. [Validated form](#2--validated-form-eg-delivery-check)
3. [Product detail page (PDP)](#3--product-detail-page-pdp)
4. [Basket / order summary](#4--basket--order-summary)
5. [Modal confirmation](#5--modal-confirmation)
6. [Empty state](#6--empty-state)
7. [Order confirmation](#7--order-confirmation)
8. [Category / product listing](#8--category--product-listing)
9. [Account dashboard](#9--account-dashboard)
10. [Checkout flow](#10--checkout-flow)

All patterns assume the `:root` token block and typography styles from this file are present in the document `<head>`.

---

#### Header Selection Guide

Every page starts with a header. Use the blueprint from §14 · Nav (Header) above — never invent a custom header.

| Page type | Header variant | Notes |
|---|---|---|
| Homepage, PDP, category listing, search results | **Core Site Header** | Full mobile + desktop with search, categories, proposition bar |
| Account dashboard, order history, saved items | **Core Site Header** | Same as above |
| Sign in, registration | **Core Site Header** | User needs access to search/navigation |
| Checkout (delivery, contact, payment) | **Checkout Header** | Simplified — logo + phone info + basket. No search, no categories. |
| Order confirmation | **Checkout Header** | Keep the focused, distraction-free feel post-purchase |
| Basket page | **Basket Header** | Like checkout but adds Account icon |

**Key rules:**
- The checkout header exists to reduce distractions — don't add search or categories back.
- The core header has both mobile and desktop variants in the same `<header>` element; CSS handles responsive show/hide at 991px.
- Always include the green accent bar (`.nav-accent`) on both variants.
- Sticky positioning (`position: sticky; top: 0; z-index: 20`) on all variants.

---

#### 1 · Sign in

Single-column, centred, max 420px. One primary CTA, one secondary route.

```html
<main style="max-width: 420px; margin: 4rem auto; padding: 0 1rem;">
  <div style="text-align:center; margin-bottom: 2rem;">
    <h1 class="text-display" style="margin-bottom: 0.5rem;">Sign in to your account</h1>
    <p class="text-body text-secondary">Use your email to track orders, save addresses, and check your delivery slots.</p>
  </div>

  <div class="card card-raised" style="display:flex; flex-direction:column; gap: 1rem;">
    <div class="field" data-aods="field">
      <label class="field-label" for="signin-email">Email address</label>
      <input class="field-input" id="signin-email" type="email" autocomplete="email">
    </div>

    <div class="field" data-aods="field">
      <label class="field-label" for="signin-password">Password</label>
      <input class="field-input" id="signin-password" type="password" autocomplete="current-password">
    </div>

    <div style="display:flex; justify-content:space-between; align-items:center; font-size: 0.875rem;">
      <label style="display:flex; gap:0.5rem; align-items:center;">
        <input type="checkbox"> Stay signed in
      </label>
      <a href="#" class="text-link">Forgotten password?</a>
    </div>

    <button class="btn btn-primary btn-full" data-aods="button">Sign in</button>
  </div>

  <p style="text-align:center; margin-top: 1.5rem;" class="text-body-sm">
    New to AO? <a href="#" class="text-link">Create an account</a>
  </p>
</main>
```

**Rules:** primary CTA is full-width on a focused single-task screen. "Forgotten password?" is a `text-link`, not a button — it's a navigation, not an action.

---

#### 2 · Validated form (e.g. delivery check)

The canonical validated-form pattern: helper text by default, switch to error/success when the user submits.

```html
<div class="card card-raised" data-aods="card" style="max-width: 480px;">
  <h3 class="text-title" style="margin-bottom: 1.25rem;">Check delivery to your postcode</h3>

  <div class="field" style="margin-bottom: 1rem;">
    <label class="field-label" for="postcode">Postcode</label>
    <input class="field-input" id="postcode" type="text" placeholder="e.g. M1 1AA" autocomplete="postal-code">
    <p class="field-msg is-helper">We deliver to all UK mainland postcodes.</p>
  </div>

  <div class="field" style="margin-bottom: 1rem;">
    <label class="field-label" for="email">Email for delivery updates</label>
    <input class="field-input is-success" id="email" type="email" value="craig@example.com">
    <p class="field-msg is-success"><i class="ico ico-tick" aria-hidden="true"></i> Valid email address.</p>
  </div>

  <div class="field" style="margin-bottom: 1.5rem;">
    <label class="field-label" for="phone">Phone number</label>
    <input class="field-input is-error" id="phone" type="tel" value="0777" aria-invalid="true" aria-describedby="phone-msg">
    <p class="field-msg is-error" id="phone-msg">Enter a valid UK mobile or landline number.</p>
  </div>

  <button class="btn btn-primary btn-full" data-aods="button">Check availability</button>
</div>
```

**Rules:** helper text by default, validation states only after the user has interacted. One Notice above the form for global errors (e.g. server-side). One primary CTA at the bottom.

---

#### 3 · Product detail page (PDP)

Two-column on desktop (image pane + details), single-column on mobile. Specs and reviews live in tabs or accordions below the fold.

```html
<nav aria-label="Breadcrumb" data-aods="breadcrumb" style="margin-bottom: 1.5rem;">
  <ol class="crumb">
    <li><a href="/">Home</a><span class="crumb-sep" aria-hidden="true">›</span></li>
    <li><a href="/appliances">Appliances</a><span class="crumb-sep" aria-hidden="true">›</span></li>
    <li><span aria-current="page">Washing machines</span></li>
  </ol>
</nav>

<section style="display:grid; grid-template-columns: 480px 1fr; gap: 3rem; align-items:start;">
  <!-- Image pane -->
  <div class="card" style="aspect-ratio: 1; padding: 0; display:flex; align-items:center; justify-content:center;">
    <img src="…" alt="Bosch Series 6 washing machine" style="max-width:80%; max-height:80%;">
  </div>

  <!-- Detail pane -->
  <div style="display:flex; flex-direction:column; gap: 1.25rem;">
    <div>
      <span class="tag tag-highlight" data-aods="tag">New</span>
      <span class="tag tag-success" data-aods="tag">In stock</span>
    </div>

    <h1 class="text-display">Bosch Series 6 9kg Washing Machine</h1>

    <div style="display:flex; align-items:baseline; gap: 0.75rem;">
      <span class="text-display-lg" style="font-size: 2rem;">£549</span>
      <span class="text-body text-secondary" style="text-decoration: line-through;">£599</span>
      <span class="tag tag-error" data-aods="tag">Save £50</span>
    </div>

    <ul style="list-style:none; padding:0; display:flex; flex-direction:column; gap: 0.5rem;">
      <li><i class="ico ico-tick" aria-hidden="true"></i> Free delivery tomorrow</li>
      <li><i class="ico ico-tick" aria-hidden="true"></i> 2-year AO guarantee included</li>
      <li><i class="ico ico-tick" aria-hidden="true"></i> Recycle your old appliance for £25</li>
    </ul>

    <div style="display:flex; gap: 1rem; align-items:center;">
      <span class="text-body-sm text-secondary">Quantity</span>
      <div class="qty-control" data-aods="quantity">
        <button class="qty-btn" aria-label="Decrease">−</button>
        <span class="qty-val">1</span>
        <button class="qty-btn" aria-label="Increase">+</button>
      </div>
    </div>

    <button class="btn btn-primary btn-lg btn-full" data-aods="button">Add to basket</button>
    <button class="btn btn-secondary btn-full" data-aods="button">Save to wishlist</button>

    <div class="notice notice-info" role="note" data-aods="notice">
      <i class="ico ico-info notice-icon" aria-hidden="true"></i>
      <div class="notice-content">
        <strong class="notice-title">Professional installation available.</strong>
        <span class="notice-body">Add fitting for £69.</span>
      </div>
    </div>
  </div>
</section>

<!-- Specs + reviews -->
<section style="margin-top: 3rem;">
  <div class="tab-list" role="tablist">
    <button class="tab-item active" role="tab">Specifications</button>
    <button class="tab-item" role="tab">Reviews</button>
    <button class="tab-item" role="tab">Delivery &amp; returns</button>
  </div>
  <div class="tab-panel" role="tabpanel" style="padding-top: 1.5rem;">…</div>
</section>
```

**Rules:** image pane is fixed 480px on desktop. Primary action is "Add to basket", supporting is "Save to wishlist". Don't stack three CTAs in a row — third option goes into a Notice or below the fold.

---

#### 4 · Basket / order summary

Two-column on desktop (line items + order summary card). Summary card is `card-raised` and sticky on long pages.

```html
<h1 class="text-display" style="margin-bottom: 1.5rem;">
  Your basket <span style="font-size: 1.125rem; color: var(--type-tertiary); font-family: 'Inter'; font-weight: 400;">(2 items)</span>
</h1>

<section style="display:grid; grid-template-columns: 1fr 360px; gap: 2.5rem; align-items:start;">
  <!-- Line items -->
  <div style="display:flex; flex-direction:column; gap: 1rem;">

    <div class="card" data-aods="card">
      <div style="display:flex; gap: 1rem;">
        <img src="…" alt="" style="width:96px; height:96px; object-fit:contain; background: var(--gray-10); border-radius: var(--radius-sm);">
        <div style="flex:1;">
          <h3 class="text-title">Bosch Series 6 9kg Washing Machine</h3>
          <p class="text-body-sm text-secondary">Energy A+++ · 1,400 rpm</p>
          <div style="display:flex; gap: 1rem; align-items:center; margin-top: 0.75rem;">
            <div class="qty-control" data-aods="quantity">
              <button class="qty-btn" aria-label="Decrease">−</button>
              <span class="qty-val">1</span>
              <button class="qty-btn" aria-label="Increase">+</button>
            </div>
            <a href="#" class="text-link text-body-sm">Remove</a>
          </div>
        </div>
        <div style="text-align:right;">
          <div class="text-title">£549</div>
        </div>
      </div>
    </div>

    <!-- Add-ons -->
    <div class="card" data-aods="card">
      <h2 class="text-title-sm" style="margin-bottom: 1rem;">Add to your order</h2>
      <div class="toggle-group" data-aods="checkbox-group">
        <label class="toggle-item" data-aods="checkbox">
          <input type="checkbox" value="install">
          <div class="toggle-item-body">
            <div class="toggle-item-label">Professional installation</div>
            <div class="toggle-item-sub">+£69 — install, level, and test.</div>
          </div>
        </label>
        <label class="toggle-item" data-aods="checkbox">
          <input type="checkbox" value="warranty">
          <div class="toggle-item-body">
            <div class="toggle-item-label">3-year warranty</div>
            <div class="toggle-item-sub">+£59 — parts and labour.</div>
          </div>
        </label>
      </div>
    </div>
  </div>

  <!-- Order summary -->
  <aside class="card card-raised" data-aods="card" style="position: sticky; top: 80px;">
    <h2 class="text-title-sm" style="margin-bottom: 1.25rem;">Order summary</h2>

    <div style="display:flex; flex-direction:column; gap: 0.5rem; font-size: 0.9375rem;">
      <div style="display:flex; justify-content:space-between;"><span>Subtotal</span><span>£549.00</span></div>
      <div style="display:flex; justify-content:space-between;"><span>Delivery</span><span>Free</span></div>
    </div>

    <div class="card-divider"></div>

    <div style="display:flex; justify-content:space-between; align-items:baseline; margin-bottom: 1.25rem;">
      <span class="text-title-sm">Total</span>
      <span class="text-title-lg">£549.00</span>
    </div>

    <button class="btn btn-primary btn-full btn-lg" data-aods="button">Checkout</button>

    <div class="notice notice-success" role="status" data-aods="notice" style="margin-top: 1rem;">
      <i class="ico ico-tick-circle notice-icon" aria-hidden="true"></i>
      <div class="notice-content">
        <strong class="notice-title">You've qualified for free delivery.</strong>
      </div>
    </div>
  </aside>
</section>
```

**Rules:** summary card sticks at `top: 80px` (under the nav). One primary CTA — "Checkout". Edit actions on items are `text-link`, not buttons.

---

#### 5 · Modal confirmation

Use modals **only** when an inline alternative is exhausted (e.g. destructive confirmation, focused single-task).

```html
<div role="dialog" aria-modal="true" aria-labelledby="modal-title"
     style="position:fixed; inset:0; background: rgba(1,22,48,0.6); display:flex; align-items:center; justify-content:center; padding: 1rem; z-index: 50;">
  <div class="card card-raised" style="max-width: 480px; width: 100%; box-shadow: var(--shadow-lg);" data-aods="modal">
    <h2 id="modal-title" class="text-title" style="margin-bottom: 0.5rem;">Cancel this order?</h2>
    <p class="text-body" style="margin-bottom: 1.5rem;">Your order #AO-228341 will be cancelled and refunded within 3–5 working days.</p>

    <div style="display:flex; gap: 0.75rem; justify-content:flex-end;">
      <button class="btn btn-tertiary" data-aods="button">Keep order</button>
      <button class="btn btn-primary" data-aods="button">Yes, cancel order</button>
    </div>
  </div>
</div>
```

**Rules:** the destructive action is the primary because it's what the user came here to do. Escape key closes. Focus traps inside the dialog. Previous focus is restored on close.

---

#### 6 · Empty state

When there's nothing to show, give the user one clear next step.

```html
<div class="card" data-aods="card" style="text-align:center; padding: 3rem 1.5rem;">
  <i class="ico ico-basket ico-3x" style="margin-bottom: 0.75rem;" aria-hidden="true"></i>
  <h2 class="text-title-lg" style="margin-bottom: 0.5rem;">Your basket is empty</h2>
  <p class="text-body text-secondary" style="max-width: 40ch; margin: 0 auto 1.5rem;">
    Browse our latest appliances and add something you'll love.
  </p>
  <button class="btn btn-primary" data-aods="button">Shop appliances</button>
</div>
```

**Rules:** one CTA, verb-first. One sentence of supporting copy. No multiple parallel suggestions ("or browse this, or that, or that") — pick the most likely next step.

---

#### 7 · Order confirmation

Single-column centred layout, max 640px. The emotional peak of the purchase flow: confirm the outcome, tell the user what happens next, then give them somewhere to go. Brand energy belongs here.

```html
<main style="max-width: 640px; margin: 0 auto; padding: 0 1.5rem 4rem;">

  <!-- Confirmation hero -->
  <div style="text-align:center; padding: 2.5rem 1.5rem 1.5rem;">
    <div style="width:72px; height:72px; border-radius:50%;
                background:var(--ui-success-base); border:2px solid var(--ui-success-accent);
                display:flex; align-items:center; justify-content:center;
                margin:0 auto 1.25rem; font-size:2rem;" aria-hidden="true"><i class="ico ico-tick"></i></div>
    <h1 class="text-display-headline" style="margin-bottom:0.5rem;">You're all set, Sarah.</h1>
    <p class="text-body text-secondary" style="max-width:44ch; margin:0 auto;">
      Your order is confirmed. We'll keep you updated every step of the way.
    </p>
    <span style="display:inline-flex; align-items:center; gap:0.5rem;
                 background:var(--gray-10); border:1px solid var(--gray-40);
                 border-radius:var(--radius-2xl); padding:0.375rem 1rem;
                 font-size:0.875rem; color:var(--type-tertiary); margin-top:0.625rem;">
      Order <strong style="color:var(--type-secondary);">#AO-228341</strong> · 16 May 2026
    </span>
  </div>

  <!-- Delivery summary -->
  <div class="card" data-aods="card" style="margin-bottom:1rem;">
    <h2 class="text-title" style="margin-bottom:1rem;">Your delivery</h2>
    <p class="text-body-sm" style="font-weight:600;">Thursday 17 May, 8am–6pm</p>
    <p class="text-body-sm text-secondary">14 Maple Close, Manchester, M14 5RQ</p>
    <div class="card-divider"></div>
    <div class="notice notice-success" role="status" data-aods="notice">
      <i class="ico ico-tick-circle notice-icon" aria-hidden="true"></i>
      Confirmation sent to <strong>sarah@example.com</strong>
    </div>
  </div>

  <!-- What happens next -->
  <div class="card" data-aods="card" style="margin-bottom:1.5rem;">
    <h2 class="text-title" style="margin-bottom:1.25rem;">What happens next</h2>
    <!-- Repeat for each step: -->
    <div style="display:flex; gap:1rem; padding:0.875rem 0; border-bottom:1px solid var(--gray-30);">
      <div style="width:28px; height:28px; border-radius:50%; flex-shrink:0;
                  background:var(--type-primary); color:#fff; display:flex;
                  align-items:center; justify-content:center;
                  font-size:0.75rem; font-weight:700;">1</div>
      <div>
        <p class="text-body-sm" style="font-weight:600; margin-bottom:0.25rem;">Confirmation email on its way</p>
        <p class="text-body-sm text-secondary">Full summary sent to your inbox within a few minutes.</p>
      </div>
    </div>
    <!-- Add steps 2, 3 following the same pattern -->
  </div>

  <!-- CTAs -->
  <div style="display:flex; flex-direction:column; gap:0.75rem; align-items:center;">
    <a href="#" class="btn btn-primary btn-lg btn-full" data-aods="button">Track your order</a>
    <a href="#" class="btn btn-secondary btn-full" data-aods="button">Continue shopping</a>
  </div>

</main>
```

**Rules:** `text-display-headline` is reserved for this page and true campaign moments — it earns its size here because the user just completed something. One primary CTA ("Track your order"), one secondary. Never use a modal on this page — all content is inline.

---

#### 8 · Category / product listing

Two-column desktop layout: filter sidebar (240px, sticky) + product grid (fluid, 3 columns). Single column on mobile with filters hidden behind a "Filter" button.

```html
<!-- Breadcrumb + page header -->
<nav aria-label="Breadcrumb" data-aods="breadcrumb">
  <ol class="crumb">
    <li><a href="/">Home</a><span class="crumb-sep" aria-hidden="true">›</span></li>
    <li><a href="/appliances">Appliances</a><span class="crumb-sep" aria-hidden="true">›</span></li>
    <li><span aria-current="page">Washing machines</span></li>
  </ol>
</nav>

<div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:1.5rem;">
  <div>
    <h1 class="text-display">Washing machines</h1>
    <p class="text-body-sm text-secondary">127 products</p>
  </div>
</div>

<div style="display:grid; grid-template-columns:240px 1fr; gap:2rem; align-items:start;">

  <!-- Filter sidebar -->
  <aside style="position:sticky; top:80px;">
    <div style="margin-bottom:1.25rem;">
      <p style="font-size:0.875rem; font-weight:600; color:var(--type-secondary);
                margin-bottom:0.625rem; padding-bottom:0.5rem; border-bottom:1px solid var(--gray-30);">
        Brand
      </p>
      <label style="display:flex; align-items:center; gap:0.5rem; padding:0.3125rem 0;
                    font-size:0.875rem; cursor:pointer;">
        <input type="checkbox" checked style="accent-color:var(--action-secondary-base);">
        Bosch
      </label>
      <!-- repeat for each filter option -->
    </div>
  </aside>

  <!-- Main content -->
  <div>
    <!-- Active filter chips + sort -->
    <div style="display:flex; justify-content:space-between; margin-bottom:1rem; align-items:center; flex-wrap:wrap; gap:0.75rem;">
      <div style="display:flex; gap:0.5rem; flex-wrap:wrap;">
        <button style="display:inline-flex; align-items:center; gap:0.375rem;
                       padding:0.3125rem 0.75rem; border-radius:var(--radius-2xl);
                       font-size:0.8125rem; font-weight:500;
                       background:var(--ui-highlight-base); color:var(--ui-highlight-contrast);
                       border:1px solid var(--ui-highlight-accent); cursor:pointer;">
          Bosch <i class="ico ico-close ico-xs" aria-hidden="true"></i>
        </button>
      </div>
      <select style="appearance:none; padding:0.5rem 2rem 0.5rem 0.875rem;
                     border:1px solid var(--gray-40); border-radius:var(--radius-sm);
                     font-family:'Inter',sans-serif; font-size:0.875rem; background:#fff;">
        <option>Sort: Featured</option>
        <option>Price: low to high</option>
      </select>
    </div>

    <!-- Product grid: 3-up desktop, 2-up tablet, 1-up mobile -->
    <div style="display:grid; grid-template-columns:repeat(3,1fr); gap:1rem;">
      <div style="background:#fff; border:1px solid var(--gray-40);
                  border-radius:var(--radius-md); overflow:hidden;" data-aods="card">
        <div style="aspect-ratio:1; background:var(--gray-20);
                    border-bottom:1px solid var(--gray-30);" aria-hidden="true"></div>
        <div style="padding:1rem; display:flex; flex-direction:column; gap:0.5rem;">
          <span class="tag tag-success" data-aods="tag">In stock</span>
          <p style="font-size:0.9375rem; font-weight:500; color:var(--type-secondary); line-height:1.35;">
            Bosch Series 6 9kg Washing Machine
          </p>
          <p class="text-body-sm text-secondary">9kg · 1,400 rpm · Energy A+++</p>
          <p style="font-family:'SmileyFace',Georgia,serif; font-weight:700;
                    font-size:1.375rem; color:var(--type-primary); margin-top:auto; padding-top:0.5rem;">
            £549
          </p>
        </div>
        <div style="padding:0 1rem 1rem;">
          <button class="btn btn-primary btn-full" data-aods="button">Add to basket</button>
        </div>
      </div>
      <!-- repeat tiles -->
    </div>

  </div>
</div>
```

**Rules:** one `btn-primary` per tile ("Add to basket"). Price in `text-title-lg` or SmileyFace Bold — never Inter. Product images on `var(--gray-10)` background only. Active filters use the `ui-highlight` surface, not custom colours. Out-of-stock tiles use `btn-inactive`.

---

#### 9 · Account dashboard

Two-column desktop layout: main content (orders, 2/3) + sidebar quick links (1/3, sticky). Personalised greeting in a dark navy header band; functional utility tone throughout.

```html
<!-- Account header band (sits below the global nav) -->
<div style="background:var(--type-primary); padding:2rem 1.5rem;">
  <div style="max-width:1100px; margin:0 auto; display:flex; justify-content:space-between; align-items:flex-end;">
    <div>
      <p style="font-family:'SmileyFace',Georgia,serif; font-weight:700;
                font-size:1.75rem; color:#fff; line-height:1.2;">Good morning, Sarah.</p>
      <p style="font-size:0.875rem; color:rgba(255,255,255,0.6); margin-top:0.25rem;">Member since 2019 · 7 orders</p>
    </div>
    <button class="btn btn-secondary" style="color:rgba(255,255,255,0.7); border-color:rgba(255,255,255,0.3);"
            data-aods="button">Sign out</button>
  </div>
</div>

<!-- Main content grid -->
<div style="display:grid; grid-template-columns:1fr 280px; gap:2rem; align-items:start; max-width:1100px; margin:2rem auto; padding:0 1.5rem;">

  <!-- Orders -->
  <div class="card" data-aods="card">
    <div style="display:flex; justify-content:space-between; align-items:baseline; margin-bottom:1rem;">
      <h2 class="text-title">Recent orders</h2>
      <a href="#" class="text-link-sm">View all</a>
    </div>

    <!-- Order row -->
    <div style="padding:1.25rem 0; border-bottom:1px solid var(--gray-30);">
      <div style="display:flex; justify-content:space-between; margin-bottom:0.75rem; flex-wrap:wrap; gap:0.5rem;">
        <div style="display:flex; gap:0.5rem; align-items:center;">
          <span style="font-size:0.875rem; font-weight:600;">#AO-228341</span>
          <span class="text-body-sm text-secondary">16 May 2026</span>
        </div>
        <span class="tag tag-highlight" data-aods="tag">In transit</span>
      </div>
      <div style="display:flex; gap:0.75rem; align-items:center;">
        <div style="width:44px; height:44px; background:var(--gray-20);
                    border:1px solid var(--gray-30); border-radius:var(--radius-sm);"
             aria-hidden="true"></div>
        <span style="font-size:0.875rem; color:var(--type-secondary); flex:1;">Bosch Series 6 9kg Washing Machine</span>
        <span style="font-size:0.875rem; font-weight:600; color:var(--type-primary);">£549</span>
      </div>
      <div style="display:flex; justify-content:space-between; margin-top:1rem; flex-wrap:wrap; gap:0.5rem;">
        <span class="text-body-sm text-secondary">Total: <strong style="color:var(--type-secondary);">£618.00</strong></span>
        <a href="#" class="btn btn-secondary btn-sm" data-aods="button">Track order</a>
      </div>
    </div>
    <!-- repeat for additional orders -->
  </div>

  <!-- Sidebar -->
  <aside style="position:sticky; top:80px; display:flex; flex-direction:column; gap:1rem;">
    <div class="card" data-aods="card">
      <h2 class="text-title-sm" style="margin-bottom:0.5rem;">My account</h2>
      <!-- Each quicklink: -->
      <a href="#" style="display:flex; align-items:center; justify-content:space-between;
                         padding:0.875rem 0; border-bottom:1px solid var(--gray-30);
                         text-decoration:none;">
        <span style="font-size:0.9375rem; color:var(--type-secondary);">Address book</span>
        <span style="color:var(--gray-60);" aria-hidden="true">›</span>
      </a>
      <!-- repeat for: Payment methods, Personal details, Communication preferences -->
    </div>
  </aside>

</div>
```

**Rules:** personalised greeting uses SmileyFace Bold at 1.75rem (below `text-display` but above `text-title-lg`). Order rows are **not** cards — they're divider-separated rows inside a single card. One primary CTA per order maximum ("Track order" or "Buy again"). The sidebar uses `text-link-sm` chevron rows, not buttons.


---

#### 10 · Checkout flow

The checkout is a multi-step, single-task flow: Delivery → Contact → Payment. Uses the **Checkout Header** (simplified, distraction-free). Two-column grid on desktop (main + order summary sidebar), single-column on mobile.

##### Layout

```html
<main class="checkout-grid">
  <div class="checkout-main">
    <!-- Step panels live here -->
  </div>
  <aside class="checkout-sidebar">
    <div class="checkout-sidebar__inner card card-raised" data-aods="card">
      <!-- Order summary -->
    </div>
  </aside>
</main>
```

```css
.checkout-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 32px;
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px 16px;
}
.checkout-main { min-width: 0; }
.checkout-sidebar { min-width: 0; }

@media (min-width: 900px) {
  .checkout-grid {
    grid-template-columns: 3fr 2fr;
    gap: 40px;
    padding: 40px 32px;
  }
  .checkout-sidebar {
    position: sticky;
    top: 80px;
    align-self: start;
  }
}
```

##### Step Navigator (chevron tabs)

A 3-step chevron bar using `clip-path` polygons. Active step is blue; completed steps are light-blue with clickable navigation; future steps are greyed out and disabled.

```html
<nav class="steps" role="tablist" aria-label="Checkout steps">
  <button class="steps__tab steps__tab--completed" role="tab" aria-selected="false">
    <span class="steps__tab-label">Delivery</span>
  </button>
  <button class="steps__tab" role="tab" aria-selected="true" aria-current="step">
    <span class="steps__tab-label">Contact</span>
  </button>
  <button class="steps__tab" role="tab" aria-selected="false">
    <span class="steps__tab-label">Payment</span>
  </button>
</nav>
```

```css
.steps {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: 8px;
  max-width: 1200px;
  margin: 0 auto;
  padding: 1.5rem 16px;
  background-color: var(--ui-core-base);
}

.steps__tab {
  position: relative;
  display: inline-flex;
  align-items: center;
  padding: 12px 24px 12px 28px;
  max-height: 24px;
  border: none;
  background-color: var(--gray-20);
  font-family: 'SmileyFace', Georgia, serif;
  font-weight: 700;
  font-size: 0.9375rem;
  line-height: 1.25;
  color: var(--type-tertiary);
  cursor: not-allowed;
  text-decoration: none;
  white-space: nowrap;
  clip-path: polygon(0% 0%, calc(100% - 14px) 0%, 100% 50%, calc(100% - 14px) 100%, 0% 100%, 14px 50%);
}

.steps__tab[aria-selected="true"] {
  background-color: var(--action-secondary-base);
  color: var(--action-secondary-contrast);
  cursor: pointer;
}

.steps__tab--completed {
  background-color: var(--ui-highlight-base);
  color: var(--action-secondary-base);
  font-weight: 700;
  cursor: pointer;
}
```

##### Delivery Calendar (day pills + time slots)

A horizontal scrollable row of day pills, each showing day name, date, and price. Navigation arrow on the right. Below it, stacked time-slot radio cards.

```html
<fieldset data-aods="radio-button-group" style="border:0; padding:0; margin:0;">
  <legend class="visually-hidden">Choose your delivery day</legend>
  <div class="delivery-day-row">
    <div class="delivery-pills">
      <label class="toggle-item" data-aods="radio-button">
        <input type="radio" name="delivery-day" value="thu" checked>
        <div class="toggle-item-body">
          <strong class="toggle-item-line">Thu</strong>
          <span class="toggle-item-line toggle-item-sub">22nd May</span>
          <strong class="toggle-item-line delivery-price">FREE</strong>
        </div>
      </label>
      <!-- more day pills -->
    </div>
    <button class="delivery-nav-btn" aria-label="Next days">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
    </button>
  </div>
</fieldset>
```

```css
.delivery-day-row {
  display: flex;
  align-items: stretch;
  gap: 0.5rem;
}
.delivery-pills {
  display: flex;
  gap: 0.5rem;
  flex: 1;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
}
.delivery-pills::-webkit-scrollbar { display: none; }
.delivery-pills .toggle-item {
  flex: 1 0 0;
  min-width: 5.5rem;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 0.75rem 0.5rem;
  border-radius: var(--radius-sm);
  scroll-snap-align: start;
}
.delivery-pills .toggle-item input { position: absolute; opacity: 0; width: 0; height: 0; }
.delivery-pills .toggle-item-body { align-items: center; }
.delivery-price {
  font-size: 0.875rem;
  color: var(--type-primary);
  font-family: 'SmileyFace', Georgia, serif;
  font-weight: 700;
}
.delivery-nav-btn {
  display: flex; align-items: center; justify-content: center;
  width: 2.5rem; flex-shrink: 0;
  background: var(--ui-highlight-base);
  border: 1px solid var(--action-secondary-base);
  border-radius: var(--radius-sm);
  color: var(--action-secondary-base);
  cursor: pointer;
  transition: background 150ms;
}
.delivery-nav-btn:hover { background: var(--action-secondary-base); color: #fff; }
.delivery-nav-btn:focus-visible { outline: 3px solid var(--action-secondary-glow); outline-offset: 2px; }
```

##### Order Summary (sidebar)

Product card grid + line items + total. Used in checkout and basket sidebars.

```html
<div class="summary-product">
  <img class="summary-product__image" src="…" alt="Product name" width="56" height="56">
  <div class="summary-product__details">
    <span class="summary-product__name">Product full title</span>
    <span class="summary-product__qty">Quantity: 1</span>
  </div>
  <span class="summary-product__price">£589.00</span>
</div>

<div class="summary-lines">
  <div class="summary-line">
    <span class="summary-line__label">Delivery</span>
    <span class="summary-line__value">FREE</span>
  </div>
  <div class="summary-line summary-line--total">
    <span class="summary-line__label">Total</span>
    <span class="summary-line__value">£1,153.00</span>
  </div>
</div>
```

```css
.summary-product {
  display: grid;
  grid-template-columns: 56px 1fr auto;
  gap: 12px;
  align-items: start;
  margin-bottom: 8px;
}
.summary-product__image {
  width: 56px; height: 56px; flex-shrink: 0;
  border-radius: var(--radius-xs);
  object-fit: contain;
  background: var(--gray-10);
}
.summary-product__details {
  display: flex; flex-direction: column; gap: 2px; min-width: 0;
}
.summary-product__name {
  font-family: 'Inter', sans-serif; font-weight: 400;
  font-size: 0.875rem; line-height: 1.4; color: var(--type-primary);
}
.summary-product__price {
  font-family: 'Inter', sans-serif; font-weight: 700;
  font-size: 0.875rem; color: var(--type-primary);
  font-variant-numeric: tabular-nums; text-align: right; white-space: nowrap;
}
.summary-product__qty {
  font-family: 'Inter', sans-serif; font-size: 0.75rem;
  color: var(--type-tertiary); line-height: 1.625;
}

.summary-lines {
  display: flex; flex-direction: column; gap: 8px;
  padding-top: 16px;
  border-top: 1px solid var(--gray-30);
}
.summary-line {
  display: flex; justify-content: space-between; align-items: baseline;
  font-family: 'Inter', sans-serif; font-size: 0.75rem;
  line-height: 1.625; color: var(--type-secondary);
}
.summary-line__value {
  font-variant-numeric: tabular-nums; font-weight: 400; text-align: right;
}
.summary-line--total {
  padding-top: 12px;
  border-top: 1px solid var(--gray-30);
}
.summary-line--total .summary-line__label,
.summary-line--total .summary-line__value {
  font-family: 'SmileyFace', Georgia, serif;
  font-weight: 700; font-size: 1.25rem;
  line-height: 1.25; color: var(--type-primary);
}
```

##### Bottom Sheet Modal

A modal that slides up from the bottom on mobile and centres on desktop. Includes scrim backdrop, focus trap, and respects `prefers-reduced-motion`.

```html
<div class="bottom-sheet-scrim" id="bottom-sheet-scrim"></div>
<div class="bottom-sheet" id="bottom-sheet" role="dialog" aria-modal="true" aria-labelledby="bottom-sheet-heading">
  <h2 id="bottom-sheet-heading" class="text-title-lg" style="text-align: center; text-wrap: balance;">Modal heading</h2>
  <p class="text-body" style="margin: 16px 0 24px; text-align: center;">Supporting message</p>
  <button class="btn btn-primary btn-full" data-aods="button">Primary action</button>
  <a href="#" class="text-link" style="display:block; text-align:center; margin-top:16px;">Secondary action</a>
</div>
```

```css
.bottom-sheet-scrim {
  position: fixed; inset: 0;
  background: rgba(1, 22, 48, 0.5);
  z-index: 100; display: none;
}
.bottom-sheet-scrim.is-open { display: block; }

.bottom-sheet {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: var(--ui-core-base);
  border-radius: var(--radius-md) var(--radius-md) 0 0;
  padding: 32px 24px; z-index: 101;
  transform: translateY(100%);
  max-height: 80vh; overflow-y: auto;
  pointer-events: none;
}
.bottom-sheet.is-open {
  transform: translateY(0);
  pointer-events: auto;
}

@media (prefers-reduced-motion: no-preference) {
  .bottom-sheet { transition: transform 300ms ease-out; }
}

@media (min-width: 900px) {
  .bottom-sheet {
    max-width: 480px;
    top: 50%; bottom: auto; left: 50%;
    transform: translate(-50%, calc(-50% + 24px));
    opacity: 0;
    border-radius: var(--radius-md);
    max-height: calc(100vh - 48px);
  }
  .bottom-sheet.is-open {
    transform: translate(-50%, -50%);
    opacity: 1;
  }
  @media (prefers-reduced-motion: no-preference) {
    .bottom-sheet { transition: transform 200ms ease-out, opacity 200ms ease-out; }
  }
}
```

**Rules:**
- Scrim uses `shadow-overlay` derived colour at 50% opacity.
- Focus trap required — `Escape` key closes the modal.
- Return focus to the triggering element on close.
- One primary CTA maximum. Secondary action uses `text-link` (not a button).
- On desktop, centres vertically and horizontally with max-width 480px.

---

#### Checkout flow rules

- **One step visible at a time.** Use `display: none` / `display: block` toggling via `.step-panel.is-active`.
- **Step tabs are navigable** — completed steps can be clicked to go back. Future steps are disabled.
- **Sidebar is sticky** on desktop (900px+) at `top: 80px` to account for the fixed header.
- **Order summary updates live** — delivery cost and Five Star membership toggle reflect in real-time.
- **Five Star upsell** appears after address confirmation. If declined, a bottom-sheet modal reminds the user before advancing.
- **Payment method selector** uses the toggle-item pattern with custom content (logos, finance details). Only one method can be selected at a time.
- **Form validation** uses the kit's standard field error pattern: `is-error` class + `aria-invalid="true"` + descriptive error message via `aria-describedby`.


---

## Anti-Patterns

### AO Anti-patterns — Refuse and Replace

> If a request, generated output, or pasted Figma frame would force any of the below, **stop and use the listed AO-correct alternative**. This is the most important file in the kit for preventing AI drift.

The pattern: **Match → Refuse → Replace.**

If you see the "Don't" on the left in input or output, refuse to produce it, explain why in one sentence, and use the "Do" on the right.

---

#### Colour & tokens

| ❌ Don't | ✅ Do |
|---|---|
| `background: #00893e;` | `background: var(--action-primary-base);` |
| `color: #011f44;` | `color: var(--type-primary);` |
| `border-color: #d6dddf;` | `border-color: var(--gray-40);` |
| Invent a new colour to match a Figma comp | Find the closest token. If genuinely none fits, surface the ambiguity — don't invent. |
| Use `palette-heat` (#f96155) for an error state | Use `ui-error` tokens (background `#fff0f6`, text `#b50016`). |
| Use `palette-toast` for "limited stock" | Use `ui-warning` tokens. |
| Use `brand-primary-base` (#12c35a) as a button fill | The button colour is `action-primary-base` (#00893e). Brand green is a *glow / accent* colour. |

---

#### Component variants

| ❌ Don't | ✅ Do |
|---|---|
| `<Button variant="success">` | Approved variants only: `primary` `secondary` `tertiary` `link` `white` `dark`. There is no `success` variant. |
| `<Button variant="green">` or `="red">` | See above — semantic name, not colour name. |
| `<Tag color="purple">` | Tags only support `ui-*` groups: `core` `neutral` `highlight` `success` `warning` `error` `light` `dark`. |

---

#### Typography

| ❌ Don't | ✅ Do |
|---|---|
| Inter on a button label | Always `text-cta` / SmileyFace Bold on `<button>`. No exceptions. |
| SmileyFace at 0.75rem (12px) | SmileyFace minimum is `text-title-sm` (14px / 0.875rem). Below that, switch to Inter. |
| `font-weight: 300` on body | Inter 400 is the minimum body weight. |
| `text-transform: uppercase` on CTAs | AO buttons are sentence-case verbs. |
| ALL CAPS LABELS in tags or buttons | Sentence case. |
| `Arial`, `Helvetica`, `system-ui` as the primary font | The two AO families are SmileyFace and Inter. System fonts only as fallbacks. |

---

#### Layout & hierarchy

| ❌ Don't | ✅ Do |
|---|---|
| Two `btn-primary` in the same visual section | One primary CTA per section. Demote the second to `secondary`. |
| Three or more parallel CTAs ("Buy", "Save", "Compare", "Share") | Maximum two visible CTAs. Move the rest to a menu or a Notice. |
| Putting validation errors above the field | Errors go **below** the input, with `aria-describedby` linking them. |
| Using placeholders as labels | Always a visible `<label>`. Placeholders show formatting hints. |
| Stacking cards inside cards inside cards | Maximum one level of card nesting. |
| Hero text at `text-display-headline` AND a `text-display-lg` in the same section | One display-level heading per section. |

---

#### CTA copy

| ❌ Don't | ✅ Do |
|---|---|
| "Submit" | "Check availability", "Confirm order", "Add to basket" — verb + object |
| "Click here" | Specific verb: "Read the delivery guide" |
| "OK" / "Cancel" on a destructive modal | "Yes, cancel order" / "Keep order" — the action stated outcome |
| "Learn more" with no context | "Read the delivery guide" — what is the user about to learn? |
| Two-word polite verbs ("Please continue") | Direct verbs ("Continue") |

---

#### Accessibility

| ❌ Don't | ✅ Do |
|---|---|
| Icon-only buttons with no `aria-label` | Always include `aria-label="…"` |
| Form inputs with no `<label>` | Always pair an input with a visible label |
| Error inputs without `aria-invalid="true"` | Auto-applied; ensure it's present in your output |
| Decorative icons without `aria-hidden="true"` | Add it. Icons paired with text are decorative. |
| Using emoji/Unicode symbols (☰, 🔍, ✓, ✗, ⚠) for icons | Use Strata icon font: `<i class="ico ico-{name}" aria-hidden="true"></i>`. See the Icons section above. |
| Removing focus outlines | Keep `:focus-visible` styling on every interactive element |
| Colour-only state indication ("the green row is approved") | Pair colour with an icon and/or text |

---

#### Surfaces & shadows

| ❌ Don't | ✅ Do |
|---|---|
| `box-shadow: 0 2px 4px rgba(0,0,0,0.1);` | `box-shadow: var(--shadow);` (or `--shadow-md`, `--shadow-lg`, `--shadow-xl`) |
| Heavy drop shadows for emphasis | AO shadows are subtle. Use the token. Use elevation to communicate *layer*, not importance. |
| Drop shadow on a flat card on the page background | Cards on the page have a 1px `gray-40` border and no shadow. `card-raised` is only for floating surfaces. |
| Mixing radius values within one component | One radius per component: buttons pill, cards 16px, tags pill, inputs 8px. |

---

#### Spacing

| ❌ Don't | ✅ Do |
|---|---|
| `padding: 14px;` | Pick from the scale: 12px or 16px. No intermediate values. |
| `gap: 10px;` | 8px or 12px. |
| Mobile padding the same as desktop | Mobile defaults: 8px gutters, 16px from `sm:` upward. |
| Cramped form fields | `gap: 1rem` between fields in a stack. `gap: 0.25rem` between label, input, and message inside one field. |

---

#### Imagery

| ❌ Don't | ✅ Do |
|---|---|
| Stock photography that doesn't match AO's product range | If unsure, use a plain neutral background. Don't invent products. |
| Lifestyle photography with people in luxury settings | AO is for real homes. Imagery is product-led; lifestyle is warm and unstaged. |
| Product images on coloured backgrounds | Product images on `#fff` or `var(--gray-10)`. Always. |

---

#### When in doubt

1. **Prefer fewer things.** Drop the second illustration. Drop the third CTA. Drop the gradient. AO earns trust through restraint.
2. **Prefer whitespace.** Density is earned by context (product pages, data tables). Default to more space, not less.
3. **Prefer the simpler token.** If you can solve a problem with `ui-core` instead of a state colour, do it.
4. **Surface the ambiguity, don't invent.** If the request doesn't fit any pattern, say so and ask. Don't produce a plausible-but-non-AO answer.

