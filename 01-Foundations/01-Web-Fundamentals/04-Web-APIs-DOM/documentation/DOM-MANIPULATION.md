# DOM Manipulation

## What is the DOM?

The Document Object Model (DOM) is a programming interface for HTML/XML documents. It represents the structure of a document as a tree of nodes.

## Selecting Elements

### getElementById

```javascript
const element = document.getElementById('myId');
```

### getElementsByClassName

```javascript
const elements = document.getElementsByClassName('myClass');
// Returns HTMLCollection (live)
```

### getElementsByTagName

```javascript
const divs = document.getElementsByTagName('div');
```

### querySelector

```javascript
// Single element
const element = document.querySelector('.myClass');
const element2 = document.querySelector('#myId');

// Multiple elements
const elements = document.querySelectorAll('.myClass');
// Returns NodeList (static)
```

## Creating Elements

```javascript
// Create element
const div = document.createElement('div');
div.textContent = 'Hello';
div.className = 'container';
div.id = 'myDiv';

// Create text node
const text = document.createTextNode('Hello World');

// Clone element
const clone = div.cloneNode(true); // true = deep clone
```

## Modifying Elements

### Content

```javascript
// textContent (plain text)
element.textContent = 'New text';

// innerHTML (HTML)
element.innerHTML = '<strong>Bold</strong> text';

// innerText (rendered text)
element.innerText = 'Text';

// insertAdjacentHTML
element.insertAdjacentHTML('beforebegin', '<p>Before</p>');
element.insertAdjacentHTML('afterbegin', '<p>After start</p>');
element.insertAdjacentHTML('beforeend', '<p>Before end</p>');
element.insertAdjacentHTML('afterend', '<p>After</p>');
```

### Attributes

```javascript
// Set attribute
element.setAttribute('data-id', '123');
element.setAttribute('class', 'new-class');

// Get attribute
const id = element.getAttribute('data-id');

// Remove attribute
element.removeAttribute('data-id');

// Check attribute
if (element.hasAttribute('data-id')) {
    // ...
}

// Direct property access
element.className = 'new-class';
element.id = 'new-id';
element.href = 'https://example.com';
```

### Styles

```javascript
// Inline styles
element.style.color = 'red';
element.style.backgroundColor = 'blue';
element.style.display = 'none';

// CSS property names (camelCase)
element.style.fontSize = '16px';
element.style.marginTop = '10px';

// setProperty
element.style.setProperty('--custom-var', 'value');
element.style.setProperty('color', 'red', 'important');

// getComputedStyle
const styles = window.getComputedStyle(element);
const color = styles.color;
```

### Classes

```javascript
// Add class
element.classList.add('active', 'highlight');

// Remove class
element.classList.remove('active');

// Toggle class
element.classList.toggle('active');

// Check if has class
if (element.classList.contains('active')) {
    // ...
}

// Replace class
element.classList.replace('old', 'new');

// Multiple operations
element.classList.add('a', 'b', 'c');
```

## Adding/Removing Elements

### Append Child

```javascript
// Append to end
parent.appendChild(child);

// Insert before
parent.insertBefore(newChild, existingChild);

// Replace
parent.replaceChild(newChild, oldChild);

// Remove
parent.removeChild(child);
// Or
child.remove();
```

### Modern Methods

```javascript
// Append (multiple)
parent.append(child1, child2, 'text');

// Prepend
parent.prepend(child);

// After
element.after(newElement);

// Before
element.before(newElement);

// Replace with
element.replaceWith(newElement);
```

## Traversing the DOM

### Parent

```javascript
element.parentElement;
element.parentNode;

// Closest ancestor matching selector
element.closest('.container');
```

### Children

```javascript
element.children; // HTMLCollection of elements
element.childNodes; // NodeList (includes text nodes)

element.firstElementChild;
element.lastElementChild;
element.firstChild; // Includes text nodes
element.lastChild;
```

### Siblings

```javascript
element.nextElementSibling;
element.previousElementSibling;
element.nextSibling; // Includes text nodes
element.previousSibling;
```

## DOM Events

See [EVENT-HANDLING.md](./EVENT-HANDLING.md) for detailed event handling.

```javascript
// Add event listener
element.addEventListener('click', handler);

// Remove event listener
element.removeEventListener('click', handler);
```

## Performance Tips

### Document Fragment

```javascript
const fragment = document.createDocumentFragment();

for (let i = 0; i < 1000; i++) {
    const div = document.createElement('div');
    fragment.appendChild(div);
}

document.body.appendChild(fragment); // Single DOM update
```

### Batch DOM Updates

```javascript
// Bad - multiple reflows
for (let i = 0; i < 100; i++) {
    element.style.width = i + 'px';
}

// Good - single reflow
let width = '';
for (let i = 0; i < 100; i++) {
    width += i + 'px';
}
element.style.width = width;
```

### Use CSS Classes

```javascript
// Bad
element.style.display = 'none';
element.style.color = 'red';

// Good
element.classList.add('hidden', 'error');
```

## Common Patterns

### Find All Elements with Data Attribute

```javascript
const elements = document.querySelectorAll('[data-category="featured"]');
```

### Create Element with Class

```javascript
function createElement(tag, className, text) {
    const element = document.createElement(tag);
    if (className) element.className = className;
    if (text) element.textContent = text;
    return element;
}

const div = createElement('div', 'container', 'Hello');
```

### Wrapper Function

```javascript
const $ = (selector) => document.querySelector(selector);
const $$ = (selector) => document.querySelectorAll(selector);

$('#myId');
$$('.myClass');
```

---

**Next**: Learn about [Event Handling](./EVENT-HANDLING.md)

