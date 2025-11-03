# 🚀 Setup Guide

Complete setup instructions for the Fullstack Web Development Mastery Hub.

## 📋 Prerequisites

Before starting, ensure you have the following installed:

### Required
- **Node.js** (v14 or higher) - [Download](https://nodejs.org/)
- **npm** (comes with Node.js) or **yarn**
- **Git** - [Download](https://git-scm.com/)

### Optional (Based on Learning Path)
- **Python** (3.8 or higher) - [Download](https://www.python.org/)
- **Java** (JDK 11 or higher) - [Download](https://www.oracle.com/java/)
- **Docker** - [Download](https://www.docker.com/)

## 🔧 Installation Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd Fullstack-Mastery-Hub
```

### 2. Install Dependencies

#### Node.js Dependencies
```bash
npm install
```

#### Python Dependencies (Optional)
```bash
pip install -r requirements.txt
```

### 3. Environment Configuration

Create a `.env` file from the template:

```bash
cp .env.example .env
```

Edit `.env` with your configuration values.

### 4. Docker Setup (Optional)

If you want to use Docker for development:

```bash
docker-compose up -d
```

This will start:
- PostgreSQL database (port 5432)
- MongoDB database (port 27017)
- Redis cache (port 6379)
- Node.js development server (port 3000)

### 5. Verify Installation

Run the verification script:

```bash
npm run verify-setup
```

## 🎯 Quick Start

### Starting a Learning Path

1. **Choose your path**:
   - Frontend: Start with `01-Foundations/01-Web-Fundamentals`
   - Backend: Start with `03-Backend-Mastery`
   - Fullstack: Follow both paths sequentially

2. **Read the README** in each section for guidance

3. **Use documentation templates** in `templates/` for creating new content

### Creating a New Technology Section

Use the helper script to create standard folder structure:

```bash
./scripts/create-technology-structure.sh "Technology-Name"
```

This creates:
- Standard folder structure
- Documentation templates
- README file

## 📚 Development Environment

### VS Code Setup (Recommended)

Recommended extensions:
- ESLint
- Prettier
- GitLens
- Docker
- Python
- JavaScript/TypeScript

### Code Formatting

Format all code:
```bash
npm run format
```

### Linting

Check code quality:
```bash
npm run lint
```

## 🔄 Git Workflow

### Branch Naming
- `feature/feature-name`: New features
- `fix/bug-name`: Bug fixes
- `docs/documentation-update`: Documentation

### Commit Messages
Use conventional commits:
- `feat: add new feature`
- `fix: resolve bug`
- `docs: update documentation`
- `chore: maintenance tasks`

## 🐳 Docker Commands

### Start Services
```bash
docker-compose up -d
```

### Stop Services
```bash
docker-compose down
```

### View Logs
```bash
docker-compose logs -f
```

### Access Database
```bash
# PostgreSQL
docker exec -it fullstack-postgres psql -U postgres

# MongoDB
docker exec -it fullstack-mongodb mongosh -u admin -p password
```

## ✅ Verification Checklist

- [ ] Node.js installed and verified
- [ ] npm/yarn working
- [ ] Git configured
- [ ] Repository cloned
- [ ] Dependencies installed
- [ ] Environment file created
- [ ] Docker services running (if using)
- [ ] Verification script passes

## 🆘 Troubleshooting

### Issue: npm install fails
**Solution**: 
- Clear npm cache: `npm cache clean --force`
- Delete `node_modules` and `package-lock.json`, then reinstall

### Issue: Docker containers won't start
**Solution**:
- Check if ports are already in use
- Stop conflicting services
- Check Docker daemon is running

### Issue: Python dependencies fail
**Solution**:
- Use virtual environment: `python -m venv venv`
- Activate: `source venv/bin/activate` (Linux/Mac) or `venv\Scripts\activate` (Windows)
- Install: `pip install -r requirements.txt`

## 📖 Next Steps

1. Review the [main README](./README.md)
2. Choose your learning path
3. Start with Foundations
4. Track your progress in projects

---

**Need Help?** Check the documentation in each section or create an issue.

