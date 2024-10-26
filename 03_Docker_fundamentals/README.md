# DOCKER FUNDAMENTALS
-   why continers?
    flexible: Event the most complex application can be containrized
    light weight: Container leverage and share the host kernel, making them much more efficient in term of system resource than virtual machines
    portable: you can build, deploy to the cloud, and run anywhere
    loosely coupled: containers are highly self suffiecient and encapasulated, allowing you to replace or upgrade one without disrupting others.
    scalable: you can increase and automatically distribute container replicas across a datacenter


## Docker
-   Docker Daemon
    dockerd listens for Docker API requests and manages Docker objects such as images, containers, networks and volumes

-   Docker Client
    Docker client can be present on either Docker Host or any other machine
    Docker client is the primary way that may Docker user interact with Docker
    when you use the commands such as $docker run, the client sends these commands to dockerd which carries them out
    the docker command use the Docker API
    The docker client can communicate with more than one demand.

-   Docker images
    an image is read-only template that instructions for creating a Docker container
    Often an image is based on another image, with some additional customizations.
    for example: we may build an image which is based on the ubuntu, but installs the Apache web server and our application, as well as the configuration details to make our application run.

-   Docker Containers
    A container is runnable instance of an image
    we can create, start, stop, move or delete a container using the Docker API or CLI
    we can connect a container to one or more networks, attach storage to it, or even create a new image based on its current state.
    when a container is removed any changes to it state that are not stored in persistent storage disappear.

-   Docker Registry or Docker Hub
    A docker registry stores Docker images
    Docker hub is a public registry that anyone can use, and Docker is configured to look for images on Docker Hub by default.
    we can even run our own private registry
    when we use the docker pull or docker run commands the required images are pulled from our configured registry.
    when we use the docker push commnd, our image is pushed to our configured registry.

## docker commands
```
    docker version
    docker login
    docker pull <repo/imagename>
    docker images
    docker run --name <app1> -p 80(localport):8080(containerport) -d <docker-image>:<tag>
    docker ps
    docker ps -a
    docker ps -a -q
    # connect to container terminal
    docker exec -it <container-name> /bin/sh

    docker stop <container-name>
    docker start <container-name>

    docker rm <container-name>

    docker rmi <image-id>
    docker login -u username -p password
    dcoker status
    docker top <container-id>
    docker version
    docker rm <container-id/name>
    docker rm -f <container-id/name>
    docker restart container-id
```

## Build docker image and push to registry

```
# build docker image & run it
docker build -t <docker-hub-id>/mynginx:v1 .
docker images
docker push <docker-hub-id>/mynginx:v1 
```

