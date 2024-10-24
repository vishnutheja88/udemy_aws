# Cluster Creation

- CLIs
    - AWS CLI
    - kubectl
    - eksctl
- Create EKS Cluster
- Create EKS Node Groups
- EKS Cluster Pricing
    - Control Plane
    - Node Groups
    - Fargate
- Delete EKS Cluster

## install aws cli
- Reference-1: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
- Reference-2: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html
```
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
aws --version
which aws
```

## install kubectl
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | shasum -a 256 --check
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo chown root: /usr/local/bin/kubectl
kubectl version --client
rm kubectl.sha256
```

## install EKSCTL
- macos
```
ARCH=arm64
PLATFORM=$(uname -s)_$ARCH
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin
```

## EKS cluster Core Components:
    -   EKS Control Plane
    -   Worker Nodes & Node Groups : group of EC2 instances where we run our applications workloads
    -   Fargate Profiles (Serverless) : insted of ec2 instances we run our applications on serverless Fargate Profiles
    -   VPC : we follow secure networking standards which will allow us to run production workloads on EKS.
                Fargate profiles only we have atleast one private subnet attached to our cluster.

## EKS Control Plane
- eks run a single tenant Kubernetes control plane for each cluster, and control plane infrstructure is not shared across cluster or AWS accounts. This control plane consiste of at least two API server nodes and three ETCD nodes that run across three AZ within region. EKS automatically detect and replace unhappy controlplane instances, restarting them across the AZ within the region as needed.

## Worker Nodes & Node Groups
- worker machines in kuberntes are called nodes. These are EC2 instances. EKS worker nodes run in our AWS account and connect to our cluster's control plane via the cluster API server endpoint. A node group is one or more EC2 instances that are deployed in an EC2 autoscaling group. All instances in a node group mustbe: be the same instances type, be running same AMIs, use the same EKS worker node IAM role.

## Fargate Profile
- AWS fargate is a technology that provides on-demand, right-size compute capacity for containers. With fargate we longer have to provision, configure, or scale group of virtual machines to run containers. Each pod running on fargate has its own isolated boundary and does not share the undelying kernel, CPU resources, memory resources, or elastic network interface with another Pod. AWS specially built Fargate controllers that organizes the pods belongs to fargate and schedules them on Fargate profiles.

## VPC
-   EKS uses VPC network policies to restrict traffic between control plane components to within a single cluster. Control palne components for a EKS cluster cannot view or receive communication from another cluster or other AWS accounts, except as authorized with Kubernetes RBAC policies. This secure and high available configuration makes EKS reliable and recomended for production workloads.

# Create EKS Cluster

stpe 01:
```
eksctl create cluster --name ekscluster-demo --region us-east-1 --zones=us-east-1a,us-east-1b --without-nodegroup
kubectl get nodes, ns
```
step 02: Create and Associate IAM OIDC provider for EKS Cluster
```
eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster ekscluster-demo --approve
```

Step 03: create EC2 keypair
```
# create keypair name: eks-key-pair.pem
```

Step 04: Create NodeGroup for cluster additional Add-ons public subnets
```
eksctl create nodegroup --cluster ekscluster-demo --region us-east-1 --name ekscluster-demo-ng-public --node-type t3.medium --nodes 2 --nodes-min 2 --node-max 4 --node-volume-size 40 --ssh-access --ssh-public-key eks-key-pair --managed --asg-access --external-dns-access --full-ecr-access --appmesh-access --alb-ingress-access
```

- verify node groups subnets to confirm ec2 instances are in public subnet
    eks -> cluster -> details tab -> Route Table -> internet gateway (0.0.0.0/0 -> igw-xxxx)
- verify cluster, Nodegroup in Management console
```
eksctl get cluster
eksctl get nodegroup --cluster=ekscluster-demo
kubectl get nodes -o wide
kubectl config view --minify
```


## Delete EKS Cluster
```
# delete nodegroup
kubectl delete nodegroup --cluster ekscluster-demo --name ekscluster-demo-ng-public

# delete eks cluster
eksctl delete cluster ekscluster-demo
```









