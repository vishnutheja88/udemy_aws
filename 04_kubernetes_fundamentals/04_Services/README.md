## Services
-   ClusterIP
-   NodePort
-   LoadBalancer
-   Ingress
-   externalName

### ClusterIP
-   used for communication between applications inside k8s cluster (ex: frontend application accessing backend application)

## NodePort
-   Used for accessing application outside of K8s cluster using Worker NodePort. (accessing front end application from browser)

## LoadBalancer
-   Primarily for Cloud Providers to integrate with their Load Balancer Service (Ex: AWS ELB)

## Ingress
-   Ingress is an advanced load balancer which provide Context path based routing, SSL, SSL Redirect and many more (AWS ELB)

## ExternalName
-   To access external hosted apps in K8s Cluster (Ex: Access AWS RDS Database endpoint by application present inside K8s Cluster)


### Example Application

![Image](https://github.com/vishnutheja88/udemy_aws/blob/mac_air/images/image.png)

## BackEnd Application Setup
```
kubectl create deployment backend-rest-app --image=stacksimplify/kube-helloworld:1.0.0
kubectl expose deployment backend-rest-app --port=8080 --target-port=8080 --name=backend-service
kubectl get svc
```
- **Backend HelloWorld Application Source** [kube-helloworld](Docker-Images/backend)

## Frontend Application Setup Using NodePort
**Nginx.conf**
```yaml
server {
    listen      80;
    server_name localhost;
    location / {
    proxy_pass  http://backend-service:8080;
    }
    error_page  500 502 503 504 /50x.html;
    location =  /50x.html {
        root    /usr/share/nginx/html;
    }
}
```
```
kubectl create deployment frontend-nginx-app --image=stacksimplify/kube-frontend-nginx:1.0.0
kubectl expose deployment frontend-nginx-app --type=NodePort --port=80 --target-port=8080 --name=frontend-service
kubectl get svc -o wide
kubectl get nodes -o wide
```

- **Frontend Nginx Reverse Proxy Application Source** [kube-frontend-nginx](Docker-Images/frontend-nginx)

