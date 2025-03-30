-- 验证网站分类映射
-- 此脚本查询网站-分类的对应关系，帮助诊断分类映射问题

-- 1. 检查数据库中网站和分类的基本情况
SELECT 'web_navigation表中总网站数量' AS description, COUNT(*) AS count
FROM web_navigation;

SELECT 'web_navigation表中有分类的网站数量' AS description, COUNT(*) AS count 
FROM web_navigation 
WHERE category_name IS NOT NULL AND array_length(category_name, 1) > 0;

SELECT 'web_navigation表中无分类的网站数量' AS description, COUNT(*) AS count 
FROM web_navigation 
WHERE category_name IS NULL OR array_length(category_name, 1) = 0;

-- 2. 检查每个分类下的网站数量
SELECT 
    cat AS category,
    COUNT(*) AS site_count
FROM (
    SELECT unnest(category_name) AS cat
    FROM web_navigation
    WHERE category_name IS NOT NULL
) AS cats
GROUP BY category
ORDER BY category;

-- 3. 检查特定关注的网站分类情况
SELECT 
    name,
    url,
    category_name
FROM web_navigation
WHERE name IN (
    'carrd', 'carrd_no_code',
    'bolt_new', 'bolt_new_no_code',
    'v0_dev', 'v0_dev_no_code'
)
ORDER BY name;

-- 4. 检查URL重复的网站
SELECT 
    url,
    array_agg(id) AS ids,
    array_agg(name) AS names,
    array_agg(category_name) AS categories
FROM web_navigation
GROUP BY url
HAVING COUNT(*) > 1
ORDER BY url;

-- 5. 检查每个分类包含的具体网站
SELECT 
    category,
    JSONB_AGG(
        JSONB_BUILD_OBJECT(
            'id', id,
            'name', name,
            'url', url
        )
    ) AS websites
FROM (
    SELECT 
        w.id,
        w.name,
        w.url,
        unnest(w.category_name) AS category
    FROM web_navigation w
    WHERE w.category_name IS NOT NULL
) AS cat_sites
GROUP BY category
ORDER BY category;

-- 6. 检查名称相似的网站对
WITH name_pairs AS (
    SELECT 
        a.id AS id_a, a.name AS name_a, a.category_name AS cats_a,
        b.id AS id_b, b.name AS name_b, b.category_name AS cats_b
    FROM web_navigation a
    JOIN web_navigation b 
    ON a.id < b.id 
    AND (
        (a.name LIKE '%' || b.name || '%') OR
        (b.name LIKE '%' || a.name || '%')
    )
    AND a.name != b.name
    ORDER BY a.name, b.name
)
SELECT * FROM name_pairs
LIMIT 100;

-- 7. 生成诊断报告：列出所有分类和其对应的网站
SELECT 
    jsonb_build_object(
        'category', category,
        'site_count', COUNT(*),
        'websites', jsonb_agg(name ORDER BY name)
    ) AS category_report
FROM (
    SELECT 
        unnest(category_name) AS category,
        name
    FROM web_navigation
    WHERE category_name IS NOT NULL
) AS subquery
GROUP BY category
ORDER BY category; 