# VS Code Fundamentals

VS Code (Visual Studio Code) is a lightweight, powerful source code editor developed by Microsoft. It's one of the most popular code editors in the development community, offering a perfect balance between simplicity and functionality.

## What is VS Code?

VS Code is a free, open-source code editor that runs on Windows, macOS, and Linux. It's built on Electron and provides excellent support for multiple programming languages through extensions.

### Key Features

- **Cross-platform**: Works on Windows, macOS, and Linux
- **Lightweight**: Fast startup and minimal resource usage
- **Extensible**: Rich ecosystem of extensions
- **Integrated Terminal**: Built-in terminal support
- **IntelliSense**: Smart code completion and suggestions
- **Debugging**: Built-in debugging capabilities
- **Git Integration**: Version control support out of the box
- **Extensions Marketplace**: Thousands of community extensions

## Installation

### Windows
1. Download the installer from code.visualstudio.com
2. Run the installer and follow the prompts
3. Choose "Add to PATH" during installation
4. Launch VS Code from Start menu

### macOS
1. Download the .zip file from the website
2. Extract and drag to Applications folder
3. Or use Homebrew: `brew install --cask visual-studio-code`
4. Launch from Applications

### Linux
```bash
# Ubuntu/Debian
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
```

## First Launch

When you first launch VS Code, you'll see:

1. **Welcome Screen**: Quick start guide
2. **File Explorer**: Left sidebar for file navigation
3. **Editor Area**: Main area for code editing
4. **Status Bar**: Bottom bar with useful information
5. **Activity Bar**: Left side icons for different views

## Basic Interface

### Panels and Views

- **Explorer**: File and folder navigation
- **Search**: Find and replace across files
- **Source Control**: Git integration
- **Run and Debug**: Debugging tools
- **Extensions**: Browse and manage extensions

### Command Palette

Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS) to open the Command Palette. This is your gateway to all VS Code features.

### Workspace

VS Code operates in workspaces:
- **Single Folder**: Open a folder as workspace
- **Multi-root**: Multiple folders in one workspace
- **Workspace File**: Save workspace configuration

## Core Concepts

### Editor Groups

You can split the editor into multiple groups:
- `Ctrl+\` (Windows/Linux) or `Cmd+\` (macOS): Split editor
- Drag tabs to create new groups
- Use `Ctrl+1/2/3` to switch between groups

### Tabs

- Multiple files open in tabs
- Click to switch between files
- Middle-click to close tabs
- Right-click for context menu

### Views

Customize your sidebar:
- Show/hide views from View menu
- Drag views to reorder
- Resize panels by dragging borders

## Essential Workflows

### Opening Files

1. File Explorer: Click files in sidebar
2. Quick Open: `Ctrl+P` (Windows/Linux) or `Cmd+P` (macOS)
3. Command Palette: "File: Open File"
4. Drag and drop files into editor

### Saving Files

- `Ctrl+S`: Save current file
- `Ctrl+K S`: Save all files
- Auto-save: Enable in settings

### Finding Code

- `Ctrl+F`: Find in file
- `Ctrl+Shift+F`: Find across files
- `Ctrl+G`: Go to line
- `Ctrl+P`: Quick file open

## Configuration

### Settings

Access settings via:
- `Ctrl+,` (Windows/Linux) or `Cmd+,` (macOS)
- File > Preferences > Settings
- Command Palette: "Preferences: Open Settings"

### Settings Files

- **User Settings**: Apply to all workspaces
- **Workspace Settings**: Apply to current workspace only
- **Settings JSON**: Edit directly in JSON format

## Extensions

VS Code's power comes from extensions:

1. Click Extensions icon in Activity Bar
2. Search for extensions
3. Click Install
4. Reload if required

Popular extension categories:
- Language support
- Themes
- Productivity tools
- Linters and formatters
- Git tools

## Keyboard Shortcuts

Essential shortcuts:
- `Ctrl+Shift+P`: Command Palette
- `Ctrl+P`: Quick Open
- `Ctrl+`: Toggle terminal
- `Ctrl+B`: Toggle sidebar
- `Ctrl+Shift+E`: Focus Explorer
- `F11`: Toggle fullscreen

## Best Practices

1. **Install Essential Extensions**: Start with language support
2. **Configure Settings**: Customize to your workflow
3. **Learn Keyboard Shortcuts**: Increase productivity
4. **Use Workspaces**: Organize projects efficiently
5. **Sync Settings**: Use Settings Sync for consistency

## Getting Help

- **Documentation**: code.visualstudio.com/docs
- **Marketplace**: marketplace.visualstudio.com
- **GitHub**: github.com/microsoft/vscode
- **Stack Overflow**: Tag your questions with `vscode`

## Next Steps

After mastering fundamentals:
- Explore [VS Code Extensions](./VSCODE-EXTENSIONS.md)
- Configure [VS Code Settings](./VSCODE-SETTINGS.json.md)
- Learn [Keyboard Shortcuts](./VSCODE-KEYBOARD-SHORTCUTS.md)
- Set up [Debugging](./VSCODE-DEBUGGING.md)

VS Code is designed to grow with your needs. Start simple and gradually add extensions and customizations as you discover what works best for your workflow.


