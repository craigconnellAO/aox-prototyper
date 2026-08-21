import clsx from "clsx";
import { forwardRef, useId, type SelectHTMLAttributes } from "react";
import "./select.css";

export interface SelectOption {
  label: string;
  value: string;
  disabled?: boolean;
}

export interface SelectProps
  extends Omit<SelectHTMLAttributes<HTMLSelectElement>, "children"> {
  label?: string;
  hint?: string;
  errorMessage?: string;
  options: SelectOption[];
  placeholder?: string;
}

/**
 * AO Select.
 *
 * A native `<select>` on purpose: it gets the platform picker on mobile,
 * which is both more accessible and closer to what AO ships than a
 * custom listbox. Port to SDS's react-aria ListBox only if a design
 * genuinely needs rich option rendering.
 */
export const Select = forwardRef<HTMLSelectElement, SelectProps>(
  function Select(
    { label, hint, errorMessage, options, placeholder, className, id, ...rest },
    ref,
  ) {
    const generatedId = useId();
    const selectId = id ?? generatedId;
    const messageId = `${selectId}-message`;
    const hasError = Boolean(errorMessage);
    const message = errorMessage ?? hint;

    return (
      <div className="ao-field" data-aods="select">
        {label && (
          <label className="ao-field-label" htmlFor={selectId}>
            {label}
          </label>
        )}
        <div className="ao-select-wrapper">
          <select
            {...rest}
            ref={ref}
            id={selectId}
            aria-invalid={hasError || undefined}
            aria-describedby={message ? messageId : undefined}
            className={clsx("ao-select", hasError && "is-error", className)}
          >
            {placeholder && (
              <option value="" disabled>
                {placeholder}
              </option>
            )}
            {options.map((option) => (
              <option
                key={option.value}
                value={option.value}
                disabled={option.disabled}
              >
                {option.label}
              </option>
            ))}
          </select>
        </div>
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
  },
);
