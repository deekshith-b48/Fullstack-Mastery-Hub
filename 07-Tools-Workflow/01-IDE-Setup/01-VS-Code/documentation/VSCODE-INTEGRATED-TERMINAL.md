# VS Code Integrated Terminal

VS Code includes a fully-featured integrated terminal that eliminates the need to switch between editor and terminal. This guide covers everything you need to know about using the terminal effectively.

## Terminal Overview

The integrated terminal provides:
- Multiple terminal instances
- Different shell support (PowerShell, bash, zsh, etc.)
- Terminal splitting
- Customizable appearance
- Task integration
- Terminal profiles

## Opening Terminal

### Methods to Open

1. **Keyboard Shortcut**: `Ctrl+` / `Cmd+`
2. **Command Palette**: "Terminal: Create New Terminal"
3. **Menu**: Terminal > New Terminal
4. **Shortcut**: `Ctrl+Shift+` / `Cmd+Shift+` for new terminal

## Terminal Management

### Creating Multiple Terminals

- `Ctrl+Shift+` / `Cmd+Shift+`: Create new terminal
- Click `+` icon in terminal panel
- Right-click terminal tab → "New Terminal"

### Switching Between Terminals

- `Ctrl+PageUp/PageDown` / `Cmd+PageUp/PageDown`: Next/Previous
- `Ctrl+Alt+←/→`: Navigate terminals
- Click terminal tabs

### Terminal Splitting

- `Ctrl+Shift+5` / `Cmd+Shift+5`: Split terminal
- Right-click terminal → "Split Terminal"
- Drag terminal to split

### Closing Terminals

- `Ctrl+Shift+W` / `Cmd+Shift+W`: Close terminal
- Click trash icon
- Right-click → "Kill Terminal"

## Terminal Configuration

### Default Shell

Windows:
```json
{
  "terminal.integrated.defaultProfile.windows": "PowerShell"
}
```

macOS:
```json
{
  "terminal.integrated.defaultProfile.osx": "zsh"
}
```

Linux:
```json
{
  "terminal.integrated.defaultProfile.linux": "bash"
}
```

### Terminal Profiles

Customize terminal profiles:

```json
{
  "terminal.integrated.profiles.windows": {
    "PowerShell": {
      "source": "PowerShell",
      "icon": "terminal-powershell"
    },
    "Command Prompt": {
      "path": "C:\\Windows\\System32\\cmd.exe",
      "icon": "terminal-cmd"
    },
    "Git Bash": {
      "source": "Git Bash",
      "icon": "terminal-bash"
    }
  }
}
```

### Shell Arguments

```json
{
  "terminal.integrated.shellArgs.windows": ["-NoExit", "-Command"],
  "terminal.integrated.shellArgs.osx": ["-l"],
  "terminal.integrated.shellArgs.linux": ["-l"]
}
```

## Terminal Appearance

### Font Settings

```json
{
  "terminal.integrated.fontFamily": "'Fira Code', 'Consolas', monospace",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.fontWeight": "normal",
  "terminal.integrated.lineHeight": 1.2
}
```

### Cursor Settings

```json
{
  "terminal.integrated.cursorBlinking": true,
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.cursorWidth": 1
}
```

### Colors and Themes

```json
{
  "terminal.integrated.foreground": "#CCCCCC",
  "terminal.integrated.background": "#1E1E1E",
  "terminal.integrated.cursorForeground": "#000000",
  "terminal.integrated.cursorBackground": "#FFFFFF"
}
```

## Terminal Features

### Terminal Tabs

- Multiple tabs for different terminals
- Rename tabs: Right-click → "Rename"
- Color-code tabs: Right-click → "Change Color"
- Reorder tabs by dragging

### Terminal Panels

- Split terminals into panels
- Resize panels by dragging borders
- Close panels with `Ctrl+Shift+W`

### Terminal Selection

- Click and drag to select text
- Double-click to select word
- Triple-click to select line
- `Ctrl+C` / `Cmd+C`: Copy selection
- Right-click to copy/paste

### Terminal Scrolling

- Mouse wheel: Scroll terminal
- Scroll bar: Navigate history
- `Ctrl+↑/↓`: Scroll line by line
- `Ctrl+PageUp/PageDown`: Scroll page by page

## Terminal Commands

### Built-in Commands

- `Ctrl+Shift+` / `Cmd+Shift+`: Create new terminal
- `Ctrl+Shift+5` / `Cmd+Shift+5`: Split terminal
- `Ctrl+PageUp/PageDown`: Navigate terminals
- `Ctrl+Shift+W` / `Cmd+Shift+W`: Close terminal
- `Ctrl+K` / `Cmd+K`: Clear terminal

### Terminal Navigation

- `Ctrl+↑`: Scroll up
- `Ctrl+↓`: Scroll down
- `Ctrl+Home`: Scroll to top
- `Ctrl+End`: Scroll to bottom

## Environment Variables

### Terminal Environment

```json
{
  "terminal.integrated.env.windows": {
    "PATH": "${env:PATH};${workspaceFolder}/bin"
  },
  "terminal.integrated.env.osx": {
    "PATH": "${env:PATH}:${workspaceFolder}/bin"
  },
  "terminal.integrated.env.linux": {
    "PATH": "${env:PATH}:${workspaceFolder}/bin"
  }
}
```

### Workspace Environment

```json
{
  "terminal.integrated.env.windows": {
    "NODE_ENV": "development",
    "API_URL": "http://localhost:3000"
  }
}
```

## Terminal Tasks

### Running Tasks

Tasks can output to terminal:
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "build",
      "type": "shell",
      "command": "npm run build",
      "problemMatcher": []
    }
  ]
}
```

### Task Terminal

- Tasks run in terminal
- Terminal shows task output
- Terminal closes after task completion (optional)

## Terminal Integration

### Git Integration

Terminal automatically detects Git:
- Shows Git status in prompt (if configured)
- Git commands work normally
- Integrated with Source Control panel

### NPM/Yarn Integration

- Run npm/yarn commands directly
- See output in terminal
- Integrated with package.json scripts

### Debug Integration

- Debug output appears in terminal
- Terminal shows debug logs
- Can run commands during debugging

## Terminal Customization

### Custom Shell Commands

```json
{
  "terminal.integrated.shellArgs.windows": [
    "-NoExit",
    "-Command",
    "cd ${workspaceFolder}; Write-Host 'Welcome to VS Code' -ForegroundColor Green"
  ]
}
```

### Terminal Icons

Customize terminal icons:
```json
{
  "terminal.integrated.tabs.enabled": true,
  "terminal.integrated.tabs.showActiveTerminal": "always"
}
```

## Advanced Features

### Terminal Links

Terminal detects:
- File paths: Click to open
- URLs: Click to open in browser
- Line numbers: Navigate to code

### Terminal Selection

- `Ctrl+Shift+C` / `Cmd+Shift+C`: Copy selection
- `Ctrl+Shift+V` / `Cmd+Shift+V`: Paste
- Right-click: Context menu

### Terminal Find

- `Ctrl+F` / `Cmd+F`: Find in terminal
- Search terminal output
- Navigate search results

## Terminal Profiles

### Creating Custom Profiles

```json
{
  "terminal.integrated.profiles.windows": {
    "Custom PowerShell": {
      "path": "powershell.exe",
      "args": ["-NoExit", "-Command"],
      "icon": "terminal-powershell",
      "color": "terminal.ansiBlue"
    }
  }
}
```

### Profile Selection

- Dropdown in terminal panel
- Select default profile
- Switch profiles per terminal

## Terminal Troubleshooting

### Terminal Not Opening

1. Check shell path is correct
2. Verify shell exists
3. Check terminal settings
4. Try different shell

### Terminal Slow

1. Reduce terminal history
2. Disable unnecessary features
3. Check system resources
4. Update VS Code

### Terminal Not Executing Commands

1. Check shell path
2. Verify permissions
3. Check environment variables
4. Try different terminal

## Best Practices

1. **Use Multiple Terminals**: Separate terminals for different tasks
2. **Name Terminals**: Rename terminals for clarity
3. **Use Terminal Profiles**: Customize for different workflows
4. **Organize Terminals**: Use split terminals effectively
5. **Clear Terminal**: Regular cleanup with `Ctrl+K`
6. **Terminal History**: Adjust history size as needed

## Terminal Shortcuts Summary

```
Terminal Management:
  Ctrl+`          Toggle terminal
  Ctrl+Shift+`    New terminal
  Ctrl+Shift+5    Split terminal
  Ctrl+PageUp/Dn  Navigate terminals
  Ctrl+Shift+W    Close terminal
  
Terminal Navigation:
  Ctrl+↑/↓       Scroll line by line
  Ctrl+Home/End  Scroll to top/bottom
  
Terminal Actions:
  Ctrl+K          Clear terminal
  Ctrl+Shift+C    Copy selection
  Ctrl+Shift+V    Paste
```

## Next Steps

- Learn about [Snippets](./VSCODE-SNIPPETS.md)
- Explore [Workspaces](./VSCODE-WORKSPACES.md)
- Optimize [Performance](./VSCODE-PERFORMANCE.md)

The integrated terminal is a powerful tool that streamlines your development workflow. Master these features to work more efficiently.


