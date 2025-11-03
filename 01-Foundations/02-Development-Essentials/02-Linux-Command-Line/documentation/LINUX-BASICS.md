# Linux Command Line Basics

## Navigation

```bash
# Current directory
pwd

# List files
ls
ls -l          # Detailed list
ls -a          # Include hidden
ls -lh         # Human-readable sizes
ls -lah        # Combined

# Change directory
cd /path/to/dir
cd ~           # Home directory
cd ..          # Parent directory
cd -           # Previous directory
cd             # Home directory
```

## File Operations

```bash
# Create file
touch file.txt

# Create directory
mkdir dirname
mkdir -p path/to/dir    # Create parent dirs

# Copy
cp file.txt newfile.txt
cp -r dir/ newdir/      # Recursive

# Move/Rename
mv file.txt newname.txt
mv file.txt /path/to/

# Delete
rm file.txt
rm -r dir/              # Recursive
rm -rf dir/             # Force recursive

# View file
cat file.txt
less file.txt           # Pager view
head -n 20 file.txt     # First 20 lines
tail -n 20 file.txt     # Last 20 lines
```

## File Permissions

```bash
# View permissions
ls -l

# Change permissions
chmod 755 file.txt
chmod +x script.sh
chmod u+w file.txt      # User write

# Change owner
chown user:group file.txt
```

## Text Processing

```bash
# Search in files
grep "pattern" file.txt
grep -r "pattern" dir/  # Recursive
grep -i "pattern" file   # Case insensitive

# Find files
find . -name "*.txt"
find . -type f -name "*.js"
find /home -size +100M

# Sort
sort file.txt
sort -r file.txt        # Reverse

# Unique lines
uniq file.txt

# Count
wc -l file.txt          # Lines
wc -w file.txt          # Words
wc -c file.txt          # Characters
```

## Process Management

```bash
# List processes
ps
ps aux
ps -ef

# Kill process
kill PID
kill -9 PID             # Force kill

# Background/Foreground
command &                # Run in background
fg                       # Bring to foreground
bg                       # Resume in background
```

## Other Essentials

```bash
# Manual pages
man command

# History
history
history | grep "pattern"

# Aliases
alias ll='ls -lah'
alias ..='cd ..'

# Environment variables
echo $PATH
export VAR="value"

# Pipe and redirect
command | another-command
command > file.txt      # Overwrite
command >> file.txt     # Append
command 2>&1            # Combine stdout and stderr
```

---

**Next**: See more in [File System](./FILE-SYSTEM.md)

