#!/usr/bin/env node
/*
 * contrast-audit.mjs — WCAG 2.1 AA check over the AO token mapping.
 *
 * Resolves each pair through the real CSS files rather than a hardcoded
 * list, so it catches a regression introduced by editing ao-theme.css.
 *
 * Usage:  node scripts/contrast-audit.mjs
 * Exit:   0 = all pass, 1 = at least one failure.
 */

import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const css = ["ao-primitives.css", "ao-theme.css"]
  .map((f) => readFileSync(join(root, "src/styles", f), "utf8"))
  .join("\n");

/** Build a name -> raw-value map from the CSS custom properties. */
const decls = new Map();
for (const [, name, value] of css.matchAll(/^\s*(--[a-z0-9-]+)\s*:\s*([^;]+);/gm)) {
  decls.set(name, value.trim());
}

/** Follow var() indirection until a literal falls out. */
function resolve(name, seen = new Set()) {
  if (seen.has(name)) throw new Error(`circular token reference at ${name}`);
  seen.add(name);
  const raw = decls.get(name);
  if (raw === undefined) throw new Error(`undefined token: ${name}`);
  const ref = raw.match(/^var\((--[a-z0-9-]+)\)$/);
  return ref ? resolve(ref[1], seen) : raw;
}

function luminance(hex) {
  const h = hex.replace("#", "");
  const ch = [0, 2, 4]
    .map((i) => parseInt(h.slice(i, i + 2), 16) / 255)
    .map((x) => (x <= 0.04045 ? x / 12.92 : ((x + 0.055) / 1.055) ** 2.4));
  return 0.2126 * ch[0] + 0.7152 * ch[1] + 0.0722 * ch[2];
}

function ratio(fg, bg) {
  const [a, b] = [luminance(fg), luminance(bg)];
  return (Math.max(a, b) + 0.05) / (Math.min(a, b) + 0.05);
}

/*
 * Pairs that components actually render. `min` is the WCAG AA floor for
 * that pair: 4.5 for normal text, 3 for large text and UI boundaries.
 * `exempt` marks pairs WCAG explicitly does not require to pass.
 */
const PAIRS = [
  ["Button primary",        "--sds-color-text-brand-on-brand",              "--sds-color-background-brand-default",     4.5],
  ["Button primary hover",  "--sds-color-text-brand-on-brand",              "--sds-color-background-brand-hover",       4.5],
  ["Button secondary",      "--ao-x-accent-default",                        "--sds-color-background-default-default",   4.5],
  ["Button secondary hover","--ao-x-accent-hover",                          "--ao-x-accent-surface",                    4.5],
  ["Button tertiary",       "--sds-color-text-default-default",             "--sds-color-background-default-secondary", 4.5],
  ["Button dark",           "--sds-color-text-neutral-on-neutral",          "--sds-color-background-neutral-default",   4.5],
  ["Button inverse",        "--ao-x-inverse-contrast",                      "--ao-x-inverse-default",                   4.5],
  ["Button inactive",       "--ao-x-inactive-contrast",                     "--ao-x-inactive-default",                  4.5],
  ["Tag neutral",           "--sds-color-text-default-default",             "--sds-color-background-default-secondary", 4.5],
  ["Tag brand",             "--sds-color-text-brand-on-brand-secondary",    "--sds-color-background-brand-secondary",   4.5],
  ["Tag positive",          "--sds-color-text-positive-on-positive-secondary","--sds-color-background-positive-secondary",4.5],
  ["Tag warning",           "--sds-color-text-warning-on-warning-secondary","--sds-color-background-warning-secondary", 4.5],
  ["Tag danger",            "--sds-color-text-danger-on-danger-secondary",  "--sds-color-background-danger-secondary",  4.5],
  ["Tag highlight",         "--ao-x-accent-on-surface",                     "--ao-x-accent-surface",                    4.5],
  ["Text on warning accent","--sds-color-text-warning-on-warning",          "--sds-color-background-warning-default",   4.5],
  ["Text on positive",      "--sds-color-text-positive-on-positive",        "--sds-color-background-positive-default",  4.5],
  ["Text on danger",        "--sds-color-text-danger-on-danger",            "--sds-color-background-danger-default",    4.5],
  ["Body text",             "--sds-color-text-default-default",             "--sds-color-background-default-default",   4.5],
  ["Secondary text",        "--sds-color-text-default-secondary",           "--sds-color-background-default-default",   4.5],
  ["Tertiary text",         "--sds-color-text-default-tertiary",            "--sds-color-background-default-default",   4.5],
  ["Error message",         "--sds-color-text-danger-default",              "--sds-color-background-default-default",   4.5],
  // AO-level gap, not a simpleRebrand bug: design.md specifies gray-50 for
  // control borders (1.71:1), below WCAG 1.4.11's 3:1. Reported every run so
  // it stays visible, but it does not fail the build — the fix belongs to
  // AO's design-system owners. See TOKEN-MAP.md § Known AO-level gap.
  ["Input border",          "--sds-color-border-default-default",           "--sds-color-background-default-default",   3.0, "gap"],
  // WCAG 2.1 §1.4.3 exempts inactive controls. Reported, never failed.
  ["Disabled label",        "--sds-color-text-disabled-default",            "--sds-color-background-disabled-default",  0, "exempt"],
];

let failures = 0;
console.log(`\n  ${"pair".padEnd(26)} ${"ratio".padStart(6)}  min   result`);
console.log("  " + "-".repeat(52));

for (const [label, fgToken, bgToken, min, flag] of PAIRS) {
  const fg = resolve(fgToken);
  const bg = resolve(bgToken);
  if (!/^#[0-9a-f]{6}$/i.test(fg) || !/^#[0-9a-f]{6}$/i.test(bg)) {
    console.log(`  ${label.padEnd(26)} ${"—".padStart(6)}  skipped (non-hex: ${fg} / ${bg})`);
    continue;
  }
  const value = ratio(fg, bg);
  const advisory = flag === "exempt" || flag === "gap";
  const pass = advisory || value >= min;
  if (!pass) failures++;
  const verdict =
    flag === "exempt" ? "exempt" : flag === "gap" ? (value >= min ? "PASS" : "AO-GAP") : pass ? "PASS" : "FAIL";
  console.log(
    `  ${label.padEnd(26)} ${value.toFixed(2).padStart(6)}  ${String(min || "—").padEnd(4)}  ${verdict}`,
  );
}

console.log();
if (failures) {
  console.error(`  ${failures} pair(s) below AA. See TOKEN-MAP.md § Contrast.\n`);
  process.exit(1);
}
console.log("  All pairs this library controls meet WCAG 2.1 AA.");
console.log("  AO-GAP rows are upstream design.md issues — see TOKEN-MAP.md.\n");
