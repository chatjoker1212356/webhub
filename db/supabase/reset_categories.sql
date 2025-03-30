-- 重置所有网站分类数据为标准格式
-- 此脚本直接重写所有网站的category_name字段，确保格式统一

-- 步骤1: 创建数据备份（安全措施）
CREATE TABLE IF NOT EXISTS web_navigation_backup_reset AS 
SELECT * FROM web_navigation;

-- 步骤2: 为每个网站设置标准化的分类数组
-- 域名查询相关
UPDATE web_navigation SET category_name = ARRAY['domain_search'] 
WHERE name IN ('lean_domain_search', 'query_domains', 'instant_domain_search');

-- 域名注册相关
UPDATE web_navigation SET category_name = ARRAY['domain_register'] 
WHERE name IN ('spaceship', 'porkbun', 'namecheap');

-- 网站开发相关
UPDATE web_navigation SET category_name = ARRAY['web_dev'] 
WHERE name IN ('vercel_templates', 'supabase', 'builtwith');

-- 网站开发工具（同时属于web_dev和no_code）
UPDATE web_navigation SET category_name = ARRAY['web_dev', 'no_code'] 
WHERE name IN ('carrd', 'bolt_new', 'v0_dev');

-- 额外的no_code专用工具
UPDATE web_navigation SET category_name = ARRAY['no_code', 'web_dev'] 
WHERE name IN ('carrd_no_code', 'bolt_new_no_code', 'v0_dev_no_code');

-- 网站托管相关
UPDATE web_navigation SET category_name = ARRAY['web_hosting'] 
WHERE name IN ('cloudflare', 'vercel_hosting');

-- 数据分析相关
UPDATE web_navigation SET category_name = ARRAY['data_analytics'] 
WHERE name IN ('google_search_console', 'google_analytics', 'bing_webmaster');

-- 数据研究相关
UPDATE web_navigation SET category_name = ARRAY['data_research'] 
WHERE name IN ('aitdk', 'semrush', 'search_suggest', 'google_trends', 
               'ahrefs_app', 'toolify', 'ahrefs_keyword');

-- 步骤3: 为未分类的网站设置默认分类
UPDATE web_navigation SET category_name = ARRAY['other'] 
WHERE array_length(category_name, 1) = 0 OR category_name IS NULL;

-- 步骤4: 验证结果
SELECT id, name, category_name FROM web_navigation ORDER BY category_name[1], name LIMIT 100; 