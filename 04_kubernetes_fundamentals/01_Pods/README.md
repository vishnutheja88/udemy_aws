#   POD

### get worker nodes status
 ```
kubectl get nodes
kubectl get nodes -o wide
 ```

 ### Create a POD
 ```
kubectl run first-pod --image nginx:latest
 ```

 ### List of Pods
 ```
kubectl get pods
kubectl get po
kubectl get pods -o wide
 ```

 1. Kubernetes create a pod
 2. Pull the docker image from the docker hub / private repository (ECR)
 3. Created the container in the Pod
 4. Started the container present in the Pod

 ### Describe the POD
-   additional information about the pod and events of the Pod.
 ```
kubectl describe pod <pod-id/pod name>
 ```
### Access Application of Pod
1. Currently we can access this application only inside worker nodes.
2. To access it externally, we need to create NodePort Service.
3. Service to one very very important concept in the Kubernetes.

### Delete Pod
```
kubectl delete pod <pod-name/pod-id>
```

## NodePort Service
-   we can expose an application running on set of PODs using different types of Services available in K8s
    -   Cluster IP
    -   Node Port
    -   LoadBalancer
-   NodePort Service
    -   To access our application outside of K8s Cluster, we can use NodePort Service
    -   Expose service on each Worker Node IPs at static port (nothing but NodePort)
    -   A ClusterIP service, to which the NodePort service routes, is automatically created.
    -   port range 30000-32767

