-- 清除原有分类数据，保留网站数据
DELETE FROM navigation_category;

-- 添加新的分类
INSERT INTO navigation_category (name, title, sort) VALUES
('domain_search', '域名查询', 1),
('domain_register', '域名注册', 2),
('web_dev', '网站开发', 3),
('web_hosting', '网站托管', 4),
('data_analytics', '数据后台', 5),
('data_research', '数据查询', 6),
('no_code', '无代码开发', 7);

-- 添加新的网站数据，使用ON CONFLICT更新现有数据
INSERT INTO web_navigation (name, title, content, url, category_name) VALUES
-- 域名查询
('lean_domain_search', 'Lean Domain Search', '快速查找可用的域名', 'https://leandomainsearch.com/', ARRAY['domain_search']),
('query_domains', 'Query Domains', '域名查询工具', 'https://query.domains/', ARRAY['domain_search']),
('instant_domain_search', 'Instant Domain Search', '即时域名查询', 'https://instantdomainsearch.com/', ARRAY['domain_search'])
ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  url = EXCLUDED.url, 
  category_name = EXCLUDED.category_name;

-- 域名注册
INSERT INTO web_navigation (name, title, content, url, category_name) VALUES
('spaceship', 'Spaceship', '域名注册服务', 'https://www.spaceship.com/', ARRAY['domain_register']),
('porkbun', 'Porkbun', '域名注册平台', 'https://porkbun.com/', ARRAY['domain_register']),
('namecheap', 'Namecheap', '域名注册和主机服务', 'https://www.namecheap.com/', ARRAY['domain_register'])
ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  url = EXCLUDED.url, 
  category_name = EXCLUDED.category_name;

-- 网站开发
INSERT INTO web_navigation (name, title, content, url, category_name) VALUES
('vercel_templates', 'Vercel Templates', 'Vercel提供的网站模板', 'https://vercel.com/templates', ARRAY['web_dev']),
('supabase', 'Supabase', '开源的Firebase替代品', 'https://supabase.com/', ARRAY['web_dev']),
('builtwith', 'BuiltWith', '网站技术栈分析工具', 'https://builtwith.com/', ARRAY['web_dev']),
('carrd', 'Carrd', '简单的单页面网站构建工具', 'https://carrd.co/', ARRAY['web_dev']),
('bolt_new', 'Bolt.new', '快速创建网站的工具', 'https://bolt.new/', ARRAY['web_dev']),
('v0_dev', 'v0.dev', 'Vercel的AI网站生成工具', 'https://v0.dev/', ARRAY['web_dev'])
ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  url = EXCLUDED.url, 
  category_name = 
    CASE 
      WHEN array_length(web_navigation.category_name, 1) IS NULL THEN EXCLUDED.category_name
      ELSE (SELECT array_agg(DISTINCT e) FROM unnest(array_cat(web_navigation.category_name, EXCLUDED.category_name)) e)
    END;

-- 网站托管
INSERT INTO web_navigation (name, title, content, url, category_name) VALUES
('cloudflare', 'Cloudflare', 'CDN和网站安全服务', 'https://www.cloudflare.com/', ARRAY['web_hosting']),
('vercel_hosting', 'Vercel', '现代网站托管平台', 'https://vercel.com/', ARRAY['web_hosting'])
ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  url = EXCLUDED.url, 
  category_name = 
    CASE 
      WHEN array_length(web_navigation.category_name, 1) IS NULL THEN EXCLUDED.category_name
      ELSE (SELECT array_agg(DISTINCT e) FROM unnest(array_cat(web_navigation.category_name, EXCLUDED.category_name)) e)
    END;

-- 数据后台
INSERT INTO web_navigation (name, title, content, url, category_name) VALUES
('google_search_console', 'Google Search Console', 'Google搜索控制台', 'https://search.google.com/search-console', ARRAY['data_analytics']),
('google_analytics', 'Google Analytics', 'Google分析工具', 'https://analytics.google.com/analytics/web', ARRAY['data_analytics']),
('bing_webmaster', 'Bing Webmaster', 'Bing站长工具', 'https://www.bing.com/webmasters/about', ARRAY['data_analytics'])
ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  url = EXCLUDED.url, 
  category_name = 
    CASE 
      WHEN array_length(web_navigation.category_name, 1) IS NULL THEN EXCLUDED.category_name
      ELSE (SELECT array_agg(DISTINCT e) FROM unnest(array_cat(web_navigation.category_name, EXCLUDED.category_name)) e)
    END;

-- 数据查询
INSERT INTO web_navigation (name, title, content, url, category_name) VALUES
('aitdk', 'AITDK', 'AI驱动的数据分析工具', 'https://aitdk.com/', ARRAY['data_research']),
('semrush', 'SEMrush', 'SEO和营销分析工具', 'https://www.semrush.com/', ARRAY['data_research']),
('search_suggest', 'Search Suggest', '搜索建议分析工具', 'https://www.searchsuggest.tips/', ARRAY['data_research']),
('google_trends', 'Google Trends', 'Google趋势分析', 'https://trends.google.com/trends/', ARRAY['data_research']),
('ahrefs_app', 'Ahrefs App', 'SEO工具套件', 'https://app.ahrefs.com/', ARRAY['data_research']),
('toolify', 'Toolify AI', 'AI驱动的SEO工具', 'https://www.toolify.ai/', ARRAY['data_research']),
('ahrefs_keyword', 'Ahrefs Keyword Difficulty', '关键词难度分析工具', 'https://ahrefs.com/keyword-difficulty', ARRAY['data_research'])
ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  url = EXCLUDED.url, 
  category_name = 
    CASE 
      WHEN array_length(web_navigation.category_name, 1) IS NULL THEN EXCLUDED.category_name
      ELSE (SELECT array_agg(DISTINCT e) FROM unnest(array_cat(web_navigation.category_name, EXCLUDED.category_name)) e)
    END;

-- 无代码开发 (更新为多分类)
INSERT INTO web_navigation (name, title, content, url, category_name) VALUES
('carrd_no_code', 'Carrd', '简单的单页网站构建工具', 'https://carrd.co/', ARRAY['no_code', 'web_dev']),
('bolt_new_no_code', 'Bolt.new', '现代前端开发环境', 'https://bolt.new/', ARRAY['no_code', 'web_dev']),
('v0_dev_no_code', 'V0.dev', 'AI驱动的界面构建工具', 'https://v0.dev/', ARRAY['no_code', 'web_dev'])
ON CONFLICT (name) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  url = EXCLUDED.url, 
  category_name = 
    CASE 
      WHEN array_length(web_navigation.category_name, 1) IS NULL THEN EXCLUDED.category_name
      ELSE (SELECT array_agg(DISTINCT e) FROM unnest(array_cat(web_navigation.category_name, EXCLUDED.category_name)) e)
    END;

-- 修复category_name字段格式
-- 确保所有的category_name都是正确的数组格式

-- 步骤1: 备份表数据（可选）
-- CREATE TABLE web_navigation_backup AS SELECT * FROM web_navigation;

-- 步骤2: 规范化category_name格式
-- 情况1: 处理带有逗号和引号的异常格式 ["category1",""]
UPDATE web_navigation
SET category_name = string_to_array(replace(replace(replace(array_to_string(category_name, ','), '"', ''), '[', ''), ']', ''), ',')
WHERE array_length(category_name, 1) > 0 
  AND (category_name::text LIKE '%""%' OR category_name::text LIKE '%,%');

-- 情况2: 处理空数组元素
UPDATE web_navigation
SET category_name = array_remove(category_name, '')
WHERE array_position(category_name, '') IS NOT NULL;

-- 情况3: 处理单个分类但格式不正确的情况
UPDATE web_navigation
SET category_name = ARRAY[trim(both '"' from category_name[1])]
WHERE array_length(category_name, 1) = 1 
  AND (category_name[1] LIKE '"%' OR category_name[1] LIKE '%"');

-- 步骤3: 确保所有记录都有正确的分类数组
-- 为缺少分类的记录添加默认分类
UPDATE web_navigation
SET category_name = ARRAY['other']
WHERE array_length(category_name, 1) = 0 OR category_name IS NULL;

-- 步骤4: 验证数据 (可选)
-- SELECT id, name, category_name FROM web_navigation ORDER BY id LIMIT 50; 