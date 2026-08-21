import clsx from "clsx";
import { forwardRef, useId, type InputHTMLAttributes } from "react";
import "./input.css";

export interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  /** Helper copy shown under the field. Replaced by `errorMessage` on error. */
  hint?: string;
  errorMessage?: string;
  success?: boolean;
}

/**
 * AO Input.
 *
 * Field text is Inter — form fields are body text. When `errorMessage` is
 * set the field is wired to it with `aria-describedby` and marked
 * `aria-invalid`, so the error is announced rather than only coloured.
 */
export const Input = forwardRef<HTMLInputElement, InputProps>(function Input(
  { label, hint, errorMessage, success = false, className, id, ...rest },
  ref,
) {
  const generatedId = useId();
  const inputId = id ?? generatedId;
  const messageId = `${inputId}-message`;
  const hasError = Boolean(errorMessage);
  const message = errorMessage ?? hint;

  return (
    <div className="ao-field" data-aods="input">
      {label && (
        <label className="ao-field-label" htmlFor={inputId}>
          {label}
        </label>
      )}
      <input
        {...rest}
        ref={ref}
        id={inputId}
        aria-invalid={hasError || undefined}
        aria-describedby={message ? messageId : undefined}
        className={clsx(
          "ao-input",
          hasError && "is-error",
          success && !hasError && "is-success",
          className,
        )}
      />
      {message && (
        <span
          id={messageId}
          className={hasError ? "ao-field-error" : "ao-field-hint"}
        >
          {message}
        </span>
      )}
    </div>
  );
});
