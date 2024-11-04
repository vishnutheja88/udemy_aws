# Init Containers
-   init containers run before application app container. Init container can contain utilities or setup scripts not present in an app image.
-   we can have and run multiple init contianers before App Container.
-   Init containers are exactly like regualr containers. except:
    -   init containers always run to completion.
    -   each init container must complete successfully before next one start
-   If a pod init container fails kubernetes repeatedly restart the pod until the init container succeeds.
-   However, if the pod has a **restartPolicy of Never**, kubernetes does not restart the pod.

## Init Container Manifest
* Update the Deployement defination file **initContainer** section under Pod Template spce which is spec.template.spec in Deployment

```yaml
spec:
  template:
    spec:
      initContainer:
        - name: init-db
          image: busybox:1.37
          command: ['sh', '-c', 'echo -e "checking for availability of MySQL server deployment"; while ! ns -z mysql 3306; do sleep 1; printf "-"; done; echo -e " >> MySQL DB server has started";']
```

```
# list of pods
kubectl get pods

# watch the pods status
kubectl get pods -w

# describe the pods
kubectl describe pod <pod-name/pod-id>

# access application health status page
http://<node-ip>:31244/usermgmt/health-status
```

