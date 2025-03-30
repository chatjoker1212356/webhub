-- 更新网站的缩略图URL，使用截图服务生成高质量缩略图
-- 使用https://image.thum.io/get/width/600/crop/900/允许跨域/网址 服务

-- 域名查询
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://leandomainsearch.com/' WHERE name = 'lean_domain_search';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://query.domains/' WHERE name = 'query_domains';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://instantdomainsearch.com/' WHERE name = 'instant_domain_search';

-- 域名注册
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://www.spaceship.com/' WHERE name = 'spaceship';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://porkbun.com/' WHERE name = 'porkbun';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://www.namecheap.com/' WHERE name = 'namecheap';

-- 网站开发
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://vercel.com/templates' WHERE name = 'vercel_templates';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://supabase.com/' WHERE name = 'supabase';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://builtwith.com/' WHERE name = 'builtwith';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://carrd.co/' WHERE name = 'carrd';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://bolt.new/' WHERE name = 'bolt_new';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://v0.dev/' WHERE name = 'v0_dev';

-- 网站托管
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://www.cloudflare.com/' WHERE name = 'cloudflare';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://vercel.com/' WHERE name = 'vercel_hosting';

-- 数据后台
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://search.google.com/search-console' WHERE name = 'google_search_console';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://analytics.google.com/analytics/web' WHERE name = 'google_analytics';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://www.bing.com/webmasters/about' WHERE name = 'bing_webmaster';

-- 数据查询
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://aitdk.com/' WHERE name = 'aitdk';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://www.semrush.com/' WHERE name = 'semrush';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://www.searchsuggest.tips/' WHERE name = 'search_suggest';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://trends.google.com/trends/' WHERE name = 'google_trends';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://app.ahrefs.com/' WHERE name = 'ahrefs_app';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://www.toolify.ai/' WHERE name = 'toolify';
UPDATE web_navigation SET thumbnail_url = 'https://image.thum.io/get/width/600/crop/900/https://ahrefs.com/keyword-difficulty' WHERE name = 'ahrefs_keyword'; 