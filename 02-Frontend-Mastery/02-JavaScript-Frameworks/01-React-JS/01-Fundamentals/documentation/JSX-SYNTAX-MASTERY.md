# JSX Syntax Mastery

## 📚 What is JSX?

JSX (JavaScript XML) is a syntax extension for JavaScript that lets you write HTML-like code in JavaScript.

## 🎯 Basic JSX

### Expressions

```jsx
const name = "John";
const element = <h1>Hello, {name}!</h1>;

// Expressions
const element = <h1>2 + 2 = {2 + 2}</h1>;

// Function calls
function formatName(user) {
  return user.firstName + ' ' + user.lastName;
}
const element = <h1>Hello, {formatName(user)}!</h1>;
```

### Attributes

```jsx
// Use camelCase for attributes
const element = <div className="container" tabIndex="0">Content</div>;

// Use {} for JavaScript expressions
const element = <img src={user.avatarUrl} alt={user.name} />;

// Boolean attributes
const element = <input disabled={isDisabled} checked={isChecked} />;
```

### Self-Closing Tags

```jsx
// Always close tags
const element = <img src="image.jpg" alt="Description" />;
const element = <br />;
const element = <hr />;
```

## 🧩 JSX Children

### Text Content

```jsx
const element = <p>This is text content</p>;
```

### Nested Elements

```jsx
const element = (
  <div>
    <h1>Title</h1>
    <p>Paragraph</p>
  </div>
);
```

### Fragments

```jsx
// Fragment
const element = (
  <>
    <h1>Title</h1>
    <p>Content</p>
  </>
);

// Named fragment
const element = (
  <React.Fragment>
    <h1>Title</h1>
    <p>Content</p>
  </React.Fragment>
);
```

## 🔧 Advanced JSX

### Conditional Rendering

```jsx
// Ternary operator
{isLoggedIn ? <Dashboard /> : <Login />}

// Logical AND
{isLoading && <Spinner />}

// If statement (outside JSX)
let content;
if (isLoggedIn) {
  content = <Dashboard />;
} else {
  content = <Login />;
}
```

### Lists and Keys

```jsx
const items = ['Item 1', 'Item 2', 'Item 3'];

const list = (
  <ul>
    {items.map((item, index) => (
      <li key={index}>{item}</li>
    ))}
  </ul>
);

// Better: Use unique IDs
const todos = [
  { id: 1, text: 'Learn React' },
  { id: 2, text: 'Build app' }
];

const list = (
  <ul>
    {todos.map(todo => (
      <li key={todo.id}>{todo.text}</li>
    ))}
  </ul>
);
```

### Event Handlers

```jsx
function Button() {
  const handleClick = (e) => {
    e.preventDefault();
    console.log('Clicked');
  };
  
  return <button onClick={handleClick}>Click me</button>;
}

// Inline handler
<button onClick={() => console.log('Clicked')}>Click</button>

// With parameters
<button onClick={(e) => handleClick(e, id)}>Click</button>
```

### Styles

```jsx
// Inline styles (object)
const style = {
  color: 'blue',
  fontSize: '20px',
  backgroundColor: 'lightgray'
};

<div style={style}>Content</div>

// Or inline
<div style={{ color: 'blue', fontSize: '20px' }}>Content</div>

// CSS classes
<div className="container">Content</div>
```

## 🎨 JSX Patterns

### Component Composition

```jsx
function Page() {
  return (
    <Layout>
      <Header />
      <Main>
        <Article />
        <Sidebar />
      </Main>
      <Footer />
    </Layout>
  );
}
```

### Children Prop

```jsx
function Container({ children }) {
  return <div className="container">{children}</div>;
}

// Usage
<Container>
  <h1>Title</h1>
  <p>Content</p>
</Container>
```

### Spread Operator

```jsx
const props = { name: 'John', age: 30 };
<UserCard {...props} />

// With override
<UserCard {...props} age={31} />
```

## ⚠️ JSX Rules

1. Return single root element or fragment
2. Use className instead of class
3. Use camelCase for attributes
4. Close all tags
5. Use {} for JavaScript expressions
6. Keys must be unique in lists

---

**Next**: Learn about [Components & Props](./COMPONENTS-PROPS-THEORY.md)

