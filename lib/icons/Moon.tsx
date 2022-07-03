import * as React from "react";
import { SVGProps } from "react";

const SvgMoon = (props: SVGProps<SVGSVGElement>) => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    data-name="Layer 1"
    viewBox="0 0 24 24"
    width={512}
    height={512}
    {...props}
  >
    <path d="M14 24A12.013 12.013 0 0 1 2 12C1.847 3.043 12.031-2.983 19.792 1.508l2.33 1.292-2.313 1.322a8.55 8.55 0 0 0 .718 15.167l2.433 1.1-2.2 1.508A11.921 11.921 0 0 1 14 24Zm0-21a9 9 0 1 0 2.848 17.529c-5.366-4.022-5.793-12.77-.817-17.3A8.873 8.873 0 0 0 14 3Z" />
  </svg>
);

export default SvgMoon;
