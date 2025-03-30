-- 重置所有网站的分类关系
-- 此脚本根据图示确保每个网站卡片都归属于正确的分类

-- 创建备份
CREATE TABLE IF NOT EXISTS web_navigation_backup_mapping AS 
SELECT * FROM web_navigation;

-- 1. 先清除所有卡片的分类关系（如果需要完全重置）
-- UPDATE web_navigation SET category_name = NULL;

-- 2. 根据图示设置每个网站的分类关系
-- 域名查询相关网站
UPDATE web_navigation
SET category_name = ARRAY['domain_search']
WHERE name IN (
    'lean_domain_search', 
    'query_domains', 
    'instant_domain_search'
) OR (url LIKE '%domain%search%' AND category_name IS NULL);

-- 域名注册相关网站
UPDATE web_navigation
SET category_name = ARRAY['domain_register']
WHERE name IN (
    'spaceship', 
    'porkbun', 
    'namecheap'
) OR (url LIKE '%domain%register%' AND category_name IS NULL);

-- 网站开发相关网站（不包括无代码工具）
UPDATE web_navigation
SET category_name = ARRAY['web_dev']
WHERE name IN (
    'vercel_templates', 
    'supabase', 
    'builtwith',
    'bolt_new',
    'v0_dev',
    'carrd'
) AND NOT ('no_code' = ANY(category_name));

-- 网站托管相关网站
UPDATE web_navigation
SET category_name = ARRAY['web_hosting']
WHERE name IN (
    'cloudflare', 
    'vercel_hosting'
) OR (url LIKE '%host%' AND category_name IS NULL);

-- 数据后台相关网站
UPDATE web_navigation
SET category_name = ARRAY['data_analytics']
WHERE name IN (
    'google_search_console', 
    'google_analytics', 
    'bing_webmaster'
) OR (
    (url LIKE '%analytics%' OR url LIKE '%console%' OR url LIKE '%webmaster%') 
    AND category_name IS NULL
);

-- 数据查询相关网站
UPDATE web_navigation
SET category_name = ARRAY['data_research']
WHERE name IN (
    'aitdk', 
    'semrush', 
    'search_suggest', 
    'google_trends', 
    'ahrefs_app', 
    'toolify', 
    'ahrefs_keyword'
) OR (
    (url LIKE '%research%' OR url LIKE '%trends%' OR url LIKE '%ahrefs%') 
    AND category_name IS NULL
);

-- 无代码开发相关网站
UPDATE web_navigation
SET category_name = ARRAY['no_code']
WHERE name IN (
    'carrd_no_code', 
    'bolt_new_no_code', 
    'v0_dev_no_code'
) OR name LIKE '%nocode%';

-- 3. 特别处理既属于web_dev又属于no_code的网站
UPDATE web_navigation
SET category_name = ARRAY['web_dev', 'no_code']
WHERE name IN ('carrd', 'bolt_new', 'v0_dev');

-- 4. 合并所有名称相似的记录分类
DO $$
DECLARE
    similar_pairs TEXT[][] := ARRAY[
        ARRAY['carrd', 'carrd_no_code'],
        ARRAY['bolt_new', 'bolt_new_no_code'],
        ARRAY['v0_dev', 'v0_dev_no_code']
    ];
    pair TEXT[];
    merged_categories TEXT[];
BEGIN
    FOREACH pair SLICE 1 IN ARRAY similar_pairs LOOP
        -- 获取合并后的分类数组
        WITH combined_cats AS (
            SELECT DISTINCT unnest(category_name) AS cat
            FROM web_navigation
            WHERE name IN (pair[1], pair[2])
        )
        SELECT array_agg(cat) INTO merged_categories FROM combined_cats;
        
        -- 更新两条记录
        UPDATE web_navigation
        SET category_name = merged_categories
        WHERE name IN (pair[1], pair[2]);
        
        RAISE NOTICE '合并了 % 和 % 的分类: %', pair[1], pair[2], merged_categories;
    END LOOP;
END;
$$;

-- 5. 可选：删除重复记录（保留ID较小的）
DO $$
DECLARE
    rec RECORD;
    primary_id BIGINT;
    secondary_id BIGINT;
BEGIN
    FOR rec IN (
        SELECT a.id AS id1, b.id AS id2
        FROM web_navigation a
        JOIN web_navigation b ON a.url = b.url AND a.id < b.id
    ) LOOP
        primary_id := rec.id1;
        secondary_id := rec.id2;
        
        -- 合并分类
        UPDATE web_navigation a
        SET category_name = (
            SELECT array_agg(DISTINCT cat)
            FROM (
                SELECT unnest(a.category_name) AS cat
                FROM web_navigation a
                WHERE a.id IN (primary_id, secondary_id)
            ) AS cats
        )
        WHERE id = primary_id;
        
        -- 删除重复记录
        DELETE FROM web_navigation WHERE id = secondary_id;
        
        RAISE NOTICE '删除了重复记录 ID=%，保留了ID=%', secondary_id, primary_id;
    END LOOP;
END;
$$;

-- 6. 验证各分类下网站数量
SELECT 
    category,
    COUNT(*) AS site_count
FROM (
    SELECT unnest(category_name) AS category
    FROM web_navigation
) AS cats
GROUP BY category
ORDER BY category;

-- 7. 显示每个分类下的所有网站
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