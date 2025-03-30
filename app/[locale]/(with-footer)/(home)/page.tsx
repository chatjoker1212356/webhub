import { Metadata } from 'next';
import dynamic from 'next/dynamic';
import Link from 'next/link';
import { createClient } from '@/db/supabase/client';
import { CircleChevronRight } from 'lucide-react';
import { getTranslations } from 'next-intl/server';

import { RevalidateOneHour } from '@/lib/constants';
import SearchForm from '@/components/home/SearchForm';
import WebNavCardList from '@/components/webNav/WebNavCardList';

import { TagList } from './Tag';

const ScrollToTop = dynamic(() => import('@/components/page/ScrollToTop'), { ssr: false });

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  const t = await getTranslations({
    locale,
    namespace: 'Metadata.home',
  });

  return {
    metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL as string),
    title: t('title'),
    description: t('description'),
    keywords: t('keywords'),
    alternates: {
      canonical: './',
    },
  };
}

export const revalidate = RevalidateOneHour;

export default async function Page() {
  const supabase = createClient();
  const t = await getTranslations('Home');

  // 确保在服务器端获取完整的数据
  const [{ data: categoryList }, { data: navigationList }] = await Promise.all([
    supabase.from('navigation_category').select(),
    supabase.from('web_navigation').select('*').order('collection_time', { ascending: false }).limit(12),
  ]);

  return (
    <div className='relative w-full'>
      <div className='relative mx-auto w-full max-w-pc flex-1 px-3 lg:px-0'>
        {/* 头部区域 */}
        <div className='my-5 flex flex-col text-center lg:mx-auto lg:my-10 lg:gap-1'>
          <h1 className='text-2xl font-bold text-white lg:text-5xl'>{t('title')}</h1>
          <h2 className='text-balance text-xs font-bold text-white lg:text-sm'>{t('subTitle')}</h2>
        </div>

        {/* 搜索区域 */}
        <div className='flex w-full items-center justify-center'>
          <SearchForm />
        </div>

        {/* 分类标签区域 */}
        <div className='my-4'>
          <TagList
            data={categoryList!.map((item) => ({
              id: String(item.id),
              name: item.name,
              href: `/category/${item.name}`,
            }))}
          />
        </div>

        {/* 工具列表区域 */}
        <div className='flex flex-col gap-5 rounded-2xl bg-gray-900 p-6 shadow-lg'>
          <h2 className='mb-4 text-center text-2xl font-bold text-white'>{t('ai-navigate')}</h2>

          {/* 工具卡片列表 */}
          {navigationList && navigationList.length > 0 ? (
            <WebNavCardList dataList={navigationList} />
          ) : (
            <div className='flex items-center justify-center py-10'>
              <p className='text-gray-400'>正在加载工具列表...</p>
            </div>
          )}

          {/* 更多工具按钮 */}
          <Link
            href='/explore'
            className='mx-auto mb-2 mt-6 flex w-fit items-center justify-center gap-3 rounded-xl bg-blue-700 px-6 py-3 font-medium text-white shadow-md transition-colors hover:bg-blue-600'
          >
            {t('exploreMore')}
            <CircleChevronRight className='h-5 w-5' />
          </Link>
        </div>

        <ScrollToTop />
      </div>
    </div>
  );
}
