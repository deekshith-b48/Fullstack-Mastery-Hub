# HTML5 Accessibility Guide

## 📋 Table of Contents

1. [Introduction to Web Accessibility](#introduction-to-web-accessibility)
2. [Semantic HTML for Accessibility](#semantic-html-for-accessibility)
3. [ARIA Attributes](#aria-attributes)
4. [Keyboard Navigation](#keyboard-navigation)
5. [Forms and Accessibility](#forms-and-accessibility)
6. [Images and Media](#images-and-media)
7. [Testing Accessibility](#testing-accessibility)
8. [WCAG Guidelines](#wcag-guidelines)

## Introduction to Web Accessibility

Web accessibility means making websites usable by everyone, including people with disabilities. HTML5 provides many features that help create accessible web content.

### Why Accessibility Matters

- **Legal**: Many countries require accessible websites
- **Ethical**: Everyone deserves access to information
- **Business**: Larger audience reach
- **SEO**: Search engines favor accessible sites

### Types of Disabilities to Consider

- Visual (blindness, low vision, color blindness)
- Auditory (deafness, hard of hearing)
- Motor (limited fine motor control)
- Cognitive (learning disabilities, attention disorders)

## Semantic HTML for Accessibility

### Use Proper Heading Structure

✅ **Good:**
```html
<h1>Main Page Title</h1>
<h2>Section Title</h2>
<h3>Subsection Title</h3>
<h2>Another Section</h2>
```

❌ **Bad:**
```html
<div class="title">Main Title</div>
<div class="section">Section</div>
```

### Landmark Elements

HTML5 semantic elements act as landmarks for screen readers:

```html
<header>    <!-- Banner landmark -->
<nav>       <!-- Navigation landmark -->
<main>      <!-- Main content landmark -->
<article>   <!-- Article landmark -->
<section>   <!-- Region landmark -->
<aside>     <!-- Complementary landmark -->
<footer>    <!-- Contentinfo landmark -->
```

### Proper Document Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Accessible Page</title>
</head>
<body>
    <!-- Skip link for keyboard users -->
    <a href="#main-content" class="skip-link">Skip to main content</a>
    
    <header role="banner">
        <nav role="navigation" aria-label="Main navigation">
            <!-- Navigation -->
        </nav>
    </header>
    
    <main id="main-content" role="main">
        <!-- Main content -->
    </main>
    
    <aside role="complementary" aria-label="Sidebar">
        <!-- Sidebar content -->
    </aside>
    
    <footer role="contentinfo">
        <!-- Footer content -->
    </footer>
</body>
</html>
```

## ARIA Attributes

ARIA (Accessible Rich Internet Applications) supplements HTML when semantics aren't enough.

### Common ARIA Attributes

#### aria-label

Provides accessible name for element:

```html
<button aria-label="Close dialog">×</button>
<nav aria-label="Main navigation">
    <!-- Navigation -->
</nav>
```

#### aria-labelledby

References another element that labels this one:

```html
<div aria-labelledby="dialog-title" role="dialog">
    <h2 id="dialog-title">Confirm Action</h2>
    <p>Are you sure?</p>
</div>
```

#### aria-describedby

References element that describes this one:

```html
<input type="text" 
       aria-describedby="email-help"
       aria-label="Email address">
<div id="email-help">Enter your email address</div>
```

#### aria-hidden

Hides decorative content from screen readers:

```html
<!-- Decorative icon -->
<span aria-hidden="true">★</span>

<!-- Important content remains accessible -->
<span>5 stars</span>
```

#### aria-live

Announces dynamic content changes:

```html
<div aria-live="polite" aria-atomic="true">
    <!-- Updates announced to screen readers -->
</div>

<!-- Values: off, polite, assertive -->
```

#### aria-expanded

Indicates if collapsible content is open:

```html
<button aria-expanded="false" aria-controls="menu">
    Menu
</button>
<ul id="menu" hidden>
    <li>Item 1</li>
</ul>
```

### ARIA Roles

Use semantic HTML instead, but ARIA roles help when needed:

```html
<!-- Navigation -->
<nav role="navigation">

<!-- Search -->
<form role="search">

<!-- Alert -->
<div role="alert">Important message!</div>

<!-- Dialog -->
<div role="dialog" aria-labelledby="dialog-title">
    <h2 id="dialog-title">Dialog Title</h2>
</div>
```

## Keyboard Navigation

### Focusable Elements

Ensure interactive elements are keyboard accessible:

✅ **Good:**
```html
<button>Click me</button>
<a href="/page">Link</a>
<input type="text">
<select>
    <option>Option 1</option>
</select>
```

❌ **Bad:**
```html
<div onclick="doSomething()">Click me</div>
<div role="button" tabindex="0">Custom button</div>
```

### Tab Order

Control tab order with `tabindex`:

```html
<!-- Natural tab order -->
<button>First</button>
<button>Second</button>

<!-- Custom tab order (use sparingly) -->
<button tabindex="3">Third in tab order</button>
<button tabindex="1">First in tab order</button>

<!-- Remove from tab order -->
<button tabindex="-1">Not focusable</button>
```

### Skip Links

Help keyboard users skip repetitive content:

```html
<a href="#main-content" class="skip-link">
    Skip to main content
</a>

<style>
.skip-link {
    position: absolute;
    top: -40px;
    left: 0;
    background: #000;
    color: #fff;
    padding: 8px;
    text-decoration: none;
}
.skip-link:focus {
    top: 0;
}
</style>

<main id="main-content">
    <!-- Main content -->
</main>
```

### Focus Indicators

Ensure focus is visible:

```css
/* Default browser focus styles are usually good */
button:focus {
    outline: 2px solid blue;
    outline-offset: 2px;
}

/* Custom focus styles */
a:focus,
button:focus {
    outline: 3px solid #0066cc;
    outline-offset: 2px;
    box-shadow: 0 0 0 4px rgba(0, 102, 204, 0.3);
}
```

## Forms and Accessibility

### Labels

Always associate labels with form controls:

✅ **Good:**
```html
<!-- Explicit association -->
<label for="email">Email:</label>
<input type="email" id="email" name="email">

<!-- Implicit association -->
<label>
    Email:
    <input type="email" name="email">
</label>
```

❌ **Bad:**
```html
<span>Email:</span>
<input type="email" name="email">
```

### Fieldsets and Legends

Group related form fields:

```html
<fieldset>
    <legend>Shipping Address</legend>
    <label for="street">Street:</label>
    <input type="text" id="street" name="street">
    
    <label for="city">City:</label>
    <input type="text" id="city" name="city">
</fieldset>

<fieldset>
    <legend>Billing Address</legend>
    <!-- Billing fields -->
</fieldset>
```

### Required Fields

Indicate required fields clearly:

```html
<label for="name">
    Name <span aria-label="required">*</span>
</label>
<input type="text" id="name" name="name" required 
       aria-required="true">

<!-- Or -->
<label for="email">Email (required):</label>
<input type="email" id="email" name="email" required>
```

### Error Messages

Associate error messages with fields:

```html
<label for="email">Email:</label>
<input type="email" 
       id="email" 
       name="email"
       aria-invalid="true"
       aria-describedby="email-error email-help">
<div id="email-error" role="alert" aria-live="polite">
    Please enter a valid email address
</div>
<div id="email-help">We'll never share your email</div>
```

### Autocomplete

Help users with form filling:

```html
<input type="text" 
       name="address-line1"
       autocomplete="street-address"
       aria-label="Street address">

<input type="email" 
       name="email"
       autocomplete="email">

<input type="tel" 
       name="phone"
       autocomplete="tel">
```

## Images and Media

### Alt Text Guidelines

**Descriptive alt text:**
```html
<img src="chart.jpg" alt="Sales increased 25% from Q1 to Q2">
```

**Decorative images (empty alt):**
```html
<img src="decorative-border.jpg" alt="">
```

**Functional images:**
```html
<a href="/home">
    <img src="logo.png" alt="Company Home">
</a>
```

**Complex images (long descriptions):**
```html
<img src="chart.jpg" 
     alt="Sales chart showing Q1 to Q2 growth"
     longdesc="chart-description.html">

<!-- Or -->
<figure>
    <img src="chart.jpg" alt="Sales chart">
    <figcaption>Sales increased 25% from Q1 to Q2</figcaption>
</figure>
```

### Video Accessibility

```html
<video controls>
    <source src="video.mp4" type="video/mp4">
    <track kind="captions" 
           src="captions.vtt" 
           srclang="en" 
           label="English">
    <track kind="descriptions" 
           src="descriptions.vtt" 
           srclang="en">
</video>
```

### Audio Accessibility

```html
<audio controls>
    <source src="audio.mp3" type="audio/mpeg">
    <!-- Provide transcript -->
    <p><a href="transcript.txt">Audio transcript</a></p>
</audio>
```

## Testing Accessibility

### Automated Testing Tools

- **WAVE**: https://wave.webaim.org/
- **axe DevTools**: Browser extension
- **Lighthouse**: Chrome DevTools
- **Pa11y**: Command-line tool

### Screen Reader Testing

- **NVDA** (Windows, free)
- **JAWS** (Windows, paid)
- **VoiceOver** (Mac/iOS, built-in)
- **TalkBack** (Android, built-in)

### Keyboard Testing

1. Remove mouse
2. Navigate using Tab, Shift+Tab, Enter, Space, Arrow keys
3. Ensure all functionality works
4. Check focus indicators are visible

### Color Contrast

Ensure sufficient color contrast (WCAG AA requires 4.5:1 for text):

- Use tools: https://webaim.org/resources/contrastchecker/
- Test color combinations
- Don't rely on color alone

## WCAG Guidelines

### Perceivable

- Provide text alternatives for images
- Provide captions for videos
- Ensure sufficient color contrast
- Make content adaptable

### Operable

- Make all functionality keyboard accessible
- Give users enough time
- Don't use content that causes seizures
- Provide ways to navigate

### Understandable

- Make text readable
- Make content appear and operate predictably
- Help users avoid and correct mistakes

### Robust

- Maximize compatibility with assistive technologies
- Use valid, semantic HTML

### WCAG Levels

- **Level A**: Basic accessibility (minimum)
- **Level AA**: Enhanced accessibility (recommended)
- **Level AAA**: Highest accessibility (ideal)

## Common Accessibility Patterns

### Accessible Modal Dialog

```html
<div role="dialog" 
     aria-labelledby="dialog-title"
     aria-modal="true"
     tabindex="-1">
    <h2 id="dialog-title">Dialog Title</h2>
    <button aria-label="Close dialog">×</button>
    <div>
        <!-- Dialog content -->
    </div>
</div>
```

### Accessible Dropdown Menu

```html
<nav aria-label="Main menu">
    <button aria-expanded="false" 
            aria-haspopup="true"
            aria-controls="menu">
        Menu
    </button>
    <ul id="menu" role="menu" hidden>
        <li role="menuitem"><a href="/">Home</a></li>
        <li role="menuitem"><a href="/about">About</a></li>
    </ul>
</nav>
```

### Accessible Form Validation

```html
<form>
    <label for="email">Email:</label>
    <input type="email" 
           id="email"
           name="email"
           required
           aria-invalid="false"
           aria-describedby="email-error">
    <div id="email-error" 
         role="alert" 
         aria-live="polite"
         class="error-message"
         hidden>
        Please enter a valid email
    </div>
</form>
```

## Quick Accessibility Checklist

- [ ] All images have alt text
- [ ] Form inputs have labels
- [ ] Headings are in proper hierarchy
- [ ] Semantic HTML elements used
- [ ] Keyboard navigation works
- [ ] Focus indicators visible
- [ ] Color contrast sufficient
- [ ] ARIA attributes used appropriately
- [ ] Page structure is logical
- [ ] Error messages are associated with fields

---

**Remember**: Accessibility is not optional—it's essential for inclusive web design!

