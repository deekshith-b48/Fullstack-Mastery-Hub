# GitHub Collaboration

## Fork and Clone

```bash
# Fork repository on GitHub (via web interface)
# Then clone your fork
git clone https://github.com/your-username/repo.git
```

## Working with Forks

```bash
# Add upstream remote
git remote add upstream https://github.com/original-owner/repo.git

# Fetch upstream changes
git fetch upstream

# Merge upstream changes
git checkout main
git merge upstream/main

# Push to your fork
git push origin main
```

## Pull Requests

1. Push your branch
2. Click "New Pull Request" on GitHub
3. Select base and compare branches
4. Add description and reviewers
5. Wait for review and merge

---

**Next**: See [Git Best Practices](./GIT-BEST-PRACTICES.md)

