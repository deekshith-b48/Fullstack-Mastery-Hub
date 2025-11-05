# Sublime Text Fundamentals

Sublime Text is a sophisticated text editor for code, markup, and prose. Known for its speed and powerful features, it's a popular choice among developers.

## What is Sublime Text?

Sublime Text is a cross-platform text editor with:
- **Speed**: Extremely fast performance
- **Powerful Features**: Advanced editing capabilities
- **Customization**: Highly customizable
- **Package Ecosystem**: Extensive package system
- **Multiple Selections**: Advanced multi-cursor editing

## Key Features

### Performance

- **Fast Startup**: Near-instant startup
- **Low Memory**: Minimal resource usage
- **Smooth Scrolling**: Smooth text rendering
- **Large Files**: Handle large files efficiently

### Editing Features

- **Multiple Cursors**: Edit multiple locations
- **Command Palette**: Quick command access
- **Goto Anything**: Fast file/symbol navigation
- **Split Editing**: Split view editing

### Customization

- **Themes**: Extensive theme support
- **Key Bindings**: Customize shortcuts
- **Settings**: Comprehensive settings
- **Packages**: Extend functionality

## Installation

### Windows

1. Download from sublimetext.com
2. Run installer
3. Follow installation wizard
4. Launch Sublime Text

### macOS

1. Download .dmg file
2. Drag to Applications
3. Or use Homebrew: `brew install --cask sublime-text`
4. Launch from Applications

### Linux

```bash
# Ubuntu/Debian
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
```

## First Launch

### Setup

1. Choose license (evaluate or purchase)
2. Configure settings
3. Install Package Control
4. Install packages

### Interface Overview

- **Editor Area**: Main editing area
- **Sidebar**: File browser
- **Status Bar**: Status information
- **Minimap**: Code overview
- **Tab Bar**: Open files

## Essential Workflows

### Opening Files

- **File Menu**: File > Open
- **Drag and Drop**: Drag files into editor
- **Command Palette**: `Ctrl+P` / `Cmd+P`
- **Goto Anything**: `Ctrl+P` / `Cmd+P`

### Navigation

- **Goto Anything**: `Ctrl+P` / `Cmd+P`
- **Goto Symbol**: `Ctrl+R` / `Cmd+R`
- **Goto Line**: `Ctrl+G` / `Cmd+G`
- **Command Palette**: `Ctrl+Shift+P` / `Cmd+Shift+P`

### Editing

- **Multiple Cursors**: `Ctrl+Click` / `Cmd+Click`
- **Column Selection**: `Alt+Shift+Arrow` / `Option+Shift+Arrow`
- **Duplicate Line**: `Ctrl+Shift+D` / `Cmd+Shift+D`
- **Delete Line**: `Ctrl+Shift+K` / `Cmd+Shift+K`

## Package Control

### Installing Package Control

1. Open Command Palette: `Ctrl+Shift+P` / `Cmd+Shift+P`
2. Type "Install Package Control"
3. Press Enter
4. Restart Sublime Text

### Installing Packages

1. `Ctrl+Shift+P` / `Cmd+Shift+P`
2. "Package Control: Install Package"
3. Search for package
4. Install

### Popular Packages

- **Emmet**: HTML/CSS abbreviations
- **SublimeLinter**: Code linting
- **GitGutter**: Git integration
- **SideBarEnhancements**: Enhanced sidebar
- **AutoFileName**: File path completion

## Configuration

### Settings

Access settings:
- `Ctrl+,` / `Cmd+,`
- Preferences > Settings
- Edit JSON directly

### User Settings

Edit `Preferences.sublime-settings`:

```json
{
  "font_size": 14,
  "font_face": "Fira Code",
  "word_wrap": "auto",
  "line_numbers": true,
  "rulers": [80, 120],
  "tab_size": 2,
  "translate_tabs_to_spaces": true
}
```

## Key Bindings

### Customizing Shortcuts

1. Preferences > Key Bindings
2. Edit key bindings JSON
3. Add custom bindings

### Example Key Bindings

```json
[
  {
    "keys": ["ctrl+shift+t"],
    "command": "reopen_last_file"
  }
]
```

## Themes

### Installing Themes

1. Package Control: Install Package
2. Search for theme
3. Install theme
4. Apply theme: Preferences > Color Scheme

### Popular Themes

- **Material Theme**: Material Design theme
- **Monokai Pro**: Professional Monokai
- **Dracula**: Dracula color scheme
- **One Dark**: Atom's One Dark theme

## Best Practices

### Setup

1. **Install Package Control**: Essential for packages
2. **Configure Settings**: Customize to your needs
3. **Install Packages**: Add useful packages
4. **Customize Key Bindings**: Optimize shortcuts
5. **Apply Theme**: Choose comfortable theme

### Workflow

1. **Learn Shortcuts**: Master keyboard shortcuts
2. **Use Packages**: Leverage package ecosystem
3. **Customize**: Tailor to your workflow
4. **Projects**: Use projects for organization

## Next Steps

- Learn about [Package Control](./SUBLIME-PACKAGE-CONTROL.md)
- Explore [Themes](./SUBLIME-THEMES.md)
- Master [Snippets](./SUBLIME-SNIPPETS.md)
- Configure [Key Bindings](./SUBLIME-KEY-BINDINGS.md)

Sublime Text is a powerful, fast editor. Master its features to become more productive.


