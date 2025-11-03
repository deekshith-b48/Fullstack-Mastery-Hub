# HTML5 Theory - Complete Guide

## 📚 Table of Contents

1. [Introduction to HTML5](#introduction-to-html5)
2. [Document Structure](#document-structure)
3. [Semantic Elements](#semantic-elements)
4. [Forms and Input Types](#forms-and-input-types)
5. [Multimedia Elements](#multimedia-elements)
6. [Canvas and SVG](#canvas-and-svg)
7. [Web Storage](#web-storage)
8. [APIs](#apis)
9. [Best Practices](#best-practices)

## Introduction to HTML5

HTML5 is the fifth and current major version of the HTML standard. It was published in October 2014 and represents a significant evolution from previous HTML versions.

### Key Improvements

- **Semantic HTML**: New semantic elements that describe content meaning
- **Multimedia Support**: Native audio and video support without plugins
- **Graphics**: Canvas for 2D graphics and improved SVG support
- **Form Enhancements**: New input types and validation attributes
- **APIs**: Rich set of JavaScript APIs for web applications
- **Offline Support**: Application cache and local storage

### HTML5 DOCTYPE

```html
<!DOCTYPE html>
```

The HTML5 DOCTYPE is incredibly simple compared to previous versions:

```html
<!-- Old HTML4 DOCTYPE -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- HTML5 DOCTYPE -->
<!DOCTYPE html>
```

## Document Structure

### Basic HTML5 Document

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Page description">
    <meta name="keywords" content="keywords, for, SEO">
    <meta name="author" content="Author Name">
    <title>Document Title</title>
</head>
<body>
    <!-- Content goes here -->
</body>
</html>
```

### Meta Tags

HTML5 introduced several important meta tags:

```html
<!-- Character encoding -->
<meta charset="UTF-8">

<!-- Viewport for responsive design -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- SEO Meta tags -->
<meta name="description" content="Page description">
<meta name="keywords" content="keyword1, keyword2">
<meta name="author" content="Author Name">

<!-- Open Graph (Facebook) -->
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Page Description">
<meta property="og:image" content="image-url.jpg">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Page Title">
```

## Semantic Elements

Semantic HTML5 elements provide meaning to the structure of web pages.

### Header and Footer

```html
<header>
    <h1>Site Title</h1>
    <nav>
        <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/about">About</a></li>
        </ul>
    </nav>
</header>

<footer>
    <p>&copy; 2024 Company Name. All rights reserved.</p>
    <nav>
        <a href="/privacy">Privacy Policy</a>
    </nav>
</footer>
```

### Navigation

```html
<nav>
    <ul>
        <li><a href="#home">Home</a></li>
        <li><a href="#about">About</a></li>
        <li><a href="#services">Services</a></li>
        <li><a href="#contact">Contact</a></li>
    </ul>
</nav>
```

### Article and Section

**Article**: Independent, self-contained content that could be distributed separately.

```html
<article>
    <header>
        <h2>Article Title</h2>
        <p>Published on <time datetime="2024-01-15">January 15, 2024</time></p>
    </header>
    <section>
        <h3>Introduction</h3>
        <p>Article introduction content...</p>
    </section>
    <section>
        <h3>Main Content</h3>
        <p>Main article content...</p>
    </section>
    <footer>
        <p>Author: John Doe</p>
    </footer>
</article>
```

**Section**: Thematic grouping of content.

```html
<section>
    <h2>Features</h2>
    <article>
        <h3>Feature 1</h3>
        <p>Feature description...</p>
    </article>
    <article>
        <h3>Feature 2</h3>
        <p>Feature description...</p>
    </article>
</section>
```

### Aside

Sidebar content that is tangentially related to main content.

```html
<aside>
    <h3>Related Articles</h3>
    <ul>
        <li><a href="/article1">Article 1</a></li>
        <li><a href="/article2">Article 2</a></li>
    </ul>
</aside>
```

### Main

The main content area. Only one `<main>` per page.

```html
<main>
    <article>
        <h1>Main Article Title</h1>
        <p>Main content...</p>
    </article>
</main>
```

### Figure and Figcaption

For images, diagrams, code, etc. with captions.

```html
<figure>
    <img src="image.jpg" alt="Description">
    <figcaption>Figure caption describing the image</figcaption>
</figure>

<figure>
    <pre><code>
        function example() {
            return "code";
        }
    </code></pre>
    <figcaption>Code example</figcaption>
</figure>
```

### Mark, Time, and Details

```html
<!-- Mark: Highlight text -->
<p>This is <mark>important</mark> text.</p>

<!-- Time: Machine-readable dates -->
<p>Published on <time datetime="2024-01-15T10:00:00">January 15, 2024</time></p>

<!-- Details: Expandable content -->
<details>
    <summary>Click to expand</summary>
    <p>Hidden content that appears when expanded.</p>
</details>
```

## Forms and Input Types

### New Input Types

HTML5 introduced many new input types for better validation and user experience:

```html
<!-- Email -->
<input type="email" name="email" placeholder="Enter email" required>

<!-- URL -->
<input type="url" name="website" placeholder="https://example.com">

<!-- Tel -->
<input type="tel" name="phone" placeholder="+1 234 567 8900">

<!-- Number -->
<input type="number" name="age" min="18" max="100" step="1">

<!-- Range -->
<input type="range" name="volume" min="0" max="100" value="50">

<!-- Date -->
<input type="date" name="birthday">

<!-- Time -->
<input type="time" name="appointment">

<!-- DateTime-local -->
<input type="datetime-local" name="event">

<!-- Week -->
<input type="week" name="week">

<!-- Month -->
<input type="month" name="month">

<!-- Color -->
<input type="color" name="favcolor" value="#ff0000">

<!-- Search -->
<input type="search" name="q" placeholder="Search...">

<!-- File -->
<input type="file" name="file" accept="image/*">
```

### Form Validation Attributes

```html
<form>
    <!-- Required field -->
    <input type="text" name="name" required>
    
    <!-- Pattern matching -->
    <input type="text" name="username" 
           pattern="[A-Za-z0-9]{5,}" 
           title="5 or more alphanumeric characters">
    
    <!-- Min/Max length -->
    <input type="text" name="pin" minlength="4" maxlength="4">
    
    <!-- Min/Max values (for numbers) -->
    <input type="number" name="age" min="18" max="120">
    
    <!-- Step (for numbers and dates) -->
    <input type="number" name="quantity" step="5" min="0">
    
    <!-- Placeholder -->
    <input type="text" placeholder="Enter your name">
    
    <!-- Autofocus -->
    <input type="text" autofocus>
    
    <!-- Disabled -->
    <input type="text" disabled>
    
    <!-- Readonly -->
    <input type="text" readonly value="Cannot edit">
    
    <!-- Multiple values -->
    <input type="file" multiple>
    <input type="email" multiple>
    
    <!-- Form validation message -->
    <input type="email" required 
           oninvalid="this.setCustomValidity('Please enter a valid email')"
           oninput="this.setCustomValidity('')">
</form>
```

### Form Elements

```html
<!-- Datalist: Predefined options -->
<label for="browser">Browser:</label>
<input list="browsers" name="browser" id="browser">
<datalist id="browsers">
    <option value="Chrome">
    <option value="Firefox">
    <option value="Safari">
    <option value="Edge">
</datalist>

<!-- Progress: Progress bar -->
<progress value="70" max="100">70%</progress>

<!-- Meter: Gauge/measurement -->
<meter value="0.6" min="0" max="1">60%</meter>

<!-- Output: Calculation results -->
<form oninput="result.value=parseInt(a.value)+parseInt(b.value)">
    <input type="number" id="a" value="10"> +
    <input type="number" id="b" value="20"> =
    <output name="result" for="a b">30</output>
</form>
```

## Multimedia Elements

### Audio

```html
<audio controls>
    <source src="audio.mp3" type="audio/mpeg">
    <source src="audio.ogg" type="audio/ogg">
    Your browser does not support the audio element.
</audio>

<!-- Audio with attributes -->
<audio controls autoplay loop muted preload="auto">
    <source src="background.mp3" type="audio/mpeg">
</audio>

<!-- Audio attributes -->
<!-- controls: Show controls -->
<!-- autoplay: Auto-play (use carefully) -->
<!-- loop: Loop playback -->
<!-- muted: Muted by default -->
<!-- preload: none | metadata | auto -->
```

### Video

```html
<video controls width="640" height="360">
    <source src="video.mp4" type="video/mp4">
    <source src="video.webm" type="video/webm">
    Your browser does not support the video element.
</video>

<!-- Video with poster (thumbnail) -->
<video controls poster="thumbnail.jpg">
    <source src="video.mp4" type="video/mp4">
</video>

<!-- Full video attributes -->
<video 
    controls 
    autoplay 
    loop 
    muted 
    preload="metadata"
    width="640" 
    height="360"
    poster="thumbnail.jpg">
    <source src="video.mp4" type="video/mp4">
    <source src="video.webm" type="video/webm">
    <track kind="subtitles" src="subtitles.vtt" srclang="en" label="English">
    Your browser does not support the video element.
</video>
```

## Canvas and SVG

### Canvas - 2D Graphics

```html
<canvas id="myCanvas" width="800" height="600"></canvas>

<script>
const canvas = document.getElementById('myCanvas');
const ctx = canvas.getContext('2d');

// Draw rectangle
ctx.fillStyle = 'red';
ctx.fillRect(10, 10, 100, 100);

// Draw circle
ctx.beginPath();
ctx.arc(200, 100, 50, 0, 2 * Math.PI);
ctx.fillStyle = 'blue';
ctx.fill();

// Draw text
ctx.font = '30px Arial';
ctx.fillStyle = 'black';
ctx.fillText('Hello Canvas', 300, 100);

// Draw line
ctx.beginPath();
ctx.moveTo(400, 50);
ctx.lineTo(500, 150);
ctx.strokeStyle = 'green';
ctx.lineWidth = 5;
ctx.stroke();
</script>
```

### SVG - Vector Graphics

```html
<svg width="400" height="400">
    <!-- Rectangle -->
    <rect x="10" y="10" width="100" height="100" fill="blue" stroke="black" stroke-width="2"/>
    
    <!-- Circle -->
    <circle cx="200" cy="100" r="50" fill="red"/>
    
    <!-- Ellipse -->
    <ellipse cx="300" cy="200" rx="80" ry="40" fill="green"/>
    
    <!-- Line -->
    <line x1="0" y1="300" x2="400" y2="300" stroke="black" stroke-width="2"/>
    
    <!-- Polyline -->
    <polyline points="10,350 50,340 90,360 130,330" fill="none" stroke="purple" stroke-width="3"/>
    
    <!-- Polygon -->
    <polygon points="200,350 240,330 280,340 260,370" fill="orange"/>
    
    <!-- Text -->
    <text x="300" y="350" fill="black" font-size="20">SVG Text</text>
    
    <!-- Path -->
    <path d="M 350 100 L 380 150 L 400 100" fill="none" stroke="black" stroke-width="2"/>
</svg>
```

## Web Storage

### LocalStorage

```html
<script>
// Set item
localStorage.setItem('username', 'john_doe');
localStorage.setItem('user', JSON.stringify({name: 'John', age: 30}));

// Get item
const username = localStorage.getItem('username');
const user = JSON.parse(localStorage.getItem('user'));

// Remove item
localStorage.removeItem('username');

// Clear all
localStorage.clear();

// Get key name by index
const key = localStorage.key(0);
</script>
```

### SessionStorage

```html
<script>
// SessionStorage works the same as localStorage
// but data persists only for the session

sessionStorage.setItem('sessionId', 'abc123');
const sessionId = sessionStorage.getItem('sessionId');
</script>
```

## APIs

### Geolocation API

```html
<script>
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
        function(position) {
            console.log('Latitude:', position.coords.latitude);
            console.log('Longitude:', position.coords.longitude);
        },
        function(error) {
            console.error('Error:', error);
        }
    );
}
</script>
```

### Drag and Drop API

```html
<div id="dragElement" draggable="true">Drag me</div>
<div id="dropZone">Drop here</div>

<script>
const dragElement = document.getElementById('dragElement');
const dropZone = document.getElementById('dropZone');

dragElement.addEventListener('dragstart', function(e) {
    e.dataTransfer.setData('text', e.target.id);
});

dropZone.addEventListener('dragover', function(e) {
    e.preventDefault();
});

dropZone.addEventListener('drop', function(e) {
    e.preventDefault();
    const data = e.dataTransfer.getData('text');
    e.target.appendChild(document.getElementById(data));
});
</script>
```

## Best Practices

### Semantic HTML

1. Use semantic elements instead of divs
2. One `<main>` per page
3. Use headings in order (h1, h2, h3...)
4. Use `<article>` for independent content
5. Use `<section>` for thematic grouping

### Accessibility

1. Always provide alt text for images
2. Use proper heading hierarchy
3. Provide labels for form inputs
4. Use ARIA attributes when needed
5. Ensure keyboard navigation works

### Performance

1. Minimize HTML structure
2. Use appropriate meta tags
3. Optimize images before embedding
4. Use async/defer for scripts
5. Minimize inline styles

### SEO

1. Use semantic HTML
2. Proper meta tags
3. Descriptive alt text
4. Clean URL structure
5. Mobile-friendly design

---

**Next Steps**: Review [HTML5-SETUP.md](./HTML5-SETUP.md) for installation and configuration.

