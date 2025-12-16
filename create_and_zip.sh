#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="NeuralNexus"
if [ -d "$ROOT_DIR" ]; then
  echo "Directory $ROOT_DIR already exists. Remove or rename it before running this script."
  exit 1
fi

mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR"

# Create folders
mkdir -p pages components public styles .github/workflows

# package.json
cat > package.json <<'EOF'
{
  "name": "neuralnexus-site",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev -p 3000",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "framer-motion": "^10.12.7"
  },
  "devDependencies": {
    "autoprefixer": "^10.4.14",
    "postcss": "^8.4.24",
    "tailwindcss": "^4.0.0",
    "typescript": "^5.2.2",
    "eslint": "^8.46.0",
    "eslint-config-next": "^14.0.0"
  }
}
EOF

# tsconfig.json
cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "lib": ["DOM", "ES2020"],
    "jsx": "preserve",
    "moduleResolution": "bundler",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "baseUrl": "."
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
EOF

# next.config.js
cat > next.config.js <<'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  experimental: { appDir: false }
};
module.exports = nextConfig;
EOF

# postcss.config.js
cat > postcss.config.js <<'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
};
EOF

# tailwind.config.js
cat > tailwind.config.js <<'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./pages/**/*.{js,ts,jsx,tsx}", "./components/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        'nn-bg': '#0B1220',
        'nn-surface': '#0F1724',
        'nn-cyan': '#00B5D8',
        'nn-purple': '#7C3AED',
        'nn-warm': '#FFB86B',
        'nn-muted': '#B9C6D8'
      },
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui']
      }
    }
  },
  plugins: []
};
EOF

# styles/globals.css
cat > styles/globals.css <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Brand tokens for non-Tailwind usage */
:root{
  --nn-bg:#0B1220;
  --nn-surface:#0F1724;
  --nn-cyan:#00B5D8;
  --nn-purple:#7C3AED;
  --nn-warm:#FFB86B;
  --nn-muted:#B9C6D8;
}

html,body,#__next{
  height:100%;
}

body {
  @apply bg-[var(--nn-bg)] text-[var(--nn-muted)] font-sans;
  -webkit-font-smoothing:antialiased;
  -moz-osx-font-smoothing:grayscale;
}
a { color: var(--nn-cyan); }
EOF

# pages/_app.tsx
cat > pages/_app.tsx <<'EOF'
import type { AppProps } from 'next/app'
import '../styles/globals.css'

export default function App({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}
EOF

# pages/index.tsx
cat > pages/index.tsx <<'EOF'
import Head from 'next/head'
import Header from '../components/Header'
import GuildCard from '../components/GuildCard'

export default function Home() {
  return (
    <>
      <Head>
        <title>NeuralNexus — Collective intelligence for builders</title>
        <meta name="description" content="Connected minds build better futures. Join NeuralNexus." />
      </Head>
      <Header />
      <main className="max-w-6xl mx-auto px-6 py-12">
        <section className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-white mb-4">NeuralNexus</h1>
          <p className="text-lg md:text-xl text-[var(--nn-muted)] max-w-2xl mx-auto">
            Connected minds build better futures. A symbiotic ecosystem for technologists to unite, elevate, and create.
          </p>
          <div className="mt-8 flex justify-center gap-4">
            <a className="px-6 py-3 rounded-lg bg-[var(--nn-cyan)] text-black font-semibold" href="/join">Join the Founding Circle</a>
            <a className="px-6 py-3 rounded-lg border border-[var(--nn-muted)]" href="/guilds">Explore Guilds</a>
          </div>
        </section>

        <section>
          <h2 className="text-2xl text-white mb-6">Guilds</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <GuildCard title="Web Nexus" tag="React • Node • Design" />
            <GuildCard title="Android Nexus" tag="Kotlin • Flutter • UX" />
            <GuildCard title="Data Nexus" tag="ML • BI • Dashboards" />
            <GuildCard title="DevOps Nexus" tag="IaC • CI/CD • Security" />
          </div>
        </section>
      </main>
    </>
  )
}
EOF

# components/Header.tsx
cat > components/Header.tsx <<'EOF'
import Link from 'next/link'

export default function Header(){
  return (
    <header className="bg-[var(--nn-surface)] border-b border-[#0B1A2B]">
      <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
        <Link href="/">
          <a className="flex items-center gap-3">
            <img src="/logo.svg" alt="NeuralNexus" className="w-10 h-10" />
            <span className="text-white font-semibold">NeuralNexus</span>
          </a>
        </Link>
        <nav className="flex gap-4 items-center">
          <Link href="/guilds"><a className="text-[var(--nn-muted)] hover:text-white">Guilds</a></Link>
          <Link href="/projects"><a className="text-[var(--nn-muted)] hover:text-white">Projects</a></Link>
          <Link href="/join"><a className="px-3 py-2 bg-[var(--nn-cyan)] text-black rounded-md">Join</a></Link>
        </nav>
      </div>
    </header>
  )
}
EOF

# components/GuildCard.tsx
cat > components/GuildCard.tsx <<'EOF'
type Props = { title: string, tag?: string }
export default function GuildCard({ title, tag }: Props){
  return (
    <article className="p-6 rounded-xl bg-[linear-gradient(0deg,rgba(255,255,255,0.02),rgba(255,255,255,0.02))] border border-[#102030]">
      <h3 className="text-xl text-white font-semibold">{title}</h3>
      <p className="text-[var(--nn-muted)] mt-2">{tag}</p>
      <div className="mt-4">
        <a className="inline-block px-3 py-2 rounded-md text-sm bg-[var(--nn-purple)]" href={`/guilds`}>Explore</a>
      </div>
    </article>
  )
}
EOF

# public/logo.svg
cat > public/logo.svg <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400" role="img" aria-labelledby="title desc">
  <title id="title">NeuralNexus logo</title>
  <desc id="desc">Circular network of nodes forming an N-shaped path in purple and cyan</desc>
  <defs>
    <linearGradient id="g" x1="0%" x2="100%" y1="0%" y2="100%">
      <stop offset="0%" stop-color="#7C3AED"/>
      <stop offset="100%" stop-color="#00B5D8"/>
    </linearGradient>
    <style>
      .stroke { stroke: url(#g); stroke-width:8; fill:none; stroke-linecap:round; stroke-linejoin:round;}
      .node { fill: url(#g); stroke:#0B1220; stroke-width:2; }
    </style>
  </defs>

  <!-- circle background -->
  <circle cx="200" cy="200" r="190" fill="none" stroke="#0F1724" stroke-width="4" />

  <!-- N-shaped path with rounded corners -->
  <path class="stroke" d="M120 280 L180 140 L240 260 L300 120" />

  <!-- nodes along the path -->
  <circle class="node" cx="120" cy="280" r="12"/>
  <circle class="node" cx="180" cy="140" r="12"/>
  <circle class="node" cx="240" cy="260" r="12"/>
  <circle class="node" cx="300" cy="120" r="12"/>

  <!-- micro connectors -->
  <line x1="160" y1="300" x2="200" y2="320" stroke="url(#g)" stroke-width="4" stroke-linecap="round" />
  <line x1="230" y1="100" x2="260" y2="80" stroke="url(#g)" stroke-width="4" stroke-linecap="round" />
</svg>
EOF

# README.md
cat > README.md <<'EOF'
# NeuralNexus — Website

Starter site built with Next.js + TypeScript + TailwindCSS.

## What’s included
- Next.js app (TypeScript)
- Tailwind CSS + brand tokens
- Logo (SVG) in /public
- Basic pages: Home + components

## Local dev
1. Install
   npm install
2. Dev
   npm run dev
3. Build
   npm run build
4. Start
   npm start

## To push to GitHub (example)
1. Create a repo on GitHub or confirm I create `NeuralNexus` under your account.
2. Locally:
   git init
   git add .
   git commit -m "chore: initial NeuralNexus site"
   git branch -M main
   git remote add origin git@github.com:TheeJuniorDev/NeuralNexus.git
   git push -u origin main

## Deploy
I recommend Vercel. Connect the GitHub repo for automatic deploys. Use environment variables later for API keys and member services.

## Next steps
- Add guild pages, contribution guidelines, and community onboarding flow
- Add authentication and member dashboard
- Integrate Discord invites and contribution tracking
- Add continuous integration (lint/test) workflow
EOF

# .gitignore
cat > .gitignore <<'EOF'
node_modules
.next
.env.local
.vercel
.DS_Store
dist
coverage
EOF

# next-env.d.ts
cat > next-env.d.ts <<'EOF'
/// <reference types="next" />
/// <reference types="next/types/global" />
/// <reference types="next/image-types/global" />

// NOTE: This file should not be edited
EOF

# .eslintrc.json
cat > .eslintrc.json <<'EOF'
{
  "extends": "next/core-web-vitals",
  "rules": {
    "semi": ["error", "always"],
    "quotes": ["error", "single"]
  }
}
EOF

# .github/workflows/ci.yml
cat > .github/workflows/ci.yml <<'EOF'
name: CI — Lint & Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    name: Install → Lint → Build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run lint
        run: npm run lint

      - name: Build
        run: npm run build

      - name: Upload build artifact
        if: success()
        uses: actions/upload-artifact@v4
        with:
          name: next-build
          path: .next
EOF

# .github/workflows/vercel-deploy.yml
cat > .github/workflows/vercel-deploy.yml <<'EOF'
name: Vercel Deploy (optional)

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  vercel-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '18'

      - name: Install
        run: npm ci

      - name: Build (pre-deploy check)
        run: npm run build

      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}        # Required
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}      # Required
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }} # Required
          working-directory: ./
          prod: true
EOF

# Create zip
ZIP_NAME="NeuralNexus.zip"
echo "Creating ZIP: $ZIP_NAME"
# Exclude node_modules if present
zip -r "$ZIP_NAME" . -x "node_modules/*" > /dev/null

echo "Done. Created $ROOT_DIR/$ZIP_NAME"
echo "To open folder: cd .. && ls -la $ROOT_DIR"
echo "If you want to push to GitHub, cd $ROOT_DIR and run the git commands in README.md"
EOF