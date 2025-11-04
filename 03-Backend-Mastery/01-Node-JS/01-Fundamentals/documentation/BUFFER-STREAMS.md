# Buffers and Streams

## 📚 Buffers

Buffers are used to handle binary data in Node.js.

### Creating Buffers

```javascript
// From string
const buf1 = Buffer.from('Hello', 'utf8');

// Allocate
const buf2 = Buffer.alloc(10); // 10 bytes, filled with zeros
const buf3 = Buffer.allocUnsafe(10); // Faster, but may contain old data

// From array
const buf4 = Buffer.from([0x48, 0x65, 0x6c, 0x6c, 0x6f]);
```

### Buffer Operations

```javascript
// Write
const buf = Buffer.alloc(10);
buf.write('Hello', 0, 'utf8');

// Read
const str = buf.toString('utf8');

// Length
const length = buf.length;

// Copy
const buf2 = Buffer.alloc(10);
buf.copy(buf2, 0, 0, 5);

// Slice
const slice = buf.slice(0, 5);
```

## 🌊 Streams

Streams handle data in chunks, making them memory-efficient.

### Types of Streams

1. **Readable**: Read data
2. **Writable**: Write data
3. **Duplex**: Both read and write
4. **Transform**: Modify data as it passes through

### Readable Streams

```javascript
const fs = require('fs');

// Read file as stream
const readable = fs.createReadStream('large-file.txt');

readable.on('data', (chunk) => {
  console.log(`Received ${chunk.length} bytes`);
});

readable.on('end', () => {
  console.log('Finished reading');
});

readable.on('error', (err) => {
  console.error('Error:', err);
});
```

### Writable Streams

```javascript
const fs = require('fs');

const writable = fs.createWriteStream('output.txt');

writable.write('Hello');
writable.write(' World');
writable.end(); // Close stream

writable.on('finish', () => {
  console.log('Finished writing');
});
```

### Piping

```javascript
// Pipe readable to writable
const readable = fs.createReadStream('input.txt');
const writable = fs.createWriteStream('output.txt');

readable.pipe(writable);

// Chain pipes
readable
  .pipe(transform)
  .pipe(compress)
  .pipe(writable);
```

### Transform Streams

```javascript
const { Transform } = require('stream');

class UpperCaseTransform extends Transform {
  _transform(chunk, encoding, callback) {
    const upper = chunk.toString().toUpperCase();
    this.push(upper);
    callback();
  }
}

const transform = new UpperCaseTransform();
readable.pipe(transform).pipe(writable);
```

### Backpressure

```javascript
// Handle backpressure
readable.on('data', (chunk) => {
  const canContinue = writable.write(chunk);
  
  if (!canContinue) {
    readable.pause(); // Pause reading
    writable.once('drain', () => {
      readable.resume(); // Resume reading
    });
  }
});
```

---

**Next**: Learn about [Error Handling](./ERROR-HANDLING.md)

