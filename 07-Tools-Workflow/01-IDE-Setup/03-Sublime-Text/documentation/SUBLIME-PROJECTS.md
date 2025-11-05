# Sublime Text Projects

Sublime Text projects allow you to save workspace configurations, including open files, folders, and settings. This guide covers project creation, configuration, and management.

## Project Overview

Sublime Text projects provide:
- **Workspace State**: Save open files and folders
- **Settings**: Project-specific settings
- **Build Systems**: Project-specific build configurations
- **Quick Access**: Quick project switching

## Creating Projects

### New Project

1. **Project** → **Save Project As...**
2. Choose location and name
3. Save `.sublime-project` file
4. Project is created

### Project Files

Projects consist of:
- **`.sublime-project`**: Project configuration file
- **`.sublime-workspace`**: Workspace state (auto-generated)

## Project Structure

### Project File Format

```json
{
  "folders": [
    {
      "path": "/path/to/project"
    }
  ],
  "settings": {
    "tab_size": 2,
    "translate_tabs_to_spaces": true
  }
}
```

### Project Configuration

- **folders**: Array of project folders
- **settings**: Project-specific settings
- **build_systems**: Project build systems

## Multi-Folder Projects

### Adding Folders

```json
{
  "folders": [
    {
      "path": "/path/to/frontend",
      "name": "Frontend"
    },
    {
      "path": "/path/to/backend",
      "name": "Backend"
    }
  ]
}
```

### Folder Properties

- **path**: Folder path
- **name**: Display name (optional)
- **file_exclude_patterns**: Exclude file patterns
- **folder_exclude_patterns**: Exclude folder patterns

## Project Settings

### Project-Specific Settings

```json
{
  "settings": {
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "rulers": [80, 120],
    "word_wrap": "auto"
  }
}
```

### Settings Precedence

1. User settings (global)
2. Project settings (override user)
3. Syntax-specific settings

## Build Systems

### Project Build Systems

```json
{
  "build_systems": [
    {
      "name": "Build",
      "cmd": ["npm", "run", "build"],
      "working_dir": "${project_path}"
    }
  ]
}
```

### Build Configuration

- **name**: Build system name
- **cmd**: Command to execute
- **working_dir**: Working directory
- **file_regex**: Error pattern matching

## Switching Projects

### Opening Projects

1. **File** → **Open Recent** → **Project**
2. Or double-click `.sublime-project` file
3. Project opens with saved state

### Quick Switch

- **Ctrl+Alt+P** / `Cmd+Option+P`: Quick switch projects
- **Project** → **Switch Project**: Switch between projects

## Workspace State

### Workspace File

`.sublime-workspace` stores:
- Open files
- File groups
- Cursor positions
- View settings

### Auto-Save

- Workspace state auto-saves
- Restores on project open
- Can be manually saved

## Best Practices

### Project Organization

1. **Save Projects**: Save projects for all major work
2. **Meaningful Names**: Use descriptive project names
3. **Version Control**: Track project files in Git
4. **Team Sharing**: Share project files with team

### Project Settings

1. **Project-Specific**: Use project settings when needed
2. **Consistent**: Maintain consistent settings
3. **Documentation**: Document project configuration
4. **Backup**: Backup project files

## Troubleshooting

### Project Issues

- **Not Opening**: Check file paths
- **Settings Not Applying**: Check settings syntax
- **State Lost**: Restore from workspace file
- **Conflicts**: Resolve project conflicts

## Next Steps

- Optimize [Performance](./SUBLIME-PERFORMANCE.md)
- Learn [Best Practices](./SUBLIME-BEST-PRACTICES.md)
- Explore [Package Control](./SUBLIME-PACKAGE-CONTROL.md)

Projects streamline workflow. Use projects to organize your work efficiently.





