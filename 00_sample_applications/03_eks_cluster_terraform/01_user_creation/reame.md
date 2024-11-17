# permissions
-   create a IAM role for teams, assign all the permissions to that role, and allow team members to assume that role
-   if you created production EKS cluster
    -   only grant read access to the developers by using RBAC, you only grant them read permission to access application logs in their namespaces.

-   aws
    - IAM users
    - IAM Roles
-   Kubernetes
    - ServiceAccounts
    - users
    - service groups

- IAM user to map with eks cluster RBAC
- IAM Roles to map with eks cluster RBAC

# IAM user Connect with EKS cluster
-   Create IAM user
    - attach policy with minimum permissions
```yaml
{
  "Version": "2012-10-17",
  "Statement":[{
    "Effect": "Allow",
    "Action": [
      "eks:DescribeCluster",
      "eks:ListCluster"
    ],
    "Resource": "*"
  }]
}
```
-   create **ClusterRole** in eks cluster

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: viewer
rules:
  - apiGroups: ["*"]
    resources: ["deployments", "pods", "configmaps", "services", "secrets"]
    verbs: ["get", "list", "watch"]
```

-   **ClusterRoleBinding** to bind this **ClusterRole** viewer RBAC group.
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: viewer-binding
roleRef:
  kind: ClusterRole
  name: viewer
  apiGroup: rbac.authorization.k8s.io
subjects:
  - kind: Group
    name: my-viewer
    apiGroup: rbac.authorization.k8s.io
```
- CRB map with CR and IAM user map with **Group** **my-viewer** RBAC group.

## IAM role with RBAC
-   IAM role and IAM policy that would grant that IAM role admin access to EKS on AWS side.
```yaml
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": "iam:PassRole",
    "Resource": "*",
    "Condition": {
      "StringEquals": {
        "iam:PassedToService": "eks.amazonaws.com"
      }
    }
  }]
}
```

- create **ClusterRoleBinding** for this **eks-admin-role**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-binding
roleRef:
  kind: ClusterRole
  name: eks-admin  #standard cluster role in K8s
  apiVersion: rbac.authorization.k8s.io
subjects:
  - kind: Group
    name: my-admin  # our new binding group
    apiVersion: rbac.authorization.k8s.io
```
- now we create **IAM User** name **manager** attach following policy name: **AmazonEKSAssumeAdminPolicy** for him.
```yaml
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": ["sts:AssumeRole"],
        "Resource": "eks-admin-role"  #Role form IAM Role
    }]
}
```
- in eks cluster **my-admin** RBAC group bind with IAM Role **eks-admin-role**..
