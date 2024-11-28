# ServiceMesh

## what is servicemesh?
- Dedicated infrstructure layer for facilitating service-to-service communications, optimize, fast, reliable and secure.
- **Configuratble**, low-latency infrstructure layer designed to handle a **high volume of network-based interposes** communication along applicaiton infrstructure service.
- The servicemesh usually implemented by providing a proxy instance, called a **sidecar**, for a each service instance.
- **Sidecars** handle interservice communications, monitoring, and security-related concerns- indeed, anything that can be abstracted awsay from the individual service.

- **ServiceDiscovery and LoadBalacing**
- **Intelligent Routing** decission to multiple services
- **Encryption** between service to service
- See services diagram and manage services.
- Monitor and Traces traffic between services.
- **Quickley Identify Issues** when mulitple NS and SVC's in cluster
- **Authuentication and Authorization** between services.
- Resiliency by adding policies
- Service Mesh is solutions, it **reside outside** of the application using Proxy pod
- By adding **Transparent Proxies** for Fault Tolerant Distributed Architectures.

### SideCar Container
- Extend the main container functionality without any impact
[sidecar imag](/images/sidecar.png)

