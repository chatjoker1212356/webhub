-- 执行所有修复脚本
-- 此脚本按顺序执行所有修复分类映射问题的脚本

-- 安全措施：创建总体备份表
CREATE TABLE IF NOT EXISTS web_navigation_backup_complete AS 
SELECT * FROM web_navigation;

-- 步骤1：运行验证脚本，查看当前状态
\i verify_categories.sql

-- 步骤2：调试并修复category_name的格式问题（确保一致是数组类型）
\i debug_browser_card_issue.sql

-- 步骤3：重置所有网站分类映射
\i reset_category_mapping.sql

-- 步骤4：清理重复记录
\i clean_duplicates.sql

-- 步骤5：再次验证分类映射是否正确
\i verify_categories.sql

-- 步骤6：完成后的提示
SELECT 'Category mapping reset and cleanup completed successfully.' AS result; 