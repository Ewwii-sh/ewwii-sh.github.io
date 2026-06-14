import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const about = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/about' }),
});

const plugins = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/plugins' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    author: z.string(),
    link: z.string(),
    tags: z.array(z.string()).default([]),
    version: z.string().optional(),
  })
});

export const collections = { about, plugins };
