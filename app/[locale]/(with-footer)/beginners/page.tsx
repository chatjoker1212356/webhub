import { Metadata } from 'next';
import Link from 'next/link';
import { useTranslations } from 'next-intl';
import { getTranslations } from 'next-intl/server';

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  const t = await getTranslations({ locale, namespace: 'Metadata' });

  return {
    title: t('beginners.title'),
    description: t('beginners.description'),
    keywords: t('beginners.keywords'),
  };
}

export default function BeginnersPage() {
  const t = useTranslations('Beginners');

  return (
    <main className='container mx-auto px-4 py-8'>
      <h1 className='mb-6 text-center text-3xl font-bold'>{t('title')}</h1>

      <div className='mx-auto mb-8 max-w-4xl rounded-xl bg-gray-800 p-6 shadow-lg'>
        <h2 className='mb-4 text-2xl font-semibold text-white'>{t('introduction.title')}</h2>
        <p className='mb-6 leading-relaxed text-gray-300'>{t('introduction.content')}</p>
        <div className='mb-4 flex h-48 w-full items-center justify-center rounded-lg bg-gray-700'>
          <span className='text-gray-400'>Website Building Introduction Image</span>
        </div>
      </div>

      <div className='mx-auto grid max-w-4xl grid-cols-1 gap-6 md:grid-cols-2'>
        <div className='rounded-xl bg-gray-800 p-6 shadow-lg'>
          <h2 className='mb-4 text-xl font-semibold text-white'>{t('section1.title')}</h2>
          <ul className='mb-6 list-inside list-disc space-y-2 text-gray-300'>
            <li>{t('section1.item1')}</li>
            <li>{t('section1.item2')}</li>
            <li>{t('section1.item3')}</li>
            <li>{t('section1.item4')}</li>
          </ul>
          <div className='mb-4 flex h-32 w-full items-center justify-center rounded-lg bg-gray-700'>
            <span className='text-gray-400'>Domain & Hosting Image</span>
          </div>
          <div className='rounded-lg bg-gray-700 p-4'>
            <h4 className='text-md mb-2 font-medium text-blue-300'>Recommended Domain Registrars</h4>
            <ul className='list-inside list-disc space-y-1 text-gray-300'>
              <li>Namecheap - Great value and free privacy</li>
              <li>GoDaddy - Popular with many TLD options</li>
              <li>Google Domains - Simple interface</li>
            </ul>
          </div>
        </div>

        <div className='rounded-xl bg-gray-800 p-6 shadow-lg'>
          <h2 className='mb-4 text-xl font-semibold text-white'>{t('section2.title')}</h2>
          <ul className='mb-6 list-inside list-disc space-y-2 text-gray-300'>
            <li>{t('section2.item1')}</li>
            <li>{t('section2.item2')}</li>
            <li>{t('section2.item3')}</li>
            <li>{t('section2.item4')}</li>
          </ul>
          <div className='mb-4 flex h-32 w-full items-center justify-center rounded-lg bg-gray-700'>
            <span className='text-gray-400'>Website Building Tools Image</span>
          </div>
          <div className='mt-4 grid grid-cols-3 gap-2'>
            <div className='rounded-lg bg-gray-700 p-3'>
              <h4 className='text-sm font-medium text-green-300'>WordPress</h4>
              <p className='text-xs text-gray-400'>For blogs & business sites</p>
            </div>
            <div className='rounded-lg bg-gray-700 p-3'>
              <h4 className='text-sm font-medium text-purple-300'>Wix</h4>
              <p className='text-xs text-gray-400'>Drag-and-drop builder</p>
            </div>
            <div className='rounded-lg bg-gray-700 p-3'>
              <h4 className='text-sm font-medium text-yellow-300'>Shopify</h4>
              <p className='text-xs text-gray-400'>Best for online stores</p>
            </div>
          </div>
        </div>

        <div className='rounded-xl bg-gray-800 p-6 shadow-lg'>
          <h2 className='mb-4 text-xl font-semibold text-white'>{t('section3.title')}</h2>
          <ul className='mb-6 list-inside list-disc space-y-2 text-gray-300'>
            <li>{t('section3.item1')}</li>
            <li>{t('section3.item2')}</li>
            <li>{t('section3.item3')}</li>
            <li>{t('section3.item4')}</li>
          </ul>
          <div className='mb-4 flex h-32 w-full items-center justify-center rounded-lg bg-gray-700'>
            <span className='text-gray-400'>Design & Content Image</span>
          </div>
          <div className='mt-4 rounded-lg bg-gray-700 p-4'>
            <h4 className='text-md mb-2 font-medium text-gray-200'>Website Design Tips</h4>
            <ol className='list-inside list-decimal space-y-1 text-gray-300'>
              <li>Keep your design clean and minimal</li>
              <li>Use consistent branding colors</li>
              <li>Ensure mobile-friendly design</li>
              <li>Pay attention to page load speed</li>
              <li>Create intuitive navigation</li>
            </ol>
          </div>
        </div>

        <div className='rounded-xl bg-gray-800 p-6 shadow-lg'>
          <h2 className='mb-4 text-xl font-semibold text-white'>{t('section4.title')}</h2>
          <ul className='mb-6 list-inside list-disc space-y-2 text-gray-300'>
            <li>{t('section4.item1')}</li>
            <li>{t('section4.item2')}</li>
            <li>{t('section4.item3')}</li>
            <li>{t('section4.item4')}</li>
          </ul>
          <div className='mb-4 flex h-32 w-full items-center justify-center rounded-lg bg-gray-700'>
            <span className='text-gray-400'>SEO & Analytics Image</span>
          </div>
          <div className='rounded-lg bg-gray-700 p-4'>
            <h4 className='text-md mb-2 font-medium text-red-300'>SEO Essentials</h4>
            <ul className='list-inside list-disc space-y-1 text-gray-300'>
              <li>Research relevant keywords</li>
              <li>Optimize meta titles</li>
              <li>Create quality content</li>
              <li>Build reputable backlinks</li>
              <li>Use Google Search Console</li>
            </ul>
          </div>
        </div>
      </div>

      <div className='mx-auto mt-8 max-w-4xl rounded-xl bg-gradient-to-r from-gray-800 to-gray-900 p-6 shadow-lg'>
        <h2 className='mb-4 text-2xl font-semibold text-white'>{t('conclusion.title')}</h2>
        <p className='mb-6 leading-relaxed text-gray-300'>{t('conclusion.content')}</p>
        <div className='flex justify-center'>
          <Link
            href='/explore'
            className='rounded-full bg-blue-600 px-6 py-2 font-medium text-white transition duration-300 hover:bg-blue-700'
          >
            Explore Website Building Tools
          </Link>
        </div>
      </div>
    </main>
  );
}
