import { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { createClient } from '@/db/supabase/client';
import { CircleArrowRight, ExternalLink, Globe } from 'lucide-react';
import { getTranslations } from 'next-intl/server';

import { Separator } from '@/components/ui/separator';
import BaseImage from '@/components/image/BaseImage';
import MarkdownProse from '@/components/MarkdownProse';

/**
 * 获取网站域名的函数
 * @param url 网站URL
 * @returns 网站域名
 */
const getDomain = (url: string) => {
  try {
    const domain = new URL(url).hostname.replace('www.', '');
    return domain;
  } catch (e) {
    return url;
  }
};

export async function generateMetadata({
  params: { locale, websiteName },
}: {
  params: { locale: string; websiteName: string };
}): Promise<Metadata> {
  const supabase = createClient();
  const t = await getTranslations({
    locale,
    namespace: 'Metadata.ai',
  });
  const { data } = await supabase.from('web_navigation').select().eq('name', websiteName);

  if (!data || !data[0]) {
    notFound();
  }

  return {
    title: `${data[0].title} | ${t('titleSubfix')}`,
    description: data[0].content,
  };
}

export default async function Page({
  params: { websiteName, locale },
}: {
  params: { websiteName: string; locale: string };
}) {
  const supabase = createClient();
  const t = await getTranslations('Startup.detail');
  const { data: dataList } = await supabase.from('web_navigation').select().eq('name', websiteName);
  if (!dataList) {
    notFound();
  }
  const data = dataList[0];
  const domain = getDomain(data.url);
  const isEnglish = locale === 'en';

  // 默认介绍文本
  const defaultIntroTitle = isEnglish ? `Introduction to ${data.title}` : `${data.title} 介绍`;
  const defaultIntroText = isEnglish
    ? `${domain} is a comprehensive website building tool that provides users with rich features to create and manage websites. Whether you're a beginner or a professional developer, you can easily complete website building tasks with this tool.`
    : `${domain} 是一个专注于网站建设的工具，为用户提供了丰富的功能来创建和管理网站。无论您是初学者还是专业开发人员，都能通过这个工具轻松完成网站构建任务。`;
  const visitButtonText = isEnglish ? `Visit ${domain}` : `访问 ${domain}`;
  const imageLoadingText = isEnglish ? 'Website preview image not loaded' : '网站预览图片暂未加载';

  return (
    <div className='w-full'>
      <div className='flex flex-col px-6 py-5 lg:h-[323px] lg:flex-row lg:justify-between lg:px-0 lg:py-10'>
        <div className='flex flex-col items-center lg:items-start'>
          <div className='space-y-1 text-balance lg:space-y-3'>
            <h1 className='text-2xl lg:text-5xl'>{data.title}</h1>
            <div className='mb-3 flex items-center gap-2 text-sm text-blue-300'>
              <Globe className='size-4' />
              <a href={data.url} target='_blank' rel='noreferrer' className='flex items-center gap-1 hover:underline'>
                {domain} <ExternalLink className='size-3' />
              </a>
            </div>
            <h2 className='text-xs lg:text-sm'>{data.content}</h2>
          </div>
          <a
            href={data.url}
            target='_blank'
            rel='noreferrer'
            className='flex-center mt-5 min-h-5 w-full gap-1 rounded-[8px] bg-white p-[10px] text-sm capitalize text-black hover:opacity-80 lg:mt-auto lg:w-[288px]'
          >
            {t('visitWebsite')} <CircleArrowRight className='size-[14px]' />
          </a>
        </div>
        <a
          href={data.url}
          target='_blank'
          rel='noreferrer'
          className='flex-center group relative h-[171px] w-full flex-shrink-0 lg:h-[234px] lg:w-[466px]'
        >
          {data.thumbnail_url ? (
            <>
              <BaseImage
                title={data.title}
                alt={data.title}
                fill
                src={data.thumbnail_url}
                className='absolute mt-3 aspect-[466/234] w-full rounded-[16px] border border-[#424242] bg-[#424242] bg-cover lg:mt-0'
              />
              <div className='absolute inset-0 z-10 hidden items-center justify-center gap-1 rounded-[16px] bg-black bg-opacity-50 text-2xl text-white transition-all duration-200 group-hover:flex'>
                {t('visitWebsite')} <CircleArrowRight className='size-5' />
              </div>
            </>
          ) : (
            <div className='flex h-full w-full items-center justify-center rounded-[16px] border border-[#424242] bg-gray-800'>
              <div className='flex flex-col items-center justify-center p-4 text-center'>
                <Globe className='mb-3 size-16 text-white' />
                <span className='text-xl font-medium text-white'>{domain}</span>
                <p className='mt-2 text-sm text-gray-400'>{imageLoadingText}</p>
              </div>
            </div>
          )}
        </a>
      </div>
      <Separator className='bg-[#010101]' />
      <div className='mb-5 px-3 lg:px-0'>
        <h2 className='my-5 text-2xl text-white/80 lg:my-10'>{t('introduction')}</h2>
        {data.detail ? (
          <MarkdownProse markdown={data.detail} />
        ) : (
          <div className='rounded-lg bg-gray-900 p-6'>
            <h3 className='mb-4 text-xl font-medium'>{defaultIntroTitle}</h3>
            <p className='mb-4 text-gray-300'>{data.content}</p>
            <p className='mb-4 text-gray-300'>{defaultIntroText}</p>
            <div className='mt-6'>
              <a
                href={data.url}
                target='_blank'
                rel='noreferrer'
                className='flex items-center justify-center gap-2 rounded-md bg-blue-600 px-4 py-2 text-white transition-colors hover:bg-blue-700'
              >
                {visitButtonText} <ExternalLink className='size-4' />
              </a>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
