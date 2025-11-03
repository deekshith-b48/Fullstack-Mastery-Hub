# Event Handling in JavaScript

## Event Listeners

### addEventListener

```javascript
// Basic syntax
element.addEventListener('click', function(event) {
    console.log('Clicked!');
});

// Arrow function
element.addEventListener('click', (e) => {
    console.log('Clicked!');
});

// Named function
function handleClick(event) {
    console.log('Clicked!');
}
element.addEventListener('click', handleClick);

// With options
element.addEventListener('click', handler, {
    once: true,        // Fire only once
    passive: true,     // Never call preventDefault()
    capture: false     // Use capturing phase
});
```

### removeEventListener

```javascript
function handler(event) {
    console.log('Clicked!');
}

element.addEventListener('click', handler);
element.removeEventListener('click', handler); // Must be same function reference
```

## Event Types

### Mouse Events

```javascript
element.addEventListener('click', handler);
element.addEventListener('dblclick', handler);
element.addEventListener('mousedown', handler);
element.addEventListener('mouseup', handler);
element.addEventListener('mouseenter', handler);
element.addEventListener('mouseleave', handler);
element.addEventListener('mousemove', handler);
element.addEventListener('mouseover', handler);
element.addEventListener('mouseout', handler);
```

### Keyboard Events

```javascript
document.addEventListener('keydown', (e) => {
    console.log('Key:', e.key);
    console.log('Code:', e.code);
    console.log('Ctrl:', e.ctrlKey);
    console.log('Shift:', e.shiftKey);
    console.log('Alt:', e.altKey);
});

document.addEventListener('keyup', handler);
document.addEventListener('keypress', handler);
```

### Form Events

```javascript
form.addEventListener('submit', (e) => {
    e.preventDefault(); // Prevent form submission
    // Handle form
});

input.addEventListener('input', (e) => {
    console.log('Value:', e.target.value);
});

input.addEventListener('change', (e) => {
    console.log('Changed:', e.target.value);
});

input.addEventListener('focus', handler);
input.addEventListener('blur', handler);
```

### Window Events

```javascript
window.addEventListener('load', () => {
    console.log('Page loaded');
});

window.addEventListener('resize', () => {
    console.log('Window resized');
});

window.addEventListener('scroll', () => {
    console.log('Scrolled');
});

window.addEventListener('beforeunload', (e) => {
    e.preventDefault();
    e.returnValue = '';
});
```

## Event Object

```javascript
element.addEventListener('click', (event) => {
    // Event properties
    event.target;          // Element that triggered event
    event.currentTarget;    // Element with listener
    event.type;            // Event type ('click')
    event.timeStamp;       // When event occurred
    
    // Mouse events
    event.clientX;         // X position relative to viewport
    event.clientY;         // Y position relative to viewport
    event.button;          // Mouse button
    
    // Keyboard events
    event.key;             // Key value
    event.code;            // Physical key code
    event.ctrlKey;         // Ctrl pressed
    event.shiftKey;         // Shift pressed
    event.altKey;          // Alt pressed
    event.metaKey;          // Meta/Cmd pressed
    
    // Prevent default
    event.preventDefault();
    
    // Stop propagation
    event.stopPropagation();
    event.stopImmediatePropagation(); // Stop all handlers
});
```

## Event Delegation

```javascript
// Instead of attaching to each item
const list = document.querySelector('.list');
list.addEventListener('click', (e) => {
    if (e.target.matches('li')) {
        console.log('List item clicked:', e.target.textContent);
    }
});

// With closest
list.addEventListener('click', (e) => {
    const item = e.target.closest('li');
    if (item) {
        console.log('List item clicked:', item.textContent);
    }
});
```

## Custom Events

```javascript
// Create custom event
const customEvent = new CustomEvent('myEvent', {
    detail: { message: 'Hello' },
    bubbles: true,
    cancelable: true
});

// Dispatch
element.dispatchEvent(customEvent);

// Listen
element.addEventListener('myEvent', (e) => {
    console.log('Custom event:', e.detail.message);
});
```

---

**Next**: Learn about [Browser Storage](./BROWSER-STORAGE.md)

