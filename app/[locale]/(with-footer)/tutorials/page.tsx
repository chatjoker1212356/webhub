import { Metadata } from 'next';
import Link from 'next/link';
import { useTranslations } from 'next-intl';
import { getTranslations } from 'next-intl/server';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  const t = await getTranslations({ locale, namespace: 'Metadata' });

  return {
    title: t('tutorials.title'),
    description: t('tutorials.description'),
    keywords: t('tutorials.keywords'),
  };
}

export default function TutorialsPage() {
  const t = useTranslations('Tutorials');

  return (
    <main className='container mx-auto px-4 py-8'>
      <h1 className='mb-6 text-center text-3xl font-bold text-white'>{t('title')}</h1>

      <div className='mx-auto mb-8 max-w-4xl rounded-xl bg-gray-800 p-6 shadow-lg'>
        <h2 className='mb-4 text-2xl font-semibold text-white'>{t('introduction.title')}</h2>
        <p className='mb-6 leading-relaxed text-gray-300'>{t('introduction.content')}</p>
        <div className='mb-4 flex h-48 w-full items-center justify-center rounded-lg bg-gray-700'>
          <span className='text-gray-400'>Website Building Tutorials Banner</span>
        </div>
      </div>

      <div className='mx-auto mb-8 grid max-w-4xl grid-cols-1 gap-6 md:grid-cols-2'>
        {[1, 2, 3, 4].map((tutorialId) => (
          <div key={tutorialId} className='hover:bg-gray-750 rounded-xl bg-gray-800 p-6 shadow-lg transition-colors'>
            <div className='mb-4 flex h-32 w-full items-center justify-center rounded-lg bg-gray-700'>
              <span className='text-gray-400'>Tutorial {tutorialId} Image</span>
            </div>
            <h3 className='mb-3 text-xl font-semibold text-white'>{t(`tutorial${tutorialId}.title`)}</h3>
            <p className='mb-4 text-sm leading-relaxed text-gray-300'>{t(`tutorial${tutorialId}.description`)}</p>
            <div className='flex items-center justify-between'>
              <span className='rounded bg-blue-900 px-2 py-1 text-xs text-blue-200'>
                {t(`tutorial${tutorialId}.level`)}
              </span>
              <Link
                href={`/tutorials/detail/${tutorialId}`}
                className='flex items-center text-sm font-medium text-blue-400 hover:text-blue-300'
              >
                {t('readMore')}
                <svg
                  xmlns='http://www.w3.org/2000/svg'
                  className='ml-1 h-4 w-4'
                  fill='none'
                  viewBox='0 0 24 24'
                  stroke='currentColor'
                >
                  <path strokeLinecap='round' strokeLinejoin='round' strokeWidth={2} d='M9 5l7 7-7 7' />
                </svg>
              </Link>
            </div>
          </div>
        ))}
      </div>

      <div className='mx-auto mb-12 max-w-4xl'>
        <h2 className='mb-6 text-2xl font-semibold text-white'>{t('categories.title')}</h2>
        <div className='mb-8 grid grid-cols-2 gap-4 md:grid-cols-4'>
          {[1, 2, 3, 4, 5, 6, 7, 8].map((categoryId) => (
            <Link
              href={`/tutorials/category/${categoryId}`}
              key={categoryId}
              className='rounded-lg bg-gray-800 p-4 text-center text-gray-200 shadow-md transition-colors hover:bg-gray-700 hover:text-white'
            >
              <div className='mb-2'>
                <svg
                  xmlns='http://www.w3.org/2000/svg'
                  className='mx-auto h-6 w-6'
                  fill='none'
                  viewBox='0 0 24 24'
                  stroke='currentColor'
                >
                  <path
                    strokeLinecap='round'
                    strokeLinejoin='round'
                    strokeWidth={2}
                    d='M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z'
                  />
                </svg>
              </div>
              {t(`categories.category${categoryId}`)}
            </Link>
          ))}
        </div>
      </div>

      <div className='mx-auto max-w-4xl'>
        <div className='mb-12 grid grid-cols-1 gap-6 md:grid-cols-3'>
          <div className='rounded-xl bg-gray-800 p-6 shadow-lg'>
            <div className='mb-2 text-green-400'>
              <svg
                xmlns='http://www.w3.org/2000/svg'
                className='h-8 w-8'
                fill='none'
                viewBox='0 0 24 24'
                stroke='currentColor'
              >
                <path strokeLinecap='round' strokeLinejoin='round' strokeWidth={2} d='M13 10V3L4 14h7v7l9-11h-7z' />
              </svg>
            </div>
            <h3 className='mb-2 text-lg font-medium text-white'>Quick Start Guides</h3>
            <p className='text-sm text-gray-300'>
              Get your website up and running quickly with our beginner-friendly guides
            </p>
          </div>
          <div className='rounded-xl bg-gray-800 p-6 shadow-lg'>
            <div className='mb-2 text-blue-400'>
              <svg
                xmlns='http://www.w3.org/2000/svg'
                className='h-8 w-8'
                fill='none'
                viewBox='0 0 24 24'
                stroke='currentColor'
              >
                <path
                  strokeLinecap='round'
                  strokeLinejoin='round'
                  strokeWidth={2}
                  d='M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z'
                />
              </svg>
            </div>
            <h3 className='mb-2 text-lg font-medium text-white'>Video Tutorials</h3>
            <p className='text-sm text-gray-300'>
              Visual learners can follow along with our step-by-step video instructions
            </p>
          </div>
          <div className='rounded-xl bg-gray-800 p-6 shadow-lg'>
            <div className='mb-2 text-purple-400'>
              <svg
                xmlns='http://www.w3.org/2000/svg'
                className='h-8 w-8'
                fill='none'
                viewBox='0 0 24 24'
                stroke='currentColor'
              >
                <path
                  strokeLinecap='round'
                  strokeLinejoin='round'
                  strokeWidth={2}
                  d='M8 9l3 3-3 3m5 0h3M5 20h14a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z'
                />
              </svg>
            </div>
            <h3 className='mb-2 text-lg font-medium text-white'>Code Examples</h3>
            <p className='text-sm text-gray-300'>Ready-to-use code snippets to add advanced features to your website</p>
          </div>
        </div>
      </div>

      <div className='mx-auto max-w-4xl'>
        <div className='space-y-4'>
          <h3 className='text-lg font-semibold text-white'>HTML & CSS 基础教程</h3>
          <div className='grid grid-cols-2 gap-3 md:grid-cols-3'>
            <Link href='/tutorials/html-basics' className='rounded-lg bg-gray-800 p-3 text-center hover:bg-gray-700'>
              <div className='font-medium'>HTML 入门</div>
              <div className='mt-1 text-xs text-gray-400'>标签、结构和语义</div>
            </Link>
            <Link href='/tutorials/css-basics' className='rounded-lg bg-gray-800 p-3 text-center hover:bg-gray-700'>
              <div className='font-medium'>CSS 样式</div>
              <div className='mt-1 text-xs text-gray-400'>选择器和属性</div>
            </Link>
            <Link href='/tutorials/responsive' className='rounded-lg bg-gray-800 p-3 text-center hover:bg-gray-700'>
              <div className='font-medium'>响应式设计</div>
              <div className='mt-1 text-xs text-gray-400'>媒体查询和弹性布局</div>
            </Link>
          </div>

          <h3 className='mt-6 text-lg font-semibold text-white'>JavaScript & 框架</h3>
          <div className='grid grid-cols-2 gap-3 md:grid-cols-3'>
            <Link href='/tutorials/javascript' className='rounded-lg bg-gray-800 p-3 text-center hover:bg-gray-700'>
              <div className='font-medium'>JavaScript 基础</div>
              <div className='mt-1 text-xs text-gray-400'>语法和DOM操作</div>
            </Link>
            <Link href='/tutorials/react' className='rounded-lg bg-gray-800 p-3 text-center hover:bg-gray-700'>
              <div className='font-medium'>React 入门</div>
              <div className='mt-1 text-xs text-gray-400'>组件和状态管理</div>
            </Link>
            <button type='button' className='rounded-lg bg-gray-800 p-3 text-center opacity-50 hover:bg-gray-700'>
              <div className='font-medium'>Vue.js (即将推出)</div>
              <div className='mt-1 text-xs text-gray-400'>敬请期待</div>
            </button>
          </div>

          <h3 className='mt-6 text-lg font-semibold text-white'>网站部署</h3>
          <div className='grid grid-cols-2 gap-3 md:grid-cols-3'>
            <Link href='/tutorials/hosting' className='rounded-lg bg-gray-800 p-3 text-center hover:bg-gray-700'>
              <div className='font-medium'>静态网站托管</div>
              <div className='mt-1 text-xs text-gray-400'>GitHub Pages和Vercel</div>
            </Link>
            <Link href='/tutorials/domains' className='rounded-lg bg-gray-800 p-3 text-center hover:bg-gray-700'>
              <div className='font-medium'>域名设置</div>
              <div className='mt-1 text-xs text-gray-400'>购买域名和DNS配置</div>
            </Link>
            <button type='button' className='rounded-lg bg-gray-800 p-3 text-center opacity-50 hover:bg-gray-700'>
              <div className='font-medium'>HTTPS (即将推出)</div>
              <div className='mt-1 text-xs text-gray-400'>敬请期待</div>
            </button>
          </div>
        </div>
      </div>

      <div className='mx-auto max-w-4xl rounded-xl bg-gradient-to-br from-indigo-900 to-indigo-950 p-6 shadow-lg'>
        <h2 className='mb-4 text-2xl font-semibold text-white'>{t('newsletter.title')}</h2>
        <p className='mb-6 text-gray-300'>{t('newsletter.description')}</p>
        <div className='flex gap-2'>
          <input
            type='email'
            placeholder={t('newsletter.placeholder')}
            className='flex-1 rounded border border-indigo-800 bg-indigo-950 px-3 py-2 text-white placeholder-indigo-400'
          />
          <button type='submit' className='rounded bg-white px-4 py-2 font-medium text-indigo-900 hover:bg-indigo-100'>
            {t('newsletter.button')}
          </button>
        </div>
      </div>
    </main>
  );
}
