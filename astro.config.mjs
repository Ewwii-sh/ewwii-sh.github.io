// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
  base: "/",
  integrations: [
    starlight({
      title: "Ewwii",
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/Ewwii-sh/",
        },
      ],
      sidebar: [
        {
          label: "Introduction",
          link: "/docs/introduction",
        },
        {
          label: "Getting Started",
          autogenerate: { directory: "docs/getting-started" },
        },
        {
          label: "Reference",
          autogenerate: { directory: "docs/reference" },
        },
      ],
    }),
  ],
  redirects: {
    "/docs": "/docs/introduction",
    "/docs/getting-started": "/docs/getting-started/installation",
    "/docs/reference": "/docs/reference/table_of_contents",
    "/docs/configuration": "/docs/configuration/configuration",
    "/docs/package-manager": "/docs/package-manager/ewwii-package-manager",
  },
});
