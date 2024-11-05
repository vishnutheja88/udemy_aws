# Namespace

-   Namespace also called **virtual Clusters** in our physical K8s cluster. We use this in environment where we have **many users spread** across multiple teams or projects.
-   Cluster with ten of users ideally don't need to use namespaces. 
-   Benefits
    - Creates isolated boundary from other k8s objects
    - we can limit the resources like CPU, memory on per namespace bias (resource quota).


```
# 
kubectl get namespace
kubectl get ns
kubens

# get all objects in kube-system namespace
kubectl get all -n kube-system
```

## create namespaces (imperative way)
```
kubectl create ns qa
kubectl create ns dev
kubectl create ns staging
```

## Declarative way 
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: dev/qa/staging
```