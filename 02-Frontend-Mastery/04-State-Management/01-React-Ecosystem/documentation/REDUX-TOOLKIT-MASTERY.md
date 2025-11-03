# Redux Toolkit - Mastery Guide

## 📚 Overview

Redux Toolkit (RTK) is the official, opinionated, batteries-included toolset for efficient Redux development.

## 🚀 Installation

```bash
npm install @reduxjs/toolkit react-redux
```

## 🎯 Basic Setup

### Store Configuration

```javascript
// store/index.js
import { configureStore } from '@reduxjs/toolkit';
import counterReducer from './features/counterSlice';

export const store = configureStore({
  reducer: {
    counter: counterReducer,
  },
});
```

### Provider Setup

```jsx
// main.jsx
import { Provider } from 'react-redux';
import { store } from './store';

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
);
```

## 🧩 Creating Slices

### Slice Example

```javascript
// features/counterSlice.js
import { createSlice } from '@reduxjs/toolkit';

const initialState = {
  value: 0,
};

const counterSlice = createSlice({
  name: 'counter',
  initialState,
  reducers: {
    increment: (state) => {
      state.value += 1;
    },
    decrement: (state) => {
      state.value -= 1;
    },
    incrementByAmount: (state, action) => {
      state.value += action.payload;
    },
  },
});

export const { increment, decrement, incrementByAmount } = counterSlice.actions;
export default counterSlice.reducer;
```

### Using in Components

```jsx
import { useSelector, useDispatch } from 'react-redux';
import { increment, decrement } from './features/counterSlice';

function Counter() {
  const count = useSelector((state) => state.counter.value);
  const dispatch = useDispatch();
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => dispatch(increment())}>Increment</button>
      <button onClick={() => dispatch(decrement())}>Decrement</button>
    </div>
  );
}
```

## 🔧 Async Actions (createAsyncThunk)

```javascript
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export const fetchUsers = createAsyncThunk(
  'users/fetchUsers',
  async () => {
    const response = await fetch('/api/users');
    return response.json();
  }
);

const usersSlice = createSlice({
  name: 'users',
  initialState: {
    items: [],
    loading: false,
    error: null,
  },
  extraReducers: (builder) => {
    builder
      .addCase(fetchUsers.pending, (state) => {
        state.loading = true;
      })
      .addCase(fetchUsers.fulfilled, (state, action) => {
        state.loading = false;
        state.items = action.payload;
      })
      .addCase(fetchUsers.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message;
      });
  },
});
```

---

**Next**: Learn about [Zustand](./ZUSTAND-STATE.md)

