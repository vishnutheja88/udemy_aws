# AWS EKS Kubernetes MasterClass | DevOps Microservices
- Concepts: 
    DOCKER, EBS, ELB, NLB, ALB, Fargate, ECR, CloudWatch, Route53, Certificate Manager, Ingress, Autoscaling, SNS

## Kubernetes Concepts
```
Architecture
Pods
ReplicaSets
Deployments
NodePortService
ClusterIP service
External name Service
Ingress Service
Ingress SSL
Ingress and External DNS
Kubectl-imperative
Declaration with YAML
Secrets
init containers
Probes
Requests and Limits
Namespaces
Limit Ranges
Resource Quota
Storage Classes
Persistent Volumes
PVC
LoadBalancers
Annotations
Canary Deployments
HPA
VPA
Daemonsets
Fluentd for logs
ConfigMaps
```

## AWS Services

```
EKS
RDS
ELB
Fargate
SNS
ALB
NLB
Cloud Watch
SNS
Route53
```

## DEVOPS
```
    AWS Code Commit
    AWS Code Build
    AWS Code Pipeline
```

## MicroServices
```
    Service Discovery
    Distributed Tracing
    Canary Deployments
```

##  Introduction
-   Install AWS CLI
-   Create EKS Cluster and NodeGroups
-   EKS Cluster Pricing
-   Delete EKS Cluster and NodeGroup

##  Docker Fundamentals
-   

## Kubernetes Fundamentals
-   imperative 
        kubectl 
        pod
        RS
        Deployment
        Service
-   declarative
        YAML & Kubectl
        Pod
        RS
        Deployment
        Services
## EKS STORAGE: EBS CSI DRIVERS

##  AWS RDS DATABASES

##  AWS EKS Network Design with EKS workload & RDS Database

##  AWS ESK Network Design with EKS Workload RDS & ELB Network Load balancer

##  AWS EKS Network Design with EKS workload RDS & ELB Application Load Balancer & Route53 , Ingress & ExternalDNS

##  EKS deployment OPtion - Mixed mode - 3 Apps

##  EKS vs ECS

##  Stages in Release Process

##  AWS Developer tools or code services

##  Microservices

##  Microservices Deployment on AWS EKS (UMS ingress service, UMS node port service, MySQL external Name service, Notification: ClusterIP Service, SMTP: External Name Service)

##  kubernetes Daemonsets (X-Ray ClusterIP Services) - Service Map

##  X-Ray Traces on Microservices

##  Microservice- Canary Deployment

##  HPA / VPA / Cluster AutoScaler

##  FluentD daemonSet (Cluster logs)

**github repo**: 
```
https://github.com/stacksimplify/aws-eks-kubernetes-masterclass
https://github.com/stacksimplify/docker-fundamentals
https://github.com/stacksimplify/kubernetes-fundamentals
```
 

## JOB
- intitue
- Redhat
- Cisco
- Wiz.io
- Paloalto networks

### AWS Trends 2025
* Generative AI (sagemaker)
* Serverless and Edge Computing (Lambda)
* AI driven cloud management (predicting potential issues, workload optimization, enhance security)
* DevOps, Cloud Computing, Cybersecurity, Generative AI, Artificial Intelligence

### Data Engineer
* Amazon Athena (apache hudi, iceberg: parque  files): sonwflake, databricks(opentable format)
* Real Time Data Streaming (kafka, flink, )
* Data Orchestration, workflow management (mage-ai, prefectH, daster-io, apache airflow: opensource)- using apache spark or python can transform data form source db to destination db.
* Integration LLMs into DataProduct: 

* Apache kafka, AWS lambda, AWS Glue, Spark create using **Terraform or Ansible**.


## Need to Complete
- [x]  fluentd
- [x]  argocd
- [x]  cilium
- [x]  coreDNS
- [x]  Open Policy Agent (OPA)
- [x]  Vitess (database)
- [x]  Dragonfly
- [x]  Thanos (monitoring)
- [x]  OpenTelemetry

- [x]  cloudzero - cost analysis 
- [x]  kubecost    -   cost across multiple cloud providers
- [x]  Loft Labs   -   cost monitoring with auto-stopping
- [x]  Helm        -   Command line tools
- [x]  kubens/kubectx -   quickly switch between cluster and namespaces 
- [x]  stern       -   specify pod id and container id 
- [x]  K9s         -   navigating, observing and managing deployed apps easier
- [x]  Ansible kubespray - integrates with Ansible playbook, provisioning tool, inventory and domain management. 
- [x]  Kops        -   Installation, upgrades, and manage k8s cluster
- [x]  Contour     -   High performance ingress controller
- [x]  Gloo Mesh   -   Istio based K8s service mesh
- [x]  Calico*     -   K8s Networking and Security Tool
- [x]  longhorn    -   Distributed block storage
- [x]  Velero      -   Backup and migrate PV for k8s
- [x]  Akamai Linode (Kubernetes Cluster) less price and less time to deploy compare with any other k8s cloud providers


-    Networking: TCP/IP, DNS, HTTP/S, VPN, Load Balancers, Firewalls, Network Protocols, Subnetting

-    Database: SQL vs. NoSQL, ACID Properties, Scalability, Data Modeling

-    Security: Encryption, Authentication, Authorization, OWASP Top 10, Security Policies, Risk Assessment, Compliance Standards (like GDPR, HIPAA).

-    Storage: Block Storage, Object Storage, File Storage, NAS, SAN, SSD vs. HDD.

-    DR: Backup and Restore, Pilot Light, Warm Standby, Multi-site, RTO (Recovery Time Objective), RPO (Recovery Point Objective).
    
-    Data Replication: Master-Slave, Peer-to-Peer, Synchronous vs. Asynchronous, Data Consistency, Replication Topologies, Log Shipping.

-    Cache: In-memory Caches (Redis, Memcached), CDN, Cache Invalidation, Write-through vs. Write-back Cache, Cache Hit Ratio.

