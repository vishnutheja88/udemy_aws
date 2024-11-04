# StorageClass, PVC, ConfigMap and MySQL

- create MySQL Database with PVC using EBS Volume
| Kubernetes Object | YAML file|
|-------------------|----------|
| Storage Class| 01-storage-class.yaml|
| PVC| 02-pvc.yaml|
|ConfigMap| 03-usermanagement-configmap.yaml|
|Deployment, Environment Variable, Volumes, Volume Mounts|04-mysql-deployment.yaml|
|ClusterIP service| 05-mysql-clusterip-service.yaml|