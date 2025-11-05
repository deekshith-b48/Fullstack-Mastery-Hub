# Sublime Text Key Bindings

Sublime Text key bindings allow you to customize keyboard shortcuts. This guide covers default shortcuts, customizing bindings, and productivity tips.

## Key Binding Overview

Key bindings in Sublime Text:
- **Customizable**: Fully customizable shortcuts
- **Context-Specific**: Different bindings per context
- **Platform-Specific**: Different bindings per platform
- **Command-Based**: Bind commands to keys

## Default Shortcuts

### Navigation

- `Ctrl+P` / `Cmd+P`: Goto Anything
- `Ctrl+R` / `Cmd+R`: Goto Symbol
- `Ctrl+G` / `Cmd+G`: Goto Line
- `Ctrl+;` / `Cmd+;`: Goto Word
- `Ctrl+Shift+P` / `Cmd+Shift+P`: Command Palette

### Editing

- `Ctrl+D` / `Cmd+D`: Select Word
- `Ctrl+L` / `Cmd+L`: Select Line
- `Ctrl+Shift+D` / `Cmd+Shift+D`: Duplicate Line
- `Ctrl+Shift+K` / `Cmd+Shift+K`: Delete Line
- `Ctrl+Enter` / `Cmd+Enter`: Insert Line After
- `Ctrl+Shift+Enter` / `Cmd+Shift+Enter`: Insert Line Before

### Multiple Cursors

- `Ctrl+Click` / `Cmd+Click`: Add Cursor
- `Ctrl+Alt+↑/↓` / `Cmd+Option+↑/↓`: Add Cursor Above/Below
- `Ctrl+D` / `Cmd+D`: Select Next Occurrence
- `Ctrl+K Ctrl+D` / `Cmd+K Cmd+D`: Skip Selection

### Find and Replace

- `Ctrl+F` / `Cmd+F`: Find
- `Ctrl+H` / `Cmd+H`: Replace
- `Ctrl+Shift+F` / `Cmd+Shift+F`: Find in Files
- `Ctrl+I` / `Cmd+I`: Incremental Find

### View

- `Ctrl+K Ctrl+B` / `Cmd+K Cmd+B`: Toggle Sidebar
- `Alt+Shift+1` / `Option+Shift+1`: Single Column
- `Alt+Shift+2` / `Option+Shift+2`: Two Columns
- `Alt+Shift+3` / `Option+Shift+3`: Three Columns

## Customizing Key Bindings

### Accessing Key Bindings

1. **Preferences** → **Key Bindings**
2. Edit JSON file
3. Add custom bindings
4. Save file

### Key Binding Format

```json
[
  {
    "keys": ["ctrl+shift+t"],
    "command": "reopen_last_file"
  },
  {
    "keys": ["ctrl+alt+n"],
    "command": "new_file"
  }
]
```

### Key Modifiers

- `ctrl` / `cmd`: Control/Command
- `alt` / `option`: Alt/Option
- `shift`: Shift
- `super`: Windows/Command key

### Key Sequences

```json
[
  {
    "keys": ["ctrl+k", "ctrl+s"],
    "command": "save_all"
  }
]
```

## Context-Specific Bindings

### Context Conditions

```json
[
  {
    "keys": ["ctrl+b"],
    "command": "build",
    "context": [
      {
        "key": "selector",
        "operator": "equal",
        "operand": "source.js"
      }
    ]
  }
]
```

### Common Contexts

- `source.js`: JavaScript files
- `source.python`: Python files
- `text.html`: HTML files
- `source.css`: CSS files
- `text.plain`: Plain text

## Useful Custom Bindings

### File Operations

```json
[
  {
    "keys": ["ctrl+shift+n"],
    "command": "new_window"
  },
  {
    "keys": ["ctrl+shift+w"],
    "command": "close_window"
  }
]
```

### Editing

```json
[
  {
    "keys": ["ctrl+shift+up"],
    "command": "swap_line_up"
  },
  {
    "keys": ["ctrl+shift+down"],
    "command": "swap_line_down"
  }
]
```

## Best Practices

### Key Binding Design

1. **Consistency**: Use consistent patterns
2. **Avoid Conflicts**: Check for conflicts
3. **Memorable**: Use memorable shortcuts
4. **Documentation**: Document custom bindings

### Organization

1. **Group Related**: Group related bindings
2. **Comments**: Add comments in JSON
3. **Backup**: Backup key bindings
4. **Version Control**: Track in Git

## Troubleshooting

### Binding Conflicts

- Check existing bindings
- Resolve conflicts
- Use different keys
- Check context conditions

### Bindings Not Working

- Check JSON syntax
- Verify command names
- Check context conditions
- Restart Sublime Text

## Next Steps

- Explore [Projects](./SUBLIME-PROJECTS.md)
- Optimize [Performance](./SUBLIME-PERFORMANCE.md)
- Learn [Best Practices](./SUBLIME-BEST-PRACTICES.md)

Custom key bindings improve productivity. Tailor shortcuts to your workflow.





