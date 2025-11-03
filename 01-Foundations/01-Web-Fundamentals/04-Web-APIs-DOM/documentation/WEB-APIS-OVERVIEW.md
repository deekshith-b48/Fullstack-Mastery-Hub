# Web APIs Overview

## Common Browser APIs

### Geolocation API

```javascript
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
        (position) => {
            console.log('Latitude:', position.coords.latitude);
            console.log('Longitude:', position.coords.longitude);
        },
        (error) => {
            console.error('Error:', error);
        }
    );
}
```

### Canvas API

```javascript
const canvas = document.getElementById('myCanvas');
const ctx = canvas.getContext('2d');

ctx.fillStyle = 'red';
ctx.fillRect(10, 10, 100, 100);

ctx.beginPath();
ctx.arc(200, 100, 50, 0, 2 * Math.PI);
ctx.fill();
```

### Web Audio API

```javascript
const audioContext = new AudioContext();
const oscillator = audioContext.createOscillator();
oscillator.connect(audioContext.destination);
oscillator.start();
```

### Intersection Observer

```javascript
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
        }
    });
});

observer.observe(element);
```

### ResizeObserver

```javascript
const resizeObserver = new ResizeObserver(entries => {
    for (const entry of entries) {
        console.log('Size:', entry.contentRect);
    }
});

resizeObserver.observe(element);
```

---

**Next**: Learn about [Git & GitHub](../02-Development-Essentials/01-Git-GitHub/documentation/GIT-FUNDAMENTALS.md)

