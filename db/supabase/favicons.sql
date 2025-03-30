-- 更新网站的缩略图URL，使用favicon.io的API获取网站图标
-- 这是一个最可靠的方案，几乎所有网站都有favicon

-- 域名查询
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=leandomainsearch.com&sz=128' WHERE name = 'lean_domain_search';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=query.domains&sz=128' WHERE name = 'query_domains';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=instantdomainsearch.com&sz=128' WHERE name = 'instant_domain_search';

-- 域名注册
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=spaceship.com&sz=128' WHERE name = 'spaceship';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=porkbun.com&sz=128' WHERE name = 'porkbun';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=namecheap.com&sz=128' WHERE name = 'namecheap';

-- 网站开发
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=vercel.com&sz=128' WHERE name = 'vercel_templates';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=supabase.com&sz=128' WHERE name = 'supabase';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=builtwith.com&sz=128' WHERE name = 'builtwith';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=carrd.co&sz=128' WHERE name = 'carrd';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=bolt.new&sz=128' WHERE name = 'bolt_new';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=v0.dev&sz=128' WHERE name = 'v0_dev';

-- 网站托管
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=cloudflare.com&sz=128' WHERE name = 'cloudflare';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=vercel.com&sz=128' WHERE name = 'vercel_hosting';

-- 数据后台
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=search.google.com&sz=128' WHERE name = 'google_search_console';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=analytics.google.com&sz=128' WHERE name = 'google_analytics';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=bing.com&sz=128' WHERE name = 'bing_webmaster';

-- 数据查询
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=aitdk.com&sz=128' WHERE name = 'aitdk';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=semrush.com&sz=128' WHERE name = 'semrush';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=searchsuggest.tips&sz=128' WHERE name = 'search_suggest';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=trends.google.com&sz=128' WHERE name = 'google_trends';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=ahrefs.com&sz=128' WHERE name = 'ahrefs_app';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=toolify.ai&sz=128' WHERE name = 'toolify';
UPDATE web_navigation SET thumbnail_url = 'https://www.google.com/s2/favicons?domain=ahrefs.com&sz=128' WHERE name = 'ahrefs_keyword'; 