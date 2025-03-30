-- 更新网站的缩略图URL，使用更简单的截图服务
-- 使用webshot.deam.io服务，它是一个简单的截图服务

-- 域名查询
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://leandomainsearch.com/?width=800&height=450' WHERE name = 'lean_domain_search';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://query.domains/?width=800&height=450' WHERE name = 'query_domains';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://instantdomainsearch.com/?width=800&height=450' WHERE name = 'instant_domain_search';

-- 域名注册
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://www.spaceship.com/?width=800&height=450' WHERE name = 'spaceship';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://porkbun.com/?width=800&height=450' WHERE name = 'porkbun';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://www.namecheap.com/?width=800&height=450' WHERE name = 'namecheap';

-- 网站开发
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://vercel.com/templates?width=800&height=450' WHERE name = 'vercel_templates';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://supabase.com/?width=800&height=450' WHERE name = 'supabase';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://builtwith.com/?width=800&height=450' WHERE name = 'builtwith';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://carrd.co/?width=800&height=450' WHERE name = 'carrd';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://bolt.new/?width=800&height=450' WHERE name = 'bolt_new';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://v0.dev/?width=800&height=450' WHERE name = 'v0_dev';

-- 网站托管
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://www.cloudflare.com/?width=800&height=450' WHERE name = 'cloudflare';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://vercel.com/?width=800&height=450' WHERE name = 'vercel_hosting';

-- 数据后台
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://search.google.com/search-console?width=800&height=450' WHERE name = 'google_search_console';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://analytics.google.com/analytics/web?width=800&height=450' WHERE name = 'google_analytics';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://www.bing.com/webmasters/about?width=800&height=450' WHERE name = 'bing_webmaster';

-- 数据查询
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://aitdk.com/?width=800&height=450' WHERE name = 'aitdk';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://www.semrush.com/?width=800&height=450' WHERE name = 'semrush';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://www.searchsuggest.tips/?width=800&height=450' WHERE name = 'search_suggest';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://trends.google.com/trends/?width=800&height=450' WHERE name = 'google_trends';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://app.ahrefs.com/?width=800&height=450' WHERE name = 'ahrefs_app';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://www.toolify.ai/?width=800&height=450' WHERE name = 'toolify';
UPDATE web_navigation SET thumbnail_url = 'https://webshot.deam.io/https://ahrefs.com/keyword-difficulty?width=800&height=450' WHERE name = 'ahrefs_keyword'; 