# Jenkins Distributed Builds

## 📚 Overview

Jenkins distributed builds allow you to run builds on multiple machines (nodes/agents). This enables parallel execution and better resource utilization.

## 🎯 Distributed Architecture

### Master-Node Architecture

- **Master**: Central Jenkins server
- **Agent/Node**: Machine that executes builds
- **Label**: Identifier for agent selection
- **Connection**: SSH, JNLP, or other methods

### Benefits

- **Parallel Execution**: Run multiple builds simultaneously
- **Resource Distribution**: Distribute load across machines
- **Specialized Agents**: Use agents with specific tools
- **Scalability**: Scale horizontally

## 🚀 Setting Up Agents

### SSH Agent

```bash
# On Jenkins master:
# Manage Jenkins > Manage Nodes and Clouds
# New Node > Permanent Agent
# Configure:
# - Name: agent-name
# - Remote root directory: /home/jenkins
# - Launch method: Launch agents via SSH
# - Host: agent-ip
# - Credentials: SSH credentials
```

### JNLP Agent

```bash
# On agent machine:
# Download agent.jar from Jenkins
# Run:
java -jar agent.jar \
  -jnlpUrl http://jenkins-url/computer/agent-name/slave-agent.jnlp \
  -secret <secret> \
  -workDir /home/jenkins
```

### Docker Agent

```groovy
pipeline {
    agent {
        docker {
            image 'node:18'
            args '-v /tmp:/tmp'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
    }
}
```

## 🔧 Agent Configuration

### Labels

```groovy
pipeline {
    agent {
        label 'linux && docker'
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build .'
            }
        }
    }
}
```

### Agent Selection

```groovy
pipeline {
    agent any  // Any available agent
    
    agent {
        label 'linux'  // Specific label
    }
    
    agent {
        node {
            label 'linux'
            customWorkspace '/tmp/build'
        }
    }
}
```

## 📊 Monitoring

### Agent Status

```bash
# Manage Jenkins > Manage Nodes and Clouds
# View agent status
# Online: Green
# Offline: Red
# Disconnected: Grey
```

### Build Distribution

```groovy
pipeline {
    agent none
    
    stages {
        stage('Build') {
            parallel {
                stage('Linux') {
                    agent { label 'linux' }
                    steps {
                        sh 'build.sh'
                    }
                }
                stage('Windows') {
                    agent { label 'windows' }
                    steps {
                        bat 'build.bat'
                    }
                }
            }
        }
    }
}
```

## 🎯 Best Practices

1. **Labels**: Use descriptive labels
2. **Resource Management**: Monitor agent resources
3. **Security**: Secure agent connections
4. **Monitoring**: Monitor agent health
5. **Scaling**: Scale agents as needed
6. **Documentation**: Document agent setup
7. **Maintenance**: Maintain agents regularly

## 🎓 Learning Resources

- Distributed Builds: https://www.jenkins.io/doc/book/using/using-agents/
- Agent Setup: https://www.jenkins.io/doc/book/managing/nodes/
- Cloud: https://www.jenkins.io/doc/book/managing/clouds/

---

**Next**: Learn about [Blue Ocean UI](./BLUE-OCEAN-UI.md)

