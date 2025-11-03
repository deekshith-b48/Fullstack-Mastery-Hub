#!/bin/bash

# Script to create standard folder structure for a new technology

if [ -z "$1" ]; then
    echo "Usage: ./create-technology-structure.sh <technology-name>"
    echo "Example: ./create-technology-structure.sh React"
    exit 1
fi

TECH_NAME="$1"
BASE_DIR="$(pwd)"

# Create directory structure
mkdir -p "$TECH_NAME/documentation"
mkdir -p "$TECH_NAME/examples/{basic,intermediate,advanced,real-world}"
mkdir -p "$TECH_NAME/projects/{mini-projects,demo-apps,templates}"
mkdir -p "$TECH_NAME/code-snippets/{useful-functions,patterns,utilities}"
mkdir -p "$TECH_NAME/exercises/{challenges,solutions,tests}"

# Copy template files
if [ -f "$BASE_DIR/templates/THEORY.md" ]; then
    cp "$BASE_DIR/templates/THEORY.md" "$TECH_NAME/documentation/"
fi

if [ -f "$BASE_DIR/templates/SETUP.md" ]; then
    cp "$BASE_DIR/templates/SETUP.md" "$TECH_NAME/documentation/"
fi

if [ -f "$BASE_DIR/templates/BEST-PRACTICES.md" ]; then
    cp "$BASE_DIR/templates/BEST-PRACTICES.md" "$TECH_NAME/documentation/"
fi

if [ -f "$BASE_DIR/templates/COMMON-PITFALLS.md" ]; then
    cp "$BASE_DIR/templates/COMMON-PITFALLS.md" "$TECH_NAME/documentation/"
fi

if [ -f "$BASE_DIR/templates/RESOURCES.md" ]; then
    cp "$BASE_DIR/templates/RESOURCES.md" "$TECH_NAME/documentation/"
fi

# Create README
cat > "$TECH_NAME/README.md" << EOF
# $TECH_NAME

## 📚 Documentation

- [Theory](./documentation/THEORY.md)
- [Setup](./documentation/SETUP.md)
- [Best Practices](./documentation/BEST-PRACTICES.md)
- [Common Pitfalls](./documentation/COMMON-PITFALLS.md)
- [Resources](./documentation/RESOURCES.md)

## 📁 Structure

- \`examples/\` - Code examples by difficulty
- \`projects/\` - Practical projects
- \`code-snippets/\` - Reusable code snippets
- \`exercises/\` - Practice challenges

## 🚀 Quick Start

[Add quick start instructions here]

## 📝 Notes

[Add your notes and insights here]
EOF

echo "✅ Standard structure created for $TECH_NAME!"
echo "📁 Location: $BASE_DIR/$TECH_NAME"

