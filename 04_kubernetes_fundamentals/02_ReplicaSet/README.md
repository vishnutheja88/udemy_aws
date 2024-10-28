## ReplicaSet
-   High Availability or Reliability
-   Load Balancing
-   Scaling of pods
-   lables and Selectors

- ReplicaSet purpose is to maintain stable set of replica Pods running at any given time.
- **reliability** If your application crashes (any pod die) replicaset will recreate the pod immediately to ensure the configured number of pods running at any given time.
- **loadbalancing** To avoid overloading of traffic to single pod we can use load balancing. Kubernetes provides Pod Load balancing out of the box using **Services** for the pods which are part of a ReplicaSet.
- **Lables&Seclectors** are the together which ties all pods together, we will know in details when we writing YAML manifest for these objects.
- **Scaling** when load become too much for the number of existing Pods, Kubernetes enables us to easily scale up our application, adding additional pods as needed. This is going to be seemless and super quick.


### Create ReplicaSet
```
kubectl create -f rs.yaml
```
**rs.yaml**
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: hello-world-rs
  labels:
    app: hello-world-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hello-world-rs
  template:
    metadata:
      lables:
        app: hello-world-rs
    spec:
      containers:
      - name: hello-world-rs
        image: stacksimplify/kube-helloworld:1.0.0
```
### list replicaset
```
kubectl get rs

# describe replicaset
kubectl describe rs hello-world-rs

kubectl get rs -o wide
```
### find the owner of the Pod
```
kubectl get rs hello-world-rs -o yaml 
# find the ownerReferences:
```
## Expose ReplicaSet as a Service
- Expose ReplicaSet with service (NodePort) to access the application externally 
```
kubectl expose rs hello-world-rs --type=NodePort --port=80 --target-port=8080 --name=hello-world-service
kubectl get svc
kubectl get nodes -o wide
```

### delete all the objects
```
kubectl delete rs hello-world-rs
kubectl delete svc hello-world-service
kubectl get all
```




