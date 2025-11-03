# BEM Methodology - Complete Guide

## 📚 What is BEM?

BEM (Block Element Modifier) is a naming methodology for CSS classes that makes your code more maintainable and scalable.

## 🎯 Core Concepts

### Block
Standalone component that is meaningful on its own.

```css
.button { }
.card { }
.menu { }
```

### Element
Part of a block that has no standalone meaning.

```css
.card__header { }
.card__body { }
.card__footer { }
.menu__item { }
```

### Modifier
A flag on a block or element to change appearance or behavior.

```css
.button--primary { }
.button--large { }
.card--featured { }
```

## 📝 Naming Convention

```
block__element--modifier
```

### Examples

```html
<!-- Block -->
<div class="card">...</div>

<!-- Block with Element -->
<div class="card">
  <div class="card__header">Header</div>
  <div class="card__body">Body</div>
  <div class="card__footer">Footer</div>
</div>

<!-- Block with Modifier -->
<div class="card card--featured">...</div>

<!-- Element with Modifier -->
<button class="button button--primary">Click</button>
<button class="button button--secondary">Click</button>
```

## 💡 Best Practices

### 1. Always Use Block as Root

```html
<!-- Good -->
<div class="card">
  <div class="card__title">Title</div>
</div>

<!-- Bad -->
<div class="card">
  <div class="title">Title</div>
</div>
```

### 2. Don't Nest Elements

```html
<!-- Good -->
<div class="card">
  <div class="card__header">
    <div class="card__title">Title</div>
  </div>
</div>

<!-- Bad -->
<div class="card">
  <div class="card__header">
    <div class="card__header__title">Title</div>
  </div>
</div>
```

### 3. Use Modifiers Independently

```html
<!-- Good -->
<button class="button button--primary button--large">Click</button>

<!-- Bad -->
<button class="button button--primary-large">Click</button>
```

## 🎨 CSS Structure

```css
/* Block */
.card {
  background: white;
  border-radius: 8px;
  padding: 20px;
}

/* Elements */
.card__header {
  margin-bottom: 16px;
}

.card__title {
  font-size: 24px;
  font-weight: bold;
}

.card__body {
  color: #666;
}

/* Modifiers */
.card--featured {
  border: 2px solid gold;
}

.card--shadow {
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Element Modifier */
.card__title--large {
  font-size: 32px;
}
```

## 🔧 Advanced Patterns

### Mixes

```html
<!-- Combining blocks -->
<div class="card popup">
  <div class="card__header popup__header">
    Header
  </div>
</div>
```

### Elements of Elements

```html
<div class="card">
  <div class="card__header">
    <div class="card__title">
      <span class="card__title-icon">Icon</span>
      Title
    </div>
  </div>
</div>
```

### Context Modifiers

```css
/* Block in specific context */
.menu .button {
  /* Button inside menu */
}

/* Better: Use modifier */
.button--menu {
  /* Menu button */
}
```

## 📚 File Organization

```
styles/
  blocks/
    button.css
    card.css
    menu.css
  elements/
    button__icon.css
    card__header.css
  modifiers/
    button--primary.css
    card--featured.css
```

## ✅ Benefits

1. **Clarity**: Names are self-documenting
2. **Maintainability**: Easy to find and modify styles
3. **Reusability**: Blocks can be used anywhere
4. **Scalability**: Works for large projects
5. **No conflicts**: Unique naming prevents collisions

---

**Next**: Learn about [CSS Modules](./CSS-MODULES-THEORY.md)

