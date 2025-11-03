# HTML5 Setup Guide

## 📋 Prerequisites

Before starting with HTML5, ensure you have:

- A modern web browser (Chrome, Firefox, Safari, Edge)
- A text editor (VS Code, Sublime Text, Atom)
- Basic understanding of web development

## 🚀 Development Environment Setup

### Option 1: Local Development (Recommended for Beginners)

1. **Install a Text Editor**

   **VS Code** (Recommended):
   ```bash
   # Download from: https://code.visualstudio.com/
   # Install HTML extensions:
   # - HTML CSS Support
   # - Live Server
   # - Prettier
   ```

2. **Create Your First HTML File**

   Create `index.html`:
   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>My First HTML5 Page</title>
   </head>
   <body>
       <h1>Hello, HTML5!</h1>
   </body>
   </html>
   ```

3. **View Your File**

   - Double-click `index.html` to open in browser
   - Or use VS Code Live Server extension
   - Or run: `python -m http.server 8000` (if Python installed)

### Option 2: Online Development

Use online editors:
- **CodePen**: https://codepen.io
- **JSFiddle**: https://jsfiddle.net
- **CodeSandbox**: https://codesandbox.io

## 🛠️ Recommended Tools

### Browser Developer Tools

All modern browsers include developer tools:

**Chrome DevTools**:
- Press `F12` or `Ctrl+Shift+I` (Windows/Linux)
- Press `Cmd+Option+I` (Mac)

**Firefox Developer Tools**:
- Press `F12` or `Ctrl+Shift+I`
- Excellent for accessibility testing

### VS Code Extensions

Install these extensions for better HTML5 development:

```json
{
  "recommendations": [
    "ritwickdey.liveserver",
    "ms-vscode.vscode-typescript-next",
    "esbenp.prettier-vscode",
    "formulahendry.auto-rename-tag",
    "bradlc.vscode-tailwindcss"
  ]
}
```

### HTML5 Validators

- **W3C Validator**: https://validator.w3.org/
- **Nu HTML Checker**: https://validator.w3.org/nu/
- **Browser Extensions**: HTML Validator extensions

## 📦 Project Structure

### Basic Project Structure

```
my-html5-project/
├── index.html
├── about.html
├── css/
│   └── style.css
├── js/
│   └── script.js
├── images/
│   └── logo.png
└── assets/
    └── fonts/
```

### Semantic Project Structure

```
semantic-project/
├── index.html
├── pages/
│   ├── about.html
│   ├── contact.html
│   └── blog/
│       └── post.html
├── assets/
│   ├── css/
│   │   ├── main.css
│   │   └── components.css
│   ├── js/
│   │   ├── main.js
│   │   └── modules/
│   ├── images/
│   │   └── icons/
│   └── fonts/
└── README.md
```

## 🎯 Quick Start Templates

### Minimal HTML5 Template

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Page description">
    <title>Page Title</title>
</head>
<body>
    <header>
        <h1>Site Title</h1>
    </header>
    <main>
        <p>Content goes here</p>
    </main>
    <footer>
        <p>&copy; 2024</p>
    </footer>
</body>
</html>
```

### Semantic Template

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Description of the page">
    <meta name="keywords" content="keyword1, keyword2">
    <meta name="author" content="Your Name">
    
    <!-- Open Graph -->
    <meta property="og:title" content="Page Title">
    <meta property="og:description" content="Page Description">
    <meta property="og:image" content="image.jpg">
    
    <title>Page Title</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/about">About</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <article>
            <header>
                <h1>Article Title</h1>
                <time datetime="2024-01-15">January 15, 2024</time>
            </header>
            <section>
                <h2>Section Title</h2>
                <p>Content...</p>
            </section>
        </article>
        
        <aside>
            <h3>Related Content</h3>
            <ul>
                <li><a href="#">Related Link 1</a></li>
            </ul>
        </aside>
    </main>
    
    <footer>
        <p>&copy; 2024 Company Name</p>
    </footer>
    
    <script src="js/script.js"></script>
</body>
</html>
```

## ✅ Validation Setup

### W3C HTML Validator

1. Visit: https://validator.w3.org/
2. Enter URL or upload file
3. Check for errors and warnings
4. Fix issues

### VS Code Validation

Install "HTMLHint" extension:

```bash
code --install-extension mkaufman.htmlhint
```

Create `.htmlhintrc`:
```json
{
  "tagname-lowercase": true,
  "attr-lowercase": true,
  "attr-value-double-quotes": true,
  "doctype-first": true,
  "id-unique": true,
  "src-not-empty": true,
  "attr-no-duplication": true
}
```

## 🔧 Development Server Setup

### Python HTTP Server

```bash
# Python 3
python -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000

# Access at: http://localhost:8000
```

### Node.js HTTP Server

```bash
# Install http-server globally
npm install -g http-server

# Run server
http-server -p 8000

# Access at: http://localhost:8000
```

### VS Code Live Server

1. Install "Live Server" extension
2. Right-click on HTML file
3. Select "Open with Live Server"
4. Auto-reloads on file changes

## 📝 Editor Configuration

### VS Code Settings

Add to `.vscode/settings.json`:

```json
{
  "emmet.includeLanguages": {
    "html": "html"
  },
  "editor.formatOnSave": true,
  "html.format.indentInnerHtml": true,
  "html.format.wrapLineLength": 80,
  "files.associations": {
    "*.html": "html"
  }
}
```

### VS Code Snippets

Create `.vscode/html.code-snippets`:

```json
{
  "HTML5 Basic Structure": {
    "prefix": "html5",
    "body": [
      "<!DOCTYPE html>",
      "<html lang=\"en\">",
      "<head>",
      "    <meta charset=\"UTF-8\">",
      "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
      "    <title>$1</title>",
      "</head>",
      "<body>",
      "    $2",
      "</body>",
      "</html>"
    ],
    "description": "HTML5 basic structure"
  }
}
```

## 🌐 Browser Testing

### Required Browsers for Testing

- **Chrome** (Latest)
- **Firefox** (Latest)
- **Safari** (Latest, if on Mac)
- **Edge** (Latest)

### Browser Testing Tools

- **BrowserStack**: Cross-browser testing
- **LambdaTest**: Online browser testing
- **Can I Use**: Feature compatibility checker

## 🚀 Deployment Setup

### GitHub Pages

1. Create GitHub repository
2. Push HTML files
3. Go to Settings > Pages
4. Select branch and folder
5. Access at: `username.github.io/repository`

### Netlify

1. Install Netlify CLI: `npm install -g netlify-cli`
2. Deploy: `netlify deploy`
3. Or connect GitHub repository

### Vercel

1. Install Vercel CLI: `npm install -g vercel`
2. Deploy: `vercel`
3. Follow prompts

## 📚 Learning Resources

- **MDN HTML5 Docs**: https://developer.mozilla.org/en-US/docs/Web/HTML
- **W3C HTML5 Spec**: https://www.w3.org/TR/html52/
- **HTML5 Doctor**: http://html5doctor.com/
- **Can I Use**: https://caniuse.com/

## ✅ Checklist

Before starting development, ensure:

- [ ] Text editor installed
- [ ] Browser developer tools familiar
- [ ] HTML5 validator bookmarked
- [ ] Local server set up
- [ ] Project structure created
- [ ] VS Code extensions installed (if using)
- [ ] First HTML5 file created and validated

---

**Next**: Start with [HTML5-BEST-PRACTICES.md](./HTML5-BEST-PRACTICES.md) for development guidelines.

