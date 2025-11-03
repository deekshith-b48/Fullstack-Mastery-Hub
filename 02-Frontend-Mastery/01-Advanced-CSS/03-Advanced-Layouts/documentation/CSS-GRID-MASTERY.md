# CSS Grid - Mastery Guide

## 📚 Overview

CSS Grid is a powerful two-dimensional layout system that allows you to create complex responsive layouts.

## 🚀 Basic Grid

### Create Grid Container

```css
.container {
  display: grid;
  grid-template-columns: 200px 200px 200px;
  grid-template-rows: 100px 100px;
  gap: 20px;
}
```

### Grid Template Areas

```css
.container {
  display: grid;
  grid-template-areas:
    "header header header"
    "sidebar main main"
    "footer footer footer";
  gap: 20px;
}

.header { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main { grid-area: main; }
.footer { grid-area: footer; }
```

## 📐 Grid Properties

### Container Properties

```css
.container {
  /* Define columns */
  grid-template-columns: 1fr 2fr 1fr;
  grid-template-columns: repeat(3, 1fr);
  grid-template-columns: minmax(200px, 1fr);
  grid-template-columns: [start] 1fr [middle] 1fr [end];
  
  /* Define rows */
  grid-template-rows: auto 1fr auto;
  
  /* Gap */
  gap: 20px;
  row-gap: 10px;
  column-gap: 20px;
  
  /* Alignment */
  justify-items: center;
  align-items: center;
  place-items: center;
  
  /* Justify/Align Content */
  justify-content: space-between;
  align-content: center;
  
  /* Auto columns/rows */
  grid-auto-columns: 100px;
  grid-auto-rows: minmax(100px, auto);
  grid-auto-flow: row; /* or column, dense */
}
```

### Item Properties

```css
.item {
  /* Position */
  grid-column: 1 / 3;
  grid-row: 1 / 2;
  grid-area: 1 / 1 / 3 / 3;
  
  /* Span */
  grid-column: span 2;
  grid-row: span 2;
  
  /* Named lines */
  grid-column: start / end;
  
  /* Self alignment */
  justify-self: start;
  align-self: center;
  place-self: center;
}
```

## 🎯 Common Patterns

### 12-Column Grid

```css
.grid-12 {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: 20px;
}

.col-1 { grid-column: span 1; }
.col-2 { grid-column: span 2; }
.col-3 { grid-column: span 3; }
.col-4 { grid-column: span 4; }
.col-6 { grid-column: span 6; }
.col-12 { grid-column: span 12; }
```

### Responsive Grid

```css
.container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

/* Media queries */
@media (max-width: 768px) {
  .container {
    grid-template-columns: 1fr;
  }
}
```

### Holy Grail Layout

```css
.container {
  display: grid;
  grid-template-areas:
    "header header header"
    "nav main aside"
    "footer footer footer";
  grid-template-rows: auto 1fr auto;
  grid-template-columns: 200px 1fr 200px;
  min-height: 100vh;
}
```

### Card Grid

```css
.cards {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
}

.card {
  display: grid;
  grid-template-rows: auto 1fr auto;
}
```

## 🔧 Advanced Features

### Subgrid (Modern Browsers)

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
}

.subgrid {
  display: grid;
  grid-column: 1 / -1;
  grid-template-columns: subgrid;
}
```

### Masonry Layout (Experimental)

```css
.masonry {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-template-rows: masonry;
}
```

### Overlapping Items

```css
.item-1 {
  grid-column: 1 / 3;
  grid-row: 1 / 2;
  z-index: 2;
}

.item-2 {
  grid-column: 2 / 4;
  grid-row: 1 / 2;
  z-index: 1;
}
```

## 📱 Responsive Patterns

```css
/* Mobile first */
.grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 10px;
}

/* Tablet */
@media (min-width: 768px) {
  .grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

## ✅ Best Practices

1. Use `fr` units for flexible sizing
2. Use `minmax()` for responsive columns
3. Use `gap` instead of margins
4. Name grid lines for clarity
5. Use `auto-fit` or `auto-fill` for responsive grids

---

**Next**: Learn about [Flexbox Deep Dive](./FLEXBOX-DEEP-DIVE.md)

