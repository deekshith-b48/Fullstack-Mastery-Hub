# AWS ECS & EKS Containers

## 📚 Overview

Amazon Elastic Container Service (ECS) and Amazon Elastic Kubernetes Service (EKS) are container orchestration services. ECS is AWS-native, while EKS provides managed Kubernetes.

## 🐳 Amazon ECS

### ECS Components

- **Cluster**: Group of EC2 instances or Fargate
- **Task Definition**: Container blueprint
- **Service**: Maintains desired number of tasks
- **Task**: Running instance of task definition
- **Container Instance**: EC2 instance running ECS agent

### Create ECS Cluster

```bash
# Create cluster
aws ecs create-cluster \
  --cluster-name my-cluster \
  --capacity-providers FARGATE FARGATE_SPOT

# Create cluster with EC2
aws ecs create-cluster \
  --cluster-name my-ec2-cluster \
  --capacity-providers EC2
```

### Task Definition

```json
{
  "family": "my-task",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "containerDefinitions": [
    {
      "name": "nginx",
      "image": "nginx:alpine",
      "portMappings": [
        {
          "containerPort": 80,
          "protocol": "tcp"
        }
      ],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/my-task",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
}
```

```bash
# Register task definition
aws ecs register-task-definition \
  --cli-input-json file://task-definition.json
```

### ECS Service

```bash
# Create service
aws ecs create-service \
  --cluster my-cluster \
  --service-name my-service \
  --task-definition my-task:1 \
  --desired-count 3 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-123],securityGroups=[sg-123],assignPublicIp=ENABLED}"
```

### Fargate

```bash
# Run task on Fargate
aws ecs run-task \
  --cluster my-cluster \
  --task-definition my-task:1 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-123],securityGroups=[sg-123]}"
```

## ☸️ Amazon EKS

### Create EKS Cluster

```bash
# Create cluster
aws eks create-cluster \
  --name my-cluster \
  --version 1.28 \
  --role-arn arn:aws:iam::123456789012:role/eks-service-role \
  --resources-vpc-config subnetIds=subnet-123,subnet-456,securityGroupIds=sg-123

# Create node group
aws eks create-nodegroup \
  --cluster-name my-cluster \
  --nodegroup-name my-nodegroup \
  --node-role arn:aws:iam::123456789012:role/NodeInstanceRole \
  --subnets subnet-123 subnet-456 \
  --instance-types t3.medium \
  --scaling-config minSize=1,maxSize=3,desiredSize=2
```

### EKS Configuration

```bash
# Update kubeconfig
aws eks update-kubeconfig --name my-cluster --region us-east-1

# Verify cluster
kubectl get nodes

# Deploy application
kubectl apply -f deployment.yaml
```

### Managed Node Groups

```bash
# Create managed node group
aws eks create-nodegroup \
  --cluster-name my-cluster \
  --nodegroup-name managed-ng \
  --node-role arn:aws:iam::123456789012:role/NodeInstanceRole \
  --subnets subnet-123 subnet-456 \
  --instance-types t3.medium \
  --ami-type AL2_x86_64 \
  --scaling-config minSize=1,maxSize=5,desiredSize=2
```

### Fargate Profiles

```bash
# Create Fargate profile
aws eks create-fargate-profile \
  --cluster-name my-cluster \
  --fargate-profile-name my-fargate-profile \
  --pod-execution-role-arn arn:aws:iam::123456789012:role/eks-fargate-profile \
  --subnets subnet-123 subnet-456 \
  --selectors namespace=default,labels={app=my-app}
```

## 🔧 Container Management

### ECS Service Scaling

```bash
# Update service desired count
aws ecs update-service \
  --cluster my-cluster \
  --service my-service \
  --desired-count 5

# Auto scaling
aws application-autoscaling register-scalable-target \
  --service-namespace ecs \
  --resource-id service/my-cluster/my-service \
  --scalable-dimension ecs:service:DesiredCount \
  --min-capacity 1 \
  --max-capacity 10
```

### EKS Auto Scaling

```yaml
# Horizontal Pod Autoscaler
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: my-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

## 🔐 Security

### ECS Task Roles

```bash
# Create task role
aws iam create-role \
  --role-name ecs-task-role \
  --assume-role-policy-document file://ecs-trust-policy.json

# Attach policy
aws iam attach-role-policy \
  --role-name ecs-task-role \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

### EKS IAM Roles

```bash
# Create service account with IAM role
eksctl create iamserviceaccount \
  --name my-serviceaccount \
  --namespace default \
  --cluster my-cluster \
  --attach-policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess \
  --approve
```

## 📊 Monitoring

### CloudWatch Logs

```bash
# ECS logs automatically sent to CloudWatch
# Configure in task definition

# EKS logs
aws eks enable-logging \
  --cluster-name my-cluster \
  --log-types api audit authenticator controllerManager scheduler
```

## 🎯 Best Practices

1. **Use Fargate**: For serverless containers
2. **Task Definitions**: Version control task definitions
3. **Service Discovery**: Use service discovery
4. **Scaling**: Configure auto-scaling
5. **Security**: Use IAM roles for tasks
6. **Networking**: Configure VPC properly
7. **Monitoring**: Enable CloudWatch logs

## 🎓 Learning Resources

- ECS Documentation: https://docs.aws.amazon.com/ecs/
- EKS Documentation: https://docs.aws.amazon.com/eks/
- Container Services: https://aws.amazon.com/containers/

---

**Next**: Learn about [CloudFront CDN](./CLOUDFRONT-CDN.md)

