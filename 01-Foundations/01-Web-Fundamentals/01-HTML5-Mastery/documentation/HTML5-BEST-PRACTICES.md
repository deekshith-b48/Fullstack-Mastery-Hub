# HTML5 Best Practices

## 📋 Table of Contents

1. [Semantic HTML](#semantic-html)
2. [Performance Optimization](#performance-optimization)
3. [Accessibility](#accessibility)
4. [SEO Best Practices](#seo-best-practices)
5. [Code Organization](#code-organization)
6. [Security](#security)
7. [Browser Compatibility](#browser-compatibility)

## Semantic HTML

### Use Semantic Elements

✅ **Good:**
```html
<header>
    <nav>
        <ul>
            <li><a href="/">Home</a></li>
        </ul>
    </nav>
</header>
<main>
    <article>
        <h1>Article Title</h1>
        <p>Content...</p>
    </article>
</main>
<footer>
    <p>&copy; 2024</p>
</footer>
```

❌ **Bad:**
```html
<div class="header">
    <div class="nav">
        <div class="nav-item">Home</div>
    </div>
</div>
<div class="main">
    <div class="article">
        <div class="title">Article Title</div>
        <div>Content...</div>
    </div>
</div>
```

### Proper Heading Hierarchy

✅ **Good:**
```html
<h1>Main Title</h1>
<h2>Section Title</h2>
<h3>Subsection Title</h3>
<h3>Another Subsection</h3>
<h2>Another Section</h2>
```

❌ **Bad:**
```html
<h1>Main Title</h1>
<h3>Section Title</h3> <!-- Skipped h2 -->
<h2>Subsection Title</h2> <!-- Wrong order -->
```

### Use Appropriate Elements

✅ **Good:**
```html
<button type="button">Click me</button>
<label for="email">Email:</label>
<input type="email" id="email" name="email">
```

❌ **Bad:**
```html
<div onclick="doSomething()">Click me</div>
<span>Email:</span>
<input type="email">
```

## Performance Optimization

### Minimize HTML Size

- Remove unnecessary whitespace and comments in production
- Use minification tools
- Avoid inline styles (use CSS files)
- Minimize use of inline JavaScript

### Optimize Images

✅ **Good:**
```html
<img src="image.webp" alt="Description" 
     srcset="image-400.webp 400w, image-800.webp 800w"
     sizes="(max-width: 600px) 400px, 800px"
     loading="lazy">
```

❌ **Bad:**
```html
<img src="large-unoptimized-image.jpg" alt="Description">
```

### Script Loading

✅ **Good:**
```html
<!-- Defer: Scripts execute after HTML parsing -->
<script src="script.js" defer></script>

<!-- Async: Scripts execute as soon as loaded -->
<script src="analytics.js" async></script>
```

❌ **Bad:**
```html
<!-- Blocks HTML parsing -->
<script src="script.js"></script>
```

### Preload Critical Resources

```html
<link rel="preload" href="font.woff2" as="font" type="font/woff2" crossorigin>
<link rel="preload" href="critical.css" as="style">
<link rel="preload" href="critical.js" as="script">
```

## Accessibility

### Always Provide Alt Text

✅ **Good:**
```html
<img src="photo.jpg" alt="A beautiful sunset over the mountains">
```

❌ **Bad:**
```html
<img src="photo.jpg">
<img src="photo.jpg" alt="image">
<img src="decorative.jpg" alt="Decorative image"> <!-- Use empty alt for decorative -->
```

✅ **For Decorative Images:**
```html
<img src="decorative-border.jpg" alt="">
```

### Form Labels

✅ **Good:**
```html
<label for="email">Email Address:</label>
<input type="email" id="email" name="email">

<!-- Or implicit label -->
<label>
    Email Address:
    <input type="email" name="email">
</label>
```

❌ **Bad:**
```html
<span>Email:</span>
<input type="email" name="email">
```

### ARIA Attributes

Use ARIA when HTML semantics aren't enough:

✅ **Good:**
```html
<button aria-label="Close dialog" aria-expanded="false">
    ×
</button>

<div role="alert" aria-live="polite">
    Form submitted successfully
</div>
```

### Keyboard Navigation

Ensure all interactive elements are keyboard accessible:

✅ **Good:**
```html
<button type="button">Click me</button>
<a href="/page">Link</a>
```

❌ **Bad:**
```html
<div onclick="doSomething()">Click me</div> <!-- Not keyboard accessible -->
```

### Focus Management

```html
<!-- Skip link for keyboard users -->
<a href="#main-content" class="skip-link">Skip to main content</a>

<main id="main-content">
    <!-- Content -->
</main>
```

## SEO Best Practices

### Meta Tags

```html
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Essential SEO meta tags -->
    <title>Page Title - Site Name</title>
    <meta name="description" content="Compelling 150-160 character description">
    <meta name="keywords" content="keyword1, keyword2, keyword3">
    
    <!-- Open Graph for social sharing -->
    <meta property="og:title" content="Page Title">
    <meta property="og:description" content="Description">
    <meta property="og:image" content="https://example.com/image.jpg">
    <meta property="og:url" content="https://example.com/page">
    
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="Page Title">
    <meta name="twitter:description" content="Description">
</head>
```

### Semantic Structure

Search engines use semantic HTML:

✅ **Good:**
```html
<article itemscope itemtype="https://schema.org/Article">
    <h1 itemprop="headline">Article Title</h1>
    <p itemprop="description">Article description...</p>
    <time itemprop="datePublished" datetime="2024-01-15">January 15, 2024</time>
</article>
```

### Descriptive URLs

✅ **Good:**
```
https://example.com/blog/html5-best-practices
```

❌ **Bad:**
```
https://example.com/page?id=123&cat=blog
```

## Code Organization

### Indentation and Formatting

✅ **Good:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
            </ul>
        </nav>
    </header>
</body>
</html>
```

### Comments

Use comments to organize code:

```html
<!-- Header Section -->
<header>
    <!-- Navigation -->
    <nav>
        <!-- Navigation links -->
        <ul>
            <li><a href="/">Home</a></li>
        </ul>
    </nav>
</header>

<!-- Main Content -->
<main>
    <!-- Article -->
    <article>
        <!-- Content -->
    </article>
</main>
```

### Separate Concerns

✅ **Good:**
```html
<!-- Structure in HTML -->
<div class="card">
    <h2>Title</h2>
    <p>Content</p>
</div>

<!-- Style in CSS -->
<style>
.card { ... }
</style>

<!-- Behavior in JavaScript -->
<script>
document.querySelector('.card').addEventListener('click', ...);
</script>
```

❌ **Bad:**
```html
<div style="color: red; font-size: 20px;" onclick="alert('clicked')">
    Content
</div>
```

## Security

### Input Validation

Always validate on server-side, but also use HTML5 validation:

✅ **Good:**
```html
<form method="POST" action="/submit">
    <input type="email" name="email" required 
           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
    <input type="password" name="password" required minlength="8">
    <button type="submit">Submit</button>
</form>
```

### XSS Prevention

✅ **Good:**
```html
<!-- Escape user-generated content server-side -->
<p>{{ escaped_user_content }}</p>
```

❌ **Bad:**
```html
<!-- Never do this -->
<div>{{ unescaped_user_content }}</div>
```

### Content Security Policy

```html
<meta http-equiv="Content-Security-Policy" 
      content="default-src 'self'; script-src 'self' 'unsafe-inline';">
```

## Browser Compatibility

### Feature Detection

```html
<script>
if ('geolocation' in navigator) {
    // Use geolocation API
} else {
    // Fallback
}
</script>
```

### Polyfills

Include polyfills for older browsers when needed:

```html
<!-- Polyfill for older browsers -->
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
```

### Progressive Enhancement

Build from basic to advanced:

```html
<!-- Basic functionality first -->
<a href="/page">Go to page</a>

<!-- Enhance with JavaScript -->
<a href="/page" id="ajax-link">Go to page</a>
<script>
document.getElementById('ajax-link').addEventListener('click', function(e) {
    e.preventDefault();
    // Load via AJAX
});
</script>
```

## Validation

### Always Validate HTML

- Use W3C Validator: https://validator.w3.org/
- Fix errors before production
- Address warnings when possible

### HTML5 Specific Validation

- Ensure proper DOCTYPE: `<!DOCTYPE html>`
- Use proper character encoding: `<meta charset="UTF-8">`
- Validate semantic structure
- Check ARIA attributes

## Common Mistakes to Avoid

### 1. Missing Viewport Meta Tag

❌ **Bad:**
```html
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
```

✅ **Good:**
```html
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
</head>
```

### 2. Using Divs for Everything

Always prefer semantic elements over generic divs.

### 3. Missing Alt Text

Always provide meaningful alt text for images.

### 4. Inline Styles and Scripts

Use external files for CSS and JavaScript.

### 5. Deprecated Elements

Avoid: `<center>`, `<font>`, `<frame>`, `<marquee>`, etc.

---

**Remember**: Write semantic, accessible, and maintainable HTML5 code!

