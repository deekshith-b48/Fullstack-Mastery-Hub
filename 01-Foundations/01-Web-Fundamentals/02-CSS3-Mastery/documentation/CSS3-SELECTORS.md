# CSS3 Selectors - Complete Reference

## 📚 Overview

CSS3 selectors allow you to target and style HTML elements with precision. This guide covers all selector types from basic to advanced.

## Basic Selectors

### Element Selector
```css
p { color: blue; }
div { margin: 10px; }
```

### Class Selector
```css
.class-name { color: red; }
.multiple.classes { font-weight: bold; }
```

### ID Selector
```css
#unique-id { color: green; }
```

### Universal Selector
```css
* { margin: 0; padding: 0; } /* Reset */
.container * { color: blue; } /* All children */
```

### Attribute Selector
```css
/* Existence */
[type] { border: 1px solid; }

/* Equals */
[type="text"] { width: 200px; }

/* Contains word */
[class~="important"] { font-weight: bold; }

/* Begins with */
[href^="https"] { color: green; }

/* Ends with */
[href$=".pdf"] { color: red; }

/* Contains substring */
[href*="example"] { text-decoration: underline; }

/* Case insensitive */
[type="text" i] { border: 1px solid; }
```

## Combinator Selectors

### Descendant Selector (space)
```css
div p { color: blue; } /* All p inside div */
```

### Child Selector (>)
```css
div > p { color: red; } /* Direct children only */
```

### Adjacent Sibling (+)
```css
h1 + p { margin-top: 0; } /* First p after h1 */
```

### General Sibling (~)
```css
h1 ~ p { color: blue; } /* All p siblings after h1 */
```

## Pseudo-classes

### Link States
```css
a:link { color: blue; }
a:visited { color: purple; }
a:hover { color: red; }
a:active { color: orange; }
```

### User Action
```css
:focus { outline: 2px solid blue; }
:hover { background: yellow; }
:active { transform: scale(0.95); }
```

### Form States
```css
:enabled { opacity: 1; }
:disabled { opacity: 0.5; }
:checked { background: green; }
:required { border-color: red; }
:optional { border-color: gray; }
:valid { border-color: green; }
:invalid { border-color: red; }
:in-range { color: green; }
:out-of-range { color: red; }
```

### Structural Pseudo-classes
```css
:first-child { font-weight: bold; }
:last-child { margin-bottom: 0; }
:only-child { text-align: center; }
:nth-child(2) { color: blue; }
:nth-child(odd) { background: gray; }
:nth-child(even) { background: white; }
:nth-child(3n) { color: red; } /* Every 3rd */
:nth-child(3n+1) { color: blue; } /* 1st, 4th, 7th... */
:nth-last-child(2) { color: green; }
:nth-of-type(2) { font-size: 1.2em; }
:first-of-type { text-transform: uppercase; }
:last-of-type { font-style: italic; }
:only-of-type { border: 2px solid; }
```

### Other Pseudo-classes
```css
:not(.exclude) { color: blue; }
:not(div) { margin: 10px; }
:root { --primary-color: blue; }
:target { background: yellow; } /* URL fragment target */
:empty { display: none; }
```

## Pseudo-elements

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
    float: left;
}

/* Selection */
::selection {
    background: yellow;
    color: black;
}

/* Placeholder */
input::placeholder {
    color: gray;
    font-style: italic;
}
```

## Selector Specificity

Specificity determines which styles apply:

1. Inline styles (1000)
2. IDs (100)
3. Classes, attributes, pseudo-classes (10)
4. Elements, pseudo-elements (1)

```css
/* Specificity: 1 */
p { color: blue; }

/* Specificity: 10 */
.class { color: red; }

/* Specificity: 100 */
#id { color: green; }

/* Specificity: 1 + 10 = 11 */
p.class { color: orange; }

/* Specificity: 100 + 10 = 110 */
#id.class { color: purple; }
```

## Advanced Selectors

### :has() (Modern browsers)
```css
/* Parent with specific child */
.container:has(.active) { background: yellow; }
```

### :is()
```css
:is(h1, h2, h3) { color: blue; }
/* Equivalent to: h1, h2, h3 { color: blue; } */
```

### :where()
```css
:where(h1, h2) { color: blue; } /* Zero specificity */
```

---

**Next**: Learn about [CSS3 Box Model](./CSS3-BOX-MODEL.md).

