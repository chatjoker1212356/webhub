/* eslint-disable import/prefer-default-export */

import { createClient as createSupabaseClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

// 防抖查询缓存, 减少重复请求
const queryCache: Record<
  string,
  {
    timestamp: number;
    result: any;
  }
> = {};

// 缓存有效期（5分钟）
const CACHE_TTL = 5 * 60 * 1000;

// 防抖查询函数
export async function cachedQuery(queryFn: () => Promise<any>, cacheKey: string, ttl: number = CACHE_TTL) {
  // 检查缓存
  const cachedResult = queryCache[cacheKey];
  const now = Date.now();

  if (cachedResult && now - cachedResult.timestamp < ttl) {
    console.log(`[缓存] 使用缓存结果: ${cacheKey}`);
    return cachedResult.result;
  }

  // 执行查询
  console.log(`[缓存] 查询并缓存: ${cacheKey}`);
  const result = await queryFn();

  // 存入缓存
  queryCache[cacheKey] = {
    timestamp: now,
    result,
  };

  return result;
}

// 清理过期缓存
export function cleanupCache() {
  const now = Date.now();
  Object.keys(queryCache).forEach((key) => {
    if (now - queryCache[key].timestamp > CACHE_TTL) {
      delete queryCache[key];
    }
  });
}

// 每10分钟自动清理一次缓存
if (typeof window !== 'undefined') {
  setInterval(cleanupCache, 10 * 60 * 1000);
}

export function createClient() {
  return createSupabaseClient(supabaseUrl, supabaseKey);
}
