## ReplicaSet

### create ReplicaSet 

replicaset.yaml

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata: 
  name: rs-nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    matadata:
      name: nginx-pod
      labels: 
        app: nginx
    spec: 
      containers:
        - name: nginx-container
          image: nginx:1.27.0
          ports:
            - containerPort: 80
```
```
kubectl apply -f replicaset.yaml
kubectl get rs
kubectl get po
```
### Create Service for ReplicaSet Pods

service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: rs-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - name: http
      port: 80
      targetPort: 80
      nodePort: 31999
```

```
kubectl apply -f service.yaml
kubectl get svc
```