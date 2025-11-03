# Browser Storage APIs

## LocalStorage

### Basic Usage

```javascript
// Set item
localStorage.setItem('username', 'john_doe');
localStorage.setItem('user', JSON.stringify({name: 'John', age: 30}));

// Get item
const username = localStorage.getItem('username');
const user = JSON.parse(localStorage.getItem('user'));

// Remove item
localStorage.removeItem('username');

// Clear all
localStorage.clear();

// Get key by index
const key = localStorage.key(0);

// Length
const length = localStorage.length;
```

### Storage Event

```javascript
// Listen for storage changes in other tabs
window.addEventListener('storage', (e) => {
    console.log('Key:', e.key);
    console.log('Old value:', e.oldValue);
    console.log('New value:', e.newValue);
    console.log('Storage area:', e.storageArea);
});
```

## SessionStorage

```javascript
// Works same as localStorage
sessionStorage.setItem('key', 'value');
const value = sessionStorage.getItem('key');
sessionStorage.removeItem('key');
sessionStorage.clear();

// But data only persists for session
```

## IndexedDB

### Opening Database

```javascript
const request = indexedDB.open('MyDB', 1);

request.onerror = (event) => {
    console.error('Database error:', event);
};

request.onsuccess = (event) => {
    const db = event.target.result;
    // Use database
};

request.onupgradeneeded = (event) => {
    const db = event.target.result;
    
    // Create object store
    if (!db.objectStoreNames.contains('users')) {
        const objectStore = db.createObjectStore('users', {
            keyPath: 'id',
            autoIncrement: true
        });
        
        // Create index
        objectStore.createIndex('name', 'name', { unique: false });
    }
};
```

### Adding Data

```javascript
const transaction = db.transaction(['users'], 'readwrite');
const objectStore = transaction.objectStore('users');
const request = objectStore.add({ name: 'John', age: 30 });

request.onsuccess = () => {
    console.log('Added successfully');
};
```

### Getting Data

```javascript
const transaction = db.transaction(['users'], 'readonly');
const objectStore = transaction.objectStore('users');
const request = objectStore.get(1);

request.onsuccess = () => {
    const user = request.result;
    console.log('User:', user);
};
```

## Cookies

```javascript
// Set cookie
document.cookie = 'username=john; expires=Thu, 18 Dec 2024 12:00:00 UTC; path=/';

// Get cookies
const cookies = document.cookie;

// Helper functions
function setCookie(name, value, days) {
    const expires = new Date();
    expires.setTime(expires.getTime() + days * 24 * 60 * 60 * 1000);
    document.cookie = `${name}=${value};expires=${expires.toUTCString()};path=/`;
}

function getCookie(name) {
    const nameEQ = name + '=';
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
```

---

**Next**: Learn about [Fetch API](./FETCH-API.md)

