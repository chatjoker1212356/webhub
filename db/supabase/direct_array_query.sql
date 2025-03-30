-- 测试不同的PostgreSQL数组查询语法
-- 此脚本用于验证数组查询是否正常工作

-- 1. 使用 @> 操作符（数组包含）
SELECT 'Test 1: @> 操作符（数组包含）' as test_name;
SELECT id, name, category_name
FROM web_navigation
WHERE category_name @> ARRAY['web_dev']
LIMIT 5;

-- 2. 使用 = ANY 操作符
SELECT 'Test 2: = ANY 操作符' as test_name;
SELECT id, name, category_name
FROM web_navigation
WHERE 'web_dev' = ANY(category_name)
LIMIT 5;

-- 3. 使用数组索引查询
SELECT 'Test 3: 数组索引查询' as test_name;
SELECT id, name, category_name
FROM web_navigation
WHERE category_name[1] = 'web_dev' OR category_name[2] = 'web_dev'
LIMIT 5;

-- 4. 查看实际数据格式
SELECT 'Test 4: 查看数据格式' as test_name;
SELECT id, name, array_to_string(category_name, ',') as category_string, 
       pg_typeof(category_name) as array_type
FROM web_navigation
LIMIT 10;

-- 5. 检查空数组或NULL
SELECT 'Test 5: 检查空数组或NULL' as test_name;
SELECT id, name, category_name, 
       array_length(category_name, 1) as array_length
FROM web_navigation
WHERE array_length(category_name, 1) IS NULL OR array_length(category_name, 1) = 0
LIMIT 5;

-- 6. 查看所有不同的分类
SELECT 'Test 6: 查看所有不同的分类' as test_name;
SELECT DISTINCT unnest(category_name) as category
FROM web_navigation
ORDER BY category;

-- 7. 统计每个分类的网站数量
SELECT 'Test 7: 统计每个分类的网站数量' as test_name;
SELECT cat, count(*) 
FROM (
  SELECT unnest(category_name) as cat
  FROM web_navigation
) as subquery
GROUP BY cat
ORDER BY count DESC; 