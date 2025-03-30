-- 规范化category_name字段格式
-- 此脚本用于修复web_navigation表中category_name字段的不一致格式问题

-- 步骤1: 创建备份表
CREATE TABLE IF NOT EXISTS web_navigation_backup AS SELECT * FROM web_navigation;

-- 步骤2: 规范化category_name格式

-- 处理格式如 ["data_research"] 的情况
UPDATE web_navigation
SET category_name = ARRAY[replace(replace(replace(category_name[1]::text, '"', ''), '[', ''), ']', '')]
WHERE array_length(category_name, 1) = 1 
  AND category_name[1]::text LIKE '["%"]' 
  AND category_name[1] NOT LIKE '%,%';

-- 处理格式如 ["category1","category2"] 的情况
UPDATE web_navigation
SET category_name = string_to_array(replace(replace(replace(category_name[1]::text, '"', ''), '[', ''), ']', ''), ',')
WHERE array_length(category_name, 1) = 1 
  AND category_name[1]::text LIKE '["%' 
  AND category_name[1]::text LIKE '%,%';

-- 处理格式如 ["web_dev","no_code"] 的情况（正确格式，跳过或清理引号）
UPDATE web_navigation
SET category_name = array_remove(category_name, '')
WHERE array_position(category_name, '') IS NOT NULL;

-- 处理空数组或NULL的情况
UPDATE web_navigation
SET category_name = ARRAY['other']
WHERE array_length(category_name, 1) = 0 OR category_name IS NULL;

-- 步骤3: 为特定工具设置多分类（可选）
-- 为web_dev工具添加no_code分类
UPDATE web_navigation
SET category_name = array_append(category_name, 'no_code')
WHERE 'web_dev' = ANY(category_name) 
  AND name IN ('carrd', 'bolt_new', 'v0_dev')
  AND NOT ('no_code' = ANY(category_name));

-- 为no_code工具添加web_dev分类
UPDATE web_navigation
SET category_name = array_append(category_name, 'web_dev')
WHERE 'no_code' = ANY(category_name) 
  AND NOT ('web_dev' = ANY(category_name));

-- 步骤4: 验证结果
SELECT id, name, category_name FROM web_navigation ORDER BY id LIMIT 50; 