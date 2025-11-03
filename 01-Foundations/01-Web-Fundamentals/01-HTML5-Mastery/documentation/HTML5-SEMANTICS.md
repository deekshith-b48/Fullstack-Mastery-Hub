# HTML5 Semantics - Deep Dive

## 📋 Table of Contents

1. [What is Semantic HTML?](#what-is-semantic-html)
2. [Semantic Elements Overview](#semantic-elements-overview)
3. [Content Sectioning](#content-sectioning)
4. [Text Content](#text-content)
5. [Forms](#forms)
6. [Embedded Content](#embedded-content)
7. [Interactive Elements](#interactive-elements)
8. [Microdata and Schema.org](#microdata-and-schemaorg)

## What is Semantic HTML?

Semantic HTML uses HTML elements that describe the **meaning** of content, not just its appearance. This helps:

- **Screen readers** understand page structure
- **Search engines** index content better
- **Developers** maintain code easier
- **Browsers** render content appropriately

### Semantic vs Non-Semantic

**Non-semantic (avoid):**
```html
<div class="header">
    <div class="nav">
        <div>Home</div>
        <div>About</div>
    </div>
</div>
<div class="main-content">
    <div class="article">
        <div class="title">Article Title</div>
        <div>Content...</div>
    </div>
</div>
```

**Semantic (prefer):**
```html
<header>
    <nav>
        <ul>
            <li><a href="/">Home</a></li>
            <li><a href="/about">About</a></li>
        </ul>
    </nav>
</header>
<main>
    <article>
        <h1>Article Title</h1>
        <p>Content...</p>
    </article>
</main>
```

## Semantic Elements Overview

### Document Structure Elements

| Element | Purpose | Notes |
|---------|---------|-------|
| `<header>` | Introductory content | Can appear multiple times |
| `<nav>` | Navigation links | Major navigation blocks |
| `<main>` | Main content | One per page |
| `<article>` | Independent content | Can be distributed separately |
| `<section>` | Thematic grouping | Generic section of content |
| `<aside>` | Tangential content | Sidebars, pull quotes |
| `<footer>` | Footer content | Can appear multiple times |

## Content Sectioning

### Header

Represents introductory content:

```html
<!-- Site header -->
<header>
    <h1>Site Title</h1>
    <nav>
        <ul>
            <li><a href="/">Home</a></li>
        </ul>
    </nav>
</header>

<!-- Article header -->
<article>
    <header>
        <h2>Article Title</h2>
        <p>Published on <time datetime="2024-01-15">Jan 15, 2024</time></p>
        <p>By <address>Author Name</address></p>
    </header>
    <!-- Article content -->
</article>
```

### Nav

Navigation sections (not every link needs nav):

```html
<!-- Main navigation -->
<nav aria-label="Main navigation">
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
</nav>

<!-- Footer navigation -->
<footer>
    <nav aria-label="Footer links">
        <ul>
            <li><a href="/privacy">Privacy</a></li>
            <li><a href="/terms">Terms</a></li>
        </ul>
    </nav>
</footer>

<!-- Breadcrumb navigation -->
<nav aria-label="Breadcrumb">
    <ol>
        <li><a href="/">Home</a></li>
        <li><a href="/category">Category</a></li>
        <li>Current Page</li>
    </ol>
</nav>
```

### Main

The main content area. Only one per page:

```html
<body>
    <header>...</header>
    <nav>...</nav>
    
    <main>
        <article>
            <h1>Main Article</h1>
            <p>Content...</p>
        </article>
    </main>
    
    <aside>...</aside>
    <footer>...</footer>
</body>
```

### Article

Self-contained, independently distributable content:

```html
<article>
    <header>
        <h2>Blog Post Title</h2>
        <time datetime="2024-01-15">January 15, 2024</time>
    </header>
    
    <section>
        <h3>Introduction</h3>
        <p>Article introduction...</p>
    </section>
    
    <section>
        <h3>Main Content</h3>
        <p>Main article content...</p>
    </section>
    
    <footer>
        <p>Tags: <a href="/tag/html5">HTML5</a>, <a href="/tag/semantics">Semantics</a></p>
    </footer>
</article>

<!-- Multiple articles -->
<section>
    <h2>Recent Posts</h2>
    <article>
        <h3>Post 1</h3>
        <p>Content...</p>
    </article>
    <article>
        <h3>Post 2</h3>
        <p>Content...</p>
    </article>
</section>
```

### Section

Thematic grouping of content:

```html
<!-- Chapter section -->
<section>
    <h2>Chapter 1: Introduction</h2>
    <p>Chapter content...</p>
</section>

<!-- Features section -->
<section>
    <h2>Features</h2>
    <article>
        <h3>Feature 1</h3>
        <p>Description...</p>
    </article>
    <article>
        <h3>Feature 2</h3>
        <p>Description...</p>
    </article>
</section>

<!-- When NOT to use section -->
<!-- ❌ Bad: Don't use for styling wrapper -->
<section class="red-background">
    <p>Just for styling</p>
</section>

<!-- ✅ Good: Use div for styling wrapper -->
<div class="red-background">
    <p>Just for styling</p>
</div>
```

### Aside

Content tangentially related to main content:

```html
<main>
    <article>
        <h1>Main Article</h1>
        <p>Main content...</p>
    </article>
</main>

<aside>
    <h2>Related Articles</h2>
    <ul>
        <li><a href="/article1">Article 1</a></li>
        <li><a href="/article2">Article 2</a></li>
    </ul>
</aside>

<!-- Or within article -->
<article>
    <h1>Article Title</h1>
    <p>Content...</p>
    
    <aside>
        <blockquote>
            "This is a pull quote from the article."
        </blockquote>
    </aside>
    
    <p>More content...</p>
</article>
```

### Footer

Footer for its nearest ancestor:

```html
<!-- Site footer -->
<footer>
    <p>&copy; 2024 Company Name</p>
    <nav>
        <ul>
            <li><a href="/privacy">Privacy</a></li>
            <li><a href="/terms">Terms</a></li>
        </ul>
    </nav>
</footer>

<!-- Article footer -->
<article>
    <h1>Article Title</h1>
    <p>Content...</p>
    <footer>
        <p>Published by <address>Author Name</address></p>
        <time datetime="2024-01-15">January 15, 2024</time>
    </footer>
</article>
```

## Text Content

### Address

Contact information:

```html
<address>
    Written by <a href="mailto:author@example.com">John Doe</a><br>
    Visit us at:<br>
    Example.com<br>
    123 Street, City<br>
    Country
</address>

<!-- Or within article -->
<article>
    <h1>Article Title</h1>
    <p>Content...</p>
    <footer>
        <address>
            By <a href="/author/john">John Doe</a>
        </address>
    </footer>
</article>
```

### Time

Machine-readable date/time:

```html
<!-- Simple date -->
<time datetime="2024-01-15">January 15, 2024</time>

<!-- Date and time -->
<time datetime="2024-01-15T14:30:00">Jan 15, 2024 at 2:30 PM</time>

<!-- Duration -->
<time datetime="PT2H30M">2 hours 30 minutes</time>

<!-- Relative time -->
<time datetime="2024-01-15" title="2024-01-15">Yesterday</time>
```

### Mark

Highlight text for reference:

```html
<p>This is <mark>important</mark> information.</p>

<!-- Search results -->
<p>Search results for "HTML5":</p>
<p>Learn about <mark>HTML5</mark> semantics and modern web development.</p>
```

### Details and Summary

Collapsible content:

```html
<details>
    <summary>Click to expand</summary>
    <p>Hidden content that appears when expanded.</p>
    <ul>
        <li>Item 1</li>
        <li>Item 2</li>
    </ul>
</details>

<!-- Open by default -->
<details open>
    <summary>FAQ</summary>
    <p>Frequently asked questions...</p>
</details>
```

### Figure and Figcaption

For images, diagrams, code with captions:

```html
<!-- Image with caption -->
<figure>
    <img src="diagram.jpg" alt="System architecture diagram">
    <figcaption>System architecture showing components and relationships</figcaption>
</figure>

<!-- Code with caption -->
<figure>
    <pre><code>
function example() {
    return "code";
}
    </code></pre>
    <figcaption>Example JavaScript function</figcaption>
</figure>

<!-- Multiple images -->
<figure>
    <img src="image1.jpg" alt="Image 1">
    <img src="image2.jpg" alt="Image 2">
    <figcaption>Gallery of images</figcaption>
</figure>
```

## Forms

### Form Elements

```html
<form>
    <!-- Fieldset groups related fields -->
    <fieldset>
        <legend>Personal Information</legend>
        
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
    </fieldset>
    
    <fieldset>
        <legend>Preferences</legend>
        <label>
            <input type="checkbox" name="newsletter">
            Subscribe to newsletter
        </label>
    </fieldset>
    
    <button type="submit">Submit</button>
</form>
```

### Output

Calculation results:

```html
<form oninput="result.value=parseInt(a.value)+parseInt(b.value)">
    <input type="number" id="a" value="10"> +
    <input type="number" id="b" value="20"> =
    <output name="result" for="a b">30</output>
</form>
```

### Datalist

Predefined options for input:

```html
<label for="browser">Choose browser:</label>
<input list="browsers" id="browser" name="browser">

<datalist id="browsers">
    <option value="Chrome">
    <option value="Firefox">
    <option value="Safari">
    <option value="Edge">
    <option value="Opera">
</datalist>
```

## Embedded Content

### Picture

Responsive images:

```html
<picture>
    <source media="(min-width: 800px)" srcset="large.jpg">
    <source media="(min-width: 400px)" srcset="medium.jpg">
    <img src="small.jpg" alt="Description">
</picture>
```

### Video and Audio

With semantic structure:

```html
<figure>
    <video controls>
        <source src="video.mp4" type="video/mp4">
        <track kind="captions" src="captions.vtt" srclang="en">
    </video>
    <figcaption>Video demonstration of HTML5 features</figcaption>
</figure>
```

## Interactive Elements

### Dialog

Modal dialogs:

```html
<button onclick="document.getElementById('dialog').showModal()">
    Open Dialog
</button>

<dialog id="dialog">
    <h2>Dialog Title</h2>
    <p>Dialog content...</p>
    <button onclick="document.getElementById('dialog').close()">
        Close
    </button>
</dialog>
```

### Details (Interactive)

```html
<details>
    <summary>Click to expand</summary>
    <p>Content that can be toggled...</p>
</details>
```

## Microdata and Schema.org

Add structured data for search engines:

### Article Schema

```html
<article itemscope itemtype="https://schema.org/Article">
    <h1 itemprop="headline">Article Title</h1>
    <p itemprop="description">Article description...</p>
    <time itemprop="datePublished" datetime="2024-01-15">
        January 15, 2024
    </time>
    <div itemprop="author" itemscope itemtype="https://schema.org/Person">
        <span itemprop="name">John Doe</span>
    </div>
</article>
```

### Organization Schema

```html
<footer itemscope itemtype="https://schema.org/Organization">
    <span itemprop="name">Company Name</span>
    <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
        <span itemprop="streetAddress">123 Main St</span>
        <span itemprop="addressLocality">City</span>
        <span itemprop="postalCode">12345</span>
    </div>
</footer>
```

### Breadcrumb Schema

```html
<nav itemscope itemtype="https://schema.org/BreadcrumbList">
    <span itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
        <a itemprop="item" href="/">
            <span itemprop="name">Home</span>
        </a>
        <meta itemprop="position" content="1">
    </span>
    <span itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
        <a itemprop="item" href="/category">
            <span itemprop="name">Category</span>
        </a>
        <meta itemprop="position" content="2">
    </span>
</nav>
```

## Semantic HTML Patterns

### Blog Post Pattern

```html
<article itemscope itemtype="https://schema.org/BlogPosting">
    <header>
        <h1 itemprop="headline">Post Title</h1>
        <p>
            Published on 
            <time itemprop="datePublished" datetime="2024-01-15">
                January 15, 2024
            </time>
            by
            <address itemprop="author" itemscope itemtype="https://schema.org/Person">
                <span itemprop="name">Author Name</span>
            </address>
        </p>
    </header>
    
    <section itemprop="articleBody">
        <p>Article content...</p>
    </section>
    
    <footer>
        <nav>
            <a rel="prev" href="/previous-post">Previous</a>
            <a rel="next" href="/next-post">Next</a>
        </nav>
    </footer>
</article>
```

### Product Page Pattern

```html
<main itemscope itemtype="https://schema.org/Product">
    <h1 itemprop="name">Product Name</h1>
    
    <figure>
        <img itemprop="image" src="product.jpg" alt="Product Name">
        <figcaption>Product image</figcaption>
    </figure>
    
    <div itemprop="description">
        <p>Product description...</p>
    </div>
    
    <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
        <span itemprop="priceCurrency">USD</span>
        <span itemprop="price">29.99</span>
    </div>
</main>
```

## Best Practices for Semantics

1. **Choose the right element**: Don't force elements into wrong roles
2. **One main per page**: Only one `<main>` element
3. **Proper nesting**: Follow logical content hierarchy
4. **Meaning over style**: Choose elements for meaning, style with CSS
5. **Progressive enhancement**: Build from semantic base, enhance with CSS/JS

---

**Remember**: Semantic HTML improves accessibility, SEO, and maintainability!

