# Cluster AutoScaler 

- EKS Pod Identities
- Cluster AutoScaler

- Cluster AutoScaler is additional component install in our EKS cluster, it automatically scale up and down our cluster.
- Cluster AutoScaler need permissions to interact with AWS and adjust the desire size. we use OpenID Connect Provider from IAM side.
- Create IAM role and establish trust with particular namespace and RBAC service account. 
- ServiceAccount
- OpenID Connect provider was having to use an annotation with the IAM role ARN on the service account.

## EKS pod identities
- we can use the EKS addon. It needs to create IAM role for the kubernetes service account 

# STEPS for Configuration
## configure Pod Identity Agent using Terraform
- ServiceAccount
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: cluster-autoscaler
  namespace: kube-system
  annotations:
    eks.awsamazon.com/role-arn: arn:aws:iam::<accountid>:role/cluster-autoscaler
```
```tf
resource "aws_eks_addon" "pod_identity" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    addon_name = "eks-pod-identity-agent"
    addon_version = "v1.2.0-eksbuild.1"
}
```
```sh
aws eks describe-addon-versions --region us-east-1 --addon-name eks-pod-identity-agent | grep -i addonversion
kubectl get daemonset eks-pod-identity-agent -n kube-system
```

- Cluster AutoScaler Role using OpenID Connect provider.

```yaml
resource "aws_iam_role" "cluster_autoscaler" {
    name = "{aws_eks_cluster.eks_cluster.name}-cluster-autoscaler"
    assume_role_policy = jsonencoded({
    Version = "2012-10-17"
    Statement [{
        Effect = "Allow"
        Action = ["sts:AssumeRole", "sts:TagSession"]
        Principal = {
            Service = "pods.eks.amazonaws.com"
        }
    }]
    })
}
```
- create Policy allow the cluster autoscaler to access the aws autoscaling group.
```yaml
data 'aws_iam_policy_document' 'cluster_autoscaler' {
    statement {
        actions = ["sts:AssumeRoleWithWebIdentity"]
        effect  = "Allow"

        condition {
            test = "StringEquals"
            variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
            values = ["system:serviceaccount:kube-system:cluster-autoscaler"]
        }
        principals {
            identifiers = [aws_iam_openid_connect_provider.eks.arn]
            type = "Federated"
        }
    }
}
```
- policy for allow the cluster autoscaler to access the AWS autoscaling group.
```yaml
resource "aws_iam_policy" "cluster_autoscaler" {
    name = "${aws_eks_cluster.eks_cluster.name}-cluster-autoscaler"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = ["autoscaling:DescribeAutoScalingGroups",
            "autoscaling:DescribeAutoScalingInstances",
            "autoscaling:DescribeLaunchConfigurations",
            "autoscaling:DescribeScalingActivities",
            "autoscaling:DescribeTags",
            "ec2:DescribeInstanceTypes",
            "ec2:DescribeImages",
            "ec2:DescribeLaunchTemplateVersions",
            "ec2:GetInstanceTypesFromInstanceRequirements",
            "ec2:DescribeNodeGroup"]
        Resource = "*"
        },
        {
            Effect = "Allow"
            Action = ["autoscaling:SetDesiredCapacity",
                        "autoscaling:TerminateInstanceInAutoScalingGroup"]
            Resource = "*"
        },
        ]
    })
}
resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
    policy_arn = aws_iam_policy.cluster_autoscaler.arn
    role = aws_iam_role.cluster_autoscaler.name
}
```
```yaml
resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    namespace = "kube-system"
    service_account = "cluster-autoscler"
    role_arn = aws_iam_role.cluster_autoscaler.arn
}
```
- Need to deploy EKS using helm charts
```yaml
resource "helm_release" "cluster_autoscaler" {
    name = "autoscaler"
    repository = "https://kubernetes.github.io/autoscaler"
    chart = "cluster-autoscaler"
    version = "9.37.0"

    set {
        name = "rbac.serviceAccount.name"
        value = "cluster-autoscaler"
    }
    set {
        name = "autoDiscovery.clusterName"
        value = aws_eks_cluster.eks_cluster.name
    }
    set {
        name = "awsRegion"
        value = "us-east-1"
    }
    depends_on = [helm_release.metrics_server]
}
```
- other autoscaling tools are KEDA and Karpenter


