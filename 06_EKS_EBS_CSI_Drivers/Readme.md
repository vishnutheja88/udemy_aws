# AWS EKS Storage CSI(Container Storage Interface)
- In-Tree Storage Provisioner (legacy lately depreciated)
- EBS CSI Drivers
- EFS CSI Drivers
- FSx for Luster CSI
  - Allow EKS Cluster to manage lifecycle of EBS Volumes for persistence storage, EFS File system, FSx for Luster file system. It is supported for greater 1.14 eks version.

  - EBS provides block level storage volumes for use with EC2 and container instances.
  - we can mount the volumes as device on our EC2 and container instances.
  - EBS volumes that are attached to an instances are exposed as storage volumes that persist independently from the life of the EC2 or Container instances.
  - We can dynamically change the configuration of a volume attached to an instances.
  - AWS recommended EBS for data that must be quickly accessible and require long-term persistance.
  - EBS well suited for both database-style applications that rely on random read and write and to throughput intensive applications that perform long, continuous read and write. 

## AWS EBS CSI Driver
- We will use **EBS CSI Driver** and use **EBS Volumes** for persistence storage to MySQL Database

## Topics
1. Install EBS CSI Driver
2. Create MySQL Database Deployment & ClusterIP Service
3. Create User Management Microservice Deployment & NodePort Service

## Concepts
| Kubernetes Object  | YAML File |
| ------------- | ------------- |
| Storage Class  | 01-storage-class.yml |
| Persistent Volume Claim | 02-persistent-volume-claim.yml   |
| Config Map  | 03-UserManagement-ConfigMap.yml  |
| Deployment, Environment Variables, Volumes, VolumeMounts  | 04-mysql-deployment.yml  |
| ClusterIP Service  | 05-mysql-clusterip-service.yml  |
| Deployment, Environment Variables  | 06-UserManagementMicroservice-Deployment.yml  |
| NodePort Service  | 07-UserManagement-Service.yml  |



## References:
- **Dynamic Volume Provisioning:** https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/deploy/kubernetes/overlays/stable
- https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes/dynamic-provisioning
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/deploy/kubernetes/overlays/stable
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver
##
- **Legacy: Will be deprecated** 
  - https://kubernetes.io/docs/concepts/storage/storage-classes/#aws-ebs
  - https://docs.aws.amazon.com/eks/latest/userguide/storage-classes.html