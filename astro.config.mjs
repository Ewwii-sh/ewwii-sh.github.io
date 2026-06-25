// @ts-check
import { defineConfig } from "astro/config";

import tailwindcss from "@tailwindcss/vite";
import sitemap from "@astrojs/sitemap";

import fs from 'node:fs'
import path from 'node:path'

const __dirname = path.resolve(path.dirname(''));
const nbclGrammar = JSON.parse(
  fs.readFileSync(path.resolve(__dirname, './nbcl.tmLanguage.json'), 'utf8')
)

// https://astro.build/config
export default defineConfig({
    site: "https://ewwii-sh.github.io",
    trailingSlash: 'always',
    integrations: [sitemap()],
    markdown: {
        shikiConfig: {
            langs: [{
                name: 'nbcl',
                aliases: ['nbcl'],
                scopeName: nbclGrammar.scopeName,
                ...nbclGrammar
            }],
        }
    },
    vite: {
        plugins: [tailwindcss()],
    },
});
