# access to aws to create LB. to grant access we will use pod identities as well.
data "aws_iam_policy_document" "aws_lbc" {
    statement {
      effect = "Allow"
        principals {
            type = "Service"
            identifiers = ["pods.eks.amazonaws.com"]
        }
        actions = [
            "sts:AssueRole",
            "sts:TagSession"
        ]
    }
}

# IAM role to attach this assume policy
resource "aws_iam_role" "aws_lbc" {
  name = "${aws_eks_cluster.eks_cluster.name}"
  assume_role_policy = data.aws_iam_policy_document.aws_lbc.json
}

resource "aws_iam_policy" "aws_lbc" {
  policy = file("./iam/AWSLoadBalancerController.json")
  name = "AWSLoadBalancerController"
}

resource "aws_iam_role_policy_attachment" "aws_lbc" {
  policy_arn = aws_iam_policy.aws_lbc.arn
  role = aws_iam_role.aws_lbc.name
}

# link the IAM role with kubernetes service account
resource "aws_eks_pod_identity_association" "aws_lbc" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  namespace = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn = aws_iam_role.aws_lbc.arn
}

# deploy the lb controller using helm charts
resource "helm_release" "aws_lbc" {
  name = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart = "aws-load-balancer-controller"
  namespace = "kube-system"
  version = "1.7.2"
  set {
    name = "clusterName"
    value = aws_eks_cluster.eks_cluster.name
  }
  set {
    name = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
  depends_on = [ helm_release.cluster_autoscaler ]
}