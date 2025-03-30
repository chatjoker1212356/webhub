import createNextIntlPlugin from 'next-intl/plugin';

const withNextIntl = createNextIntlPlugin();

/** @type {import('next').NextConfig} */
const nextConfig = {
  env: {
    NEXT_BASE_API: process.env.NEXT_BASE_API,
  },
  logging: {
    fetches: {
      fullUrl: process.env.NODE_ENV === 'development',
    },
  },
  compiler: {
    removeConsole: process.env.NODE_ENV === 'production',
  },
  images: {
    unoptimized: true,
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'img.artiversehub.ai',
        port: '',
        pathname: '/**',
      },
    ],
  },
  productionBrowserSourceMaps: false,
  webpack: (config) => {
    if (!config.optimization) {
      config.optimization = {};
    }
    
    if (!config.optimization.splitChunks) {
      config.optimization.splitChunks = {};
    }

    config.optimization.splitChunks = {
      ...config.optimization.splitChunks,
      chunks: 'all',
      maxSize: 20 * 1024 * 1024, // 20MB，低于Cloudflare的25MB限制
    };

    return config;
  },
};

export default withNextIntl(nextConfig);
