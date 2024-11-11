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
* for best practices is not to use IAM users with long-term credentials.
* attach role to RoleBinding

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
spec:
  name: viewer-role-binding
roleRef:
  kind: ClusterRole
  name: viewer-role # user group/role
  apiGroup: rbac.authorization.k8s.io
subjects:
  - kind: Group # service accounts
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
-   need metrics server for autoscaling in the k8s cluster. metric server configuration using helm charts.
-   use memory or CPU usage metrics to decide when we need to scale up our application.
-   when you create a deployment or a statefulset you must have the resource block defined. HPA will use the request section to calculate the CPU and memory usage of Pod, not the limits.

## Cluster AutoScaler & Pod Identities
-   Cluser autosclaer is an external component that you need to additionally install on you EKS cluster to automatically scale up and down your cluster.
-   AWS EKS cluster nodegroup created as regular AWS Autoscaling groups with maximum, minimum and desire size properties.
### OpenId Connector
-   If an openid connect provider on the IAM side, then create an IAM role and establish trust with particular namespace and thr RBAC service account. OpenID Connector provider was having to use an annotations with the IAM role ARN on the Service Account.
-   **new approach** : EKS pod identities that we can use to grant access. use the eks addon **aws_eks_addon** using terraform.
-   

## AWS Load Balancer Controller (TLS)


## NGINX Ingress Controller (Cert-manager & TLS)


## EKS CSI Drivers


## ESK EFS CSI Drivers


## EKS + Secret Manager (ASM)