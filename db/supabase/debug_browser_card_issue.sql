-- 浏览器卡片显示问题调试脚本
-- 此脚本帮助诊断分类数组解析问题，确保category_name的格式一致性

-- 1. 检查分类值类型不一致的情况
SELECT
    id,
    name,
    pg_typeof(category_name) AS category_type,
    CASE 
        WHEN pg_typeof(category_name) = 'text[]'::regtype THEN 'array'
        WHEN pg_typeof(category_name) = 'text'::regtype THEN 'string'
        ELSE 'other'
    END AS simplified_type,
    category_name
FROM web_navigation
ORDER BY simplified_type, name;

-- 2. 转换字符串格式的分类为数组格式
-- 如果发现category_name有些是字符串而不是数组，可以用这个转换
DO $$
BEGIN
    -- 第一步：将所有NULL的category_name设置为空数组
    UPDATE web_navigation
    SET category_name = '{}'::text[]
    WHERE category_name IS NULL;
    
    -- 第二步：将字符串格式的category_name转换为数组格式
    UPDATE web_navigation
    SET category_name = string_to_array(category_name, ',')
    WHERE pg_typeof(category_name) = 'text'::regtype;
    
    -- 第三步：确保重复的carrd_no_code和carrd共享相同的分类数组
    WITH combined_cats AS (
        SELECT 
            ARRAY(
                SELECT DISTINCT unnest(category_name)
                FROM web_navigation
                WHERE name IN ('carrd', 'carrd_no_code')
            ) AS categories
    )
    UPDATE web_navigation
    SET category_name = (SELECT categories FROM combined_cats)
    WHERE name IN ('carrd', 'carrd_no_code');
    
    -- 第四步：对bolt_new系列做同样处理
    WITH combined_cats AS (
        SELECT 
            ARRAY(
                SELECT DISTINCT unnest(category_name)
                FROM web_navigation
                WHERE name IN ('bolt_new', 'bolt_new_no_code')
            ) AS categories
    )
    UPDATE web_navigation
    SET category_name = (SELECT categories FROM combined_cats)
    WHERE name IN ('bolt_new', 'bolt_new_no_code');
    
    -- 第五步：对v0_dev系列做同样处理
    WITH combined_cats AS (
        SELECT 
            ARRAY(
                SELECT DISTINCT unnest(category_name)
                FROM web_navigation
                WHERE name IN ('v0_dev', 'v0_dev_no_code')
            ) AS categories
    )
    UPDATE web_navigation
    SET category_name = (SELECT categories FROM combined_cats)
    WHERE name IN ('v0_dev', 'v0_dev_no_code');
END;
$$;

-- 3. 检查特定网站的分类值
SELECT 
    id,
    name,
    category_name,
    pg_typeof(category_name) AS category_type,
    array_length(category_name, 1) AS array_length
FROM web_navigation
WHERE name IN (
    'carrd', 'carrd_no_code',
    'bolt_new', 'bolt_new_no_code',
    'v0_dev', 'v0_dev_no_code'
)
ORDER BY name;

-- 4. 检查浏览器中不匹配问题的模拟（JavaScript解析模拟）
SELECT 
    name,
    CASE 
        WHEN pg_typeof(category_name) = 'text[]'::regtype THEN 
            array_to_json(category_name)::text
        ELSE 
            category_name::text
    END AS category_json,
    category_name
FROM web_navigation
WHERE name IN (
    'carrd', 'carrd_no_code',
    'bolt_new', 'bolt_new_no_code',
    'v0_dev', 'v0_dev_no_code'
)
ORDER BY name;

-- 5. 为WebNavCard组件生成额外的测试数据
-- 如有问题，确保这些测试记录有一致的格式
INSERT INTO web_navigation (name, title, url, category_name)
VALUES 
('test_array_category', 'Test Array Category', 'https://example.com/test1', ARRAY['web_dev', 'no_code']),
('test_string_category', 'Test String Category', 'https://example.com/test2', 'web_dev')
ON CONFLICT (name) DO UPDATE
SET category_name = EXCLUDED.category_name;

-- 6. 生成前端调试信息
SELECT 
    id,
    name,
    title,
    url,
    category_name,
    pg_typeof(category_name) AS db_type,
    CASE 
        WHEN pg_typeof(category_name) = 'text[]'::regtype THEN 
            array_to_json(category_name)::text
        ELSE 
            category_name::text
    END AS js_serialized,
    'console.log("' || name || '", ' || 
    CASE 
        WHEN pg_typeof(category_name) = 'text[]'::regtype THEN 
            array_to_json(category_name)::text
        ELSE 
            '["' || category_name || '"]'
    END || ');' AS debug_code
FROM web_navigation
WHERE name IN (
    'carrd', 'carrd_no_code',
    'bolt_new', 'bolt_new_no_code',
    'v0_dev', 'v0_dev_no_code',
    'test_array_category', 'test_string_category'
)
ORDER BY name;

-- 7. 解决方案：标准化所有分类为数组类型
UPDATE web_navigation
SET category_name = 
    CASE 
        WHEN category_name IS NULL THEN 
            '{}'::text[]
        WHEN pg_typeof(category_name) = 'text'::regtype THEN 
            string_to_array(category_name, ',')
        ELSE 
            category_name
    END;

-- 8. 验证修复结果
SELECT 
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE pg_typeof(category_name) = 'text[]'::regtype) AS array_records,
    COUNT(*) FILTER (WHERE pg_typeof(category_name) = 'text'::regtype) AS string_records,
    COUNT(*) FILTER (WHERE category_name IS NULL) AS null_records
FROM web_navigation;
