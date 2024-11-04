## Create MySQL database and Connect with MySQL DB

## Usermanagement Diagram
![Test Image1](https://github.com/vishnutheja88/udemy_aws/blob/mac_air/06_EKS_EBS_CSI_Drivers/03_MySQL_DB_UserManagement/ebs_csi_driver.png)

```
# create mysql db
kubectl apply -f k8s_manifests/

# list pvc, sc, pv and deploy
kubectl get pvc, sc, pv, deploy
# pvc status show as Bound and pv status also as Bound

# check mysql pod labels
kubectl get pods -l app=mysql

# connect with mysql db in pods
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -dbpassword1
mysql> show schemas;
# you will find db usermgnt
mysql> quit
# pod will delete 
```

## References
- We need to discuss references exclusively here. 
- These will help you in writing effective templates based on need in your environments. 
- Few features are still in alpha stage as on today (Example:Resizing), but once they reach beta you can start leveraging those templates and make your trials. 
- **EBS CSI Driver:** https://github.com/kubernetes-sigs/aws-ebs-csi-driver
- **EBS CSI Driver Dynamic Provisioning:**  https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes/dynamic-provisioning
- **EBS CSI Driver - Other Examples like Resizing, Snapshot etc:** https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/examples/kubernetes
- **k8s API Reference Doc:** https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#storageclass-v1-storage-k8s-io