# CSS3 Positioning

## Position Property

The `position` property determines how an element is positioned in the document.

### Static (Default)

```css
.element {
    position: static; /* Normal flow */
}
```

### Relative

```css
.element {
    position: relative;
    top: 20px;
    left: 30px;
    /* Moved relative to its normal position */
}
```

### Absolute

```css
.element {
    position: absolute;
    top: 50px;
    right: 20px;
    /* Positioned relative to nearest positioned ancestor */
}
```

### Fixed

```css
.element {
    position: fixed;
    bottom: 20px;
    right: 20px;
    /* Positioned relative to viewport */
}
```

### Sticky

```css
.element {
    position: sticky;
    top: 0;
    /* Sticks when scrolling reaches threshold */
}
```

## Z-Index

Controls stacking order (only works on positioned elements):

```css
.element1 {
    position: relative;
    z-index: 1;
}

.element2 {
    position: relative;
    z-index: 2; /* Appears above element1 */
}

.element3 {
    position: relative;
    z-index: 10; /* Appears above both */
}
```

## Float

```css
.element {
    float: left;
    float: right;
    float: none; /* Default */
    clear: both; /* Clear floats */
}

/* Clearfix */
.container::after {
    content: "";
    display: table;
    clear: both;
}
```

## Common Patterns

### Centering

```css
/* Horizontal center - block element */
.element {
    margin: 0 auto;
}

/* Absolute center */
.element {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

/* Flexbox center */
.container {
    display: flex;
    justify-content: center;
    align-items: center;
}
```

### Sticky Header

```css
.header {
    position: sticky;
    top: 0;
    z-index: 100;
    background: white;
}
```

### Fixed Footer

```css
.footer {
    position: fixed;
    bottom: 0;
    width: 100%;
}
```

