# Fetch API

## Basic Usage

```javascript
// GET request
fetch('/api/users')
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error('Error:', error));
```

## POST Request

```javascript
fetch('/api/users', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify({
        name: 'John',
        age: 30
    })
})
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error('Error:', error));
```

## Response Handling

```javascript
fetch('/api/data')
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => console.log(data))
    .catch(error => console.error('Error:', error));
```

## Async/Await

```javascript
async function fetchData() {
    try {
        const response = await fetch('/api/data');
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error:', error);
        throw error;
    }
}
```

## Headers

```javascript
fetch('/api/data', {
    headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer token123',
        'X-Custom-Header': 'value'
    }
});
```

## Error Handling

```javascript
async function fetchWithErrorHandling(url) {
    try {
        const response = await fetch(url);
        
        if (response.status === 404) {
            throw new Error('Not found');
        }
        
        if (response.status === 500) {
            throw new Error('Server error');
        }
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        return await response.json();
    } catch (error) {
        if (error.name === 'TypeError') {
            console.error('Network error:', error);
        } else {
            console.error('Error:', error);
        }
        throw error;
    }
}
```

---

**Next**: See [Web APIs Overview](./WEB-APIS-OVERVIEW.md)

