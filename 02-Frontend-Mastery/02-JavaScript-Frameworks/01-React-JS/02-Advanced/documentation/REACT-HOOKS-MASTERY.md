# React Hooks - Mastery Guide

## 📚 What are Hooks?

Hooks are functions that let you "hook into" React state and lifecycle features from function components.

## 🎯 Basic Hooks

### useState

```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <button onClick={() => setCount(prev => prev + 1)}>Increment (functional)</button>
    </div>
  );
}

// Multiple state
function Form() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  
  return (
    <form>
      <input value={name} onChange={(e) => setName(e.target.value)} />
      <input value={email} onChange={(e) => setEmail(e.target.value)} />
    </form>
  );
}
```

### useEffect

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

// Cleanup
useEffect(() => {
  const timer = setInterval(() => {
    console.log('Tick');
  }, 1000);
  
  return () => clearInterval(timer); // Cleanup
}, []);

// Run on mount only
useEffect(() => {
  console.log('Component mounted');
}, []); // Empty dependency array
```

### useContext

```jsx
import { createContext, useContext } from 'react';

const ThemeContext = createContext('light');

function App() {
  return (
    <ThemeContext.Provider value="dark">
      <ThemedButton />
    </ThemeContext.Provider>
  );
}

function ThemedButton() {
  const theme = useContext(ThemeContext);
  return <button className={theme}>Button</button>;
}
```

## 🔧 Additional Hooks

### useReducer

```jsx
import { useReducer } from 'react';

function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return { count: state.count + 1 };
    case 'decrement':
      return { count: state.count - 1 };
    default:
      return state;
  }
}

function Counter() {
  const [state, dispatch] = useReducer(reducer, { count: 0 });
  
  return (
    <div>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: 'increment' })}>+</button>
      <button onClick={() => dispatch({ type: 'decrement' })}>-</button>
    </div>
  );
}
```

### useMemo

```jsx
import { useMemo } from 'react';

function ExpensiveComponent({ items }) {
  const sortedItems = useMemo(() => {
    return items.sort((a, b) => a.value - b.value);
  }, [items]);
  
  return <div>{/* Render sorted items */}</div>;
}
```

### useCallback

```jsx
import { useCallback } from 'react';

function Parent({ items }) {
  const handleClick = useCallback((id) => {
    console.log('Clicked:', id);
  }, []); // Empty deps - function never changes
  
  return (
    <div>
      {items.map(item => (
        <Child key={item.id} onClick={handleClick} id={item.id} />
      ))}
    </div>
  );
}
```

### useRef

```jsx
import { useRef } from 'react';

function TextInput() {
  const inputRef = useRef(null);
  
  const focusInput = () => {
    inputRef.current.focus();
  };
  
  return (
    <div>
      <input ref={inputRef} />
      <button onClick={focusInput}>Focus</button>
    </div>
  );
}

// Store mutable value
function Timer() {
  const intervalRef = useRef(null);
  
  useEffect(() => {
    intervalRef.current = setInterval(() => {
      console.log('Tick');
    }, 1000);
    
    return () => clearInterval(intervalRef.current);
  }, []);
}
```

## 🎨 Custom Hooks

```jsx
// useFetch custom hook
function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    fetch(url)
      .then(res => res.json())
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [url]);
  
  return { data, loading, error };
}

// Usage
function DataDisplay({ url }) {
  const { data, loading, error } = useFetch(url);
  
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  return <div>{JSON.stringify(data)}</div>;
}
```

## 📋 Rules of Hooks

1. Only call hooks at the top level
2. Only call hooks from React functions
3. Don't call hooks conditionally

```jsx
// ❌ Bad
if (condition) {
  useState(0);
}

// ✅ Good
const [state, setState] = useState(0);
if (condition) {
  // Use state
}
```

---

**Next**: Learn about [Context API](./CONTEXT-API-DEEP-DIVE.md)

