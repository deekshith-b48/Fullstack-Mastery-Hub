# HTML5 Mastery - Theory

## 📚 Overview

HTML5 is the latest version of the HyperText Markup Language, introducing semantic elements, form enhancements, and multimedia capabilities.

## 🎯 Core Concepts

### Semantic HTML

**Definition**: Semantic HTML uses HTML elements to convey meaning and structure, not just presentation.

**Key Semantic Elements**:
- `<header>`: Site or section header
- `<nav>`: Navigation links
- `<main>`: Main content area
- `<article>`: Independent, self-contained content
- `<section>`: Thematic grouping of content
- `<aside>`: Sidebar content
- `<footer>`: Site or section footer

**Example**:
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
    <p>Article content...</p>
  </article>
</main>

<footer>
  <p>&copy; 2024 Company Name</p>
</footer>
```

### Forms and Input Types

**New Input Types**:
- `email`: Email validation
- `tel`: Phone numbers
- `url`: URLs
- `number`: Numeric input
- `date`, `time`, `datetime-local`: Date/time pickers
- `range`: Slider control
- `color`: Color picker
- `search`: Search input

**Example**:
```html
<form>
  <label for="email">Email:</label>
  <input type="email" id="email" name="email" required>
  
  <label for="date">Date:</label>
  <input type="date" id="date" name="date">
  
  <label for="range">Volume:</label>
  <input type="range" id="range" name="volume" min="0" max="100">
  
  <button type="submit">Submit</button>
</form>
```

### Multimedia Elements

**Audio and Video**:
```html
<!-- Audio -->
<audio controls>
  <source src="audio.mp3" type="audio/mpeg">
  Your browser does not support audio.
</audio>

<!-- Video -->
<video controls width="640" height="360">
  <source src="video.mp4" type="video/mp4">
  Your browser does not support video.
</video>
```

### Accessibility (a11y)

**Key Practices**:
- Use semantic HTML
- Provide alt text for images
- Ensure proper heading hierarchy
- Use ARIA attributes when needed
- Ensure keyboard navigation

**Example**:
```html
<img src="photo.jpg" alt="Description of the image" />
<button aria-label="Close dialog">×</button>
```

## 🔑 Key Terminology

- **Semantic HTML**: HTML that conveys meaning
- **ARIA**: Accessible Rich Internet Applications
- **Progressive Enhancement**: Building from basic to advanced features
- **Document Outline**: Structure created by headings

## 📖 Detailed Topics

### Document Structure
- HTML5 document type declaration
- Head section elements
- Body structure
- Meta tags and SEO

### Form Validation
- HTML5 validation attributes
- Custom validation messages
- Client-side validation patterns

### Canvas and SVG
- Drawing with Canvas API
- Vector graphics with SVG
- Animation possibilities

## 🎓 Learning Resources

- [MDN HTML5 Guide](https://developer.mozilla.org/en-US/docs/Web/HTML)
- [HTML5 Doctor](http://html5doctor.com/)
- [W3C HTML5 Specification](https://www.w3.org/TR/html52/)

---

**Last Updated**: 2024

