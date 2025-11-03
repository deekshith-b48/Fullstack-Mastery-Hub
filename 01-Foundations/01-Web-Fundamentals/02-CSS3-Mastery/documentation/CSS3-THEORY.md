# CSS3 Theory - Complete Guide

## 📚 Table of Contents

1. [Introduction to CSS3](#introduction-to-css3)
2. [CSS Syntax](#css-syntax)
3. [Selectors](#selectors)
4. [The Box Model](#the-box-model)
5. [Layout Systems](#layout-systems)
6. [Typography](#typography)
7. [Colors and Backgrounds](#colors-and-backgrounds)
8. [Transitions and Animations](#transitions-and-animations)
9. [Responsive Design](#responsive-design)
10. [CSS Variables](#css-variables)

## Introduction to CSS3

CSS3 (Cascading Style Sheets Level 3) is the latest version of CSS, introducing powerful features for modern web design.

### Key Features

- **Flexible Box Layout (Flexbox)**: One-dimensional layout
- **Grid Layout**: Two-dimensional layout system
- **Animations**: Keyframe animations
- **Transitions**: Smooth property changes
- **Transforms**: 2D and 3D transformations
- **Media Queries**: Responsive design
- **CSS Variables**: Custom properties
- **Advanced Selectors**: More powerful selectors

### CSS Versions

- **CSS1** (1996): Basic styling
- **CSS2** (1998): Positioning, media types
- **CSS2.1** (2011): Refinement of CSS2
- **CSS3** (Ongoing): Modular approach, new features

## CSS Syntax

### Basic Syntax

```css
selector {
    property: value;
    property: value;
}
```

### Example

```css
h1 {
    color: blue;
    font-size: 24px;
    margin: 10px;
}
```

### Comments

```css
/* Single line comment */

/* 
   Multi-line
   comment
*/
```

### CSS Rules

```css
/* Rule set */
h1 {
    color: red;
}

/* Multiple selectors */
h1, h2, h3 {
    color: blue;
}

/* Nested rules (CSS Nesting - newer browsers) */
.parent {
    color: blue;
    
    .child {
        color: red;
    }
}
```

## Selectors

### Basic Selectors

```css
/* Element selector */
p {
    color: blue;
}

/* Class selector */
.class-name {
    color: red;
}

/* ID selector */
#id-name {
    color: green;
}

/* Universal selector */
* {
    margin: 0;
    padding: 0;
}

/* Attribute selector */
[type="text"] {
    border: 1px solid blue;
}
```

### Combinator Selectors

```css
/* Descendant (space) */
div p {
    color: blue;
}

/* Child (>) */
div > p {
    color: red;
}

/* Adjacent sibling (+) */
h1 + p {
    margin-top: 0;
}

/* General sibling (~) */
h1 ~ p {
    color: blue;
}
```

### Pseudo-classes

```css
/* Link states */
a:link { color: blue; }
a:visited { color: purple; }
a:hover { color: red; }
a:active { color: orange; }

/* Form states */
input:focus { border-color: blue; }
input:disabled { opacity: 0.5; }
input:checked { background: green; }

/* Structural */
:first-child { color: red; }
:last-child { color: blue; }
:nth-child(2) { color: green; }
:nth-child(odd) { background: gray; }
:nth-child(even) { background: white; }

/* Not */
:not(.exclude) { color: blue; }
```

### Pseudo-elements

```css
/* Before */
.element::before {
    content: "→ ";
}

/* After */
.element::after {
    content: " ←";
}

/* First line */
p::first-line {
    font-weight: bold;
}

/* First letter */
p::first-letter {
    font-size: 200%;
}

/* Selection */
::selection {
    background: yellow;
    color: black;
}
```

## The Box Model

Every element is a rectangular box with:

1. **Content**: Actual content
2. **Padding**: Space inside border
3. **Border**: Border around padding
4. **Margin**: Space outside border

```css
.box {
    width: 200px;
    height: 100px;
    padding: 20px;
    border: 5px solid black;
    margin: 10px;
}
```

### Box-sizing

```css
/* Default - border-box is better */
.element {
    box-sizing: border-box; /* Width includes padding and border */
    width: 200px;
    padding: 20px; /* Included in 200px */
}

.element2 {
    box-sizing: content-box; /* Default - width doesn't include padding */
    width: 200px;
    padding: 20px; /* Total width = 240px */
}
```

### Margin Collapse

```css
/* Vertical margins collapse (larger wins) */
.element1 {
    margin-bottom: 20px;
}

.element2 {
    margin-top: 30px; /* Only 30px gap between them */
}
```

## Layout Systems

### Display Property

```css
/* Block */
div {
    display: block; /* Full width, new line */
}

/* Inline */
span {
    display: inline; /* Width of content, no new line */
}

/* Inline-block */
.button {
    display: inline-block; /* Width of content, but accepts width/height */
}

/* Flex */
.container {
    display: flex; /* Flexbox layout */
}

/* Grid */
.container {
    display: grid; /* Grid layout */
}

/* None */
.hidden {
    display: none; /* Removed from layout */
}

/* Visibility */
.hidden {
    visibility: hidden; /* Space kept, but invisible */
}
```

### Flexbox

One-dimensional layout:

```css
/* Flex Container */
.container {
    display: flex;
    flex-direction: row; /* row | column | row-reverse | column-reverse */
    justify-content: center; /* Main axis alignment */
    align-items: center; /* Cross axis alignment */
    flex-wrap: wrap; /* wrap | nowrap */
    gap: 20px;
}

/* Flex Items */
.item {
    flex: 1; /* flex-grow, flex-shrink, flex-basis */
    align-self: flex-start;
    order: 2;
}
```

### Grid

Two-dimensional layout:

```css
.container {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 3 equal columns */
    grid-template-rows: 100px 200px;
    gap: 20px;
    grid-template-areas:
        "header header header"
        "sidebar main main"
        "footer footer footer";
}

.item {
    grid-column: 1 / 3; /* Span columns */
    grid-row: 1; /* Row position */
    grid-area: header; /* Named area */
}
```

## Typography

### Font Properties

```css
.text {
    font-family: "Helvetica Neue", Arial, sans-serif;
    font-size: 16px;
    font-weight: 400; /* 100-900 */
    font-style: italic;
    line-height: 1.5;
    letter-spacing: 1px;
    word-spacing: 2px;
    text-transform: uppercase;
    text-decoration: underline;
}
```

### Text Alignment

```css
.text {
    text-align: left; /* left | center | right | justify */
    text-align-last: justify;
    vertical-align: middle;
    text-indent: 20px;
}
```

### Text Effects

```css
.text {
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    text-overflow: ellipsis; /* With overflow: hidden */
    white-space: nowrap;
    word-wrap: break-word;
}
```

## Colors and Backgrounds

### Colors

```css
.element {
    /* Named colors */
    color: red;
    
    /* Hex */
    color: #ff0000;
    color: #f00; /* Short hex */
    
    /* RGB */
    color: rgb(255, 0, 0);
    color: rgba(255, 0, 0, 0.5); /* With alpha */
    
    /* HSL */
    color: hsl(0, 100%, 50%);
    color: hsla(0, 100%, 50%, 0.5);
    
    /* Current color */
    border-color: currentColor;
}
```

### Backgrounds

```css
.element {
    background-color: blue;
    background-image: url('image.jpg');
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover; /* cover | contain | 100% 100% */
    background-attachment: fixed;
    
    /* Shorthand */
    background: url('image.jpg') center/cover no-repeat;
}
```

### Gradients

```css
/* Linear gradient */
.element {
    background: linear-gradient(to right, red, blue);
    background: linear-gradient(45deg, red, blue, green);
}

/* Radial gradient */
.element {
    background: radial-gradient(circle, red, blue);
}

/* Conic gradient */
.element {
    background: conic-gradient(red, blue, green);
}
```

## Transitions and Animations

### Transitions

```css
.button {
    background: blue;
    transition: background 0.3s ease;
}

.button:hover {
    background: red;
}

/* Multiple properties */
.element {
    transition: background 0.3s ease, transform 0.5s ease-in-out;
}

/* All properties */
.element {
    transition: all 0.3s ease;
}
```

### Animations

```css
/* Keyframes */
@keyframes slide {
    from {
        transform: translateX(0);
    }
    to {
        transform: translateX(100px);
    }
}

/* Or with percentages */
@keyframes bounce {
    0%, 100% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-20px);
    }
}

/* Apply animation */
.element {
    animation: slide 2s ease-in-out infinite;
    animation-name: slide;
    animation-duration: 2s;
    animation-timing-function: ease-in-out;
    animation-delay: 1s;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}
```

### Transforms

```css
.element {
    /* 2D Transforms */
    transform: translateX(50px);
    transform: translateY(50px);
    transform: translate(50px, 50px);
    transform: rotate(45deg);
    transform: scale(1.5);
    transform: scaleX(2);
    transform: skewX(20deg);
    
    /* Multiple transforms */
    transform: translate(50px, 50px) rotate(45deg) scale(1.2);
    
    /* 3D Transforms */
    transform: perspective(1000px) rotateY(45deg);
    transform-style: preserve-3d;
}
```

## Responsive Design

### Media Queries

```css
/* Basic media query */
@media (max-width: 768px) {
    .container {
        width: 100%;
    }
}

/* Multiple conditions */
@media (min-width: 768px) and (max-width: 1024px) {
    .container {
        width: 750px;
    }
}

/* Orientation */
@media (orientation: landscape) {
    .container {
        flex-direction: row;
    }
}

/* Print */
@media print {
    .no-print {
        display: none;
    }
}
```

### Responsive Units

```css
.element {
    /* Relative units */
    width: 50%; /* Percentage */
    font-size: 1.5rem; /* Relative to root */
    font-size: 1.5em; /* Relative to parent */
    width: 50vw; /* Viewport width */
    height: 50vh; /* Viewport height */
    
    /* Absolute units */
    width: 200px;
    font-size: 16pt;
}
```

## CSS Variables

```css
/* Define variables */
:root {
    --primary-color: #3498db;
    --secondary-color: #2ecc71;
    --font-size-base: 16px;
    --spacing-unit: 8px;
}

/* Use variables */
.element {
    color: var(--primary-color);
    font-size: var(--font-size-base);
    margin: calc(var(--spacing-unit) * 2);
}

/* With fallback */
.element {
    color: var(--primary-color, blue);
}

/* Scope variables */
.container {
    --local-var: red;
}

.container .item {
    color: var(--local-var);
}
```

## Advanced CSS3 Features

### Filters

```css
.element {
    filter: blur(5px);
    filter: brightness(1.5);
    filter: contrast(1.2);
    filter: grayscale(50%);
    filter: hue-rotate(90deg);
    filter: invert(100%);
    filter: opacity(0.5);
    filter: saturate(200%);
    filter: sepia(100%);
    
    /* Multiple filters */
    filter: blur(2px) brightness(1.2) contrast(1.1);
}
```

### Backdrop Filters

```css
.element {
    backdrop-filter: blur(10px);
    backdrop-filter: brightness(1.2);
}
```

### Clip-path

```css
.element {
    clip-path: circle(50%);
    clip-path: polygon(0 0, 100% 0, 50% 100%);
    clip-path: ellipse(50% 40% at 50% 50%);
}
```

---

**Next**: Learn about [CSS3 Selectors](./CSS3-SELECTORS.md) in detail.

