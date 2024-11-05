# Namespace Limits

## create namespaces
```
kubectl create ns dev1
kubectl create ns dev2
kubectl get ns
```

- deploy the manifest files into the two dev1 and dev2 namespaces.
    - whenever you create with same manifest multiple environments like dev1, dev2 with namespaces, we cannot have same worker nodeport for multiple service.
    -   we will have port conflict. Its good for K8s system to provide dynamics NodePort for such scenario.

    ```
    # 07_usermanagement_service.yaml
        #nodePort: 31244 comment the line
    ```

``` 
# deploy manifest file into dev1 namespace
kubectl apply -f k8s_manifests/ -n dev1

# verify dev1 objects
kubectl get all -n dev1

# deploy manifest files into dev2 namespace
kubectl apply -f k8s_manifests/ -n dev2

# verify dev2 objects
kubectl get all -n dev2
```

# Limits
```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: default-cpu-mem-limit-range
  namespace: dev1
spec:
  limits:
    - default:
        memory: "512Mi"
        cpu: "500m"
      defaultRequest:
        memory: "256Mi"
        cpu: "300m"
      type: Container
```
 
```
# check the containers, using  describe command (mysql pods)
kubectl get limits -n dev

kubectl describe limits <limit-name> -n dev

# delete all the objects
kubectl delete -f k8s-manifests/
```