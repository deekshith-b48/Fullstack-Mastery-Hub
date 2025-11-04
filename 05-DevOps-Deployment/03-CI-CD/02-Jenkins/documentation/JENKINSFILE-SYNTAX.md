# Jenkinsfile Syntax

## 📚 Overview

Jenkinsfile syntax defines pipeline structure using Groovy DSL. Understanding the syntax is essential for creating effective Jenkins pipelines.

## 🎯 Declarative Syntax

### Basic Structure

```groovy
pipeline {
    agent any
    
    stages {
        stage('Stage Name') {
            steps {
                echo 'Step'
            }
        }
    }
}
```

### Agent Options

```groovy
pipeline {
    // Any available agent
    agent any
    
    // Specific label
    agent {
        label 'linux'
    }
    
    // Docker
    agent {
        docker {
            image 'node:18'
            args '-v /tmp:/tmp'
        }
    }
    
    // None (define agent per stage)
    agent none
}
```

### Stages

```groovy
stages {
    stage('Build') {
        steps {
            sh 'npm install'
        }
    }
    
    stage('Test') {
        steps {
            sh 'npm test'
        }
    }
}
```

### Parallel Stages

```groovy
stages {
    stage('Test') {
        parallel {
            stage('Unit Tests') {
                steps {
                    sh 'npm run test:unit'
                }
            }
            stage('Integration Tests') {
                steps {
                    sh 'npm run test:integration'
                }
            }
        }
    }
}
```

## 🔧 Advanced Syntax

### Options

```groovy
pipeline {
    agent any
    
    options {
        timeout(time: 1, unit: 'HOURS')
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
        disableConcurrentBuilds()
    }
}
```

### Environment

```groovy
pipeline {
    agent any
    
    environment {
        NODE_ENV = 'production'
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Build') {
            steps {
                sh "echo $NODE_ENV"
            }
        }
    }
}
```

### Post Actions

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
    }
    
    post {
        always {
            echo 'Always executed'
        }
        success {
            echo 'Success!'
        }
        failure {
            echo 'Failed!'
        }
        unstable {
            echo 'Unstable!'
        }
    }
}
```

## 🔄 Conditionals

### When

```groovy
stage('Deploy') {
    when {
        branch 'main'
    }
    steps {
        sh 'deploy.sh'
    }
}
```

### Complex Conditions

```groovy
stage('Deploy') {
    when {
        anyOf {
            branch 'main'
            branch 'develop'
        }
        not {
            branch 'master'
        }
    }
    steps {
        sh 'deploy.sh'
    }
}
```

## 📊 Scripted Syntax

### Basic Scripted

```groovy
node {
    stage('Build') {
        sh 'npm install'
    }
    
    stage('Test') {
        sh 'npm test'
    }
}
```

### Advanced Scripted

```groovy
node('linux') {
    def workspace = pwd()
    
    stage('Build') {
        sh "npm install"
    }
    
    stage('Test') {
        try {
            sh 'npm test'
        } catch (Exception e) {
            echo "Tests failed: ${e}"
            throw e
        }
    }
}
```

## 🎯 Best Practices

1. **Consistency**: Use consistent syntax
2. **Readability**: Write readable pipelines
3. **Modularity**: Break down complex logic
4. **Error Handling**: Handle errors properly
5. **Documentation**: Document complex logic
6. **Testing**: Test pipeline syntax
7. **Maintenance**: Keep syntax updated

## 🎓 Learning Resources

- Syntax Reference: https://www.jenkins.io/doc/book/pipeline/syntax/
- Declarative Syntax: https://www.jenkins.io/doc/book/pipeline/syntax/#declarative-pipeline
- Scripted Syntax: https://www.jenkins.io/doc/book/pipeline/syntax/#scripted-pipeline

---

**Next**: Learn about [Plugins Management](./PLUGINS-MANAGEMENT.md)

