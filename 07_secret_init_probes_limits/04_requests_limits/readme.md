# Requests and Limits

*   We can specify how much each container Pod need the resources like CPU and Memory. When we provide this information in our Pod, the scheduler uses this information to decide which node to place the Pod on.
*   When you specify a resource limit for a Container, the kubelet enforce those **limits** so that the running container is not allowed to use more of that resources than the limit you set.
*   The kubelet also reserves at least the **request** amount of that system resources specifically for that container to use.

## Request and Limits in Manifest file

```yaml
    resources:
      requests:
        memory: "128Mi" # 128Mb is equal to 135 Mb
        cpu: "500m" # m means milliCPU
      limits:
        memory: "500Mi"
        cpu: "1000m"    # 1000m is equal to 1vCPU core
```
```
# check the node details
kubectl describe node <node-id/node-name>

```

