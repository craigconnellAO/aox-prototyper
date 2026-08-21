import clsx from "clsx";
import type { HTMLAttributes, ReactNode } from "react";
import "./tag.css";

export type TagIntent =
  | "neutral"
  | "brand"
  | "positive"
  | "warning"
  | "danger"
  | "highlight";

export interface TagProps extends HTMLAttributes<HTMLSpanElement> {
  intent?: TagIntent;
  /** Square corners instead of the default pill. */
  square?: boolean;
  children: ReactNode;
}

/** AO Tag. Status pill — colour alone never carries the meaning, so the
 *  label always states the status in words. */
export function Tag({
  intent = "neutral",
  square = false,
  className,
  children,
  ...rest
}: TagProps) {
  return (
    <span
      {...rest}
      data-aods="tag"
      className={clsx(
        "ao-tag",
        `ao-tag-intent-${intent}`,
        square && "ao-tag-square",
        className,
      )}
    >
      {children}
    </span>
  );
}
