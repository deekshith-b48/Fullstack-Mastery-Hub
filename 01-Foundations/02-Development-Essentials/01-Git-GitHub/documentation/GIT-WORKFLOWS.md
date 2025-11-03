# Git Workflows

## Feature Branch Workflow

```bash
# Create feature branch
git checkout -b feature/new-feature

# Make changes and commit
git add .
git commit -m "Add new feature"

# Push branch
git push origin feature/new-feature

# Merge via pull request on GitHub
```

## Git Flow

```bash
# Main branches
main        # Production
develop     # Development

# Supporting branches
feature/*   # New features
release/*   # Release preparation
hotfix/*    # Production fixes
```

## GitHub Flow

1. Create branch from main
2. Make changes and commit
3. Push branch to GitHub
4. Create Pull Request
5. Review and merge
6. Deploy

---

**Next**: Learn about [GitHub Collaboration](./GITHUB-COLLABORATION.md)

