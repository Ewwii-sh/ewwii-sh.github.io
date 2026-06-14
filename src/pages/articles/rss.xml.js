import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';

export async function GET(context) {
  const articles = await getCollection('articles');
  const sortedArticles = articles.sort((a, b) => b.data.date.getTime() - a.data.date.getTime());

  return rss({
    title: 'Ewwii Articles',
    description: 'Fresh technical updates, configuration guides, and articles.',
    site: context.site || 'https://ewwii-sh.github.io', 
    items: sortedArticles.map((article) => ({
      title: article.data.title,
      pubDate: article.data.date,
      description: article.data.description,
      link: `/articles/${article.id}/`, 
    })),
  });
}
