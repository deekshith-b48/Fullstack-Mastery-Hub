# CSS3 Responsive Design

## Media Queries

### Basic Syntax

```css
@media (max-width: 768px) {
    .container {
        width: 100%;
    }
}
```

### Breakpoints

```css
/* Mobile */
@media (max-width: 575px) { }

/* Tablet */
@media (min-width: 576px) and (max-width: 767px) { }

/* Desktop */
@media (min-width: 768px) { }

/* Large Desktop */
@media (min-width: 1200px) { }
```

### Common Breakpoints

```css
/* Small devices */
@media (max-width: 575.98px) { }

/* Medium devices */
@media (min-width: 576px) and (max-width: 767.98px) { }

/* Large devices */
@media (min-width: 768px) and (max-width: 991.98px) { }

/* Extra large */
@media (min-width: 992px) and (max-width: 1199.98px) { }

/* XXL */
@media (min-width: 1200px) { }
```

## Viewport Meta Tag

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

## Responsive Units

```css
.element {
    /* Relative units */
    width: 100%;           /* Percentage */
    font-size: 1.5rem;      /* Root-relative */
    font-size: 1.5em;       /* Parent-relative */
    
    /* Viewport units */
    width: 50vw;            /* 50% of viewport width */
    height: 50vh;           /* 50% of viewport height */
    font-size: 5vmin;        /* Smaller of vw/vh */
    font-size: 5vmax;        /* Larger of vw/vh */
}
```

## Flexible Images

```css
img {
    max-width: 100%;
    height: auto;
}
```

## Responsive Typography

```css
/* Fluid typography */
.text {
    font-size: clamp(1rem, 2.5vw, 2rem);
}

/* Using calc */
.text {
    font-size: calc(1rem + 1vw);
}
```

## Mobile-First Approach

```css
/* Base styles (mobile) */
.container {
    padding: 10px;
    font-size: 14px;
}

/* Tablet and up */
@media (min-width: 768px) {
    .container {
        padding: 20px;
        font-size: 16px;
    }
}

/* Desktop and up */
@media (min-width: 1200px) {
    .container {
        padding: 30px;
        font-size: 18px;
    }
}
```

## Flexbox for Responsive

```css
.container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.item {
    flex: 1 1 300px; /* Grow, shrink, base width */
}
```

## Grid for Responsive

```css
.container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
}
```

## Container Queries (Modern)

```css
.card {
    container-type: inline-size;
}

@container (min-width: 400px) {
    .card {
        display: flex;
    }
}
```

