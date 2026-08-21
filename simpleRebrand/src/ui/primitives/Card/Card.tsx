import clsx from "clsx";
import type { HTMLAttributes, ReactNode } from "react";
import "./card.css";

export interface CardProps extends HTMLAttributes<HTMLDivElement> {
  elevated?: boolean;
  /** Hover/focus affordances. Pair with a real control for keyboard access. */
  interactive?: boolean;
  selected?: boolean;
  children: ReactNode;
}

/** AO Card. Surface container at 16px radius. */
export function Card({
  elevated = false,
  interactive = false,
  selected = false,
  className,
  children,
  ...rest
}: CardProps) {
  return (
    <div
      {...rest}
      data-aods="card"
      className={clsx(
        "ao-card",
        elevated && "ao-card-elevated",
        interactive && "ao-card-interactive",
        selected && "ao-card-selected",
        className,
      )}
    >
      {children}
    </div>
  );
}

export function CardTitle({ children, className, ...rest }: HTMLAttributes<HTMLHeadingElement>) {
  return (
    <h3 {...rest} className={clsx("ao-card-title", className)}>
      {children}
    </h3>
  );
}

export function CardBody({ children, className, ...rest }: HTMLAttributes<HTMLParagraphElement>) {
  return (
    <p {...rest} className={clsx("ao-card-body", className)}>
      {children}
    </p>
  );
}

export function CardFooter({ children, className, ...rest }: HTMLAttributes<HTMLDivElement>) {
  return (
    <div {...rest} className={clsx("ao-card-footer", className)}>
      {children}
    </div>
  );
}
