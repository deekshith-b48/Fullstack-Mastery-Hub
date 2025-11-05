# WebStorm Version Control

WebStorm provides comprehensive version control integration with Git, SVN, Mercurial, and other VCS systems. This guide covers VCS setup, workflows, and advanced features.

## Version Control Overview

WebStorm VCS features:
- **Visual Git Tools**: Graphical Git interface
- **Commit Tool**: Integrated commit interface
- **Merge Tool**: Merge conflict resolution
- **History**: View version history
- **Branch Management**: Branch operations
- **Diff Viewer**: Compare file changes

## Git Integration

### Enabling Git

1. **VCS** → **Enable Version Control Integration**
2. Select **Git**
3. Configure Git executable
4. Apply

### Git Configuration

- **Git Executable**: Path to Git
- **SSH Executable**: SSH configuration
- **Credentials Helper**: Credential storage
- **Commit Options**: Commit behavior

## Git Workflows

### Checking Status

- **VCS** → **Git** → **Show Git Log**
- **Alt+9**: Open Version Control tool window
- **Status Bar**: Shows current branch and changes

### Viewing Changes

- **Alt+9**: Version Control tool window
- **Local Changes**: View modified files
- **Incoming Changes**: View remote changes
- **Repository**: Browse repository

## Committing Changes

### Commit Tool

1. **VCS** → **Commit** or `Ctrl+K` / `Cmd+K`
2. Review changes
3. Enter commit message
4. Select files to commit
5. Commit

### Commit Options

- **Commit and Push**: Commit and push immediately
- **Amend**: Amend previous commit
- **Sign-off**: Add sign-off
- **Author**: Override commit author

### Commit Message

- **Template**: Use commit message templates
- **Format**: Follow commit message conventions
- **Body**: Detailed commit description

## Branching

### Creating Branches

1. **VCS** → **Git** → **Branches**
2. Click `+` → **New Branch**
3. Enter branch name
4. Checkout branch

### Switching Branches

1. **VCS** → **Git** → **Branches**
2. Select branch
3. **Checkout**

### Merging Branches

1. **VCS** → **Git** → **Merge Changes**
2. Select branch to merge
3. Review changes
4. Merge

## Pull and Push

### Pulling Changes

1. **VCS** → **Git** → **Pull**
2. Select remote
3. Choose merge strategy
4. Pull

### Pushing Changes

1. **VCS** → **Git** → **Push**
2. Select branch
3. Review commits
4. Push

### Update Project

- **Ctrl+T** / `Cmd+T`: Update project
- Pulls changes and merges
- Updates local repository

## Merging

### Merge Conflicts

1. **VCS** → **Git** → **Resolve Conflicts**
2. View conflict markers
3. Choose resolution strategy
4. Resolve conflicts
5. Mark as resolved

### Merge Tool

- **Three-way Merge**: Compare all versions
- **Accept Changes**: Accept theirs/ours
- **Manual Resolution**: Edit manually
- **Preview**: Preview resolution

## Diff Viewer

### Viewing Diffs

1. **Right-click** file → **Git** → **Compare with...**
2. Compare with branch
3. Compare with working tree
4. View diff

### Diff Options

- **Side-by-Side**: Side-by-side comparison
- **Unified**: Unified diff view
- **Highlight Changes**: Highlight differences
- **Navigate Changes**: Navigate between changes

## History

### Git Log

- **VCS** → **Git** → **Show Git Log**
- View commit history
- Filter commits
- Search history

### File History

1. **Right-click** file → **Git** → **Show History**
2. View file history
3. Compare versions
4. Revert changes

### Annotate

- **Right-click** → **Git** → **Annotate**
- View line-by-line authorship
- See commit for each line
- Navigate to commits

## Stashing

### Create Stash

1. **VCS** → **Git** → **Stash Changes**
2. Enter stash message
3. Choose files
4. Create stash

### Apply Stash

1. **VCS** → **Git** → **Unstash Changes**
2. Select stash
3. Apply or pop
4. Resolve conflicts if any

## Advanced Features

### Git Flow

- **Git Flow Integration**: Git Flow support
- **Feature Branches**: Feature branch workflow
- **Release Branches**: Release management
- **Hotfix Branches**: Hotfix workflow

### Rebase

- **VCS** → **Git** → **Rebase**
- Select branch to rebase onto
- Interactive rebase
- Resolve conflicts

### Cherry-Pick

- **VCS** → **Git** → **Cherry-Pick**
- Select commits
- Apply to current branch

## GitHub Integration

### GitHub Accounts

1. **Settings** → **Version Control** → **GitHub**
2. Add GitHub account
3. Authenticate
4. Configure

### Pull Requests

- **VCS** → **Git** → **Create Pull Request**
- View pull requests
- Review PRs
- Merge PRs

## Best Practices

### Commit Workflow

1. **Review Changes**: Always review before commit
2. **Meaningful Messages**: Write clear commit messages
3. **Atomic Commits**: Commit related changes together
4. **Regular Commits**: Commit frequently

### Branch Strategy

1. **Feature Branches**: Use for features
2. **Main Branch**: Keep stable
3. **Regular Updates**: Update regularly
4. **Clean History**: Maintain clean history

## Troubleshooting

### Common Issues

- **Authentication**: Check credentials
- **Conflicts**: Resolve merge conflicts
- **Remote Issues**: Check remote configuration
- **Permissions**: Verify file permissions

## Next Steps

- Explore [Database Tools](./WEBSTORM-DATABASE-TOOLS.md)
- Optimize [Performance](./WEBSTORM-PERFORMANCE.md)
- Compare [VS Code](./WEBSTORM-VS-VSCODE.md)

Version control is essential for collaboration. Master WebStorm's Git integration for efficient version control workflows.


