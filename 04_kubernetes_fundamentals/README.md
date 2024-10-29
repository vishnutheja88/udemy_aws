# Kubernetes Fundamentals

## kubernetes Architecture
-   kubernetes is portable, extensible, open-source platform for managing containerized workloads.
-   Out of the box features
    -   service discovery and load balancing
    -   storage orchestration
    -   Automated rollouts and rollbacks
    -   Automatic bin packing
    -   Self-healing
    -   Secrets and configuration Management

## Kubernetes Architecture

### kube-apiserver

-   its acts as front-end for the kubernetes control plane. It exposes the kubernetes API
-   CLI tools (like kubectl), Users and even Master components (like scheduler, controller, ETCD) and Worker node components like kubelet, every thing talk with API Server.

### ETCD

-   Consistent and highly-available key value store used as Kubernetes backing store for all cluster data.
-   It stores all the masters and worker node information.

### kube-scheduler

-   Scheduler is responsible for distributed containers across multiple nodes
-   It watches for newly created Pods with no assigned node, and selects a node for them to run on.

### kube controller manager
-   controller are responsible for noticing and responding when nodes, containers or endpoints go down. They make decision to bring up new containers in such cases.
    -   Node Controller: responsible for noticing and responding when nodes goes down.
    -   Replication Controller: Responsible for maintaining the correct number of pods for every replication controller object in the system.
    -   Endpoint Controller: Populates the Endpoints objects (that is, joins Services & Pods)
    -   Service Accounts & Token Controller: Creates default accounts and API Access for new namespaces. 

### Cloud Controller Manager:
-   A kubernetes control plane component that embeds cloud-specific control logic
-   It only runs controllers that are specific to your cloud provider.
-   On-Premise Kubernetes cluster will not have this components.
-   Node Controller: For checking the cloud provider to determine if a node has been deleted in the cloud after it stops responding.
-   Route Controller: For setting up routes in the underlying cloud infrastructure.
-   Service Controller: For creating, updating and deleting cloud provider load balancer.

### Fargate Controller Manager (EKS):
    

##  Worker Node Components
### Container Runtime Environment
-   Container runtime is the underlying software where we run all these Kubernetes components.
-   We are using Docker, but we have other runtime options like rkt, container-d etc..

### Kubelet
-   Kubelet is the agent that runs on every node in the cluster.
-   This agent is responsible for making sure that container are running in a Pod on a Node.

### Kube-Proxy
-   It is a Network proxy that runs on each node in your cluster.
-   It maintains network rules on Nodes.
-   In short, these network rules allow network communication to your Pods from network sessions inside or outside of your cluster.

--------------------------------------------------------------------------------------------------------------------------------
-   EKS lest us focus only on Application Workloads
-   We don't need to worry about any of these components like (controller, scheduler, etcd, container runtime environment, API Server)

## Introduction Fundamentals: (Pods, ReplicaSet, Deployment, Service)
-   Pod
    -   A Pod is a single instance of an Application.
    -   A Pod is the smallest object, that you can create in Kubernetes.

-   ReplicaSet:
    -   A replicaset will maintain a stable set of replicas Pods running at any given time.
    -   In short, it is often used to guarantee the availability of a specific number of identical pods.

-   Deployment:
    -   Deployment runs multiple replicas of your application and automatically replaces any instances that fail or become unresponsive.
    -   Rollout & Rollback changes to applications. Deployments are well-suited for stateless applications.

-   Service:
    -   A service is an abstraction for Pods, providing a stable, so called virtual (VIP) address.
    -   In simple term, service sits in front of a Pod and acts a load balancer.

```
https://github.com/stacksimplify/kubernetes-fundamentals
```

## PODS
-   With Kubernetes our core goal will be to deploy our application in the form of containers on worker nodes in a K8s Cluster.
-   Kubernetes does not deploy containers directly on the worker nodes.
-   Container is encapsulated in to a Kubernetes object names POD.
-   A POD is single instance of an application.
-   A POD is the smallest object that we can create in Kubernetes.

-   PODs generally have one to one relationship with containers.
-   To scale up we create new POD and to scale down we delete the POD.
-   we can't have multiple containers of same kind in a single POD.
-   Example: Two NGINX containers in single POD serving same purpose is not recommended.

    ### Multi-Container Pods
    -   We can have multiple containers in a single POD, provided they are not of same kind (Nginx pod, Helper container).
    -   Helper Container (side-Cars):
        -   Data Pullers: Pull data required by Main Container.
        -   Data pushers: Push data by collecting from main container (logs).
        -   Proxies: Writes static data to html files using Helper container and Reads using Main Container.
    -   Communication
        -   The two containers can easily communicate with each other easily they share same network space.
        -   They can also easily share same storage space.
    -   Multi-Container Pods is a rare-case and we will try to focus on core fundamentals.

## docker hub
```
https://github.com/stacksimplify/docker-hub-to-github-container-registry
```
