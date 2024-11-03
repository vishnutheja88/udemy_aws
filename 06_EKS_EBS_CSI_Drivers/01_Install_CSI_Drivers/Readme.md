# INSTALL EBS DRIVER

## Steps
-   Create IAM policy for EBS
-   Associate IAM policy to worker Node IAM Role
-   Install EBS CSI Driver CRD

## Create IAM Policy
```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AttachVolume",
                "ec2:CreateSnapshot",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:DeleteSnapshot",
                "ec2:DeleteTags",
                "ec2:DeleteVolume",
                "ec2:DescribeInstances"
                "ec2:DescribeSnapshots",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes",
                "ec2:DetachVolume"
            ],
            "Resource": "*"
        }
    ]
}
```
-   **Name**: Amazon_EBS_CSI_Driver
-   **Description**: policy for ec2 instances to access EBS

## IAM Role worker nodes using and Associate this policy to the role
```
# get the worker-nodes IAM Role ARN
kubectl describe configmap aws-auth -n kube-system
```
## Deploy the Amazon EBS CSI Driver
-   Deploy the Amazon EBS CSI Driver
```
# Deploy EBS CSI Driver
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"

# Verify ebs-csi pods running
kubectl get pods -n kube-system
```