# Bootstrap - Complete Guide

## 📚 Overview

Bootstrap is a popular CSS framework for developing responsive, mobile-first web projects.

## 🚀 Installation

### Via CDN

```html
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
```

### Via npm

```bash
npm install bootstrap
```

### Setup

```javascript
// Import in your main JS file
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
```

## 🎨 Grid System

### Basic Grid

```html
<div class="container">
  <div class="row">
    <div class="col-md-6">Column 1</div>
    <div class="col-md-6">Column 2</div>
  </div>
</div>
```

### Responsive Breakpoints

```html
<!-- Columns adapt at different screen sizes -->
<div class="col-12 col-sm-6 col-md-4 col-lg-3">
  <!-- 
    xs: 12 columns (default)
    sm: 6 columns (≥576px)
    md: 4 columns (≥768px)
    lg: 3 columns (≥992px)
  -->
</div>
```

### Grid Options

- **col-***: Extra small (<576px)
- **col-sm-***: Small (≥576px)
- **col-md-***: Medium (≥768px)
- **col-lg-***: Large (≥992px)
- **col-xl-***: Extra large (≥1200px)
- **col-xxl-***: XXL (≥1400px)

## 🧩 Components

### Buttons

```html
<button class="btn btn-primary">Primary</button>
<button class="btn btn-secondary">Secondary</button>
<button class="btn btn-success">Success</button>
<button class="btn btn-outline-primary">Outline</button>
<button class="btn btn-lg">Large</button>
<button class="btn btn-sm">Small</button>
```

### Cards

```html
<div class="card" style="width: 18rem;">
  <div class="card-body">
    <h5 class="card-title">Card Title</h5>
    <p class="card-text">Card content</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>
```

### Forms

```html
<form>
  <div class="mb-3">
    <label for="email" class="form-label">Email</label>
    <input type="email" class="form-control" id="email">
  </div>
  <div class="mb-3">
    <label for="password" class="form-label">Password</label>
    <input type="password" class="form-control" id="password">
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
```

### Navigation

```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">About</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
```

## 🎯 Utilities

### Spacing

```html
<div class="m-3">Margin all sides</div>
<div class="p-4">Padding all sides</div>
<div class="mt-2 mb-3">Margin top and bottom</div>
<div class="mx-auto">Center horizontally</div>
```

### Display

```html
<div class="d-none d-md-block">Hidden on mobile</div>
<div class="d-flex justify-content-center">Flexbox center</div>
<div class="d-grid gap-3">CSS Grid</div>
```

### Colors

```html
<div class="text-primary">Primary text</div>
<div class="bg-danger">Danger background</div>
<div class="border border-success">Success border</div>
```

## 🔧 Customization

### Sass Variables

```scss
// _variables.scss
$primary: #007bff;
$secondary: #6c757d;
$border-radius: 0.5rem;
```

### JavaScript API

```javascript
// Initialize tooltips
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => 
  new bootstrap.Tooltip(tooltipTriggerEl)
);

// Modal
const myModal = new bootstrap.Modal(document.getElementById('myModal'));
myModal.show();
```

---

**Next**: Learn about [Material-UI](./MATERIAL-UI-THEORY.md)

