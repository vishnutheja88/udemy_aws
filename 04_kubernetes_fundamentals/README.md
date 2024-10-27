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
        -   

### Cloud Controller Manager:
    -   A kubernetes control plane component that embeds cloud-specific control logic
    -   It only runs controllers that are specific to your cloud provider.
    -   On-Premise Kubernetes cluster will not have this components.
    -   Node Controller: For checking the cloud provider to determine if a node has been deleted in the cloud after it stops responding.
    -   Route Controller: For setting up routes in the underlying cloud infrastructure.
    -   Service Controller: For creating, updating and deleting cloud provider load balancer.

### Fargate Controller Manager (EKS):
    -   

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
-   Pod:
    -   A Pod is a single instance of an Application.
    -   A Pod is the smallest object, that you can create in Kubernetes.

-   ReplicaSet:
    -   

-   Deployment:
    -
       
-   Service:
    -   