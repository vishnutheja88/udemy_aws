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
- IAM user map with RBAC
- IAM Role map with RBAC
- In AWS side we can user IAM users or IAM roles as objects that represents identities. In K8s we can use Kubernetes service accounts, users and RBAC groups. 
- we will map IAM user with K8s Cluster RBAC. 


### userpolicy with minimum permission

* iam > create user> user > attache following poicy
```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["eks:DescribeCluster", "eks:ListClusters"],
            "Resource": "*"
        }
    ]
}
```
* create k8s viewr role

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: viewer-role
rules:
  - apiGroups: ["*"]
    resources: ["deployments", "configmaps", "pods", "secrets", "services"]
    verbs: ["get", "list", "watch"]
```

* attach role to rolebinding

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
spec:
  name: viewer-role-binding
roleRef:
  kind: ClusterRole
  name: viewer-role
  apiGroup: rbac.authorization.k8s.io
subjects:
  - kind: Group
    name: viewer-role-bind
    apiGroup: rbac.authorization.k8s.io
```
### Create IAM Role for EKS Cluster permissions

* create role > attach following policy
```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["eks:*"],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PasswdToService": "eks.amazonaws.com"
                }
            }
        }
    ]
}
```

## HPA


## Cluster AutoScaler


## AWS Load Balancer Controller (TLS)


## NGINX Ingress Controller (Cert-manager & TLS)


## EKS CSI Drivers


## ESK EFS CSI Drivers


## EKS + Secret Manager (ASM)