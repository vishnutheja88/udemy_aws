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

### Expose Pod with Service
-   Expose POD with a Service to access the application externally (from internet)
-   PORTS:
    -   port: port on which node port service listens in Kubernetes cluster internally.
    -   NodePort: Worker Node port on which we can access our application.
    -   targetPort: We define conatainer port here on which our application is running.
```
# create a POD
kubectl run nginx --image nginx:latest
kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service
kubectl get svc, po
kubectl get nodes -o wide
```
### Interact with POD
```
# Get pod details
kubectl get pods

# Dump Pod logs
kubectl logs <pod-name>

# stream pod logs 
kubectl logs -f <pod-name>
```
- **cheetsheet**: https://kubernetes.io/docs/reference/kubectl/quick-reference/

### Connect with Container in Pod

```
kubectl exec -it <pod-name> -- /bin/bash
```
**running commands in the container**
```
kubectl exec -it <pod-name> <command>
kubectl exec -it nginx env
```

### YAML output
```
kubectl get pod nginx -o yaml

kubectl get svc nginx-service -o yaml
```

### delete objects
```
kubectl get all

kubectl delete svc nginx-service
kubectl delete po nginx

kubectl get all
```


