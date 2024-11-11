resource "aws_iam_user" "developer" {
  name = "developer"
}

# user policy
resource "aws_iam_policy" "developer_eks_policy" {
  name = "AmazonEKSDeveloperPolicy"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["eks:DiscribeCluster", "eks:ListClusters"],
            "Resource": "*"
        }
    ]
}
POLICY
}

# attach policy to the developer user
resource "aws_iam_user_policy_attachment" "developer_policy_attache" {
  user = aws_iam_user.developer.name
  policy_arn = aws_iam_policy.developer_eks_policy.arn
}

# bind developer iam user with the RBAC in EKS Cluster
resource "aws_eks_access_entry" "developer_rbac" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  principal_arn = aws_iam_user.developer.arn
  kubernetes_groups = ["viewer-role"]
}

# aws configure --profile developer
# aws sts get-caller-identity --profile developer
# aws eks update-kubeconfig --region us-east-1 --name dev_demo_cluster --profile developer

# kubectl config view --minify
# kubectl auth can-i "*" "*"