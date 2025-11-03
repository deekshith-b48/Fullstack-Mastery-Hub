# Git Branching

## Branch Basics

```bash
# List branches
git branch
git branch -a              # All branches
git branch -r              # Remote branches

# Create branch
git branch feature-branch

# Switch branch
git checkout feature-branch
git switch feature-branch  # Newer syntax

# Create and switch
git checkout -b feature-branch
git switch -c feature-branch

# Delete branch
git branch -d feature-branch
git branch -D feature-branch  # Force delete
```

## Merging

```bash
# Merge branch into current
git checkout main
git merge feature-branch

# Merge with no-fast-forward
git merge --no-ff feature-branch

# Squash merge
git merge --squash feature-branch
```

## Rebasing

```bash
# Rebase current branch
git checkout feature-branch
git rebase main

# Interactive rebase
git rebase -i HEAD~3

# Abort rebase
git rebase --abort
```

---

**Next**: See [Git Workflows](./GIT-WORKFLOWS.md)

