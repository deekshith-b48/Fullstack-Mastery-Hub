# Sublime Text Themes

Themes control the appearance of Sublime Text, including colors, syntax highlighting, and UI elements. This guide covers theme installation, customization, and best practices.

## Theme Overview

Sublime Text themes include:
- **Color Schemes**: Syntax highlighting colors
- **UI Themes**: Overall interface appearance
- **Icon Themes**: File and folder icons
- **Customization**: Extensive customization options

## Installing Themes

### Via Package Control

1. `Ctrl+Shift+P` / `Cmd+Shift+P`
2. "Package Control: Install Package"
3. Search theme name
4. Install theme
5. Apply theme: Preferences > Color Scheme

### Popular Themes

- **Material Theme**: Material Design theme
- **Monokai Pro**: Professional Monokai
- **Dracula**: Dracula color scheme
- **One Dark**: Atom's One Dark theme
- **Spacegray**: Minimal dark theme
- **Solarized**: Eye-friendly color palette

## Applying Themes

### Color Scheme

1. **Preferences** → **Color Scheme**
2. Select color scheme
3. Theme applies immediately

### UI Theme

1. **Preferences** → **Theme**
2. Select UI theme
3. Restart if required

## Color Scheme Formats

### .tmTheme Format

Sublime Text uses TextMate theme format:
- XML-based format
- Defines syntax colors
- Customizable color values

### Customizing Colors

Edit color scheme file:
1. **Preferences** → **Browse Packages**
2. Navigate to theme folder
3. Edit `.tmTheme` file
4. Modify color values

## Creating Custom Themes

### Theme Structure

1. Create theme folder in Packages
2. Create `.tmTheme` file
3. Define color scheme
4. Apply theme

### Color Scheme Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
<dict>
  <key>name</key>
  <string>My Theme</string>
  <key>settings</key>
  <array>
    <dict>
      <key>scope</key>
      <string>comment</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>#6A9955</string>
      </dict>
    </dict>
  </array>
</dict>
</plist>
```

## UI Themes

### Material Theme

Comprehensive Material Design theme:
- Multiple color schemes
- Customizable UI
- Sidebar enhancements
- Tab styling

### Installation

1. Install via Package Control
2. **Preferences** → **Theme**
3. Select Material Theme
4. Configure settings

## Best Practices

### Theme Selection

1. **Eye Comfort**: Choose comfortable colors
2. **Contrast**: Ensure good contrast
3. **Consistency**: Use consistent themes
4. **Productivity**: Themes that improve productivity

### Customization

1. **Start with Base**: Modify existing theme
2. **Test Changes**: Test color changes
3. **Backup Original**: Keep original theme
4. **Share Themes**: Share with team

## Next Steps

- Learn [Snippets](./SUBLIME-SNIPPETS.md)
- Configure [Key Bindings](./SUBLIME-KEY-BINDINGS.md)
- Explore [Projects](./SUBLIME-PROJECTS.md)

Themes enhance your Sublime Text experience. Choose and customize themes to create a comfortable editing environment.





