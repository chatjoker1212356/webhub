-- 删除web_navigation表中的重复网页
-- 此脚本用于识别和删除重复的网站卡片，保留多分类关系

-- 步骤1: 创建临时备份表(安全措施)
CREATE TABLE IF NOT EXISTS web_navigation_backup_before_dedup AS 
SELECT * FROM web_navigation;

-- 步骤2: 查看重复的URL记录
SELECT url, COUNT(*) as duplicate_count, array_agg(name) as names, array_agg(id) as ids
FROM web_navigation
GROUP BY url
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 步骤3: 查看重复的名称记录
SELECT LOWER(name) as lowercase_name, COUNT(*) as duplicate_count, array_agg(name) as names, array_agg(id) as ids
FROM web_navigation
GROUP BY LOWER(name)
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 步骤4: 合并重复记录的分类(如carrd, carrd_no_code等)
-- 创建临时表存储需要合并的记录
CREATE TEMP TABLE duplicates_to_merge AS
WITH duplicate_urls AS (
    SELECT url, array_agg(id) as ids, array_agg(name) as names, array_agg(category_name) as categories
    FROM web_navigation
    GROUP BY url
    HAVING COUNT(*) > 1
)
SELECT * FROM duplicate_urls;

-- 步骤5: 针对每组重复记录，合并分类并保留一条记录
DO $$
DECLARE
    rec RECORD;
    merged_categories TEXT[];
    primary_id BIGINT;
    secondary_ids BIGINT[];
BEGIN
    FOR rec IN SELECT * FROM duplicates_to_merge LOOP
        -- 选择第一个ID作为主记录
        primary_id := (rec.ids)[1];
        secondary_ids := rec.ids[2:array_length(rec.ids, 1)];
        
        -- 合并所有分类到一个数组(去重)
        WITH all_categories AS (
            SELECT DISTINCT unnest(category) as cat
            FROM (
                SELECT unnest(c) as category
                FROM unnest(rec.categories) c
            ) subcategories
        )
        SELECT array_agg(cat) INTO merged_categories FROM all_categories;
        
        -- 更新主记录的分类
        UPDATE web_navigation
        SET category_name = merged_categories
        WHERE id = primary_id;
        
        -- 删除次要记录
        DELETE FROM web_navigation
        WHERE id = ANY(secondary_ids);
        
        RAISE NOTICE 'Merged duplicates for URL %: primary_id=%, removed_ids=%, merged_categories=%', 
                     rec.url, primary_id, secondary_ids, merged_categories;
    END LOOP;
END;
$$;

-- 步骤6: 处理名称相似但URL不同的情况(如carrd和carrd_no_code)
-- 这些可能是故意设计的多个实例，先查看再决定是否合并
SELECT 
    a.id as id_a, a.name as name_a, a.url as url_a, a.category_name as categories_a,
    b.id as id_b, b.name as name_b, b.url as url_b, b.category_name as categories_b
FROM web_navigation a
JOIN web_navigation b ON 
    (LOWER(a.name) LIKE LOWER(b.name) || '%' OR LOWER(b.name) LIKE LOWER(a.name) || '%')
    AND a.id < b.id
    AND a.url <> b.url
ORDER BY a.name;

-- 步骤7: 根据上面的查询结果，手动决定是否合并特定记录
-- 例如合并carrd和carrd_no_code的分类，但保留两条记录
-- 示例:
/*
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
*/

-- 步骤8: 验证结果
SELECT url, COUNT(*) 
FROM web_navigation
GROUP BY url
HAVING COUNT(*) > 1;

-- 完成后执行以下查询验证每个分类下的网站数量
SELECT 
    cat, 
    COUNT(*) as website_count
FROM (
    SELECT unnest(category_name) as cat
    FROM web_navigation
) as categories
GROUP BY cat
ORDER BY website_count DESC; 