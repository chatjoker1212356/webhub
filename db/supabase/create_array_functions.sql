-- 创建PostgreSQL函数用于处理数组查询
-- 此函数可以在Supabase中直接调用

-- 创建函数: 根据分类获取网站
CREATE OR REPLACE FUNCTION get_websites_by_category(category_param TEXT)
RETURNS SETOF web_navigation
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY 
  SELECT * FROM web_navigation 
  WHERE category_param = ANY(category_name)
  ORDER BY id;
END;
$$;

-- 测试函数
SELECT COUNT(*) FROM get_websites_by_category('web_dev');
SELECT COUNT(*) FROM get_websites_by_category('no_code');
SELECT COUNT(*) FROM get_websites_by_category('domain_search');

-- 创建函数: 列出所有分类及其对应的网站数量
CREATE OR REPLACE FUNCTION get_category_counts()
RETURNS TABLE (category TEXT, website_count BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY 
  SELECT cat, COUNT(*) 
  FROM (
    SELECT unnest(category_name) as cat
    FROM web_navigation
  ) as subquery
  GROUP BY cat
  ORDER BY COUNT(*) DESC;
END;
$$;

-- 测试函数
SELECT * FROM get_category_counts(); 