## POD with YAML

-   **Pod API Object Reference** https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#pod-v1-core

```yaml
apiVersion: v1 # string
kind: Pod # string
metadata: # Dictionary
  name: nginx
  labels: # Dictionary
    app: nginx
spec: # 
  containers: #list
    - name: myapp
      image: nginx:1.27.0
      resources:
        limits:
          memory: "128Mi"
          cpu: "500m"
      ports: # list
        - containerPort: 80
```

```
# create a pod with defination file
kubectl create -f pod.yaml
kubectl get pods
```

### Create NodePort service for Pod
service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service # Name of the Service
spec:
  type: NodePort 
  selector: # traffic accross the pods matching this label selector
    app: nginx
  ports: # acceping the traffic sent to port 80
    - name: http
      port: 80  # service port
      targetPort: 80 # container port
      nodePort: 30999 # Node port
```