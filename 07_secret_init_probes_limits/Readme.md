# Secrets, Init Container, Liveness Probe, Request and limits 

-   Secretes
-   init Containers
-   Liveness and Readiness Probes
-   Requests and Limits of Pods & NameSpaces


## Secrets
-   Secrets are store and manage sensitive information, such as Passwords, OAuth tokens and SSH-Keys.
-   Storing confidential information in a Secret is safer and more flexible than putting it directly in a Pod defination or in a Container.

```
# encoding bast64 with command
echo -n 'dbpassword1' | base 64
ZGJwYXNzd29yZDEK
# url: https://www.base64encode.org
```

### K8s Secrete Manifest file
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-db-password
type: Opaque
data:
  db-password: ZGJwYXNzd29yZDEK

```

