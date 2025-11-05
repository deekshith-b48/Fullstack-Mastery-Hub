# VS Code Workspaces

Workspaces allow you to organize and manage multiple folders and their settings in VS Code. This guide covers workspace configuration, multi-root workspaces, and best practices.

## Workspace Overview

A workspace in VS Code is:
- A collection of one or more folders
- Settings specific to that workspace
- Tasks and launch configurations
- Extension recommendations
- Source control configuration

## Workspace Types

### Single Folder Workspace

- Open a folder: File > Open Folder
- VS Code remembers folder settings
- Simplest workspace type

### Multi-Root Workspace

- Multiple folders in one workspace
- Useful for monorepos
- Shared settings across folders

### Workspace File

- Saved workspace configuration
- `.code-workspace` file
- Portable workspace setup

## Creating Workspaces

### Single Folder

1. File > Open Folder
2. Select folder
3. VS Code opens as workspace

### Multi-Root Workspace

1. File > Add Folder to Workspace
2. Add multiple folders
3. Save workspace: File > Save Workspace As

### Workspace File

Workspace files are JSON:

```json
{
  "folders": [
    {
      "path": "frontend"
    },
    {
      "path": "backend"
    },
    {
      "path": "shared"
    }
  ],
  "settings": {
    "editor.tabSize": 2,
    "files.exclude": {
      "**/node_modules": true
    }
  }
}
```

## Workspace Settings

### Settings Hierarchy

1. **User Settings**: Apply to all workspaces
2. **Workspace Settings**: Override user settings
3. **Folder Settings**: Folder-specific settings

### Workspace Settings File

Located in `.vscode/settings.json`:

```json
{
  "editor.tabSize": 4,
  "files.exclude": {
    "**/node_modules": true,
    "**/dist": true
  },
  "search.exclude": {
    "**/node_modules": true
  }
}
```

## Workspace Configuration

### Folders Configuration

```json
{
  "folders": [
    {
      "name": "Frontend",
      "path": "./frontend"
    },
    {
      "name": "Backend",
      "path": "./backend"
    }
  ]
}
```

### Settings Configuration

```json
{
  "settings": {
    "editor.formatOnSave": true,
    "files.autoSave": "afterDelay",
    "typescript.tsdk": "node_modules/typescript/lib"
  }
}
```

### Extensions Configuration

```json
{
  "extensions": {
    "recommendations": [
      "esbenp.prettier-vscode",
      "dbaeumer.vscode-eslint",
      "ms-python.python"
    ],
    "unwantedRecommendations": []
  }
}
```

## Multi-Root Workspaces

### Use Cases

- **Monorepos**: Multiple related projects
- **Full-Stack**: Frontend and backend together
- **Microservices**: Multiple services
- **Shared Libraries**: Common code across projects

### Benefits

- Single editor window
- Shared settings
- Unified search
- Integrated debugging
- Single source control view

### Folder Management

- Add folder: File > Add Folder to Workspace
- Remove folder: Right-click folder → Remove Folder
- Reorder folders: Drag folders
- Rename folders: Right-click → Rename

## Workspace Tasks

### Task Configuration

`.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build Frontend",
      "type": "shell",
      "command": "npm run build",
      "options": {
        "cwd": "${workspaceFolder}/frontend"
      }
    },
    {
      "label": "Build Backend",
      "type": "shell",
      "command": "npm run build",
      "options": {
        "cwd": "${workspaceFolder}/backend"
      }
    }
  ]
}
```

### Compound Tasks

Run multiple tasks:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build Frontend",
      "type": "shell",
      "command": "npm run build",
      "options": {
        "cwd": "${workspaceFolder}/frontend"
      }
    },
    {
      "label": "Build Backend",
      "type": "shell",
      "command": "npm run build",
      "options": {
        "cwd": "${workspaceFolder}/backend"
      }
    }
  ],
  "compounds": {
    "Build All": {
      "dependsOn": ["Build Frontend", "Build Backend"],
      "dependsOrder": "parallel"
    }
  }
}
```

## Workspace Launch Configurations

### Debug Configuration

`.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Frontend",
      "program": "${workspaceFolder}/frontend/src/index.js"
    },
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Backend",
      "program": "${workspaceFolder}/backend/src/index.js"
    }
  ],
  "compounds": [
    {
      "name": "Launch Full Stack",
      "configurations": ["Launch Frontend", "Launch Backend"]
    }
  ]
}
```

## Workspace Variables

### Available Variables

- `${workspaceFolder}`: First folder in workspace
- `${workspaceFolderBasename}`: Name of workspace folder
- `${relativeFile}`: Relative path of current file
- `${fileBasename}`: Current file basename
- `${fileDirname}`: Current file directory
- `${fileExtname}`: Current file extension

### Multi-Root Variables

- `${workspaceFolder:folderName}`: Specific folder path
- `${folderName}`: Folder name

## Workspace Extensions

### Extension Recommendations

`.vscode/extensions.json`:

```json
{
  "recommendations": [
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "ms-python.python"
  ],
  "unwantedRecommendations": []
}
```

### Prompt for Extensions

VS Code prompts to install recommended extensions when opening workspace.

## Workspace Best Practices

### Organization

1. **Logical Grouping**: Group related projects
2. **Clear Naming**: Use descriptive folder names
3. **Consistent Structure**: Maintain consistent structure
4. **Documentation**: Document workspace setup

### Settings Management

1. **Workspace-Specific**: Use workspace settings for project-specific configs
2. **Version Control**: Commit workspace settings
3. **Team Sharing**: Share workspace files
4. **Settings Sync**: Use Settings Sync for personal projects

### Performance

1. **Limit Folders**: Don't add too many folders
2. **Exclude Files**: Exclude unnecessary files
3. **Search Exclusions**: Configure search exclusions
4. **File Watchers**: Limit file watchers

## Workspace File Structure

### Typical Structure

```
project/
├── .vscode/
│   ├── settings.json
│   ├── tasks.json
│   ├── launch.json
│   └── extensions.json
├── frontend/
├── backend/
└── shared/
```

### Workspace File

```
project.code-workspace
```

## Opening Workspaces

### Methods

1. **File Menu**: File > Open Workspace from File
2. **Command Line**: `code project.code-workspace`
3. **Recent**: File > Open Recent
4. **Double-click**: Double-click `.code-workspace` file

### Recent Workspaces

VS Code remembers recent workspaces:
- File > Open Recent
- Quick access to workspaces

## Troubleshooting

### Workspace Not Loading

1. Check workspace file syntax
2. Verify folder paths
3. Check file permissions
4. Reload window

### Settings Not Applying

1. Check workspace settings file
2. Verify settings hierarchy
3. Check for conflicts
4. Reload window

### Performance Issues

1. Limit number of folders
2. Exclude large directories
3. Configure file watchers
4. Check extension impact

## Workspace Examples

### Monorepo Workspace

```json
{
  "folders": [
    {
      "name": "Packages",
      "path": "./packages"
    },
    {
      "name": "Apps",
      "path": "./apps"
    }
  ],
  "settings": {
    "files.exclude": {
      "**/node_modules": true,
      "**/dist": true
    }
  }
}
```

### Full-Stack Workspace

```json
{
  "folders": [
    {
      "name": "Client",
      "path": "./client"
    },
    {
      "name": "Server",
      "path": "./server"
    }
  ],
  "settings": {
    "editor.formatOnSave": true,
    "typescript.tsdk": "node_modules/typescript/lib"
  }
}
```

## Next Steps

- Learn about [Performance Optimization](./VSCODE-PERFORMANCE.md)
- Explore [Settings](./VSCODE-SETTINGS.json.md)
- Master [Keyboard Shortcuts](./VSCODE-KEYBOARD-SHORTCUTS.md)

Workspaces are powerful for organizing complex projects. Use them to maintain a clean, efficient development environment.


