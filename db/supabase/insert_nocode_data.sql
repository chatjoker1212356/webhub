-- 为no_code分类添加网站数据

-- 添加/更新Carrd网站数据
INSERT INTO web_navigation (
  name, 
  title, 
  url, 
  category_name, 
  collection_time,
  content
) VALUES (
  'carrd',
  'Carrd',
  'https://carrd.co/',
  ARRAY['no_code', 'web_dev'],
  NOW(),
  '# Carrd - 简单的单页网站构建工具

Carrd是一个简单而强大的单页网站构建平台，专为需要快速创建个人网站、项目展示页或登陆页的用户设计。

## 主要特点

- **简单易用**：直观的拖放界面，无需编码知识
- **响应式设计**：自动适应各种设备尺寸
- **丰富模板**：提供大量精美的起始模板
- **性价比高**：提供免费计划和经济实惠的付费计划
- **集成功能**：支持表单、支付、嵌入第三方工具等

## 适用场景

- 个人简历或作品集
- 项目或产品展示页
- 活动登陆页
- 简单的商业网站
- 会员订阅页面

Carrd因其简单性和高效率，成为了快速创建单页面网站的理想选择，特别适合那些不想花时间学习复杂编码但又需要专业外观网站的用户。'
)
ON CONFLICT (name) 
DO UPDATE SET 
  title = EXCLUDED.title,
  url = EXCLUDED.url,
  category_name = EXCLUDED.category_name,
  collection_time = EXCLUDED.collection_time,
  content = EXCLUDED.content;

-- 添加/更新Bolt.new网站数据
INSERT INTO web_navigation (
  name, 
  title, 
  url, 
  category_name, 
  collection_time,
  content
) VALUES (
  'bolt_new',
  'Bolt.new',
  'https://bolt.new/',
  ARRAY['no_code', 'web_dev'],
  NOW(),
  '# Bolt.new - 现代前端开发环境

Bolt.new是一个现代化的前端开发环境，专注于快速构建和迭代网站项目。

## 主要特点

- **快速开发**：即时预览和实时协作功能
- **前端专注**：专为现代网站和应用界面设计
- **组件库**：提供丰富的UI组件和模板
- **云端托管**：简化部署和发布流程
- **开发者友好**：支持现代JavaScript框架和工具

## 适用场景

- 快速原型设计
- 前端界面开发
- 响应式网站构建
- 团队协作项目
- UI/UX设计实现

Bolt.new为前端开发者提供了一个高效的工作环境，显著减少了从概念到成品的时间，使网站开发过程更加流畅和高效。'
)
ON CONFLICT (name) 
DO UPDATE SET 
  title = EXCLUDED.title,
  url = EXCLUDED.url,
  category_name = EXCLUDED.category_name,
  collection_time = EXCLUDED.collection_time,
  content = EXCLUDED.content;

-- 添加/更新V0.dev网站数据
INSERT INTO web_navigation (
  name, 
  title, 
  url, 
  category_name, 
  collection_time,
  content
) VALUES (
  'v0_dev',
  'V0.dev',
  'https://v0.dev/',
  ARRAY['no_code', 'web_dev'],
  NOW(),
  '# V0.dev - AI驱动的界面构建工具

V0.dev是Vercel推出的一款革命性工具，允许开发者利用AI快速构建复杂的前端界面。

## 主要特点

- **AI生成界面**：通过文本描述生成完整UI组件
- **React/Tailwind支持**：生成基于React和Tailwind CSS的代码
- **可自定义**：生成后可以进一步编辑和定制
- **组件库**：丰富的预设组件和模式
- **版本控制**：跟踪和管理界面变更

## 适用场景

- 快速原型设计
- 复杂UI界面开发
- 模板和组件创建
- 设计系统实现
- 前端开发加速

V0.dev代表了一种新型的低代码开发方式，它允许开发者通过自然语言指令创建专业级的用户界面，极大地提高了开发效率。'
)
ON CONFLICT (name) 
DO UPDATE SET 
  title = EXCLUDED.title,
  url = EXCLUDED.url,
  category_name = EXCLUDED.category_name,
  collection_time = EXCLUDED.collection_time,
  content = EXCLUDED.content;

-- 更新缩略图URL（使用clearbit logo API）
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/carrd.co?size=350' WHERE name = 'carrd';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/bolt.new?size=350' WHERE name = 'bolt_new';
UPDATE web_navigation SET thumbnail_url = 'https://logo.clearbit.com/v0.dev?size=350' WHERE name = 'v0_dev';

-- 设置默认图片（如果logo获取失败）
UPDATE web_navigation SET image_url = '/images/default-tool.png' WHERE (image_url IS NULL OR image_url = '');
