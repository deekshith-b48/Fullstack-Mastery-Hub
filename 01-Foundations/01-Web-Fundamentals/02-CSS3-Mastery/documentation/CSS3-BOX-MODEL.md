# CSS3 Box Model

## Understanding the Box Model

Every HTML element is rendered as a rectangular box with four areas:

1. **Content**: The actual content (text, images, etc.)
2. **Padding**: Space between content and border
3. **Border**: Border around padding
4. **Margin**: Space outside border

```
┌─────────────────────────────────┐
│          MARGIN                  │
│  ┌───────────────────────────┐  │
│  │        BORDER             │  │
│  │  ┌─────────────────────┐ │  │
│  │  │     PADDING         │ │  │
│  │  │  ┌───────────────┐  │ │  │
│  │  │  │   CONTENT    │  │ │  │
│  │  │  └───────────────┘  │ │  │
│  │  └─────────────────────┘ │  │
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

## Box-Sizing

### Content-Box (Default)

```css
.element {
    box-sizing: content-box;
    width: 200px;
    padding: 20px;
    border: 5px solid black;
    /* Total width = 200 + 20*2 + 5*2 = 250px */
}
```

### Border-Box (Recommended)

```css
.element {
    box-sizing: border-box;
    width: 200px;
    padding: 20px;
    border: 5px solid black;
    /* Total width = 200px (includes padding and border) */
}
```

### Global Reset

```css
*,
*::before,
*::after {
    box-sizing: border-box;
}
```

## Width and Height

```css
.element {
    width: 200px;
    height: 100px;
    min-width: 150px;
    max-width: 300px;
    min-height: 50px;
    max-height: 200px;
}
```

## Padding

```css
/* Individual sides */
.element {
    padding-top: 10px;
    padding-right: 20px;
    padding-bottom: 15px;
    padding-left: 25px;
}

/* Shorthand */
.element {
    padding: 10px;                    /* All sides */
    padding: 10px 20px;               /* Top/bottom, left/right */
    padding: 10px 20px 15px;          /* Top, left/right, bottom */
    padding: 10px 20px 15px 25px;    /* Top, right, bottom, left */
}
```

## Border

```css
.element {
    /* Individual properties */
    border-width: 2px;
    border-style: solid;
    border-color: black;
    
    /* Shorthand */
    border: 2px solid black;
    
    /* Individual sides */
    border-top: 1px solid red;
    border-right: 2px dashed blue;
    border-bottom: 3px dotted green;
    border-left: 4px double purple;
}

/* Border radius */
.element {
    border-radius: 10px;
    border-radius: 50%; /* Circle */
    border-top-left-radius: 10px;
    border-top-right-radius: 20px;
}
```

## Margin

```css
/* Individual sides */
.element {
    margin-top: 10px;
    margin-right: 20px;
    margin-bottom: 15px;
    margin-left: 25px;
}

/* Shorthand */
.element {
    margin: 10px;                    /* All sides */
    margin: 10px 20px;               /* Top/bottom, left/right */
    margin: 10px 20px 15px;          /* Top, left/right, bottom */
    margin: 10px 20px 15px 25px;    /* Top, right, bottom, left */
    
    /* Auto - centers horizontally */
    margin: 0 auto;
    
    /* Negative margins */
    margin-top: -10px;
}
```

### Margin Collapse

Vertical margins collapse (only the larger margin is used):

```css
.element1 {
    margin-bottom: 20px;
}

.element2 {
    margin-top: 30px;
    /* Gap between elements = 30px (not 50px) */
}
```

## Display and Box Type

```css
/* Block */
.block {
    display: block; /* Full width, new line */
}

/* Inline */
.inline {
    display: inline; /* Width of content */
}

/* Inline-block */
.inline-block {
    display: inline-block; /* Width of content, but accepts width/height */
}

/* Flex */
.flex {
    display: flex;
}

/* Grid */
.grid {
    display: grid;
}

/* None */
.hidden {
    display: none; /* Removed from layout */
}
```

## Overflow

```css
.element {
    overflow: visible; /* Default - content spills */
    overflow: hidden;  /* Content clipped */
    overflow: scroll;  /* Always show scrollbar */
    overflow: auto;    /* Show scrollbar when needed */
    
    /* Individual axes */
    overflow-x: hidden;
    overflow-y: scroll;
}
```

## Box Model Best Practices

1. Always use `box-sizing: border-box`
2. Use consistent spacing units (rems, ems)
3. Understand margin collapse behavior
4. Use padding for inner spacing, margin for outer spacing
5. Consider using CSS Grid or Flexbox for complex layouts

