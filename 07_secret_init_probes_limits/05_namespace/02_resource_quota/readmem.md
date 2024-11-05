# Resource Quota

- how you define the resource quota per namespace.
- A namespace the resources present in inside this namespace, the containers or the pods running inside namespace can't use more than whatever is defined CPU, Memory. 
- same way you can even define other service like pods, services, configmaps, other objects.we can define in such a way that we can have only five ports running in this namespace.

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ns-resource-quota
  namespace: dev
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
    pods: "5"
    configmaps: "5"
    PersistentVolumeClaims: "5"
    secrets: "5"
    services: "5"
```

```
kubectl get pods -n dev
kubectl get quota -n dev
kubectl describe quota <quota-name> -n dev
```