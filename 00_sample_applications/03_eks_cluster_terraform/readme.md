## EKS Cluster

### IAM 
* IAM Role: vishnu-eks-cluster 

```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "eks.amazonaws.com"
            }
        }
    ]
}
```
* add permissions above role
    **Policy** : **AmazonEKSClusterPolicy**
    **Policy** : **AmazonWorkerNodePolicy**
    **Policy** : **AmazonEKS_CNI_Policy**
    **Policy** : **AmazonEC2ContainerRegistryReadOnly**
    

```
aws sts get-caller-identity
aws esk update-kubeconfig --region us-east-1 --name dev_demo_cluster
kubectl get pods
kubectl auth can-i "*" "*" 
```

## Add IAM User and IAM Role to AWS EKS Cluster


## HPA


## Cluster AutoScaler


## AWS Load Balancer Controller (TLS)


## NGINX Ingress Controller (Cert-manager & TLS)


## EKS CSI Drivers


## ESK EFS CSI Drivers


## EKS + Secret Manager (ASM)