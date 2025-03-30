/* eslint-disable react/jsx-no-target-blank */

'use client';

import { memo, useEffect, useState } from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { normalizeCategories } from '@/db/supabase/helper/category_helper';
import { WebNavigation } from '@/db/supabase/types';
import { CircleArrowRight, ExternalLink, Globe } from 'lucide-react';
import { useTranslations } from 'next-intl';

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

/**
 * 网站导航卡片组件
 * @param {WebNavigation} props - 网站导航数据
 * @returns {JSX.Element} 网站导航卡片组件
 */
function WebNavCard({ id, name, thumbnail_url, title, url, content, category_name }: WebNavigation) {
  const t = useTranslations('Home');
  const [imgError, setImgError] = useState(false);
  const [isLoaded, setIsLoaded] = useState(false);
  const { locale } = useParams();
  const isEnglish = locale === 'en';

  // 使用useEffect延迟获取规范化后的分类数组，避免渲染期间的重复计算
  const [normalizedCategories, setNormalizedCategories] = useState<string[]>([]);

  useEffect(() => {
    // 在组件挂载后规范化分类数据
    const normalized = normalizeCategories(category_name);
    setNormalizedCategories(normalized);

    // 调试输出
    if (process.env.NODE_ENV !== 'production') {
      console.log(`卡片[${name}]的分类:`, {
        id,
        name,
        原始值: category_name,
        规范化后: normalized,
      });
    }
  }, [category_name, id, name]);

  // 默认图片
  const defaultImage = '/images/default-tool.png';

  // 错误处理函数
  const handleImageError = () => {
    setImgError(true);
  };

  // 加载完成处理函数
  const handleImageLoad = () => {
    setIsLoaded(true);
  };

  // 获取网站域名
  const domain = getDomain(url);

  // 预加载图片
  useEffect(() => {
    const img = new Image();
    img.src = thumbnail_url || defaultImage;
    img.onload = handleImageLoad;
    img.onerror = handleImageError;

    return () => {
      img.onload = null;
      img.onerror = null;
    };
  }, [thumbnail_url]);

  /**
   * 根据网站名称和类别生成专业的描述
   * @returns {string} 网站描述
   */
  const getEnhancedDescription = () => {
    // 确保category_name是规范化后的数组格式
    const categoryNameValue = normalizedCategories.length > 0 ? normalizedCategories[0] : '';

    // 详细网站描述映射
    const descriptionMap: Record<string, { en: string; cn: string }> = {
      // 域名查询工具
      lean_domain_search: {
        en: 'Creative domain name suggestion tool that generates numerous available domains from your keywords, perfect for inspiration.',
        cn: '专注于为用户提供创意域名建议，输入关键词即可生成大量可用域名，适合寻找灵感。',
      },
      query_domains: {
        en: 'Fast domain availability checker supporting multiple TLDs, clean and efficient interface.',
        cn: '提供快速的域名可用性查询，支持多种顶级域名后缀，简洁高效。',
      },
      instant_domain_search: {
        en: 'Real-time domain availability checker with purchase options and related suggestions, extremely fast.',
        cn: '实时显示域名可用性，支持域名购买和相关建议，速度极快。',
      },

      // 域名注册平台
      spaceship: {
        en: 'Clean and transparent domain registration service with affordable pricing and excellent user experience.',
        cn: '提供简洁透明的域名注册服务，价格实惠，用户体验优良。',
      },
      porkbun: {
        en: 'Known for low prices and rich TLD choices, offers free privacy protection for all domains.',
        cn: '以低价和丰富的域名后缀选择著称，同时提供免费隐私保护。',
      },
      namecheap: {
        en: 'Globally recognized domain registrar with reasonable prices and additional services like hosting and SSL.',
        cn: '全球知名的域名注册商，价格合理，支持多种附加服务如托管和SSL证书。',
      },

      // 网站开发工具
      vercel_templates: {
        en: 'Provides numerous open-source website templates for quick project starts, supports one-click deployment.',
        cn: '提供大量开源网站模板，适合快速启动开发项目，支持一键部署。',
      },
      supabase: {
        en: 'Open-source Backend-as-a-Service platform offering database, authentication, and real-time functionality.',
        cn: '开源后端即服务平台，提供数据库、认证和实时功能，开发者友好。',
      },
      builtwith: {
        en: 'Website technology stack analyzer helping developers understand competitors or optimize technology choices.',
        cn: '分析网站技术栈的工具，帮助开发者了解竞争对手或优化技术选择。',
      },
      carrd: {
        en: 'Simple one-page website builder, perfect for creating personal profiles or small project sites quickly.',
        cn: '简单易用的单页网站构建工具，适合快速创建个人简介或小型项目网站。',
      },
      bolt_new: {
        en: 'Modern frontend development environment focused on rapidly building and iterating websites.',
        cn: '提供现代化的前端开发环境，专注于快速构建和迭代网站。',
      },
      v0_dev: {
        en: 'Low-code tool for developers to quickly build complex frontend interfaces with minimal effort.',
        cn: '面向开发者的低代码工具，支持快速构建复杂的前端界面。',
      },

      // 网站托管平台
      cloudflare: {
        en: 'Leading global CDN and network security platform offering fast, secure hosting services.',
        cn: '全球领先的CDN和网络安全平台，提供快速、安全的托管服务。',
      },
      vercel: {
        en: 'Frontend application hosting platform with seamless deployment and automated optimization.',
        cn: '专注于前端应用托管，支持无缝部署和自动化优化，适合开发者和团队。',
      },

      // 数据后台工具
      google_search_console: {
        en: 'Website performance monitoring and optimization tool to improve search rankings and resolve indexing issues.',
        cn: '提供网站性能监控与优化工具，帮助改善搜索排名和解决索引问题。',
      },
      google_analytics: {
        en: 'Powerful data analytics platform tracking user behavior and providing insights to optimize website performance.',
        cn: '强大的数据分析平台，追踪用户行为，提供深度洞察以优化网站表现。',
      },
      bing_webmaster_tools: {
        en: 'Comprehensive performance analysis and optimization suggestions for websites in Bing search engine.',
        cn: '提供网站在Bing搜索引擎上的性能分析与优化建议，功能全面。',
      },

      // 数据查询工具
      aitdk: {
        en: 'AI tool directory focused on helping users quickly find suitable artificial intelligence solutions.',
        cn: '专注于AI工具目录查询，帮助用户快速找到合适的人工智能解决方案。',
      },
      semrush: {
        en: 'Comprehensive digital marketing tool supporting keyword research, competitor analysis, and SEO optimization.',
        cn: '全面的数字营销工具，支持关键词研究、竞争分析和SEO优化。',
      },
      search_suggest_tips: {
        en: 'Real-time search suggestion query tool helping users discover popular keywords and search trends.',
        cn: '提供实时搜索建议查询，帮助用户发现热门关键词和搜索趋势。',
      },
      google_trends: {
        en: 'Analyzes global search trends to discover popular topics and keyword changes over time.',
        cn: '分析全球搜索趋势，发现热门话题和关键词的变化。',
      },
      ahrefs: {
        en: 'Professional SEO tool supporting keyword difficulty queries, content analysis, and link building strategies.',
        cn: '专业的SEO工具，支持关键词难度查询、内容分析和链接建设。',
      },
      toolify: {
        en: 'AI tool search and recommendation platform helping users quickly find effective solutions.',
        cn: 'AI工具搜索与推荐平台，帮助用户快速找到高效解决方案。',
      },
      ahrefs_keyword_difficulty: {
        en: 'Focused on keyword difficulty analysis to evaluate competition and develop optimization strategies.',
        cn: '专注于关键词难度分析，评估竞争强度，帮助制定优化策略。',
      },
      wix: {
        en: 'Cloud-based website builder with intuitive drag-and-drop interface and customizable templates.',
        cn: '基于云的网站构建器，具有直观的拖放界面和可定制的模板。',
      },
      squarespace: {
        en: 'All-in-one website building platform with professional templates for businesses and portfolios.',
        cn: '一体化网站构建平台，为企业和作品集提供专业模板。',
      },
      hostinger: {
        en: 'Affordable web hosting with free domain, SSL certificates, and easy-to-use website builder.',
        cn: '经济实惠的网络托管服务，提供免费域名、SSL和网站构建器。',
      },
      bluehost: {
        en: 'Reliable web hosting service with one-click WordPress installation and 24/7 support.',
        cn: '可靠的网络托管服务，支持一键安装WordPress和全天候技术支持。',
      },
      carrd_nocode: {
        en: 'Simple one-page website builder requiring no coding skills, perfect for portfolios and landing pages.',
        cn: '简单的单页网站构建工具，无需编程技能，非常适合作品集和落地页。',
      },
      bolt_new_nocode: {
        en: 'Modern frontend development environment with no-code options for rapid website creation.',
        cn: '现代前端开发环境，提供无代码选项，可快速创建网站。',
      },
      v0_dev_nocode: {
        en: 'AI-powered interface building tool that turns text descriptions into functional UI components.',
        cn: 'AI驱动的界面构建工具，将文本描述转换为功能性UI组件，无需编码。',
      },
    };

    // 分类特定描述
    const categoryDescriptions: Record<string, { en: string; cn: string }> = {
      domain_search: {
        en: 'Tools to quickly find and check availability of perfect domain names for your website.',
        cn: '快速查找并检查适合您网站的域名可用性的专业工具。',
      },
      domain_register: {
        en: 'Reliable domain registration services with competitive pricing and comprehensive protection options.',
        cn: '可靠的域名注册服务，价格具有竞争力，提供全面的保护选项。',
      },
      web_dev: {
        en: 'Professional web development tools for creating stunning, responsive, and functional websites.',
        cn: '专业网站开发工具，用于创建美观、响应式和功能强大的网站。',
      },
      web_hosting: {
        en: 'Secure and reliable web hosting services with excellent uptime and responsive customer support.',
        cn: '安全可靠的网络托管服务，提供卓越的运行时间和响应迅速的客户支持。',
      },
      data_analytics: {
        en: 'Comprehensive analytics tools for monitoring website performance and understanding visitor behavior patterns.',
        cn: '全面的分析工具，用于监控网站性能和理解访客行为模式。',
      },
      data_research: {
        en: 'Advanced research tools for gathering market insights and analyzing web data for strategic decisions.',
        cn: '高级研究工具，用于收集市场洞察和分析网络数据，辅助战略决策。',
      },
      no_code: {
        en: 'No-code development platforms for building websites and applications without writing code.',
        cn: '无代码开发平台，无需编写代码即可构建网站和应用程序。',
      },
    };

    // 基于网站名称的特定描述
    const normalizedName = name?.toLowerCase().replace(/[.-]/g, '_');
    if (normalizedName && descriptionMap[normalizedName]) {
      return isEnglish ? descriptionMap[normalizedName].en : descriptionMap[normalizedName].cn;
    }

    // 尝试匹配网站名称（不区分大小写）
    const matchedKey = Object.keys(descriptionMap).find(
      (key) =>
        key.toLowerCase() === normalizedName ||
        key.toLowerCase().includes(normalizedName || '') ||
        (normalizedName || '').includes(key.toLowerCase()),
    );

    if (matchedKey) {
      return isEnglish ? descriptionMap[matchedKey].en : descriptionMap[matchedKey].cn;
    }

    // 基于分类的通用描述
    if (categoryNameValue && categoryDescriptions[categoryNameValue]) {
      return isEnglish ? categoryDescriptions[categoryNameValue].en : categoryDescriptions[categoryNameValue].cn;
    }

    // 通用默认描述
    if (!content || content.length < 10) {
      return isEnglish
        ? 'Professional website building tool with intuitive interface and powerful features for creating modern websites.'
        : '专业的网站构建工具，拥有直观的界面和强大的功能，帮助用户创建现代化网站。';
    }

    // 如果有原始内容且为英文，但当前语言是中文，提供中文翻译
    if (content && !isEnglish && content.match(/^[a-zA-Z0-9\s.,!?;:()\-"']+$/)) {
      // 如果内容是英文，但界面是中文，尝试翻译常见短语
      if (content.toLowerCase().includes('domain')) {
        return '专业域名搜索和注册工具，帮助您快速找到理想的网站域名并完成注册。';
      }
      if (content.toLowerCase().includes('host')) {
        return '高性能网站托管服务，提供稳定可靠的服务器支持和全面的安全保障。';
      }
      if (content.toLowerCase().includes('website') || content.toLowerCase().includes('builder')) {
        return '功能全面的网站构建平台，通过简洁的操作界面帮助用户快速创建专业网站。';
      }
      if (content.toLowerCase().includes('wordpress')) {
        return '专业的WordPress相关工具，简化网站开发流程，提供丰富的模板和插件支持。';
      }
      if (content.toLowerCase().includes('analytics') || content.toLowerCase().includes('data')) {
        return '全面的网站数据分析工具，提供详细的用户行为洞察，助力网站性能优化。';
      }
      if (content.toLowerCase().includes('seo') || content.toLowerCase().includes('search')) {
        return '专业的搜索引擎优化工具，帮助提升网站排名和可见度，增加有机流量。';
      }
    }

    return content;
  };

  return (
    <div className='flex h-[190px] flex-col gap-2 rounded-xl border border-gray-800 bg-gray-900 p-1 shadow-lg transition-all duration-300 hover:shadow-xl lg:h-[320px]'>
      <Link href={`/ai/${name}`} title={title} className='group relative'>
        <div className='flex aspect-[16/9] w-full items-center justify-center overflow-hidden rounded-xl bg-gray-800 hover:opacity-70'>
          {!imgError ? (
            <>
              {!isLoaded && (
                <div className='flex h-full w-full animate-pulse items-center justify-center bg-gray-800'>
                  <span className='text-gray-400'>{t('loading')}</span>
                </div>
              )}
              <img
                src={thumbnail_url || defaultImage}
                alt={title}
                title={title}
                width={310}
                height={174}
                onError={handleImageError}
                onLoad={handleImageLoad}
                className={`max-h-full max-w-full object-contain p-2 transition-opacity duration-300 ${isLoaded ? 'opacity-100' : 'opacity-0'}`}
              />
            </>
          ) : (
            <div className='flex h-full w-full items-center justify-center bg-gray-800'>
              <div className='flex flex-col items-center justify-center p-3 text-center'>
                <Globe className='mb-1 size-8 text-white' />
                <span className='text-base font-medium text-white'>{domain}</span>
              </div>
            </div>
          )}
        </div>
        <div className='absolute inset-0 z-10 hidden items-center justify-center gap-1 rounded-xl bg-black bg-opacity-50 text-lg text-white transition-all duration-200 group-hover:flex'>
          {t('checkDetail')} <CircleArrowRight className='size-4' />
        </div>
      </Link>
      <div className='flex items-center justify-between px-2'>
        <a href={url} title={title} target='_blank' rel='nofollow' className='hover:opacity-70'>
          <h3 className='line-clamp-1 flex-1 text-sm font-bold text-white'>{title}</h3>
        </a>
        <a href={url} title={title} target='_blank' rel='nofollow' className='ml-1 text-white hover:opacity-70'>
          <ExternalLink className='size-4' />
          <span className='sr-only'>{title}</span>
        </a>
      </div>
      <p className='mb-1 line-clamp-3 px-2 text-xs font-light italic leading-relaxed text-blue-200/90'>
        {getEnhancedDescription()}
      </p>
    </div>
  );
}

// 使用memo避免不必要的重渲染
export default memo(WebNavCard);
