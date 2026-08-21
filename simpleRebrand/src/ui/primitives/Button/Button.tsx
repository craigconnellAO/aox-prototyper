import clsx from "clsx";
import { forwardRef, type ButtonHTMLAttributes } from "react";
import "./button.css";

export type ButtonVariant =
  | "primary"
  | "secondary"
  | "tertiary"
  | "dark"
  | "inverse"
  | "inactive";

export type ButtonSize = "small" | "medium" | "large";

export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  /**
   * AO action tier. `primary` is reserved for the ONE main CTA per visual
   * section — design.md §Component Blueprints §1. Using it twice in a
   * section is an AO anti-pattern, not a style choice.
   */
  variant?: ButtonVariant;
  size?: ButtonSize;
  /** Stretch to the container width (AO `btn-full`). */
  full?: boolean;
  /** Square, icon-only (AO `btn-icon`). Requires an accessible label. */
  iconOnly?: boolean;
  loading?: boolean;
  error?: boolean;
  success?: boolean;
}

/**
 * AO Button.
 *
 * Label renders in SmileyFace Bold via `--ao-font-cta`. That is a brand
 * rule, not a default — an AO CTA set in Inter reads as off-brand
 * immediately.
 */
export const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  function Button(
    {
      variant = "primary",
      size = "medium",
      full = false,
      iconOnly = false,
      loading = false,
      error = false,
      success = false,
      className,
      children,
      ...rest
    },
    ref,
  ) {
    return (
      <button
        {...rest}
        ref={ref}
        data-aods="button"
        aria-busy={loading || undefined}
        className={clsx(
          "ao-button",
          `ao-button-variant-${variant}`,
          `ao-button-size-${size}`,
          full && "ao-button-full",
          iconOnly && "ao-button-icon-only",
          loading && "is-loading",
          error && "is-error",
          success && "is-success",
          className,
        )}
      >
        {children}
      </button>
    );
  },
);
