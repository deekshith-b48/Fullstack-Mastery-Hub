#!/usr/bin/env node

const { execSync } = require('child_process');

const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
};

function checkCommand(command, name) {
  try {
    const version = execSync(command, { encoding: 'utf-8' }).trim();
    console.log(`${colors.green}✓${colors.reset} ${name}: ${version}`);
    return true;
  } catch (error) {
    console.log(`${colors.red}✗${colors.reset} ${name}: Not installed`);
    return false;
  }
}

console.log(`${colors.blue}🔍 Verifying Fullstack Mastery Hub Setup...${colors.reset}\n`);

const checks = [
  { command: 'node --version', name: 'Node.js' },
  { command: 'npm --version', name: 'npm' },
  { command: 'python --version', name: 'Python' },
  { command: 'python -m pip --version', name: 'pip' },
  { command: 'java -version 2>&1 | head -1', name: 'Java' },
  { command: 'git --version', name: 'Git' },
  { command: 'docker --version', name: 'Docker' },
];

let allPassed = true;

checks.forEach(check => {
  const passed = checkCommand(check.command, check.name);
  if (!passed) allPassed = false;
});

console.log(`\n${colors.blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${colors.reset}`);

if (allPassed) {
  console.log(`${colors.green}✅ All prerequisites are installed!${colors.reset}`);
} else {
  console.log(`${colors.yellow}⚠️  Some prerequisites are missing. Please install them to continue.${colors.reset}`);
}

process.exit(allPassed ? 0 : 1);

