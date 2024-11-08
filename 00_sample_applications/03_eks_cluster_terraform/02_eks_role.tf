# eks iam-role
resource "aws_iam_role" "eks_role" {
  name = "${local.env}-${local.eks_name}-eks-cluster"
  assume_role_policy = <<POLICY
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
POLICY
}

# create policy
resource "aws_iam_role_policy_attachment" "eks_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusetrPolicy"
  role = aws_iam_role.eks_role.name
}

# eks cluster creation
resource "aws_eks_cluster" "eks_cluster" {
  name = "${local.env}_${local.eks_name}"
  version = local.eks_version
  role_arn = aws_iam_role.eks_role.name

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = [
        aws_subnet.private_zone1.id,
        aws_subnet.private_zone2.id
    ]
  }
  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }
  depends_on = [ aws_iam_role_policy_attachment.eks_policy ]
}

# Create NodeGroups

# create IAM Role for nodegroup
resource "aws_iam_role" "eks_nodes" {
  name = "${local.env}-${local.eks_name}-eks-node-group"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
POLICY
}

# attach policy to above role (assume policy)
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_nodes.id
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_nodes.id
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role = aws_iam_role.eks_nodes.id
}

# nodegroup
resource "aws_eks_node_group" "eks_node_group_general" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  version = local.eks_version
  node_group_name = "general" #memory,CPU optimize, GPU
  node_role_arn = aws_iam_role.eks_nodes.arn

  subnet_ids = [
    aws_subnet.private_zone1, aws_subnet.private_zone2
  ]
  capacity_type = "ON_DEMAND"
  instance_types = ["t3.small"]
  scaling_config {
    desired_size = 1
    max_size = 5
    min_size = 0
  }
  update_config {
    max_unavailable = 1
  }
  labels = {
    role = "general"
  }
  depends_on = [ aws_iam_role_policy_attachment.amazon_eks_worker_node_policy1,
  aws_iam_role_policy_attachment.amazon_eks_cni_policy,
  aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only ]
  lifecycle {
    ignore_changes = [ scaling_config[0].desired_size ]
  }
}