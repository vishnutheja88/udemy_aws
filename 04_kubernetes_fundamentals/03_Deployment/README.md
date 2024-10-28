## Deployments

- Create a Deployment to rollout a Replicaset
- Updating the Deployment
- Roll back a Deployment
- Sacaling Deployment
- Pausing and Resuming a Deployments
- Deployment Status
- Clean up Policy
- Canary Deployments


### Create Deployment
```
kubectl create deployment nginx-deployment --image=nginx:1.27.0
kubectl get deploy
kubectl describe deployment nginx-deployment
kubectl get rs
kubectl get po
```
### Scaling Deployment
- scale the deployment to increase the number of replicas (pods).
```
kubectl scale --replicas=5 deployment/nginx-deployment
kubectl get deploy
kubectl get rs, po

# scale down replicas
kubectl scale --replicas=2 deployment/nginx-deployment
kubectl get deploy,rs,po
```
### Expose deployment as a Service
```
kubectl expose deployment nginx-deployment --type=NodePort --port=80 --target-port=80 --name=nginx-deploy-service
kubectl get svc
kubectl get nodes -o wide
```

## Update Deployments
- set image
- edit deployment command

### set image option
- please check conatiner name in `spce.container.name` yaml output and make a note of it and replace `kubectl set image` command conatiner-name
```
kubectl get deployment ngixn-deployment -o yaml
kubectl set image deployment/<deployment-name> <container-name>=<container-image> --record=true
kubectl set image deployment/nginx-deployment kubenginx=nginx:1.17.2 --record=true

# --record=true: version is enable for deployment

# check the rollout status of deployment
kubectl rollout status deployment/nginx-deployment
kubectl get deploy
```
- Verify the Events and understand the Kubernetes by default to `Rolling Update` for new application releases.
```
kubectl describe deployment nginx-deployment
```
### RollOut history of Deployment
- we have rollout history, so we can switch back to older versions using revision history available to us.
```
kubectl rollout history deployment/nginx-deployment 
```

### EDIT command
```
kubectl edit deployment <deployment-name>
kubectl edit deploy nginx-deployment
```
```yml
# Change From 1.27.2
    spec:
      containers:
      - image: nginx:1.27.2

# Change To 1.27.3
    spec:
      containers:
      - image: nginx:1.27.2
```

## Rollback Application to Previous Version
- we can rollback application two types
    - previous version
    - specific version

### previous version
```
# check the deployment history
kubectl rollout history deployment/nginx-deployment

# changes in the version
kubectl rollout history deployment/nginx-deployment --revision=1

# rollback to previous version
kubectl rollout undo deployment/nginx-deployment 
kubectl rollout history deployment/nginx-deployment
```
### rollback to specific version
```
kubectl rollout undo deployment/nginx-deployment --to-revision=1
kubectl rollout history deployment/nginx-deployment
```

## Pause & Resume Deployments
- if we want to make multiple changes to our deployment, we can pause the deployment make all changes and resume it.
- we are going to update our application version from v2 to v3 as part  of example.

