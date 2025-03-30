'use client';

import Link from 'next/link';
import { useParams } from 'next/navigation';

/**
 * 标签项组件
 * @param {Object} props - 组件属性
 * @param {React.ReactNode} props.children - 子元素
 * @param {string} [props.emoji] - 表情符号
 * @returns {JSX.Element} 标签项组件
 */
export function TagItem({ children, emoji }: { children: React.ReactNode; emoji?: string }) {
  return (
    <div className='flex h-[48px] w-full items-center justify-center gap-2 whitespace-nowrap rounded-xl border border-gray-700 bg-gradient-to-r from-gray-800 to-gray-900 px-6 text-sm font-medium shadow-md transition-all hover:border-blue-700 hover:from-gray-700 hover:to-gray-800'>
      {emoji && <span className='mr-1 text-lg'>{emoji}</span>}
      <span className='text-white'>{children}</span>
    </div>
  );
}

/**
 * 标签链接组件
 * @param {Object} props - 组件属性
 * @param {string} props.name - 标签名称
 * @param {string} props.href - 链接地址
 * @param {string} [props.emoji] - 表情符号
 * @returns {JSX.Element} 标签链接组件
 */
export function TagLink({ name, href, emoji }: { name: string; href: string; emoji?: string }) {
  return (
    <Link href={href} title={name} className='w-full'>
      <TagItem emoji={emoji}>{name}</TagItem>
    </Link>
  );
}

// 分类标签对应的中文翻译映射
const categoryChineseMap: Record<string, string> = {
  domain_search: '域名搜索',
  domain_register: '域名注册',
  web_dev: '网站开发',
  web_hosting: '网站托管',
  data_analytics: '数据分析',
  data_research: '数据研究',
  no_code: '无代码开发',
};

// 分类标签对应的英文翻译映射
const categoryEnglishMap: Record<string, string> = {
  domain_search: 'Domain Search',
  domain_register: 'Domain Register',
  web_dev: 'Web Dev',
  web_hosting: 'Web Hosting',
  data_analytics: 'Data Analytics',
  data_research: 'Research',
  no_code: 'No Code',
};

// 分类图标类型映射
const getCategoryEmoji = (name: string) => {
  switch (name) {
    case 'domain_search':
      return '🔍';
    case 'domain_register':
      return '📝';
    case 'web_dev':
      return '💻';
    case 'web_hosting':
      return '☁️';
    case 'data_analytics':
      return '📊';
    case 'data_research':
      return '🔬';
    case 'no_code':
      return '⚡';
    default:
      return '📌';
  }
};

/**
 * 标签列表组件
 * @param {Object} props - 组件属性
 * @param {Array} props.data - 标签数据
 * @returns {JSX.Element} 标签列表组件
 */
export function TagList({ data }: { data: { name: string; href: string; id: string }[] }) {
  const { locale } = useParams();
  const isEnglish = locale === 'en';

  // 根据当前语言显示对应的标题和分类名
  const headerTitle = isEnglish ? 'Website Building Tool Categories' : '网站建设工具分类';

  return (
    <div className='py-4'>
      <h3 className='mb-3 text-center text-xl font-semibold text-white'>{headerTitle}</h3>
      <div className='mx-auto max-w-5xl'>
        <ul className='grid grid-cols-2 gap-3 px-2 md:grid-cols-3 lg:grid-cols-7'>
          {data.map((item) => {
            // 根据当前语言选择要显示的映射
            const displayName = isEnglish
              ? categoryEnglishMap[item.name] || item.name
              : categoryChineseMap[item.name] || item.name;

            // sr-only 文本也需要根据语言选择
            const srText = isEnglish ? 'category' : '分类';

            return (
              <li key={item.href} className='w-full'>
                <TagLink name={displayName} href={item.href} emoji={getCategoryEmoji(item.name)} />
                <span className='sr-only'>
                  {displayName} {srText}
                </span>
              </li>
            );
          })}
        </ul>
      </div>
    </div>
  );
}
