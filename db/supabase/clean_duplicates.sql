-- 简化版脚本：删除重复记录并合并分类
-- 此脚本直接解决重复卡片问题

-- 安全措施：创建备份表
CREATE TABLE IF NOT EXISTS web_navigation_backup_clean AS 
SELECT * FROM web_navigation;

-- 第1步：查看并删除完全重复的记录（URL相同）
-- 先创建一个临时表，用于记录URL相同的记录组
CREATE TEMP TABLE duplicate_urls AS
SELECT url, array_agg(id) as ids, array_agg(name) as names
FROM web_navigation
GROUP BY url
HAVING COUNT(*) > 1;

-- 打印重复记录供查看
SELECT * FROM duplicate_urls;

-- 第2步：删除重复记录，保留ID最小的一条记录
-- 对于每个重复组，保留ID最小的记录
DO $$
DECLARE
    rec RECORD;
    to_keep BIGINT;
    to_delete BIGINT[];
BEGIN
    FOR rec IN SELECT * FROM duplicate_urls LOOP
        -- 选择要保留的ID（最小的ID）
        to_keep := (SELECT MIN(id) FROM unnest(rec.ids) AS id);
        
        -- 确定要删除的ID列表
        to_delete := array_remove(rec.ids, to_keep);
        
        -- 合并分类前先打印信息
        RAISE NOTICE '处理URL: %, 保留ID: %, 删除ID: %, 记录名称: %', 
                     rec.url, to_keep, to_delete, rec.names;
        
        -- 合并所有分类到保留记录
        UPDATE web_navigation a
        SET category_name = (
            SELECT array_agg(DISTINCT cat)
            FROM (
                SELECT unnest(b.category_name) AS cat
                FROM web_navigation b
                WHERE b.id = ANY(rec.ids)
            ) AS categories
        )
        WHERE a.id = to_keep;
        
        -- 删除多余记录
        DELETE FROM web_navigation
        WHERE id = ANY(to_delete);
    END LOOP;
END;
$$;

-- 第3步：处理名称相似的网站记录（例如：carrd 和 carrd_no_code）
-- 创建需要合并分类的配对表
CREATE TEMP TABLE similar_names AS
SELECT 
    a.id AS id_a, a.name AS name_a, 
    b.id AS id_b, b.name AS name_b
FROM web_navigation a
JOIN web_navigation b ON 
    a.id < b.id AND
    (
        (a.name = 'carrd' AND b.name = 'carrd_no_code') OR
        (a.name = 'bolt_new' AND b.name = 'bolt_new_no_code') OR
        (a.name = 'v0_dev' AND b.name = 'v0_dev_no_code')
    );

-- 打印结果查看
SELECT * FROM similar_names;

-- 第4步：合并名称相似记录的分类
DO $$
DECLARE
    rec RECORD;
    merged_categories TEXT[];
BEGIN
    FOR rec IN SELECT * FROM similar_names LOOP
        -- 合并两条记录的分类
        WITH combined_cats AS (
            SELECT DISTINCT unnest(a.category_name) AS cat
            FROM web_navigation a
            WHERE a.id IN (rec.id_a, rec.id_b)
        )
        SELECT array_agg(cat) INTO merged_categories FROM combined_cats;
        
        -- 更新两条记录的分类为合并后的结果
        UPDATE web_navigation
        SET category_name = merged_categories
        WHERE id IN (rec.id_a, rec.id_b);
        
        RAISE NOTICE '已合并记录分类: % 和 %, 合并后分类: %', 
                     rec.name_a, rec.name_b, merged_categories;
    END LOOP;
END;
$$;

-- 第5步：如果需要删除_no_code系列的冗余记录，可以取消下面代码的注释
/*
DELETE FROM web_navigation
WHERE name IN ('carrd_no_code', 'bolt_new_no_code', 'v0_dev_no_code');
*/

-- 第6步：确认重复记录已被清除
SELECT url, COUNT(*) 
FROM web_navigation
GROUP BY url
HAVING COUNT(*) > 1;

-- 第7步：确认每个分类下的网站数量
SELECT 
    category,
    COUNT(*) AS site_count
FROM (
    SELECT unnest(category_name) AS category
    FROM web_navigation
) AS cats
GROUP BY category
ORDER BY category;

-- 第8步：按分类显示所有网站
SELECT 
    cat AS category,
    array_agg(name) AS websites
FROM (
    SELECT 
        unnest(category_name) AS cat,
        name
    FROM web_navigation
) AS subquery
GROUP BY cat
ORDER BY cat;