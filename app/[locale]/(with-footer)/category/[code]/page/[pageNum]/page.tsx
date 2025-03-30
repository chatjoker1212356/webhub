/* eslint-disable react/jsx-props-no-spreading */

import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { createClient } from '@/db/supabase/client';

import { InfoPageSize, RevalidateOneHour } from '@/lib/constants';

import Content from '../../Content';

export const revalidate = RevalidateOneHour * 6;

export async function generateMetadata({ params }: { params: { code: string; pageNum?: string } }): Promise<Metadata> {
  const supabase = createClient();
  const { data: categoryList } = await supabase.from('navigation_category').select().eq('name', params.code);

  if (!categoryList || !categoryList[0]) {
    notFound();
  }

  return {
    title: categoryList[0].title,
  };
}

export default async function Page({ params }: { params: { code: string; pageNum: string } }) {
  const supabase = createClient();
  // 处理页码
  const pageNum = Number(params.pageNum) || 1;
  const offset = (pageNum - 1) * InfoPageSize;

  // 添加调试日志
  console.log('分页页面 - 查询分类:', params.code, '页码:', pageNum);

  // 获取分类信息
  const { data: categoryList } = await supabase.from('navigation_category').select().eq('name', params.code);

  if (!categoryList || !categoryList[0]) {
    notFound();
  }

  // 尝试方法1: 使用ANY操作符 (推荐的PostgreSQL数组查询方式)
  const {
    data: data1,
    count: count1,
    error: error1,
  } = await supabase
    .from('web_navigation')
    .select('*', { count: 'exact' })
    .or(`${params.code}=ANY(category_name)`)
    .range(offset, offset + InfoPageSize - 1);

  console.log('分页查询方法1结果:', { count: count1, error: error1 });

  // 尝试方法2: 使用数组包含操作符
  const {
    data: data2,
    count: count2,
    error: error2,
  } = await supabase
    .from('web_navigation')
    .select('*', { count: 'exact' })
    .contains('category_name', [params.code])
    .range(offset, offset + InfoPageSize - 1);

  console.log('分页查询方法2结果:', { count: count2, error: error2 });

  // 尝试方法3: 使用字符串匹配 (不推荐，但可作为备选)
  const {
    data: data3,
    count: count3,
    error: error3,
  } = await supabase
    .from('web_navigation')
    .select('*', { count: 'exact' })
    .or(`category_name::text ilike '%${params.code}%'`)
    .range(offset, offset + InfoPageSize - 1);

  console.log('分页查询方法3结果:', { count: count3, error: error3 });

  // 选择有结果的查询方法
  let navigationList = data1;
  let count = count1;

  if (!navigationList || navigationList.length === 0) {
    navigationList = data2;
    count = count2;
  }

  if (!navigationList || navigationList.length === 0) {
    navigationList = data3;
    count = count3;
  }

  return (
    <Content
      headerTitle={categoryList[0]!.title || params.code}
      navigationList={navigationList || []}
      currentPage={pageNum}
      total={count || 0}
      pageSize={InfoPageSize}
      route={`/category/${params.code}`}
    />
  );
}
