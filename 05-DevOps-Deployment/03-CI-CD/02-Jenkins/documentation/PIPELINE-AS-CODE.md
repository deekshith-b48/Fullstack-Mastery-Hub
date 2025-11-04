# Jenkins Pipeline as Code

## 📚 Overview

Pipeline as Code allows you to define Jenkins pipelines in code (Jenkinsfile) stored in version control. This enables versioning, review, and collaboration on pipeline definitions.

## 🎯 Pipeline Types

### Declarative Pipeline

```groovy
// Jenkinsfile
pipeline {
    agent any
    
    options {
        timeout(time: 1, unit: 'HOURS')
        timestamps()
    }
    
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'npm install'
                sh 'npm run build'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'npm test'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sh 'npm run deploy'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
```

### Scripted Pipeline

```groovy
// Jenkinsfile
node {
    stage('Build') {
        echo 'Building...'
        sh 'npm install'
        sh 'npm run build'
    }
    
    stage('Test') {
        echo 'Testing...'
        sh 'npm test'
    }
    
    stage('Deploy') {
        echo 'Deploying...'
        sh 'npm run deploy'
    }
}
```

## 🔧 Pipeline Syntax

### Agent

```groovy
pipeline {
    agent any  // Run on any available agent
    
    // Or specific agent
    agent {
        label 'linux'
    }
    
    // Or Docker
    agent {
        docker {
            image 'node:18'
            args '-v /tmp:/tmp'
        }
    }
}
```

### Stages

```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        
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
}
```

### Steps

```groovy
steps {
    // Shell command
    sh 'npm install'
    
    // Script
    sh '''
        echo "Multi-line"
        echo "Script"
    '''
    
    // Echo
    echo 'Hello from Jenkins'
    
    // Error handling
    sh 'npm test' || echo 'Tests failed'
}
```

## 📊 Advanced Features

### Environment Variables

```groovy
pipeline {
    agent any
    
    environment {
        NODE_ENV = 'production'
        API_URL = 'https://api.example.com'
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

### Credentials

```groovy
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    
    stages {
        stage('Deploy') {
            steps {
                sh 'aws s3 sync dist/ s3://my-bucket/'
            }
        }
    }
}
```

### Parameters

```groovy
pipeline {
    agent any
    
    parameters {
        string(name: 'ENVIRONMENT', defaultValue: 'staging', description: 'Deployment environment')
        choice(name: 'VERSION', choices: ['1.0', '2.0', '3.0'], description: 'Version to deploy')
    }
    
    stages {
        stage('Deploy') {
            steps {
                sh "deploy.sh --env ${params.ENVIRONMENT} --version ${params.VERSION}"
            }
        }
    }
}
```

## 🔄 Conditional Execution

### When Conditions

```groovy
pipeline {
    agent any
    
    stages {
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh 'deploy.sh'
            }
        }
        
        stage('Test') {
            when {
                anyOf {
                    branch 'main'
                    branch 'develop'
                }
            }
            steps {
                sh 'npm test'
            }
        }
    }
}
```

## 🎯 Best Practices

1. **Version Control**: Store Jenkinsfiles in Git
2. **Declarative**: Prefer declarative pipelines
3. **Modularity**: Break down complex pipelines
4. **Documentation**: Document pipeline logic
5. **Testing**: Test pipeline changes
6. **Security**: Use credentials properly
7. **Maintenance**: Keep pipelines updated

## 🎓 Learning Resources

- Pipeline Syntax: https://www.jenkins.io/doc/book/pipeline/syntax/
- Pipeline as Code: https://www.jenkins.io/doc/book/pipeline/pipeline-as-code/
- Jenkinsfile: https://www.jenkins.io/doc/book/pipeline/jenkinsfile/

---

**Next**: Learn about [Jenkinsfile Syntax](./JENKINSFILE-SYNTAX.md)

