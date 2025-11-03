# Git Fundamentals

## What is Git?

Git is a distributed version control system that tracks changes in source code during software development.

## Installation

```bash
# Check if installed
git --version

# Install on Ubuntu/Debian
sudo apt-get install git

# Install on macOS
brew install git

# Install on Windows
# Download from https://git-scm.com/
```

## Initial Setup

```bash
# Configure user name
git config --global user.name "Your Name"

# Configure email
git config --global user.email "your.email@example.com"

# Check configuration
git config --list

# Set default editor
git config --global core.editor "code --wait"
```

## Basic Commands

### Initialize Repository

```bash
# Initialize new repository
git init

# Clone existing repository
git clone https://github.com/user/repo.git
git clone https://github.com/user/repo.git my-folder
```

### Status and Log

```bash
# Check status
git status

# View commit history
git log
git log --oneline
git log --graph --oneline --all
git log -5  # Last 5 commits

# Show changes
git diff
git diff --staged
```

### Adding and Committing

```bash
# Add files
git add file.txt
git add .                    # All files
git add *.js                 # Pattern matching
git add -A                   # All changes

# Commit
git commit -m "Initial commit"
git commit -m "Add feature" -m "Detailed description"

# Add and commit in one step
git commit -am "Message"
```

### Removing Files

```bash
# Remove from working directory and stage
git rm file.txt

# Remove from staging area only
git rm --cached file.txt

# Force remove
git rm -f file.txt
```

## Undoing Changes

```bash
# Unstage file
git restore --staged file.txt
git reset HEAD file.txt

# Discard changes in working directory
git restore file.txt
git checkout -- file.txt

# Amend last commit
git commit --amend -m "New message"

# Reset to previous commit
git reset --soft HEAD~1    # Keep changes staged
git reset --mixed HEAD~1    # Keep changes, unstage
git reset --hard HEAD~1     # Discard changes
```

## Remote Repositories

```bash
# Add remote
git remote add origin https://github.com/user/repo.git

# View remotes
git remote -v

# Rename remote
git remote rename old new

# Remove remote
git remote remove origin

# Fetch changes
git fetch origin

# Pull changes
git pull origin main

# Push changes
git push origin main
git push -u origin main     # Set upstream
```

---

**Next**: Learn about [Git Branching](./GIT-BRANCHING.md)

