/* eslint-disable react/jsx-props-no-spreading */

import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { getWebsitesByCategory } from '@/db/supabase/helper/category_helper';

import { InfoPageSize, RevalidateOneHour } from '@/lib/constants';

import Content from './Content';

// 降低缓存时间，使页面更快反映数据变化
export const revalidate = RevalidateOneHour * 1;

export async function generateMetadata({ params }: { params: { code: string } }): Promise<Metadata> {
  const { categoryInfo } = await getWebsitesByCategory(params.code, 1);

  if (!categoryInfo) {
    notFound();
  }

  return {
    title: categoryInfo.title,
  };
}

export default async function Page({ params }: { params: { code: string } }) {
  console.log('分类页面加载:', params.code);

  // 使用统一的辅助函数获取数据
  const { items, total, categoryInfo } = await getWebsitesByCategory(params.code, InfoPageSize);

  if (!categoryInfo) {
    notFound();
  }

  return (
    <Content
      headerTitle={categoryInfo.title || params.code}
      navigationList={items}
      currentPage={1}
      total={total}
      pageSize={InfoPageSize}
      route={`/category/${params.code}`}
    />
  );
}
