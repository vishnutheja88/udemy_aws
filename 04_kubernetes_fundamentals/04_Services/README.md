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





![Image](images/image.png)