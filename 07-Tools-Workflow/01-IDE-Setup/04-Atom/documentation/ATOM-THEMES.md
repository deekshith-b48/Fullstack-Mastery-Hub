# Atom Themes

Atom themes customize the appearance of the editor, including syntax highlighting, UI elements, and overall visual style. This guide covers theme installation, customization, and best practices.

## Theme Overview

Atom themes include:
- **Syntax Themes**: Code syntax highlighting
- **UI Themes**: Interface appearance
- **Combined Themes**: Both syntax and UI
- **Custom Themes**: Create your own

## Installing Themes

### Via Settings

1. **File** → **Settings** → **Themes**
2. Browse themes
3. Install theme
4. Apply theme

### Via Command Line

```bash
# Install theme
apm install theme-name

# Search themes
apm search theme
```

## Popular Themes

### Syntax Themes

- **One Dark Syntax**: Default dark syntax
- **One Light Syntax**: Default light syntax
- **Monokai**: Monokai color scheme
- **Solarized Dark**: Solarized dark
- **Solarized Light**: Solarized light

### UI Themes

- **One Dark UI**: Default dark UI
- **One Light UI**: Default light UI
- **Seti UI**: Seti interface theme
- **Material UI**: Material Design theme
- **Nucleus Dark**: Dark UI theme

## Applying Themes

### Changing Themes

1. **File** → **Settings** → **Themes**
2. Select UI Theme
3. Select Syntax Theme
4. Themes apply immediately

### Theme Settings

- **UI Theme**: Interface appearance
- **Syntax Theme**: Code highlighting
- **Preview**: Preview themes before applying

## Customizing Themes

### Creating Custom Themes

1. **File** → **Settings** → **Packages** → **Generate Syntax Theme**
2. Enter theme name
3. Theme scaffold created
4. Customize colors

### Theme Structure

```
my-theme/
├── package.json
├── styles/
│   ├── colors.less
│   └── syntax-variables.less
└── README.md
```

### Customizing Colors

Edit theme files:
```less
@syntax-text-color: #abb2bf;
@syntax-cursor-color: #528bff;
@syntax-selection-color: #3e4451;
```

## Theme Configuration

### Settings

Configure theme settings:
1. **File** → **Settings** → **Themes**
2. Select theme
3. Click Settings
4. Configure options

### Font Settings

- **Font Family**: Set editor font
- **Font Size**: Adjust font size
- **Line Height**: Set line height
- **Font Ligatures**: Enable ligatures

## Best Practices

### Theme Selection

1. **Eye Comfort**: Choose comfortable colors
2. **Contrast**: Ensure good contrast
3. **Consistency**: Use consistent themes
4. **Productivity**: Themes that improve focus

### Customization

1. **Start with Base**: Modify existing theme
2. **Test Changes**: Test color changes
3. **Backup Original**: Keep original theme
4. **Share Themes**: Share with team

## Next Steps

- Learn [Hackability](./ATOM-HACKABILITY.md)
- Configure [Git Integration](./ATOM-GIT-INTEGRATION.md)
- Optimize [Performance](./ATOM-PERFORMANCE.md)

Themes enhance your Atom experience. Choose and customize themes for a comfortable editing environment.





