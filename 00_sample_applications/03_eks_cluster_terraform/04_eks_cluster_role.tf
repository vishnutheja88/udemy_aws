data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eks_admin_role" {
  name = "${local.env}_${local.eks_name}_eks_admin"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            }
        }
    ]
}
POLICY
}

# Policy
resource "aws_iam_policy" "eks_admin_policy" {
  name = "AmazonEKSAdminPolicy"
  policy = <<POLICY
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
          "Condition": {
              "StringEquals": "iam:PassedToService": "eks.amazonaws.com"
          }
        }
    ]
}
POLICY
}
# bind the IAM role with the IAM policy
resource "aws_iam_role_policy_attachment" "eks_admin_policy_attachment" {
  role = aws_iam_role.eks_admin_role.name
  policy_arn = aws_iam_policy.eks_admin_policy.arn
}
# create IAM User
resource "aws_iam_user" "manager" {
  name = "manager"
}
# assume permission for user manager using above IAM role
resource "aws_iam_policy" "eks_admin_assume" {
  name = "AmazonEKSAssumeAdminPolicy"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action: ["sts.AssumeRole"],
            "Resource: "${aws_iam_role.eks_amin.arn}"
        }
    ]
}
POLICY
}

resource "aws_iam_user_policy_attachment" "manager" {
  user = aws_iam_user.manager.name
  policy_arn = aws_iam_policy.eks_admin_assume.arn
}
# map the IAM Role to EKS ClusterRoleBind RBAC
resource "aws_eks_access_entry" "manager" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  principal_arn = aws_iam_role.eks_admin_role.arn
  kubernetes_groups = ["my-admin"]
}

# create AWS profile for manager user:
#aws configure --profile manager

# assume temporary credential for manager:
# aws sts assume-role --role-arn arn:aws:iam::<accountid>:role/dev_demo_cluster_eks_admin --role-session-name manager-session --profile manager
# now you get the accesskey, secretkey and token
# create new profile for role-session $ vi ~/.aws/config

#[profile eks_admin] role_arn=xxxx
#                    source_profile = manager
# aws eks update-kubeconfig --region us-east-1 --name demo_cluster --profile eks_admin
# kubectl config view --minify 
# kubectl get pods,svc
# kubectl auth can-i "*" "*"