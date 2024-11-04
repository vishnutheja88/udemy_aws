# Probes
- liveness probe
- readiness probe
- startup probe

## Liveness Probe
-   Kubelet uses liveness probes to know when to  restart a container
-   livenss probe cloud catch a **deadlock** where an application is running, but unable to make progress and **restarting conatiner** help in such state.
-   check using commands : /bin/sh -c nx -z localhost 8095
-   check using HTTP GET Request: httpget path:/health-status
-   check using TPC: tcpsocket port:8095

## Readiness Probe
-   Kubelet uses readiness probes to know when a container is **ready to accept the traffic**.
-   when a pod is not ready, it is **removed** from Service load balancer based on this **readiness probe signal**.
-   check using commands : /bin/sh -c nx -z localhost 8095
-   check using HTTP GET Request: httpget path:/health-status
-   check using TPC: tcpsocket port:8095

## Startup Probe
-   kubelet uses startup probes to know when **a container application has started**. First this probe **disables** liveness & readiness checks until it **success** ensuring those pods doesn't interface with app startup.
-   this can be used to adopt liveness checks on **slow starting containers**, avoiding them getting killed by the kubelet before they are up and running.

