# Arrays and Strings

## Arrays

### Operations

```javascript
// Access
arr[index]

// Insert
arr.push(value)         // End
arr.unshift(value)      // Beginning
arr.splice(index, 0, value)  // At index

// Remove
arr.pop()               // End
arr.shift()             // Beginning
arr.splice(index, 1)   // At index

// Search
arr.indexOf(value)
arr.includes(value)
arr.find(callback)
arr.findIndex(callback)
```

### Common Algorithms

```javascript
// Reverse
function reverse(arr) {
    return arr.reverse();
}

// Rotate
function rotate(arr, k) {
    k = k % arr.length;
    return [...arr.slice(-k), ...arr.slice(0, -k)];
}

// Two Sum
function twoSum(arr, target) {
    const map = new Map();
    for (let i = 0; i < arr.length; i++) {
        const complement = target - arr[i];
        if (map.has(complement)) {
            return [map.get(complement), i];
        }
        map.set(arr[i], i);
    }
    return [];
}
```

## Strings

### Common Operations

```javascript
// Manipulation
str.length
str.charAt(index)
str.substring(start, end)
str.slice(start, end)
str.replace(pattern, replacement)
str.toLowerCase()
str.toUpperCase()
str.trim()

// Search
str.indexOf(substring)
str.includes(substring)
str.startsWith(prefix)
str.endsWith(suffix)

// Split/Join
str.split(delimiter)
arr.join(delimiter)
```

### Algorithms

```javascript
// Reverse string
function reverse(str) {
    return str.split('').reverse().join('');
}

// Palindrome check
function isPalindrome(str) {
    const cleaned = str.toLowerCase().replace(/\W/g, '');
    return cleaned === cleaned.split('').reverse().join('');
}

// Anagrams
function areAnagrams(str1, str2) {
    const normalize = str => str.toLowerCase().split('').sort().join('');
    return normalize(str1) === normalize(str2);
}
```

---

**Next**: Learn about [Linked Lists](./LINKED-LISTS.md)

