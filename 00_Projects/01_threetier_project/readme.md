Youtube Channel: DevOps Shark

Video: The ultimate CICD Corporate DevOps pipeline project | Real time devops project

syntax based errors --> unit test cases (functionality) --> sonar-qube (code quality, bug issue, code smells, vulnerability inside the source code) --> Trivy (any sensitive data or dependencies out dated) --> build the application (mvn) --> publish nexus repo --> build the docker image and tagging --> trivy (scan docker image vulnerability in docker ) --> docker repo --> k8s (kube audit) --> deploy (k8s) --> verify --> mail notification --> monitor the application (grafana) -->  black box exporter 

Phase1: Network environment: private, isolated, secure
        k8s cluster : deploy our application, scan tool
        VMs (EC2) : sonar-qube, nexus, jenkins, monitoring tools (grafana, prometheus)

Phase2: git repository (private)
        push our code source code
        Visible repository

Phase3: CI/CD pipeline
        best practices
        security measures
        configure mail notification

Phase4: Monitoring App (system level app,ram: website level -> traffic)