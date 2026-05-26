import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';

const about = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/about' }),
});

export const collections = { about };
