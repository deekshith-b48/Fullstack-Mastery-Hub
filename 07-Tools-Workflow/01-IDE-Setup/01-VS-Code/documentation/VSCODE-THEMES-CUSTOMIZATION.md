# VS Code Themes and Customization

VS Code offers extensive customization options to make your editor look and feel exactly how you want. This guide covers themes, colors, icons, and UI customization.

## Themes Overview

Themes control the appearance of VS Code:
- **Color Themes**: Color schemes for syntax highlighting
- **Icon Themes**: File and folder icons
- **Product Icon Themes**: VS Code icon appearance

## Installing Themes

### From Marketplace

1. Open Extensions view (`Ctrl+Shift+X`)
2. Search for "theme"
3. Browse popular themes
4. Click Install
5. Reload if prompted

### Popular Color Themes

- **One Dark Pro**: Atom's One Dark theme
- **Material Theme**: Material Design themes
- **Dracula Official**: Dracula color scheme
- **Monokai Pro**: Professional Monokai theme
- **GitHub Theme**: GitHub's color scheme
- **Nord**: Arctic color palette
- **Tokyo Night**: Clean dark theme

## Applying Themes

### Changing Color Theme

1. Command Palette: "Preferences: Color Theme"
2. `Ctrl+K Ctrl+T` / `Cmd+K Cmd+T`
3. File > Preferences > Color Theme
4. Browse and select theme

### Changing Icon Theme

1. Command Palette: "Preferences: File Icon Theme"
2. Select icon theme
3. Popular options: Material Icon Theme, VS Code Icons

### Changing Product Icon Theme

1. Command Palette: "Preferences: Product Icon Theme"
2. Select product icon theme
3. Changes VS Code's own icons

## Customizing Themes

### User Settings

Customize colors in settings.json:

```json
{
  "workbench.colorCustomizations": {
    "editor.background": "#1e1e1e",
    "editor.foreground": "#d4d4d4",
    "sideBar.background": "#252526",
    "statusBar.background": "#007acc"
  }
}
```

### Token Color Customization

Customize syntax highlighting:

```json
{
  "editor.tokenColorCustomizations": {
    "textMateRules": [
      {
        "scope": "comment",
        "settings": {
          "foreground": "#6A9955",
          "fontStyle": "italic"
        }
      },
      {
        "scope": "string",
        "settings": {
          "foreground": "#CE9178"
        }
      }
    ]
  }
}
```

### Semantic Token Customization

Customize semantic tokens:

```json
{
  "editor.semanticTokenColorCustomizations": {
    "rules": {
      "variable": "#9CDCFE",
      "function": "#DCDCAA",
      "class": "#4EC9B0"
    }
  }
}
```

## Font Customization

### Font Family

```json
{
  "editor.fontFamily": "'Fira Code', 'Consolas', 'Courier New', monospace",
  "terminal.integrated.fontFamily": "'Fira Code', monospace"
}
```

### Font Ligatures

Enable font ligatures for coding fonts:

```json
{
  "editor.fontLigatures": true
}
```

### Font Size

```json
{
  "editor.fontSize": 14,
  "terminal.integrated.fontSize": 14
}
```

### Line Height

```json
{
  "editor.lineHeight": 1.6,
  "editor.fontWeight": "400"
}
```

## UI Customization

### Activity Bar

```json
{
  "workbench.activityBar.visible": true,
  "workbench.activityBar.location": "side"
}
```

### Side Bar

```json
{
  "workbench.sideBar.location": "left",
  "workbench.sideBar.visible": true
}
```

### Status Bar

```json
{
  "workbench.statusBar.visible": true,
  "statusBar.background": "#007acc",
  "statusBar.foreground": "#ffffff"
}
```

### Editor

```json
{
  "editor.minimap.enabled": true,
  "editor.minimap.maxColumn": 120,
  "editor.rulers": [80, 120],
  "editor.renderWhitespace": "boundary",
  "editor.renderLineHighlight": "all"
}
```

## Creating Custom Themes

### Theme Extension

Create a theme extension:

1. Install Yeoman and VS Code generator:
```bash
npm install -g yo generator-code
```

2. Generate theme:
```bash
yo code
# Select "New Color Theme"
```

3. Customize colors in generated file

4. Test theme:
   - Press F5 to launch Extension Development Host
   - Test your theme

5. Package theme:
```bash
vsce package
```

### Theme File Structure

```json
{
  "name": "My Custom Theme",
  "type": "dark",
  "colors": {
    "editor.background": "#1e1e1e",
    "editor.foreground": "#d4d4d4"
  },
  "tokenColors": [
    {
      "scope": "comment",
      "settings": {
        "foreground": "#6A9955"
      }
    }
  ]
}
```

### Theme Types

- **dark**: Dark theme
- **light**: Light theme
- **hc**: High contrast theme

## Advanced Customization

### Workbench Colors

Customize workbench colors:

```json
{
  "workbench.colorCustomizations": {
    "[Default Dark+]": {
      "editor.background": "#1e1e1e",
      "sideBar.background": "#252526",
      "statusBar.background": "#007acc",
      "statusBar.foreground": "#ffffff",
      "activityBar.background": "#2d2d30",
      "titleBar.activeBackground": "#007acc",
      "titleBar.activeForeground": "#ffffff"
    }
  }
}
```

### Scope-Specific Colors

```json
{
  "editor.tokenColorCustomizations": {
    "[One Dark Pro]": {
      "textMateRules": [
        {
          "scope": [
            "keyword.control",
            "storage.type"
          ],
          "settings": {
            "foreground": "#C678DD",
            "fontStyle": "bold"
          }
        }
      ]
    }
  }
}
```

## Icon Themes

### Installing Icon Themes

1. Extensions: Search "icon theme"
2. Popular options:
   - Material Icon Theme
   - VS Code Icons
   - File Icons
   - Material Theme Icons

### Customizing Icons

Create custom icon theme:

1. Create icon theme extension
2. Define icon associations
3. Package and install

## Product Icon Themes

### Installing Product Icon Themes

1. Extensions: Search "product icon theme"
2. Select product icon theme
3. Apply theme

## Customization Best Practices

### Consistency

- Use consistent color schemes
- Match terminal colors
- Coordinate with OS theme
- Test in different lighting

### Performance

- Avoid too many customizations
- Use efficient themes
- Test performance impact
- Optimize settings

### Accessibility

- Ensure sufficient contrast
- Use readable fonts
- Test with different vision needs
- Follow WCAG guidelines

## Theme Settings Sync

### Syncing Themes

Themes sync automatically with Settings Sync:
1. Enable Settings Sync
2. Themes sync across devices
3. Customizations sync too

## Troubleshooting

### Theme Not Applying

1. Reload window: `Ctrl+R` / `Cmd+R`
2. Check theme name
3. Verify theme is installed
4. Check settings.json

### Colors Not Working

1. Check tokenColorCustomizations syntax
2. Verify scope names
3. Test with different themes
4. Check extension compatibility

## Popular Customization Combinations

### Dark Theme Setup

```json
{
  "workbench.colorTheme": "One Dark Pro",
  "workbench.iconTheme": "material-icon-theme",
  "editor.fontFamily": "'Fira Code'",
  "editor.fontLigatures": true,
  "editor.fontSize": 14
}
```

### Light Theme Setup

```json
{
  "workbench.colorTheme": "GitHub Light",
  "workbench.iconTheme": "vscode-icons",
  "editor.fontFamily": "'JetBrains Mono'",
  "editor.fontSize": 14
}
```

## Next Steps

- Learn about [Workspaces](./VSCODE-WORKSPACES.md)
- Optimize [Performance](./VSCODE-PERFORMANCE.md)
- Explore [Extensions](./VSCODE-EXTENSIONS.md)

Customizing your editor creates a comfortable and productive environment. Experiment with different themes and settings to find what works best for you.


