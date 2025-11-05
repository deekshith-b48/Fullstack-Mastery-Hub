# Atom Fundamentals

Atom is a free, open-source text editor developed by GitHub. Known as "A hackable text editor for the 21st Century," Atom provides extensive customization through packages and themes.

## What is Atom?

Atom is a modern text editor with:
- **Open Source**: Free and open-source
- **Hackable**: Highly customizable
- **Package Ecosystem**: Extensive package system
- **Cross-Platform**: Works on Windows, macOS, Linux
- **Modern UI**: Beautiful, modern interface

## Key Features

### Core Features

- **Built-in Package Manager**: apm (Atom Package Manager)
- **Multiple Panes**: Split view editing
- **Fuzzy Finder**: Fast file navigation
- **Find and Replace**: Powerful search and replace
- **Git Integration**: Built-in Git support
- **Teletype**: Real-time collaboration

### Customization

- **Packages**: Extend functionality
- **Themes**: Customize appearance
- **Key Bindings**: Customize shortcuts
- **Settings**: Extensive configuration

## Installation

### Windows

1. Download installer from atom.io
2. Run installer
3. Follow installation wizard
4. Launch Atom

### macOS

1. Download .dmg file
2. Drag to Applications
3. Or use Homebrew: `brew install --cask atom`
4. Launch from Applications

### Linux

```bash
# Ubuntu/Debian
sudo apt-get install atom

# Or download .deb package
wget https://atom.io/download/deb
sudo dpkg -i atom-amd64.deb
```

## First Launch

### Setup

1. Choose license (open-source, free)
2. Configure settings
3. Install packages
4. Customize appearance

### Interface Overview

- **Editor Area**: Main editing area
- **Tree View**: File browser sidebar
- **Status Bar**: Status information
- **Tab Bar**: Open files
- **Command Palette**: Command access

## Essential Workflows

### Opening Files

- **File Menu**: File > Open
- **Drag and Drop**: Drag files into editor
- **Fuzzy Finder**: `Ctrl+P` / `Cmd+P`
- **Command Palette**: `Ctrl+Shift+P` / `Cmd+Shift+P`

### Navigation

- **Fuzzy Finder**: `Ctrl+P` / `Cmd+P` - Open files
- **Command Palette**: `Ctrl+Shift+P` / `Cmd+Shift+P` - Commands
- **Symbol View**: `Ctrl+R` / `Cmd+R` - Browse symbols
- **Go to Line**: `Ctrl+G` / `Cmd+G` - Jump to line

### Editing

- **Multiple Cursors**: `Ctrl+Click` / `Cmd+Click`
- **Select Line**: `Ctrl+L` / `Cmd+L`
- **Duplicate Line**: `Ctrl+Shift+D` / `Cmd+Shift+D`
- **Delete Line**: `Ctrl+Shift+K` / `Cmd+Shift+K`

## Package Management

### Installing Packages

1. **File** → **Settings** → **Install**
2. Search for package
3. Click Install
4. Package installs

### Command Line

```bash
# Install package
apm install package-name

# Search packages
apm search keyword

# List installed
apm list --installed
```

### Popular Packages

- **atom-beautify**: Code formatter
- **linter**: Code linting
- **emmet**: HTML/CSS abbreviations
- **git-plus**: Git integration
- **file-icons**: File icons
- **minimap**: Code minimap

## Configuration

### Settings

Access settings:
- **File** → **Settings** or `Ctrl+,` / `Cmd+,`
- Configure editor behavior
- Customize appearance
- Manage packages

### Settings Categories

- **Editor**: Code editor settings
- **Core**: Core editor behavior
- **Editor**: Syntax highlighting
- **System**: System integration
- **Packages**: Package management

## Themes

### Installing Themes

1. **File** → **Settings** → **Themes**
2. Browse themes
3. Install theme
4. Apply theme

### Popular Themes

- **One Dark**: Default dark theme
- **One Light**: Default light theme
- **Material UI**: Material Design theme
- **Seti UI**: Seti theme
- **Nucleus Dark**: Dark theme

## Best Practices

### Setup

1. **Install Packages**: Add useful packages
2. **Configure Settings**: Customize to your needs
3. **Apply Theme**: Choose comfortable theme
4. **Customize Key Bindings**: Optimize shortcuts
5. **Organize**: Use projects for organization

### Workflow

1. **Learn Shortcuts**: Master keyboard shortcuts
2. **Use Packages**: Leverage package ecosystem
3. **Customize**: Tailor to your workflow
4. **Projects**: Use projects for organization

## Next Steps

- Explore [Packages](./ATOM-PACKAGES.md)
- Customize [Themes](./ATOM-THEMES.md)
- Learn [Hackability](./ATOM-HACKABILITY.md)
- Configure [Git Integration](./ATOM-GIT-INTEGRATION.md)

Atom is a powerful, customizable editor. Master its features to become more productive.





