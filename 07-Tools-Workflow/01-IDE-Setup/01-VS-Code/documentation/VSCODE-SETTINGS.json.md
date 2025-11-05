# VS Code Settings Configuration

VS Code settings allow you to customize every aspect of your editor experience. Understanding how to configure settings effectively is crucial for optimizing your development workflow.

## Settings Overview

VS Code has two types of settings:
- **User Settings**: Apply to all VS Code instances
- **Workspace Settings**: Apply only to the current workspace/folder

## Accessing Settings

### Methods to Open Settings

1. **UI Method**:
   - `Ctrl+,` (Windows/Linux) or `Cmd+,` (macOS)
   - File > Preferences > Settings
   - Command Palette: "Preferences: Open Settings"

2. **JSON Method**:
   - Command Palette: "Preferences: Open Settings (JSON)"
   - `Ctrl+Shift+P` → "Preferences: Open User Settings (JSON)"

## Settings File Locations

### User Settings
- **Windows**: `%APPDATA%\Code\User\settings.json`
- **macOS**: `~/Library/Application Support/Code/User/settings.json`
- **Linux**: `~/.config/Code/User/settings.json`

### Workspace Settings
- Stored in `.vscode/settings.json` in your project root

## Essential Settings

### Editor Settings

```json
{
  // Font settings
  "editor.fontFamily": "'Fira Code', 'Consolas', monospace",
  "editor.fontSize": 14,
  "editor.fontLigatures": true,
  "editor.lineHeight": 1.6,
  
  // Display settings
  "editor.minimap.enabled": true,
  "editor.minimap.maxColumn": 120,
  "editor.wordWrap": "on",
  "editor.rulers": [80, 120],
  "editor.renderWhitespace": "boundary",
  "editor.renderLineHighlight": "all",
  
  // Behavior settings
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": false,
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true,
    "source.organizeImports": true
  },
  
  // Cursor settings
  "editor.cursorBlinking": "smooth",
  "editor.cursorSmoothCaretAnimation": true,
  "editor.multiCursorModifier": "ctrlCmd",
  
  // Selection settings
  "editor.selectionHighlight": true,
  "editor.occurrencesHighlight": true,
  "editor.suggestSelection": "first"
}
```

### File Settings

```json
{
  // Auto-save
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,
  
  // Exclude files
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true,
    "**/.next": true,
    "**/dist": true
  },
  
  // Watcher settings
  "files.watcherExclude": {
    "**/.git/objects/**": true,
    "**/.git/subtree-cache/**": true,
    "**/node_modules/**": true
  },
  
  // Encoding
  "files.encoding": "utf8",
  "files.eol": "\n",
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true
}
```

### Terminal Settings

```json
{
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.fontFamily": "'Fira Code', monospace",
  "terminal.integrated.cursorBlinking": true,
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.defaultProfile.windows": "PowerShell",
  "terminal.integrated.defaultProfile.osx": "zsh",
  "terminal.integrated.defaultProfile.linux": "bash"
}
```

### Git Settings

```json
{
  "git.enableSmartCommit": true,
  "git.confirmSync": false,
  "git.autofetch": true,
  "git.enabled": true,
  "git.path": null,
  "git.ignoreLimitWarning": true
}
```

### Search Settings

```json
{
  "search.exclude": {
    "**/node_modules": true,
    "**/bower_components": true,
    "**/*.code-search": true,
    "**/dist": true,
    "**/build": true
  },
  "search.useIgnoreFiles": true,
  "search.smartCase": true
}
```

## Language-Specific Settings

### JavaScript/TypeScript

```json
{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.tabSize": 2
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.tabSize": 2
  },
  "javascript.updateImportsOnFileMove.enabled": "always",
  "typescript.updateImportsOnFileMove.enabled": "always",
  "typescript.preferences.importModuleSpecifier": "relative"
}
```

### Python

```json
{
  "[python]": {
    "editor.defaultFormatter": "ms-python.python",
    "editor.tabSize": 4,
    "editor.formatOnSave": true
  },
  "python.formatting.provider": "black",
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true
}
```

### JSON

```json
{
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "json.schemas": [
    {
      "fileMatch": ["package.json"],
      "schema": {
        "type": "object",
        "properties": {
          "name": { "type": "string" },
          "version": { "type": "string" }
        }
      }
    }
  ]
}
```

## Advanced Settings

### Performance Settings

```json
{
  "editor.suggest.maxVisibleSuggestions": 10,
  "editor.suggest.showKeywords": true,
  "editor.suggest.showSnippets": true,
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": true
  },
  "editor.quickSuggestionsDelay": 100,
  "files.maxMemoryForLargeFilesMB": 4096
}
```

### Accessibility Settings

```json
{
  "editor.accessibilitySupport": "auto",
  "editor.accessibilityPageSize": 10,
  "editor.smoothScrolling": true,
  "workbench.enableExperiments": false
}
```

### Extension Settings

```json
{
  "extensions.autoUpdate": true,
  "extensions.autoCheckUpdates": true,
  "extensions.ignoreRecommendations": false
}
```

## Workspace Settings

Workspace settings override user settings:

```json
{
  "editor.tabSize": 4,
  "files.exclude": {
    "**/node_modules": true,
    "**/dist": true
  },
  "typescript.tsdk": "node_modules/typescript/lib"
}
```

## Settings Sync

Sync settings across machines:

1. Sign in with GitHub/Microsoft account
2. Settings sync automatically enabled
3. Settings synced across devices

### Sync Settings

```json
{
  "settingsSync.ignoredSettings": [
    "editor.fontSize",
    "terminal.integrated.fontSize"
  ],
  "settingsSync.ignoredExtensions": []
}
```

## Environment Variables

Reference environment variables in settings:

```json
{
  "terminal.integrated.env.osx": {
    "PATH": "${env:PATH}:${workspaceFolder}/bin"
  },
  "terminal.integrated.env.linux": {
    "PATH": "${env:PATH}:${workspaceFolder}/bin"
  },
  "terminal.integrated.env.windows": {
    "PATH": "${env:PATH};${workspaceFolder}\\bin"
  }
}
```

## Settings Organization

### Group Related Settings

Use comments to organize:

```json
{
  // Editor Appearance
  "editor.fontSize": 14,
  "editor.fontFamily": "'Fira Code'",
  
  // Editor Behavior
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  
  // File Management
  "files.autoSave": "afterDelay",
  "files.exclude": {}
}
```

## Best Practices

1. **Start with Defaults**: Begin with default settings
2. **Incremental Changes**: Make changes gradually
3. **Workspace-Specific**: Use workspace settings for project-specific configs
4. **Document Changes**: Comment non-obvious settings
5. **Version Control**: Commit workspace settings to repository
6. **Sync Settings**: Use Settings Sync for consistency

## Troubleshooting Settings

### Settings Not Applying
1. Check JSON syntax
2. Reload window: `Ctrl+R` or `Cmd+R`
3. Check workspace settings override
4. Verify setting name is correct

### Performance Issues
1. Disable unused features
2. Reduce `editor.suggest.maxVisibleSuggestions`
3. Increase `files.maxMemoryForLargeFilesMB`
4. Check extension settings

### Conflicting Settings
1. Check workspace vs user settings
2. Review extension settings
3. Check language-specific settings
4. Use Settings UI to see active values

## Settings Schema

VS Code provides IntelliSense for settings:
- Hover over setting name for description
- Use `Ctrl+Space` for autocomplete
- Check settings.json validation errors

## Common Settings Patterns

### Full-Stack Development

```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true,
    "source.organizeImports": true
  },
  "files.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/.next": true
  },
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true
  }
}
```

### Multi-Language Projects

```json
{
  "[javascript]": { "editor.tabSize": 2 },
  "[typescript]": { "editor.tabSize": 2 },
  "[python]": { "editor.tabSize": 4 },
  "[java]": { "editor.tabSize": 4 },
  "[json]": { "editor.tabSize": 2 }
}
```

## Next Steps

- Learn [Keyboard Shortcuts](./VSCODE-KEYBOARD-SHORTCUTS.md)
- Configure [Workspaces](./VSCODE-WORKSPACES.md)
- Optimize [Performance](./VSCODE-PERFORMANCE.md)

Proper settings configuration can significantly improve your productivity and development experience.


