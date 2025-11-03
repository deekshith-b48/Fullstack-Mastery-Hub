# Git Best Practices

## Commit Messages

```bash
# Format
type(scope): subject

body (optional)

footer (optional)

# Types
feat:     New feature
fix:      Bug fix
docs:     Documentation
style:    Formatting
refactor: Code restructuring
test:     Tests
chore:    Maintenance

# Examples
git commit -m "feat(auth): add login functionality"
git commit -m "fix(api): resolve timeout issue"
```

## .gitignore

```gitignore
# Dependencies
node_modules/
vendor/

# Environment
.env
.env.local

# Build
dist/
build/

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db
```

## Branch Naming

```bash
feature/user-authentication
bugfix/login-error
hotfix/security-patch
release/v1.0.0
```

---

**Next**: Learn about [Linux Command Line](../02-Linux-Command-Line/documentation/LINUX-BASICS.md)

