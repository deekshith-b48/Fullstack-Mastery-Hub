# Atom Git Integration

Atom has built-in Git integration and supports Git packages for enhanced version control functionality. This guide covers Git setup, workflows, and popular Git packages.

## Built-in Git Support

### Git Status

Atom shows Git status:
- **File Colors**: Modified files highlighted
- **Status Bar**: Git branch and status
- **Tree View**: Git status icons

### Git Commands

Access via Command Palette:
- **Git: Add**
- **Git: Commit**
- **Git: Push**
- **Git: Pull**

## Git Packages

### git-plus

Enhanced Git integration:

**Installation:**
```bash
apm install git-plus
```

**Features:**
- Git commands in Command Palette
- Commit from editor
- Push/pull operations
- Branch management

**Usage:**
1. `Ctrl+Shift+H` / `Cmd+Shift+H`: Git commands
2. Select command
3. Execute operation

### git-time-machine

Visual Git history:

**Installation:**
```bash
apm install git-time-machine
```

**Features:**
- Visual commit history
- File diff visualization
- Time-based navigation
- Commit comparison

**Usage:**
1. Right-click file → **Git Time Machine**
2. View commit history
3. Navigate through time
4. Compare versions

### merge-conflicts

Merge conflict resolution:

**Installation:**
```bash
apm install merge-conflicts
```

**Features:**
- Visual conflict markers
- Easy resolution
- Conflict navigation
- Auto-resolution

**Usage:**
1. Open file with conflicts
2. View conflict markers
3. Choose resolution
4. Mark as resolved

## Git Workflow

### Basic Operations

1. **Stage Files**: Right-click → **Git** → **Add**
2. **Commit**: Command Palette → **Git: Commit**
3. **Push**: Command Palette → **Git: Push**
4. **Pull**: Command Palette → **Git: Pull**

### Branch Management

1. **Checkout Branch**: Command Palette → **Git: Checkout**
2. **Create Branch**: Command Palette → **Git: Create Branch**
3. **Merge**: Command Palette → **Git: Merge**

## Configuration

### Git Settings

1. **File** → **Settings** → **Packages** → **git-plus**
2. Configure options
3. Set Git path if needed
4. Configure credentials

### Git Path

Set Git executable path:
1. **File** → **Settings** → **Core**
2. Set Git path
3. Or use system Git

## Best Practices

### Git Workflow

1. **Regular Commits**: Commit frequently
2. **Meaningful Messages**: Write clear commit messages
3. **Branch Strategy**: Use branches effectively
4. **Review Changes**: Review before committing

### Package Usage

1. **git-plus**: Daily Git operations
2. **git-time-machine**: History visualization
3. **merge-conflicts**: Conflict resolution
4. **Combine**: Use packages together

## Troubleshooting

### Git Issues

- **Git Not Found**: Set Git path in settings
- **Authentication**: Configure Git credentials
- **Conflicts**: Use merge-conflicts package
- **Performance**: Check Git repository size

## Next Steps

- Optimize [Performance](./ATOM-PERFORMANCE.md)
- Learn [Migration Guide](./ATOM-MIGRATION-GUIDE.md)
- Explore [Community](./ATOM-COMMUNITY.md)

Git integration streamlines version control. Use Git packages to enhance your workflow.





