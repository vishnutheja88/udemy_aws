data "aws_eks_cluster" "eks" {
    name = aws_eks_cluster.eks_cluster.name
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.eks_cluster.name
}

provider "helm" {
  kubernetes {
    host = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.eks_auth.token
    #or
    # exec {
    #     api_version = "client.authentication.k8s.io/v1beta1"
    #     args = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.eks.id]
    #     command = "aws"
    # }
  }
}

## metrics server configuration
resource "helm_release" "metrics_server" {
  name = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics_server/"
  chart = "metrics-server"
  namespace = "kube-system"
  version = "3.12.1"
  values = [file("${path.module}/values/metrics-server.yaml")]
  depends_on = [ aws_eks_node_group.eks_node_group_general ]
}
