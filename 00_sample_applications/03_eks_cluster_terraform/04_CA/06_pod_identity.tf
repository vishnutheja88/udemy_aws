resource "aws_eks_addon" "pod_identity" {
    addon_name = "eks-pod-identity-agent"
    cluster_name = aws_eks_cluster.eks_cluster.name
    addon_version = "v1.2.0-eksbuild.1"
}

# aws eks describe-addon-versions --region us-east-1 --addon-name eks-pod-identity-agent | grep -i addonversion
# kubectl get daemonset eks-pod-identity-agent -n kube-system
# Cluster Auto Scaler
resource "aws_iam_role" "cluster_autoscaler" {
    name = "${aws_eks_cluster.eks_cluster.name}-cluster-autoscaler"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow"
                Action = ["sts:AssumeRole", "sts:TagSession"]
                Principal = {
                    Service = "pods.eks.amazonaws.com"
                }
            }
        ]
    })
}

# openid connector
# data "aws_iam_policy_document" "efs_csi_driver" {
#     statement {
#       actions = [ "sts:AssumeRoleWithWebIdentity" ]
#       effect = "Allow"
    
#     condition {
#         test = "StringEquals"
#         variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
#         values = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
#     }
#     principals {
#       identifiers = [ aws_iam_openid_connect_provider.eks_cluster.arn ]
#       type = "Federated"
#     }
#     }
# }

resource "aws_iam_policy" "cluster_autoscaler" {
    name = "${aws_eks_cluster.eks_cluster.name}-cluster-autoscaler"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:DescribeTags",
                "ec2:DescribeImages",
                "ec2:DescribeInstanceTypes",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:GetInstanceTypesFromInstanceRequirements",
                "eks:DescribeNodeGroups"
            ]
            Resource = "*"
        },
        {
            Effect = "Allow"
            Action = [
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup"
            ]
            Resource = "*"
        },]
    })
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
    policy_arn = aws_iam_policy.cluster_autoscaler.arn
    role = aws_iam_role.cluster_autoscaler.name
}
resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
    cluster_name = aws_eks_cluster.eks_cluster.name
    namespace = "kube-system"
    role_arn = aws_iam_role.cluster_autoscaler.arn
    service_account = "cluster-autoscaler"
}

# helm chart
resource "helm_release" "cluster_autoscaler" {
    chart = "cluster-autoscaler"
    name = "autoscaler"
    repository = "https://kubernetes.github.io/autoscaler"
    namespace = "kube-system"
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
    depends_on = [ helm_release.metrics_server ]
}
