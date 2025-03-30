/**
 * 分类处理辅助函数
 * 提供统一的分类数据格式化、验证和转换功能
 */

import { cachedQuery, createClient } from '../client';
import type { WebNavigation } from '../types';

/**
 * 规范化分类数组，处理数据库中不同格式的category_name
 * @param categories 原始分类数据（可能是字符串、数组或其他格式）
 * @returns 标准化后的字符串数组
 */
export function normalizeCategories(categories: any): string[] {
  try {
    // 空值处理
    if (!categories) return [];

    // 已经是数组，直接返回
    if (Array.isArray(categories)) return categories;

    // 字符串格式，尝试解析为数组
    if (typeof categories === 'string') {
      // 如果是JSON字符串，尝试解析
      if (categories.startsWith('[') && categories.endsWith(']')) {
        try {
          return JSON.parse(categories);
        } catch (e) {
          console.error('Failed to parse JSON categories:', categories);
          return [categories]; // 解析失败，作为单一元素数组返回
        }
      }
      // 普通字符串，按逗号分割
      return categories
        .split(',')
        .map((c) => c.trim())
        .filter(Boolean);
    }

    // 其他类型，尝试转为字符串后处理
    console.warn('Unknown category_name type:', typeof categories, categories);
    return [String(categories)];
  } catch (err) {
    console.error('分类处理错误:', err, categories);
    return [];
  }
}

/**
 * 通过分类名称获取网站列表
 * @param categoryCode 分类代码
 * @param pageSize 每页数量
 * @param pageIndex 页码（从0开始）
 * @returns 网站列表和总数
 */
export async function getWebsitesByCategory(
  categoryCode: string,
  pageSize: number = 20,
  pageIndex: number = 0,
): Promise<{
  items: WebNavigation[];
  total: number;
  categoryInfo?: any;
}> {
  // 使用缓存优化查询
  return cachedQuery(async () => {
    try {
      const supabase = createClient();
      const from = pageIndex * pageSize;
      const to = from + pageSize - 1;

      // 获取分类信息
      const { data: categoryList } = await supabase.from('navigation_category').select().eq('name', categoryCode);

      // 尝试多种查询方法获取匹配的网站
      // 首先尝试contains方法（最可靠）
      const { data: items, count } = await supabase
        .from('web_navigation')
        .select('*', { count: 'exact' })
        .contains('category_name', [categoryCode])
        .range(from, to);

      if (items && items.length > 0) {
        console.log(`分类[${categoryCode}]使用contains方法查询成功`);
        return {
          items: items.map((item) => ({
            ...item,
            category_name: normalizeCategories(item.category_name),
          })),
          total: count || 0,
          categoryInfo: categoryList?.[0],
        };
      }

      // 如果contains失败，尝试ANY操作符
      const { data: anyItems, count: anyCount } = await supabase
        .from('web_navigation')
        .select('*', { count: 'exact' })
        .or(`${categoryCode}=ANY(category_name)`)
        .range(from, to);

      if (anyItems && anyItems.length > 0) {
        console.log(`分类[${categoryCode}]使用ANY操作符查询成功`);
        return {
          items: anyItems.map((item) => ({
            ...item,
            category_name: normalizeCategories(item.category_name),
          })),
          total: anyCount || 0,
          categoryInfo: categoryList?.[0],
        };
      }

      // 最后尝试字符串匹配（不太可靠但作为备选）
      const { data: likeItems, count: likeCount } = await supabase
        .from('web_navigation')
        .select('*', { count: 'exact' })
        .or(`category_name::text ilike '%${categoryCode}%'`)
        .range(from, to);

      return {
        items: (likeItems || []).map((item) => ({
          ...item,
          category_name: normalizeCategories(item.category_name),
        })),
        total: likeCount || 0,
        categoryInfo: categoryList?.[0],
      };
    } catch (err) {
      console.error('获取分类网站失败:', err);
      return { items: [], total: 0 };
    }
  }, `category_${categoryCode}_page${pageIndex}_size${pageSize}`);
}

/**
 * 获取所有可用分类
 * @returns 分类列表
 */
export async function getAllCategories() {
  return cachedQuery(async () => {
    const supabase = createClient();
    const { data, error } = await supabase.from('navigation_category').select('*').order('sort', { ascending: true });

    if (error) {
      console.error('获取分类列表失败:', error);
      return [];
    }

    return data || [];
  }, 'all_categories');
}
