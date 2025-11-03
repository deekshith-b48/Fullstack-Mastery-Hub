# CSS3 Animations & Transitions

## Transitions

Smooth property changes over time:

```css
.button {
    background: blue;
    transition: background 0.3s ease;
}

.button:hover {
    background: red; /* Smooth transition */
}

/* Multiple properties */
.element {
    transition: background 0.3s ease, transform 0.5s ease-in-out;
}

/* All properties */
.element {
    transition: all 0.3s ease;
}

/* Individual properties */
.element {
    transition-property: background, transform;
    transition-duration: 0.3s, 0.5s;
    transition-timing-function: ease, ease-in-out;
    transition-delay: 0s, 0.1s;
}
```

### Timing Functions

```css
.element {
    transition-timing-function: ease;        /* Default */
    transition-timing-function: linear;
    transition-timing-function: ease-in;
    transition-timing-function: ease-out;
    transition-timing-function: ease-in-out;
    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    transition-timing-function: steps(4, end);
}
```

## Animations

### Keyframes

```css
@keyframes slide {
    from {
        transform: translateX(0);
    }
    to {
        transform: translateX(100px);
    }
}

/* With percentages */
@keyframes bounce {
    0%, 100% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-20px);
    }
}

/* Complex animation */
@keyframes complex {
    0% {
        transform: translateX(0) rotate(0deg);
        opacity: 1;
    }
    50% {
        transform: translateX(100px) rotate(180deg);
        opacity: 0.5;
    }
    100% {
        transform: translateX(200px) rotate(360deg);
        opacity: 1;
    }
}
```

### Applying Animations

```css
.element {
    animation: slide 2s ease-in-out infinite;
    
    /* Or individually */
    animation-name: slide;
    animation-duration: 2s;
    animation-timing-function: ease-in-out;
    animation-delay: 1s;
    animation-iteration-count: infinite;
    animation-direction: alternate;
    animation-fill-mode: both;
    animation-play-state: running;
}
```

### Animation Properties

```css
.element {
    /* Duration */
    animation-duration: 2s;
    
    /* Timing function */
    animation-timing-function: ease-in-out;
    
    /* Delay */
    animation-delay: 0.5s;
    
    /* Iteration count */
    animation-iteration-count: 3;      /* Number */
    animation-iteration-count: infinite; /* Forever */
    
    /* Direction */
    animation-direction: normal;        /* Forward */
    animation-direction: reverse;       /* Backward */
    animation-direction: alternate;     /* Forward then backward */
    animation-direction: alternate-reverse; /* Backward then forward */
    
    /* Fill mode */
    animation-fill-mode: none;          /* Default */
    animation-fill-mode: forwards;     /* Keep final state */
    animation-fill-mode: backwards;     /* Apply initial state */
    animation-fill-mode: both;         /* Both */
    
    /* Play state */
    animation-play-state: running;      /* Playing */
    animation-play-state: paused;       /* Paused */
}
```

## Common Animations

### Fade In

```css
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.element {
    animation: fadeIn 1s ease-in;
}
```

### Slide In

```css
@keyframes slideIn {
    from {
        transform: translateX(-100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}
```

### Bounce

```css
@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translateY(0);
    }
    40% {
        transform: translateY(-30px);
    }
    60% {
        transform: translateY(-15px);
    }
}
```

### Rotate

```css
@keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.loading {
    animation: rotate 2s linear infinite;
}
```

### Pulse

```css
@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.1);
    }
}

.button:hover {
    animation: pulse 0.5s ease-in-out;
}
```

## Transforms

### 2D Transforms

```css
.element {
    /* Translate */
    transform: translateX(50px);
    transform: translateY(50px);
    transform: translate(50px, 50px);
    
    /* Rotate */
    transform: rotate(45deg);
    
    /* Scale */
    transform: scale(1.5);
    transform: scaleX(2);
    transform: scaleY(0.5);
    transform: scale(1.5, 0.5);
    
    /* Skew */
    transform: skewX(20deg);
    transform: skewY(10deg);
    transform: skew(20deg, 10deg);
    
    /* Multiple transforms */
    transform: translate(50px, 50px) rotate(45deg) scale(1.2);
}
```

### 3D Transforms

```css
.container {
    perspective: 1000px;
    perspective-origin: center;
}

.element {
    transform: perspective(1000px) rotateY(45deg);
    transform-style: preserve-3d;
    backface-visibility: hidden;
}
```

## Performance Tips

1. Animate `transform` and `opacity` (GPU accelerated)
2. Avoid animating `width`, `height`, `margin`, `padding`
3. Use `will-change` sparingly
4. Prefer transitions for simple changes
5. Use animations for complex sequences

```css
/* Good - GPU accelerated */
.element {
    transform: translateX(100px);
    opacity: 0.5;
}

/* Avoid - Layout reflow */
.element {
    width: 200px;
    margin-left: 100px;
}
```

