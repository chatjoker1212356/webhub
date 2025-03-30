-- 更新网站的缩略图URL，使用高质量的品牌logo
-- 为了更好的显示效果，我们使用Clearbit Logo API（https://clearbit.com/logo）
-- 配合网站背景色的品牌卡片，尺寸为350x175像素

-- 域名查询
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/leandomainsearch.com?size=350' WHERE name = 'lean_domain_search';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/query.domains?size=350' WHERE name = 'query_domains';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/instantdomainsearch.com?size=350' WHERE name = 'instant_domain_search';

-- 域名注册
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/spaceship.com?size=350' WHERE name = 'spaceship';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/porkbun.com?size=350' WHERE name = 'porkbun';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/namecheap.com?size=350' WHERE name = 'namecheap';

-- 网站开发
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/vercel.com?size=350' WHERE name = 'vercel_templates';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/supabase.com?size=350' WHERE name = 'supabase';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/builtwith.com?size=350' WHERE name = 'builtwith';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/carrd.co?size=350' WHERE name = 'carrd';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/bolt.new?size=350' WHERE name = 'bolt_new';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/v0.dev?size=350' WHERE name = 'v0_dev';

-- 网站托管
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/cloudflare.com?size=350' WHERE name = 'cloudflare';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/vercel.com?size=350' WHERE name = 'vercel_hosting';

-- 数据后台
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/google.com?size=350' WHERE name = 'google_search_console';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/google.com/analytics?size=350' WHERE name = 'google_analytics';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/bing.com?size=350' WHERE name = 'bing_webmaster';

-- 数据查询
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/aitdk.com?size=350' WHERE name = 'aitdk';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/semrush.com?size=350' WHERE name = 'semrush';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/searchsuggest.tips?size=350' WHERE name = 'search_suggest';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/google.com?size=350' WHERE name = 'google_trends';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/ahrefs.com?size=350' WHERE name = 'ahrefs_app';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/toolify.ai?size=350' WHERE name = 'toolify';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/ahrefs.com?size=350' WHERE name = 'ahrefs_keyword';

-- 设置备用图片（如果logo获取失败）
UPDATE web_navigation SET image_url = '/images/default-tool.png' WHERE image_url IS NULL OR image_url = ''; 