# Jenkins Fundamentals

## 📚 Overview

Jenkins is an open-source automation server that enables continuous integration and continuous delivery. It provides a powerful platform for building, testing, and deploying software.

## 🎯 What is Jenkins?

Jenkins is a self-contained, Java-based program that can be installed on any machine. It provides a web interface for managing builds, plugins, and configurations.

### Key Concepts

- **Job**: Automated task or project
- **Build**: Execution of a job
- **Node**: Machine that executes builds
- **Plugin**: Extends Jenkins functionality
- **Pipeline**: Automated workflow
- **Agent**: Executor that runs builds

### Benefits

- **Open Source**: Free and extensible
- **Plugin Ecosystem**: Thousands of plugins
- **Flexibility**: Highly customizable
- **Distributed**: Run builds on multiple nodes
- **Community**: Large community support

## 🚀 Installation

### Docker Installation

```bash
# Run Jenkins with Docker
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

# Access Jenkins
# http://localhost:8080
```

### Linux Installation

```bash
# Add Jenkins repository
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update
sudo apt-get install jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

## 🔧 Basic Configuration

### Initial Setup

```bash
# Get initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Access Jenkins web interface
# http://localhost:8080
# Enter admin password
# Install suggested plugins
```

### Configure Jenkins

```bash
# Jenkins configuration file
# /var/lib/jenkins/config.xml

# Update Jenkins URL
# Manage Jenkins > Configure System > Jenkins URL
```

## 📝 Creating Jobs

### Freestyle Project

```bash
# Create new item
# New Item > Freestyle project

# Configure:
# - Source Code Management (Git)
# - Build Triggers (Poll SCM, GitHub hook)
# - Build Steps (Shell, Maven, etc.)
# - Post-build Actions (Archive, Email)
```

### Pipeline Project

```groovy
// Jenkinsfile
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'npm run deploy'
            }
        }
    }
}
```

## 🔄 Build Triggers

### Poll SCM

```bash
# Poll every 5 minutes
# H/5 * * * *

# Build triggers > Poll SCM
# Schedule: H/5 * * * *
```

### GitHub Webhook

```bash
# Configure webhook in GitHub
# Settings > Webhooks > Add webhook
# Payload URL: http://jenkins-url/github-webhook/
# Content type: application/json

# In Jenkins:
# Build Triggers > GitHub hook trigger for GITScm polling
```

### Scheduled Builds

```bash
# Build periodically
# Schedule: 0 0 * * * (daily at midnight)

# Build Triggers > Build periodically
# Schedule: 0 0 * * *
```

## 📊 Monitoring

### Build History

```bash
# View build history
# Job > Build History

# View console output
# Build > Console Output
```

### Build Status

```bash
# Blue: Success
# Red: Failure
# Yellow: Unstable
# Grey: Aborted/Not built
```

## 🎯 Best Practices

1. **Version Control**: Store Jenkinsfiles in Git
2. **Pipeline as Code**: Use declarative pipelines
3. **Plugins**: Use necessary plugins only
4. **Security**: Configure security properly
5. **Backup**: Regular backups
6. **Monitoring**: Monitor Jenkins health
7. **Documentation**: Document configurations

## 🎓 Learning Resources

- Jenkins Documentation: https://www.jenkins.io/doc/
- Getting Started: https://www.jenkins.io/doc/book/getting-started/
- Jenkins: https://www.jenkins.io

---

**Next**: Learn about [Pipeline as Code](./PIPELINE-AS-CODE.md)

