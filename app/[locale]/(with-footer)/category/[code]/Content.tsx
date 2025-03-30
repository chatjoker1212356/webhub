/* eslint-disable react/jsx-props-no-spreading */

'use client';

import { useEffect, useState } from 'react';
import { WebNavigation } from '@/db/supabase/types';
import { useTranslations } from 'next-intl';

import Empty from '@/components/Empty';
import ExploreBreadcrumb from '@/components/explore/ExploreBreadcrumb';
import BasePagination from '@/components/page/BasePagination';
import WebNavCard from '@/components/webNav/WebNavCard';

export default function Content({
  headerTitle,
  navigationList,
  currentPage,
  total,
  pageSize,
  route,
}: {
  headerTitle: string;
  navigationList: WebNavigation[];
  currentPage: number;
  total: number;
  pageSize: number;
  route: string;
}) {
  const t = useTranslations('Category');
  const [isLoaded, setIsLoaded] = useState(false);
  const [items, setItems] = useState<WebNavigation[]>([]);

  useEffect(() => {
    if (navigationList && navigationList.length > 0) {
      console.log(`分类[${headerTitle}]加载了${navigationList.length}个项目`);
      const processedItems = navigationList.map((item) => {
        let formattedCategory: string[] = [];
        if (Array.isArray(item.category_name)) {
          formattedCategory = item.category_name;
        } else if (item.category_name) {
          formattedCategory = [item.category_name as string];
        }
        return {
          ...item,
          category_name: formattedCategory,
        };
      });
      setItems(processedItems);
    } else {
      console.log(`分类[${headerTitle}]未找到项目`);
      setItems([]);
    }
    setIsLoaded(true);
  }, [navigationList, headerTitle]);

  return (
    <>
      <div className='mx-auto flex flex-col gap-3 py-5 lg:pt-10'>
        <h1 className='text-center text-[28px] font-bold lg:text-5xl'>{headerTitle}</h1>
        <div className='mx-auto'>
          <ExploreBreadcrumb
            linkList={[
              {
                href: '/',
                title: t('home'),
              },
              {
                title: headerTitle,
                isLast: true,
              },
            ]}
          />
        </div>
      </div>
      <div className='mt-3'>
        {(() => {
          if (!isLoaded) {
            return (
              <div className='flex items-center justify-center py-10'>
                <div className='flex animate-pulse flex-col items-center'>
                  <div className='mb-2 h-4 w-28 rounded bg-gray-700' />
                  <div className='h-2 w-20 rounded bg-gray-600' />
                </div>
              </div>
            );
          }

          if (!items || items.length === 0) {
            return (
              <div className='mb-3 lg:mb-5'>
                <Empty title={t('empty')} />
              </div>
            );
          }

          return (
            <>
              <div className='grid grid-cols-2 gap-3 lg:grid-cols-4 lg:gap-4'>
                {items.map((item) => (
                  <WebNavCard key={item.id} {...item} />
                ))}
              </div>
              <div className='my-5 flex items-center justify-center lg:my-10'>
                <BasePagination
                  currentPage={currentPage}
                  total={total}
                  pageSize={pageSize}
                  route={route}
                  subRoute='/page'
                />
              </div>
            </>
          );
        })()}
      </div>
    </>
  );
}
