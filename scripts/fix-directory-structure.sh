#!/bin/bash

# Fix directories that were created incorrectly with brace expansion

BASE_DIR="/home/deekshi484/Fullstack-Mastery-Hub"

# Development Essentials
cd "$BASE_DIR/01-Foundations/02-Development-Essentials"
rm -rf "{01-Git-GitHub,02-Linux-Command-Line,03-HTTP-Protocols,04-DevTools-Mastery}" 2>/dev/null
mkdir -p 01-Git-GitHub 02-Linux-Command-Line 03-HTTP-Protocols 04-DevTools-Mastery

# Software Engineering
cd "$BASE_DIR/01-Foundations/03-Software-Engineering"
rm -rf "{01-Data-Structures,02-Algorithms,03-Design-Patterns,04-System-Design}" 2>/dev/null
mkdir -p 01-Data-Structures 02-Algorithms 03-Design-Patterns 04-System-Design

# Fix other brace expansion directories
find "$BASE_DIR" -type d -name "*{*" -exec rm -rf {} + 2>/dev/null

echo "✅ Directory structure fixed!"

