# VS Code Keyboard Shortcuts

Mastering keyboard shortcuts is one of the fastest ways to increase your productivity in VS Code. This guide covers essential shortcuts and how to customize them.

## Essential Shortcuts

### Navigation

- `Ctrl+P` / `Cmd+P`: Quick Open - Open files quickly
- `Ctrl+Shift+P` / `Cmd+Shift+P`: Command Palette - Access all commands
- `Ctrl+Tab` / `Ctrl+Shift+Tab`: Switch between editor groups
- `Ctrl+1/2/3`: Focus editor groups
- `Ctrl+B` / `Cmd+B`: Toggle sidebar
- `Ctrl+Shift+E`: Focus Explorer
- `Ctrl+Shift+F`: Focus Search
- `Ctrl+Shift+G`: Focus Source Control
- `Ctrl+Shift+D`: Focus Run and Debug
- `Ctrl+Shift+X`: Focus Extensions

### Editing

- `Ctrl+X` / `Cmd+X`: Cut line (no selection)
- `Ctrl+C` / `Cmd+C`: Copy line (no selection)
- `Alt+↑/↓`: Move line up/down
- `Shift+Alt+↑/↓`: Copy line up/down
- `Ctrl+Shift+K` / `Cmd+Shift+K`: Delete line
- `Ctrl+Enter` / `Cmd+Enter`: Insert line below
- `Ctrl+Shift+Enter` / `Cmd+Shift+Enter`: Insert line above
- `Ctrl+]` / `Cmd+]`: Indent line
- `Ctrl+[` / `Cmd+[`: Outdent line
- `Ctrl+/` / `Cmd+/`: Toggle line comment
- `Shift+Alt+A` / `Shift+Option+A`: Toggle block comment

### Selection

- `Ctrl+L` / `Cmd+L`: Select current line
- `Ctrl+Shift+L` / `Cmd+Shift+L`: Select all occurrences
- `Ctrl+D` / `Cmd+D`: Add selection to next Find match
- `Ctrl+K Ctrl+D` / `Cmd+K Cmd+D`: Move last selection to next Find match
- `Alt+Click`: Insert cursor
- `Ctrl+Alt+↑/↓` / `Cmd+Option+↑/↓`: Insert cursor above/below
- `Ctrl+U` / `Cmd+U`: Undo last cursor operation

### Search and Replace

- `Ctrl+F` / `Cmd+F`: Find
- `Ctrl+H` / `Cmd+H`: Replace
- `Ctrl+Shift+F` / `Cmd+Shift+F`: Find in files
- `Ctrl+Shift+H` / `Cmd+Shift+H`: Replace in files
- `F3` / `Shift+F3`: Find next/previous
- `Alt+Enter`: Select all occurrences

### File Management

- `Ctrl+N` / `Cmd+N`: New file
- `Ctrl+O` / `Cmd+O`: Open file
- `Ctrl+S` / `Cmd+S`: Save
- `Ctrl+K S` / `Cmd+K S`: Save all
- `Ctrl+Shift+S` / `Cmd+Shift+S`: Save as
- `Ctrl+K Ctrl+W` / `Cmd+K Cmd+W`: Close all
- `Ctrl+W` / `Cmd+W`: Close editor
- `Ctrl+K Ctrl+Shift+W` / `Cmd+K Cmd+Shift+W`: Close all editors

### Terminal

- `Ctrl+` / `Cmd+`: Toggle terminal
- `Ctrl+Shift+` / `Cmd+Shift+`: Create new terminal
- `Ctrl+Shift+[` / `Cmd+Shift+[`: Focus previous terminal
- `Ctrl+Shift+]` / `Cmd+Shift+]`: Focus next terminal

### Git

- `Ctrl+Shift+G` / `Cmd+Shift+G`: Open Source Control
- `Ctrl+Enter` / `Cmd+Enter`: Commit (in Source Control view)
- `Ctrl+Shift+P` → "Git: Stage All": Stage all changes
- `Ctrl+Shift+P` → "Git: Unstage All": Unstage all changes

### Debugging

- `F5`: Start debugging / Continue
- `F9`: Toggle breakpoint
- `F10`: Step over
- `F11`: Step into
- `Shift+F11`: Step out
- `Shift+F5`: Stop debugging
- `Ctrl+Shift+F5` / `Cmd+Shift+F5`: Restart debugging

### Code Navigation

- `F12`: Go to definition
- `Alt+F12`: Peek definition
- `Shift+F12`: Find all references
- `Ctrl+T` / `Cmd+T`: Go to symbol in workspace
- `Ctrl+Shift+O` / `Cmd+Shift+O`: Go to symbol in file
- `Ctrl+G` / `Cmd+G`: Go to line
- `Ctrl+Shift+\` / `Cmd+Shift+\`: Jump to matching bracket

### IntelliSense

- `Ctrl+Space` / `Cmd+Space`: Trigger suggestion
- `Ctrl+Shift+Space` / `Cmd+Shift+Space`: Trigger parameter hints
- `Tab`: Accept suggestion
- `Esc`: Dismiss suggestion
- `Ctrl+.` / `Cmd+.`: Quick fix

### Editor Management

- `Ctrl+\` / `Cmd+\`: Split editor
- `Ctrl+1/2/3` / `Cmd+1/2/3`: Focus editor group
- `Ctrl+K Ctrl+←/→` / `Cmd+K Cmd+←/→`: Focus editor group
- `Ctrl+PageUp/PageDown` / `Cmd+PageUp/PageDown`: Switch editor
- `Ctrl+K Ctrl+Shift+←/→` / `Cmd+K Cmd+Shift+←/→`: Move editor

### View

- `Ctrl+=` / `Cmd+=`: Zoom in
- `Ctrl+-` / `Cmd+-`: Zoom out
- `Ctrl+0` / `Cmd+0`: Reset zoom
- `F11`: Toggle fullscreen
- `Ctrl+K Z` / `Cmd+K Z`: Zen mode

## Customizing Shortcuts

### Opening Keyboard Shortcuts Editor

1. `Ctrl+K Ctrl+S` / `Cmd+K Cmd+S`
2. File > Preferences > Keyboard Shortcuts
3. Command Palette: "Preferences: Open Keyboard Shortcuts"

### Editing Shortcuts

1. Find command in list
2. Double-click or press Enter
3. Press desired key combination
4. Press Enter to save

### Keybinding Format

Shortcuts are stored in `keybindings.json`:

```json
[
  {
    "key": "ctrl+shift+e",
    "command": "workbench.action.files.openFolder"
  },
  {
    "key": "ctrl+k ctrl+s",
    "command": "workbench.action.openGlobalKeybindings"
  }
]
```

### Keybinding Modifiers

- `ctrl` / `cmd`: Control (Windows/Linux) or Command (macOS)
- `shift`: Shift key
- `alt` / `option`: Alt (Windows/Linux) or Option (macOS)
- `meta`: Meta key

### Keybinding Operators

- `+`: Key combination (e.g., `ctrl+k`)
- ` `: Space for chording (e.g., `ctrl+k ctrl+s`)

## Common Customizations

### Multi-Cursor Shortcuts

```json
{
  "key": "ctrl+alt+up",
  "command": "editor.action.insertCursorAbove",
  "when": "editorTextFocus"
},
{
  "key": "ctrl+alt+down",
  "command": "editor.action.insertCursorBelow",
  "when": "editorTextFocus"
}
```

### Custom Command Shortcuts

```json
{
  "key": "ctrl+shift+t",
  "command": "workbench.action.terminal.new"
},
{
  "key": "ctrl+shift+p",
  "command": "workbench.action.showCommands"
}
```

## Context Keys

Shortcuts can be context-sensitive:

- `editorTextFocus`: When editor has focus
- `editorHasSelection`: When text is selected
- `inDebugMode`: When debugging
- `terminalFocus`: When terminal has focus

## Platform-Specific Shortcuts

### Windows/Linux Defaults

- `Ctrl` for most commands
- `Alt` for alternative actions
- `Shift` for reverse actions

### macOS Defaults

- `Cmd` for most commands
- `Option` for alternative actions
- `Shift` for reverse actions

## Shortcut Conflicts

### Resolving Conflicts

1. Open Keyboard Shortcuts
2. Search for conflicting key
3. Right-click → "Change Keybinding"
4. Choose new key combination

### Extension Conflicts

Some extensions may override shortcuts:
- Check extension settings
- Modify extension shortcuts
- Disable conflicting shortcuts

## Productivity Tips

### Learn Gradually

1. Start with essential shortcuts
2. Add more as you need them
3. Practice regularly
4. Use cheat sheet initially

### Muscle Memory

- Use shortcuts consistently
- Avoid mouse when possible
- Practice with common tasks
- Customize for your workflow

### Shortcut Patterns

- `Ctrl+K` followed by key: Command chord
- `Ctrl+Shift+`: Alternative action
- `Alt+`: Secondary action

## Useful Shortcut Combinations

### File Navigation

- `Ctrl+P` → Type filename
- `Ctrl+P` → `@` → Go to symbol
- `Ctrl+P` → `#` → Search in files
- `Ctrl+P` → `:` → Go to line

### Code Editing

- `Ctrl+K Ctrl+S`: Save all
- `Ctrl+K Ctrl+X`: Trim trailing whitespace
- `Ctrl+K Ctrl+C`: Add line comment
- `Ctrl+K Ctrl+U`: Remove line comment

### Editor Management

- `Ctrl+K Ctrl+W`: Close all editors
- `Ctrl+K Ctrl+Shift+W`: Close all editor groups
- `Ctrl+K Ctrl+←/→`: Move editor group

## Cheat Sheet

### Most Used Shortcuts

```
Navigation:
  Ctrl+P          Quick Open
  Ctrl+Shift+P    Command Palette
  Ctrl+B          Toggle Sidebar
  
Editing:
  Ctrl+X          Cut Line
  Ctrl+D          Add Selection
  Alt+↑/↓         Move Line
  
Search:
  Ctrl+F          Find
  Ctrl+H          Replace
  Ctrl+Shift+F    Find in Files
  
Terminal:
  Ctrl+`          Toggle Terminal
  Ctrl+Shift+`    New Terminal
```

## Next Steps

- Explore [VS Code Settings](./VSCODE-SETTINGS.json.md)
- Learn about [Debugging](./VSCODE-DEBUGGING.md)
- Optimize [Performance](./VSCODE-PERFORMANCE.md)

Mastering keyboard shortcuts transforms VS Code from a good editor into a powerful development tool.


