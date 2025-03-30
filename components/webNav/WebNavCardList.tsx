import type { WebNavigation } from '@/db/supabase/types';
import { useTranslations } from 'next-intl';

import WebNavCard from './WebNavCard';

/**
 * 网站导航卡片列表组件
 * @param {Object} props - 组件属性
 * @param {WebNavigation[]} props.dataList - 导航数据列表
 * @returns {JSX.Element} 网站导航卡片列表组件
 */
export default function WebNavCardList({ dataList }: { dataList: WebNavigation[] }) {
  const t = useTranslations('Home');

  if (!dataList || dataList.length === 0) {
    return (
      <div className='flex items-center justify-center py-8'>
        <p className='text-gray-400'>{t('empty')}</p>
      </div>
    );
  }

  return (
    <div className='grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4 lg:gap-4'>
      {dataList.map((item) => (
        <WebNavCard
          key={item.id}
          id={item.id}
          name={item.name}
          title={item.title}
          url={item.url}
          content={item.content}
          detail={item.detail}
          image_url={item.image_url}
          thumbnail_url={item.thumbnail_url}
          website_data={item.website_data}
          collection_time={item.collection_time}
          star_rating={item.star_rating}
          tag_name={item.tag_name}
          category_name={item.category_name}
        />
      ))}
    </div>
  );
}
