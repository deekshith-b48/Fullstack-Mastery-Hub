# Vite - Deep Dive Guide

## 📚 What is Vite?

Vite is a next-generation frontend build tool that provides a faster development experience with instant server start and lightning-fast HMR (Hot Module Replacement).

## 🚀 Installation

```bash
# Create new project
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

## ⚡ Key Features

### Instant Server Start

Vite uses native ES modules, so the dev server starts instantly without bundling.

### Lightning Fast HMR

Hot Module Replacement is extremely fast - only the changed module is updated.

### Optimized Production Build

Uses Rollup for optimized production builds.

## 📁 Project Structure

```
my-app/
├── index.html          # Entry point
├── src/
│   ├── main.jsx        # App entry
│   ├── App.jsx
│   └── style.css
├── public/
├── vite.config.js      # Configuration
└── package.json
```

## ⚙️ Configuration

```javascript
// vite.config.js
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    open: true,
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
  },
});
```

## 🔧 Features

### CSS Preprocessing

```javascript
// Install sass
npm install -D sass

// Use in components
import './styles.scss';
```

### Environment Variables

```javascript
// .env
VITE_API_URL=https://api.example.com

// Use in code
const apiUrl = import.meta.env.VITE_API_URL;
```

### Path Aliases

```javascript
// vite.config.js
export default defineConfig({
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
});

// Usage
import Component from '@/components/Component';
```

---

**Next**: Learn about [Webpack](./WEBPACK-MASTERY.md)

