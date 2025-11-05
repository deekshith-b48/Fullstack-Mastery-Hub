# Atom Packages

Atom's package system is the heart of its extensibility. Packages add functionality, themes, and integrations to Atom. This guide covers package management, essential packages, and best practices.

## Package System Overview

Atom packages provide:
- **Functionality**: Extend editor capabilities
- **Language Support**: Add language support
- **Themes**: Customize appearance
- **Integrations**: Connect with external tools
- **Productivity**: Enhance workflow

## Package Manager

### APM (Atom Package Manager)

APM is Atom's command-line package manager:
```bash
# Install package
apm install package-name

# Search packages
apm search keyword

# List installed
apm list --installed

# Update packages
apm update
```

### Installing Packages

#### Via UI

1. **File** → **Settings** → **Install**
2. Search for package
3. Click Install
4. Package installs

#### Via Command Line

```bash
apm install package-name
```

## Essential Packages

### Code Quality

- **linter**: Code linting framework
- **linter-eslint**: ESLint integration
- **linter-pylint**: Python linting
- **editorconfig**: EditorConfig support

### Productivity

- **atom-beautify**: Code formatter
- **emmet**: HTML/CSS abbreviations
- **minimap**: Code minimap
- **file-icons**: File icons
- **pigments**: Color preview

### Git Integration

- **git-plus**: Git integration
- **git-time-machine**: Git history visualization
- **merge-conflicts**: Merge conflict resolution

### Language Support

- **language-javascript**: JavaScript support
- **language-typescript**: TypeScript support
- **language-python**: Python support
- **language-html**: HTML support

## Package Categories

### Linters

Code quality packages:
- **linter**: Base linting framework
- **linter-eslint**: JavaScript linting
- **linter-pylint**: Python linting
- **linter-htmlhint**: HTML linting

### Formatters

Code formatting:
- **atom-beautify**: Universal formatter
- **prettier-atom**: Prettier integration
- **formatter**: Formatting framework

### Themes

Appearance packages:
- **one-dark-ui**: One Dark UI theme
- **seti-ui**: Seti UI theme
- **material-ui**: Material Design theme

## Package Configuration

### Package Settings

1. **File** → **Settings** → **Packages**
2. Find package
3. Click Settings
4. Configure options

### Package Files

Packages stored in:
- **Windows**: `%USERPROFILE%\.atom\packages\`
- **macOS**: `~/.atom/packages/`
- **Linux**: `~/.atom/packages/`

## Managing Packages

### Updating Packages

1. **File** → **Settings** → **Updates**
2. View available updates
3. Click Update
4. Or use: `apm update`

### Removing Packages

1. **File** → **Settings** → **Packages**
2. Find package
3. Click Uninstall
4. Or use: `apm uninstall package-name`

### Disabling Packages

1. **File** → **Settings** → **Packages**
2. Find package
3. Click Disable
4. Package disabled but not removed

## Package Development

### Creating Packages

1. **File** → **Settings** → **Packages** → **Generate Package**
2. Enter package name
3. Package scaffold created
4. Develop package

### Package Structure

```
my-package/
├── package.json
├── lib/
│   └── main.coffee
├── styles/
│   └── styles.less
└── README.md
```

### Publishing Packages

1. Create GitHub repository
2. Publish to npm
3. Register with Atom package registry
4. Package available in Atom

## Best Practices

### Package Management

1. **Essential Only**: Install only necessary packages
2. **Regular Updates**: Keep packages updated
3. **Review Regularly**: Review installed packages
4. **Remove Unused**: Uninstall unused packages
5. **Monitor Performance**: Check package impact

### Package Selection

1. **Well-Maintained**: Choose actively maintained packages
2. **Documentation**: Read package documentation
3. **Ratings**: Check package ratings
4. **Performance**: Consider performance impact

## Troubleshooting

### Package Issues

- **Not Installing**: Check internet connection
- **Conflicts**: Resolve package conflicts
- **Performance**: Disable problematic packages
- **Errors**: Check console for errors

### Solutions

1. **Restart Atom**: Restart after package changes
2. **Clear Cache**: Clear package cache
3. **Reinstall**: Reinstall problematic package
4. **Check Logs**: Review console for errors

## Next Steps

- Explore [Themes](./ATOM-THEMES.md)
- Learn [Hackability](./ATOM-HACKABILITY.md)
- Configure [Git Integration](./ATOM-GIT-INTEGRATION.md)

Packages extend Atom's functionality. Choose packages wisely to enhance your workflow.





