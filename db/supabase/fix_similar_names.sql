-- 处理名称相似但保留不同记录的情况
-- 此脚本用于处理名称相似的网站记录，合并它们的分类属性

-- 步骤1: 查找名称相似的记录对
SELECT 
    a.id as id_a, a.name as name_a, a.url as url_a, a.category_name as categories_a,
    b.id as id_b, b.name as name_b, b.url as url_b, b.category_name as categories_b
FROM web_navigation a
JOIN web_navigation b ON 
    a.id <> b.id AND
    (
        -- 名称相似的匹配条件
        (a.name = 'carrd' AND b.name = 'carrd_no_code') OR
        (a.name = 'carrd_no_code' AND b.name = 'carrd') OR
        (a.name = 'bolt_new' AND b.name = 'bolt_new_no_code') OR
        (a.name = 'bolt_new_no_code' AND b.name = 'bolt_new') OR
        (a.name = 'v0_dev' AND b.name = 'v0_dev_no_code') OR
        (a.name = 'v0_dev_no_code' AND b.name = 'v0_dev')
    );

-- 步骤2: 合并carrd和carrd_no_code的分类
-- 将carrd_no_code的分类合并到carrd
UPDATE web_navigation a
SET category_name = (
    SELECT array_agg(DISTINCT category)
    FROM (
        SELECT unnest(a.category_name) as category
        UNION
        SELECT unnest(b.category_name) as category
    ) as combined_categories
)
FROM web_navigation b
WHERE a.name = 'carrd' AND b.name = 'carrd_no_code';

-- 将carrd的分类合并到carrd_no_code
UPDATE web_navigation a
SET category_name = (
    SELECT array_agg(DISTINCT category)
    FROM (
        SELECT unnest(a.category_name) as category
        UNION
        SELECT unnest(b.category_name) as category
    ) as combined_categories
)
FROM web_navigation b
WHERE a.name = 'carrd_no_code' AND b.name = 'carrd';

-- 步骤3: 合并bolt_new和bolt_new_no_code的分类
-- 将bolt_new_no_code的分类合并到bolt_new
UPDATE web_navigation a
SET category_name = (
    SELECT array_agg(DISTINCT category)
    FROM (
        SELECT unnest(a.category_name) as category
        UNION
        SELECT unnest(b.category_name) as category
    ) as combined_categories
)
FROM web_navigation b
WHERE a.name = 'bolt_new' AND b.name = 'bolt_new_no_code';

-- 将bolt_new的分类合并到bolt_new_no_code
UPDATE web_navigation a
SET category_name = (
    SELECT array_agg(DISTINCT category)
    FROM (
        SELECT unnest(a.category_name) as category
        UNION
        SELECT unnest(b.category_name) as category
    ) as combined_categories
)
FROM web_navigation b
WHERE a.name = 'bolt_new_no_code' AND b.name = 'bolt_new';

-- 步骤4: 合并v0_dev和v0_dev_no_code的分类
-- 将v0_dev_no_code的分类合并到v0_dev
UPDATE web_navigation a
SET category_name = (
    SELECT array_agg(DISTINCT category)
    FROM (
        SELECT unnest(a.category_name) as category
        UNION
        SELECT unnest(b.category_name) as category
    ) as combined_categories
)
FROM web_navigation b
WHERE a.name = 'v0_dev' AND b.name = 'v0_dev_no_code';

-- 将v0_dev的分类合并到v0_dev_no_code
UPDATE web_navigation a
SET category_name = (
    SELECT array_agg(DISTINCT category)
    FROM (
        SELECT unnest(a.category_name) as category
        UNION
        SELECT unnest(b.category_name) as category
    ) as combined_categories
)
FROM web_navigation b
WHERE a.name = 'v0_dev_no_code' AND b.name = 'v0_dev';

-- 步骤5: 可选 - 删除冗余的_no_code记录
-- 如果想保留原始记录，可以注释掉此部分
/*
DELETE FROM web_navigation
WHERE name IN ('carrd_no_code', 'bolt_new_no_code', 'v0_dev_no_code');
*/

-- 步骤6: 验证结果 - 检查所有网站的分类是否已合并
SELECT name, url, category_name 
FROM web_navigation
WHERE name IN ('carrd', 'carrd_no_code', 'bolt_new', 'bolt_new_no_code', 'v0_dev', 'v0_dev_no_code')
ORDER BY name;