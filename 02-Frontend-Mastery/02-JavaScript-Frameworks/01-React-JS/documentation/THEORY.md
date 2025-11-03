# React.js - Theory

## 📚 Overview

React is a JavaScript library for building user interfaces, particularly web applications. It uses a component-based architecture and a virtual DOM for efficient rendering.

## 🎯 Core Concepts

### Components

**Definition**: Reusable, self-contained pieces of UI.

**Functional Components**:
```jsx
function Welcome({ name }) {
  return <h1>Hello, {name}!</h1>;
}

// Arrow function
const Welcome = ({ name }) => <h1>Hello, {name}!</h1>;
```

**Class Components**:
```jsx
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}!</h1>;
  }
}
```

### JSX

**Definition**: JavaScript syntax extension that lets you write HTML-like code in JavaScript.

**Example**:
```jsx
const element = <h1>Hello, World!</h1>;
const name = 'John';
const greeting = <h1>Hello, {name}!</h1>;
```

### Props

**Definition**: Properties passed from parent to child components.

**Example**:
```jsx
function UserCard({ name, email, age }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{email}</p>
      <p>Age: {age}</p>
    </div>
  );
}

<UserCard name="John" email="john@example.com" age={30} />
```

### State

**Definition**: Component's internal data that can change over time.

**Using useState Hook**:
```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

### Hooks

**Common Hooks**:
- `useState`: Manage component state
- `useEffect`: Handle side effects
- `useContext`: Access context
- `useReducer`: Complex state management
- `useMemo`: Memoize expensive calculations
- `useCallback`: Memoize functions

**useEffect Example**:
```jsx
import { useEffect, useState } from 'react';

function DataFetcher({ url }) {
  const [data, setData] = useState(null);
  
  useEffect(() => {
    fetch(url)
      .then(res => res.json())
      .then(setData);
  }, [url]); // Dependency array
  
  return data ? <div>{JSON.stringify(data)}</div> : <div>Loading...</div>;
}
```

### Virtual DOM

**Definition**: In-memory representation of the real DOM that React uses for efficient updates.

**How it works**:
1. React creates a virtual DOM when state changes
2. Compares with previous virtual DOM (diffing)
3. Updates only changed parts in the real DOM (reconciliation)

### Component Lifecycle

**Functional Components (with Hooks)**:
```jsx
useEffect(() => {
  // Component did mount + did update
  return () => {
    // Cleanup (component will unmount)
  };
}, [dependencies]);
```

**Class Components**:
- `componentDidMount`: After first render
- `componentDidUpdate`: After update
- `componentWillUnmount`: Before unmount

### Event Handling

**Example**:
```jsx
function Button() {
  const handleClick = (e) => {
    e.preventDefault();
    console.log('Clicked!');
  };
  
  return <button onClick={handleClick}>Click me</button>;
}
```

### Conditional Rendering

```jsx
function Greeting({ isLoggedIn }) {
  return (
    <div>
      {isLoggedIn ? (
        <h1>Welcome back!</h1>
      ) : (
        <h1>Please log in.</h1>
      )}
      
      {isLoggedIn && <Dashboard />}
    </div>
  );
}
```

### Lists and Keys

```jsx
function TodoList({ todos }) {
  return (
    <ul>
      {todos.map(todo => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}
```

## 🔑 Key Concepts

### Unidirectional Data Flow
- Data flows down from parent to child
- Events flow up from child to parent
- State is managed at the appropriate level

### Composition over Inheritance
- Build complex UIs from simple components
- Compose components together
- Reuse logic with custom hooks

### React Patterns
- **Container/Presentational**: Separate logic and presentation
- **Higher-Order Components**: Reuse component logic
- **Render Props**: Share code between components
- **Custom Hooks**: Extract and reuse stateful logic

## 📚 Resources

- [React Official Docs](https://react.dev/)
- [React Hooks Guide](https://react.dev/reference/react)
- [React Patterns](https://reactpatterns.com/)

---

**Last Updated**: 2024

