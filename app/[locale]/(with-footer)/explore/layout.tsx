import { ReactNode } from 'react';

export default function ExploreLayout({ children }: { children: ReactNode }) {
  return (
    <div className='mx-auto max-w-7xl px-3 lg:px-5'>
      <div className='max-w-4xl py-10'>{children}</div>
    </div>
  );
}
