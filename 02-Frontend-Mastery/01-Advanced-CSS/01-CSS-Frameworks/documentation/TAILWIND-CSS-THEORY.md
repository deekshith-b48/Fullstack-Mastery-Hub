# Tailwind CSS - Complete Guide

## 📚 Overview

Tailwind CSS is a utility-first CSS framework that provides low-level utility classes to build custom designs.

## 🚀 Installation

### Via CDN (Development)

```html
<script src="https://cdn.tailwindcss.com"></script>
```

### Via npm

```bash
npm install -D tailwindcss
npx tailwindcss init
```

### Configuration

```javascript
// tailwind.config.js
module.exports = {
  content: ["./src/**/*.{html,js}"],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

### CSS Setup

```css
/* input.css */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

## 🎯 Core Concepts

### Utility Classes

```html
<!-- Spacing -->
<div class="p-4 m-2">Padding and margin</div>
<div class="px-6 py-4">Horizontal and vertical padding</div>

<!-- Colors -->
<div class="bg-blue-500 text-white">Background and text color</div>
<div class="hover:bg-blue-600">Hover state</div>

<!-- Typography -->
<h1 class="text-4xl font-bold">Large bold heading</h1>
<p class="text-gray-600 text-center">Centered gray text</p>

<!-- Layout -->
<div class="flex items-center justify-between">Flexbox layout</div>
<div class="grid grid-cols-3 gap-4">Grid layout</div>

<!-- Responsive -->
<div class="w-full md:w-1/2 lg:w-1/3">Responsive widths</div>
```

### Responsive Design

```html
<!-- Mobile first approach -->
<div class="
  text-sm          <!-- Default (mobile) -->
  md:text-base     <!-- Medium screens and up -->
  lg:text-lg       <!-- Large screens and up -->
  xl:text-xl       <!-- Extra large screens -->
">
  Responsive text
</div>

<!-- Breakpoints -->
sm:  640px
md:  768px
lg:  1024px
xl:  1280px
2xl: 1536px
```

### State Variants

```html
<!-- Hover -->
<button class="bg-blue-500 hover:bg-blue-600">Hover me</button>

<!-- Focus -->
<input class="focus:ring-2 focus:ring-blue-500">

<!-- Active -->
<button class="active:scale-95">Click me</button>

<!-- Disabled -->
<button class="disabled:opacity-50" disabled>Disabled</button>
```

### Dark Mode

```html
<!-- Enable in config -->
// tailwind.config.js
module.exports = {
  darkMode: 'class', // or 'media'
  // ...
}

<!-- Usage -->
<div class="bg-white dark:bg-gray-800">
  <p class="text-gray-900 dark:text-white">Content</p>
</div>
```

## 🎨 Customization

### Theme Configuration

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        'brand-blue': '#1e40af',
        'brand-red': '#dc2626',
      },
      spacing: {
        '72': '18rem',
        '84': '21rem',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
}
```

### Custom Utilities

```css
/* Using @layer */
@layer utilities {
  .text-shadow {
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
  }
  
  .scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }
}
```

### Component Classes

```css
@layer components {
  .btn-primary {
    @apply px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600;
  }
  
  .card {
    @apply bg-white rounded-lg shadow-md p-6;
  }
}
```

## 📝 Best Practices

### Composition

```html
<!-- Good: Use utility classes -->
<button class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
  Button
</button>

<!-- Better: Extract to component class -->
<button class="btn-primary">Button</button>
```

### Performance

- Use PurgeCSS (built-in) to remove unused CSS
- Configure content paths properly
- Avoid dynamic class names in JavaScript

### Organization

```html
<!-- Group related utilities -->
<div class="
  flex items-center justify-between
  p-4 m-2
  bg-white rounded-lg shadow
  hover:shadow-lg transition-shadow
">
  Card content
</div>
```

## 🔧 Advanced Features

### Arbitrary Values

```html
<!-- Custom values -->
<div class="w-[500px]">Custom width</div>
<div class="bg-[#1da1f2]">Custom color</div>
<div class="grid-cols-[1fr_500px_2fr]">Custom grid</div>
```

### JIT Mode

```javascript
// tailwind.config.js
module.exports = {
  mode: 'jit', // Just-in-Time mode
  // Generates CSS on-demand
}
```

### Plugins

```javascript
// tailwind.config.js
const forms = require('@tailwindcss/forms');
const typography = require('@tailwindcss/typography');

module.exports = {
  plugins: [forms, typography],
}
```

## 📚 Common Patterns

### Card Component

```html
<div class="max-w-sm mx-auto bg-white rounded-xl shadow-lg overflow-hidden">
  <div class="p-8">
    <div class="uppercase tracking-wide text-sm text-indigo-500 font-semibold">
      Card Title
    </div>
    <p class="mt-2 text-gray-500">Card description</p>
  </div>
</div>
```

### Navigation

```html
<nav class="bg-white shadow-lg">
  <div class="max-w-7xl mx-auto px-4">
    <div class="flex justify-between h-16">
      <div class="flex items-center">
        <a href="#" class="text-xl font-bold">Logo</a>
      </div>
      <div class="flex space-x-4">
        <a href="#" class="px-3 py-2 hover:bg-gray-100">Home</a>
        <a href="#" class="px-3 py-2 hover:bg-gray-100">About</a>
      </div>
    </div>
  </div>
</nav>
```

---

**Next**: Learn about [Bootstrap](./BOOTSTRAP-THEORY.md)

