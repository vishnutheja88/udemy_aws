Security Group:
    port open: 25(smtp), 22, 3000-10000(applications), 80, 443, 6443, 465,30000-32767, 465(mail-notification) --> 0.0.0.0/0
    sg name: primary

create 3 vms in ec2 as ubuntu (4gb ram) --> select primary-sg
    name:   master-node
            slave1
            slave2

## master-node | slave1 | slave2 :
```sh
    sudo apt-get update
    sudo apt install docker.io -y
    sudo apt-get install -y apt-transport-https ca-certificates curl gpg
    curl -fsSL https://pkgs.k8s.io/core:/stable/:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/source.list.d/kubernetes.list
    sudo apt update

    sudo apt install -y kubeadm-1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1
    
    -**MasterNode**-
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16
    -- it provide command to join the slaves, need to run using sudo user....
    -- kubeadm join <masternode ip>:6443 --token <token> --discovery-token-ca-cert-has <hash value>

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.config $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    kubectl apply -f https://docs.projectcalico.org/v3.20/manifests/calico.yaml
    kubectl apply -f https://raws.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml

    kubectl get nodes
    kubectl get ns

    ## Scanning the kubernetes cluster to find any issues 
    https://github.com/Shopify/kubeaudit/releases
    wget <link>
    tar -xvzf kubeaudit_linux_amd64.tar.gz
    sudo mv kubeaudit /usr/local/bin/
    kubeaudit all


# Phase 2: (VMs Jenkins, Sonar, Nexus, Monitoring)

- configure two ec2 instance with t2.micro (nexus, sonarqube)
- another ec2 instance for t2.large for Jenkins 30GB volume

## SonarQube | Nexus
```sh
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo chmod 666 /var/run/docker.sock
    docker pull hello-world

    # run sonarqube
    docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
    docker ps
    # default username and password --> admin/admin


    # nexus run on nexus ec2
    docker run -d --name nexus -p 8081:8081 sonartype/nexus3
    docker ps
    # username: admin
    # password: docker exec -it <containerid> /bin/bash
    # cat sonartype-work/nexus3/admin.password



- Configure Jenkins server
## Jenkins
```sh
    apt-get update
    sudo apt install openjdk-17-jre-headless -y
    sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins

    # install docker on jenkins server
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo chmod 666 /var/run/docker.sock
    docker pull hello-world


    







