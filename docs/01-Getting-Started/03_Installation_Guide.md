# Installation Guide

> **Enterprise DevSecOps CI/CD Pipeline – Installation and Configuration Guide**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Installation Guide |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, DevSecOps Engineers, Platform Engineers, Cloud Engineers, Students |
| Maintainer | Muralidhar G |

---

# Purpose

This document provides detailed, step-by-step instructions for installing, configuring, and validating the Enterprise DevSecOps CI/CD Pipeline.

The guide is designed to help readers build a fully functional local DevSecOps platform capable of:

- Building Java applications
- Performing automated code quality analysis
- Executing security scans
- Managing application artifacts
- Building Docker images
- Deploying applications to Kubernetes
- Managing releases using Helm
- Verifying successful deployments

Following this guide will result in a complete enterprise-grade CI/CD environment suitable for learning, experimentation, and portfolio demonstrations.

---

# Installation Overview

The installation process is divided into several logical phases.

Each phase builds upon the previous one to ensure a smooth and reproducible deployment experience.

The installation consists of:

1. Development Environment Setup
2. Container Platform Installation
3. Kubernetes Cluster Configuration
4. Infrastructure Service Configuration
5. CI/CD Pipeline Configuration
6. Application Deployment
7. Deployment Verification

Completing each phase successfully ensures the platform is ready for the next stage.

---

# Supported Platforms

The installation steps in this guide have been validated on the following operating systems.

| Platform | Status |
|----------|--------|
| Ubuntu 24.04 LTS | ✅ Recommended |
| Ubuntu 22.04 LTS | ✅ Supported |
| Windows 11 with WSL2 | ✅ Recommended |
| macOS | ⚠ Supported with minor adjustments |
| Rocky Linux | ⚠ Compatible |
| Red Hat Enterprise Linux | ⚠ Compatible |

Although commands are demonstrated using Ubuntu and WSL2, the overall installation process is portable across most Linux-based environments.

---

# Installation Architecture

The following diagram illustrates the relationship between the major components installed during this guide.

```text
                    Developer
                        │
                        ▼
                  GitHub Repository
                        │
                        ▼
                    Jenkins Pipeline
                        │
        ┌───────────────┼────────────────┐
        │               │                │
        ▼               ▼                ▼
    Maven Build     SonarQube      OWASP Dependency Check
        │
        ▼
  Publish Artifact
        │
        ▼
 Nexus Repository
        │
        ▼
 Docker Image Build
        │
        ▼
 Trivy Security Scan
        │
        ▼
 Docker Registry
        │
        ▼
 Kubernetes Cluster (Kind)
        │
        ▼
      Helm Release
        │
        ▼
 Application Deployment
```

This architecture demonstrates the complete software delivery workflow from source code to Kubernetes deployment.

---

# Installation Workflow

The installation follows a structured sequence to minimize configuration issues.

```text
Prepare Environment
        │
        ▼
Clone Repository
        │
        ▼
Install Development Tools
        │
        ▼
Install Docker
        │
        ▼
Create Kubernetes Cluster
        │
        ▼
Install Helm
        │
        ▼
Configure Jenkins
        │
        ▼
Configure SonarQube
        │
        ▼
Configure Nexus Repository
        │
        ▼
Configure Trivy
        │
        ▼
Execute Jenkins Pipeline
        │
        ▼
Deploy Application
        │
        ▼
Verify Deployment
```

Following this sequence ensures that all dependencies are available before they are required.

---

# Installation Sequence

The complete installation consists of the following stages.

| Phase | Description |
|--------|-------------|
| Phase 1 | Clone the repository |
| Phase 2 | Configure the development environment |
| Phase 3 | Install Docker and container tools |
| Phase 4 | Configure the Kubernetes cluster |
| Phase 5 | Install supporting infrastructure services |
| Phase 6 | Configure Jenkins Pipeline |
| Phase 7 | Build and deploy the application |
| Phase 8 | Validate the deployment |

Each phase concludes with verification steps to confirm successful configuration before moving forward.

---

# Before You Begin

Before continuing, ensure that you have completed all tasks described in the **Prerequisites** document.

Verify that:

- Java 17 is installed.
- Maven is installed.
- Git is installed.
- Docker Engine is operational.
- Docker Compose is available.
- kubectl is installed.
- Kind is installed.
- Helm is installed.
- Trivy is installed.
- Internet connectivity is available.
- Hardware resources meet the recommended specifications.

If any prerequisite has not been completed, return to the **Prerequisites** guide before proceeding.

---

# Estimated Installation Time

The time required to complete the installation depends on internet speed and system performance.

| Activity | Estimated Time |
|----------|---------------:|
| Development Environment Setup | 15–20 Minutes |
| Docker & Kubernetes Installation | 20–30 Minutes |
| Infrastructure Services | 30–45 Minutes |
| Jenkins Configuration | 15–20 Minutes |
| Pipeline Configuration | 20–30 Minutes |
| Application Deployment | 10–15 Minutes |
| Verification | 10 Minutes |

**Total Estimated Time:** **2–3 Hours**

The initial setup may take longer due to downloading Docker images, Maven dependencies, and Jenkins plugins.

---

# Expected Outcome

After completing this guide, your environment will include:

- GitHub repository configured
- Java development environment
- Maven build environment
- Docker Engine
- Kubernetes cluster (Kind)
- Helm package manager
- Jenkins automation server
- SonarQube code quality platform
- Nexus Repository Manager
- Trivy vulnerability scanner
- Complete Jenkins CI/CD Pipeline
- Kubernetes-deployed sample application

This fully integrated environment mirrors the architecture used by many enterprise DevSecOps teams.

---

# Related Documentation

Before continuing, review the following documents if you have not already done so.

## Getting Started

- [Project Overview](01_Project_Overview.md)
- [Prerequisites](02_Prerequisites.md)

These documents provide the architectural context and environment preparation required for a successful installation.

---

# Next Section

The next section walks through the complete development environment setup, including repository cloning, Java configuration, Maven verification, Git setup, and project validation before installing the remaining platform components.

---

# Development Environment Setup

This section prepares the local development environment required to build, test, and deploy the Enterprise DevSecOps CI/CD Pipeline.

At the end of this section, you will have:

- Repository cloned locally
- Git configured
- Java installed and verified
- Maven installed and verified
- Environment variables configured
- Development workspace validated

---

# Step 1 – Clone the Repository

Clone the project from GitHub.

```bash
git clone https://github.com/muralidhargurram39/automation-deployment-project.git

cd automation-deployment-project
```

Verify the repository was cloned successfully.

```bash
pwd

ls -la
```

Expected output:

```
README.md
docs/
application/
docker/
helm/
scripts/
Jenkinsfile
docker-compose.yml
...
```

---

# Step 2 – Configure Git

Verify Git is installed.

```bash
git --version
```

Example:

```
git version 2.49.x
```

Configure your Git identity.

```bash
git config --global user.name "Your Name"

git config --global user.email "your-email@example.com"
```

Verify the configuration.

```bash
git config --list
```

Expected output should include:

```
user.name=Your Name

user.email=your-email@example.com
```

---

# Step 3 – Verify Java Installation

Confirm that Java 17 is installed.

```bash
java -version
```

Example:

```
openjdk version "17.x.x"
```

Verify the Java compiler.

```bash
javac -version
```

Example:

```
javac 17.x.x
```

---

# Step 4 – Configure JAVA_HOME

Determine the Java installation directory.

```bash
readlink -f $(which java)
```

Example:

```
/usr/lib/jvm/java-17-openjdk-amd64/bin/java
```

Configure the environment variable.

```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

export PATH=$JAVA_HOME/bin:$PATH
```

Persist the configuration.

```bash
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64' >> ~/.bashrc

echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

source ~/.bashrc
```

Verify.

```bash
echo $JAVA_HOME
```

---

# Step 5 – Verify Maven Installation

Confirm Maven is installed.

```bash
mvn -version
```

Example output:

```
Apache Maven 3.9.x

Java version: 17

Maven home: ...
```

If Maven reports the correct Java version, the Java environment has been configured successfully.

---

# Step 6 – Verify Project Build

Perform a clean build to ensure the development environment is functioning correctly.

```bash
mvn clean package
```

Maven performs the following operations:

- Downloads project dependencies
- Compiles source code
- Executes unit tests
- Packages the application
- Produces the WAR artifact

Expected result:

```
BUILD SUCCESS
```

---

# Step 7 – Verify Generated Artifact

After the build completes, verify the generated artifact.

```bash
ls -lh target/
```

Example:

```
application.war
```

The WAR file will later be published to Nexus Repository during the Jenkins Pipeline.

---

# Step 8 – Review Repository Structure

Verify that the repository contains the expected directories.

```bash
tree -L 2
```

Expected structure:

```text
automation-deployment-project/

├── application/
├── docker/
├── helm/
├── kubernetes/
├── scripts/
├── docs/
├── images/
├── Jenkinsfile
├── docker-compose.yml
└── README.md
```

The exact directory names may vary slightly as the project evolves, but the overall organization should remain consistent.

---

# Step 9 – Verify Required Commands

Confirm that all essential development tools are available.

```bash
java -version

javac -version

mvn -version

git --version
```

All commands should execute successfully without errors.

---

# Development Environment Validation

Verify the following before continuing.

| Validation | Status |
|------------|--------|
| Repository Cloned | ☐ |
| Git Configured | ☐ |
| Java Installed | ☐ |
| JAVA_HOME Configured | ☐ |
| Maven Installed | ☐ |
| Maven Build Successful | ☐ |
| WAR Artifact Generated | ☐ |
| Repository Structure Verified | ☐ |

Once every item has been verified, the development environment is ready for container platform installation.

---

# Best Practices

For a reliable development environment:

- Use **OpenJDK 17 LTS**.
- Keep Maven updated to a supported stable release.
- Store source code in a dedicated workspace.
- Avoid running builds as the root user unless required.
- Use SSH authentication for GitHub when possible.
- Commit changes frequently with meaningful commit messages.
- Keep local repositories synchronized with the remote repository.

Following these practices improves maintainability and aligns with enterprise development standards.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|------|----------------|------------|
| `java: command not found` | Java not installed or PATH misconfigured | Install Java and update `JAVA_HOME`/`PATH` |
| `javac: command not found` | JDK not installed | Install OpenJDK 17 |
| `mvn: command not found` | Maven missing or PATH incorrect | Install Maven and update `PATH` |
| `BUILD FAILURE` | Missing dependencies or project issue | Review Maven output and resolve the reported errors |
| Git authentication failed | Invalid credentials or SSH key | Configure a Personal Access Token (PAT) or SSH keys |

Resolve any issues before continuing with the remaining installation steps.

---

# Container Platform Setup

This section installs and configures the container platform required by the Enterprise DevSecOps CI/CD Pipeline.

At the end of this section, you will have:

- Docker Engine installed and operational
- Docker Compose available
- kubectl installed
- Kind Kubernetes cluster created
- Helm installed
- Trivy installed
- Container platform validated

---

# Container Platform Architecture

The following diagram illustrates the relationship between the container technologies used throughout the project.

```text
                Docker Engine
                      │
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
   Jenkins      SonarQube      Nexus Repository
        │
        ▼
      Kind Cluster
        │
        ▼
   Kubernetes Nodes
        │
        ▼
     Helm Charts
        │
        ▼
   Application Pods
```

Docker provides the runtime, Kind provisions the Kubernetes cluster, Helm manages releases, and Trivy performs security scanning.

---

# Step 1 – Verify Docker Installation

Confirm that Docker Engine is installed and running.

```bash
docker version
```

Expected output:

```text
Client:
 Version: xx.x.x

Server:
 Engine:
  Version: xx.x.x
```

Verify Docker information.

```bash
docker info
```

This command displays information about the Docker daemon, storage driver, available resources, and runtime configuration.

---

# Step 2 – Verify Docker Compose

Docker Compose is required to manage multi-container services during local development.

Verify the installation.

```bash
docker compose version
```

Expected output:

```text
Docker Compose version v2.x.x
```

---

# Step 3 – Validate Docker Functionality

Run the standard Docker test container.

```bash
docker run hello-world
```

Expected output:

```text
Hello from Docker!
```

This confirms that:

- Docker Engine is running.
- Images can be downloaded.
- Containers start successfully.

---

# Step 4 – Install kubectl

The Kubernetes command-line interface is required to interact with the cluster.

Verify installation.

```bash
kubectl version --client
```

Example output:

```text
Client Version: v1.xx.x
```

---

# Step 5 – Install Kind

Kind (Kubernetes in Docker) creates a lightweight Kubernetes cluster for local development.

Verify installation.

```bash
kind version
```

Example:

```text
kind v0.xx.x
```

---

# Step 6 – Create the Kubernetes Cluster

Create the local cluster.

```bash
kind create cluster --name devsecops
```

Expected output:

```text
Creating cluster "devsecops" ...
✓ Ensuring node image
✓ Preparing nodes
✓ Writing configuration
✓ Starting control-plane
✓ Installing CNI
✓ Installing StorageClass
```

Cluster creation may take several minutes depending on your system performance and internet connection.

---

# Step 7 – Verify the Cluster

Confirm that Kubernetes is accessible.

```bash
kubectl cluster-info
```

Example:

```text
Kubernetes control plane is running...
```

Verify cluster nodes.

```bash
kubectl get nodes
```

Expected output:

```text
NAME                  STATUS   ROLES           AGE   VERSION
devsecops-control-plane   Ready    control-plane   xxm   v1.xx.x
```

---

# Step 8 – Verify Kubernetes Components

Display system namespaces.

```bash
kubectl get namespaces
```

Example:

```text
default

kube-system

kube-public

kube-node-lease
```

Verify system pods.

```bash
kubectl get pods -A
```

All Kubernetes system pods should report a **Running** status.

---

# Step 9 – Install Helm

Helm simplifies Kubernetes application deployment and release management.

Verify installation.

```bash
helm version
```

Expected output:

```text
Version:"v3.x.x"
```

Helm will later be used to install and upgrade the application.

---

# Step 10 – Install Trivy

Trivy performs vulnerability scanning for Docker images within the CI/CD pipeline.

Verify installation.

```bash
trivy --version
```

Example:

```text
Version: 0.xx.x
```

During the first scan, Trivy automatically downloads its vulnerability database.

---

# Step 11 – Verify the Complete Container Platform

Run the following commands to validate the entire container platform.

```bash
docker version

docker compose version

kubectl version --client

kubectl get nodes

kind version

helm version

trivy --version
```

All commands should execute successfully without errors.

---

# Container Platform Validation

Complete the following checklist before continuing.

| Validation | Status |
|------------|--------|
| Docker Installed | ☐ |
| Docker Engine Running | ☐ |
| Docker Compose Available | ☐ |
| kubectl Installed | ☐ |
| Kind Installed | ☐ |
| Kubernetes Cluster Created | ☐ |
| Kubernetes Nodes Ready | ☐ |
| Helm Installed | ☐ |
| Trivy Installed | ☐ |

Once all items have been verified, the container platform is ready for infrastructure service configuration.

---

# Best Practices

Follow these recommendations for a reliable local Kubernetes environment.

- Allocate at least **8 GB** of memory to Docker Desktop (or equivalent resources to Docker Engine).
- Keep Kubernetes and kubectl versions reasonably aligned.
- Use descriptive Kind cluster names if managing multiple clusters.
- Remove unused Docker images periodically to reclaim disk space.
- Update the Trivy vulnerability database regularly.
- Verify cluster health before deploying applications.

These practices improve stability and reduce troubleshooting during later stages.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|------|----------------|------------|
| Docker daemon not running | Docker service stopped | Start Docker Engine or Docker Desktop |
| `docker: permission denied` | User not in the `docker` group | Add the user to the `docker` group and re-login |
| `kind: command not found` | Kind not installed or PATH missing | Install Kind and update PATH |
| `kubectl cannot connect to the server` | Cluster not created or context incorrect | Create the Kind cluster or switch to the correct context |
| Helm command unavailable | Helm not installed | Install Helm and verify PATH |
| Trivy database download failed | Network or proxy restriction | Verify internet connectivity or proxy configuration |

Resolve any issues before continuing with the infrastructure installation.

---

# Section Summary

The container platform is now fully configured.

You have successfully prepared:

- Docker Engine
- Docker Compose
- Kubernetes (Kind)
- kubectl
- Helm
- Trivy

These components provide the runtime environment required for the remaining infrastructure services and the CI/CD pipeline.

The next section installs and configures Jenkins, SonarQube, Nexus Repository, and the supporting services that complete the Enterprise DevSecOps platform.

---

# Infrastructure Services Setup

With the development environment and container platform ready, the next phase is to deploy and configure the infrastructure services that support the Enterprise DevSecOps CI/CD Pipeline.

These services provide:

- Continuous Integration
- Code Quality Analysis
- Artifact Management
- Container Registry
- Security Scanning

The detailed installation and configuration of each component is covered in the **Infrastructure** section of this documentation.

---

# Infrastructure Architecture

The platform consists of the following services.

```text
                    GitHub
                       │
                       ▼
                  Jenkins Server
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
   SonarQube      Nexus Repository    Docker
        │
        ▼
 Kubernetes (Kind)
        │
        ▼
      Helm
        │
        ▼
   Application Deployment
```

Each component performs a specialized role within the software delivery lifecycle.

---

# Infrastructure Components

| Component | Purpose |
|-----------|---------|
| GitHub | Source code repository |
| Jenkins | CI/CD pipeline orchestration |
| SonarQube | Static code quality analysis |
| Nexus Repository | Artifact repository and Docker registry |
| Docker | Container runtime |
| Kubernetes (Kind) | Container orchestration |
| Helm | Kubernetes package manager |
| Trivy | Container image vulnerability scanner |

Together, these services provide an end-to-end DevSecOps platform.

---

# Infrastructure Deployment Sequence

Deploy the infrastructure components in the following order.

1. Jenkins
2. SonarQube
3. Nexus Repository
4. Docker Configuration
5. Kubernetes (Kind)
6. Helm
7. Trivy

Installing the services in this sequence ensures that all dependencies are available before configuring the CI/CD pipeline.

---

# Verify Running Services

After installation, verify that the required containers are running.

```bash
docker ps
```

Example output:

```text
CONTAINER ID   IMAGE         STATUS

jenkins        Up

sonarqube      Up

nexus          Up
```

All infrastructure containers should report a healthy **Up** status.

---

# Verify Jenkins

Open Jenkins in your web browser.

```
http://localhost:8080
```

Confirm that:

- Jenkins is accessible
- Dashboard loads successfully
- Required plugins are installed
- Administrative user is configured

Refer to:

**06_Jenkins_Setup.md**

for detailed installation and configuration.

---

# Verify SonarQube

Open SonarQube.

```
http://localhost:9000
```

Verify:

- Login page appears
- Database initialization completed
- Quality profiles available
- Quality gates configured

Refer to:

**07_SonarQube_Setup.md**

for complete configuration.

---

# Verify Nexus Repository

Open Nexus Repository.

```
http://localhost:8081
```

Verify:

- Repository Manager loads
- Administrative login succeeds
- Maven repositories available
- Docker hosted repository configured

Refer to:

**08_Nexus_Setup.md**

for detailed configuration.

---

# Configure Jenkins Credentials

Before executing the pipeline, configure the required credentials within Jenkins.

Typical credentials include:

- GitHub Personal Access Token or SSH Key
- SonarQube Token
- Nexus Username and Password
- Docker Registry Credentials
- Kubernetes kubeconfig
- Helm configuration (if applicable)

Credential configuration is described in the Jenkins Setup document.

---

# Configure Tool Integrations

Integrate Jenkins with the required platform services.

| Integration | Purpose |
|-------------|---------|
| GitHub | Source code checkout |
| Maven | Build automation |
| SonarQube | Static analysis |
| Nexus Repository | Artifact publishing |
| Docker | Image build |
| Trivy | Image scanning |
| Kubernetes | Deployment |
| Helm | Release management |

Successful integration enables a fully automated CI/CD workflow.

---

# Infrastructure Validation

Verify that each component is operational.

| Component | Validation |
|-----------|------------|
| Jenkins | Dashboard accessible |
| SonarQube | Login successful |
| Nexus Repository | Repository Manager available |
| Docker | Containers running |
| Kubernetes | Cluster healthy |
| Helm | Version command successful |
| Trivy | Version command successful |

All validations should complete successfully before proceeding to pipeline execution.

---

# Infrastructure Readiness Checklist

| Requirement | Status |
|-------------|--------|
| Jenkins Running | ☐ |
| SonarQube Running | ☐ |
| Nexus Repository Running | ☐ |
| Docker Operational | ☐ |
| Kubernetes Cluster Ready | ☐ |
| Helm Installed | ☐ |
| Trivy Installed | ☐ |
| Jenkins Credentials Configured | ☐ |
| Tool Integrations Completed | ☐ |

Once every item has been verified, the infrastructure platform is ready for CI/CD pipeline execution.

---

# Best Practices

To ensure reliable platform operation:

- Use dedicated Docker volumes for persistent data.
- Keep Jenkins plugins updated.
- Regularly back up Jenkins and Nexus data.
- Monitor SonarQube database health.
- Remove unused Docker images to reclaim storage.
- Verify Kubernetes cluster health before deployments.
- Rotate credentials and access tokens periodically.

Following these practices improves platform stability and maintainability.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|-------|----------------|------------|
| Jenkins unavailable | Container stopped | Restart the Jenkins container |
| SonarQube startup delay | Database initialization | Wait until initialization completes |
| Nexus inaccessible | Container startup failure | Check Docker logs |
| Jenkins cannot reach SonarQube | Network or configuration issue | Verify URLs and credentials |
| Artifact upload fails | Nexus credentials incorrect | Update Jenkins credentials |
| Kubernetes deployment fails | Cluster unavailable | Verify the Kind cluster and kubectl context |

Consult the dedicated infrastructure documents for detailed troubleshooting procedures.

---

# Section Summary

The infrastructure platform is now installed and validated.

The following services should be operational:

- Jenkins
- SonarQube
- Nexus Repository
- Docker
- Kubernetes
- Helm
- Trivy

With these components available, the platform is ready for CI/CD pipeline execution and application deployment.

The next section explains how to configure and execute the Jenkins Pipeline to automate the complete software delivery workflow.

---

# CI/CD Pipeline Execution

With the infrastructure platform operational, the next step is to execute the CI/CD pipeline and deploy the application.

This phase validates that all platform components work together as an integrated Enterprise DevSecOps solution.

The pipeline automates:

- Source code retrieval
- Application compilation
- Unit testing
- Static code analysis
- Security scanning
- Artifact publication
- Docker image creation
- Container image vulnerability scanning
- Kubernetes deployment
- Deployment verification

---

# CI/CD Pipeline Workflow

The pipeline follows a fully automated software delivery process.

```text
        GitHub Repository
               │
               ▼
        Jenkins Pipeline
               │
               ▼
         Checkout Source
               │
               ▼
          Maven Build
               │
               ▼
          Unit Testing
               │
               ▼
      SonarQube Analysis
               │
               ▼
      Quality Gate Check
               │
               ▼
      Publish to Nexus
               │
               ▼
      Docker Image Build
               │
               ▼
      Trivy Image Scan
               │
               ▼
      Push Image (Optional)
               │
               ▼
      Helm Deployment
               │
               ▼
     Kubernetes Cluster
               │
               ▼
      Application Running
```

Every stage must complete successfully before the next stage begins.

---

# Execute the Pipeline

Open the Jenkins Dashboard.

```
http://localhost:8080
```

Locate the configured pipeline job.

Typical execution steps include:

1. Open the pipeline project.
2. Select **Build Now**.
3. Monitor the build progress.
4. Review the Console Output.
5. Confirm successful completion.

A successful pipeline indicates that the platform has been configured correctly.

---

# Monitor Pipeline Progress

During execution, monitor the Jenkins build stages.

Typical stages include:

| Stage | Description |
|--------|-------------|
| Checkout | Retrieve source code from GitHub |
| Build | Compile the application |
| Test | Execute unit tests |
| SonarQube Analysis | Perform static code analysis |
| Quality Gate | Validate code quality |
| Publish Artifact | Upload WAR file to Nexus |
| Docker Build | Build the container image |
| Trivy Scan | Scan the image for vulnerabilities |
| Helm Deploy | Deploy to Kubernetes |
| Verification | Validate deployment |

Refer to **14_Pipeline_Stages.md** for detailed information about each stage.

---

# Verify SonarQube Analysis

After the pipeline completes, open SonarQube.

```
http://localhost:9000
```

Verify:

- Project appears in the dashboard.
- Analysis completed successfully.
- Quality Gate status is **Passed**.
- No critical issues remain unresolved.

Code quality should meet the organization's defined quality standards before deployment.

---

# Verify Artifact Publication

Open Nexus Repository.

```
http://localhost:8081
```

Verify that:

- The generated WAR artifact is available.
- Artifact version matches the build.
- Repository upload completed successfully.

Artifact publication confirms successful build packaging.

---

# Verify Docker Image

List available Docker images.

```bash
docker images
```

Example:

```text
REPOSITORY          TAG

automation-app      latest
```

The application image should be present without build errors.

---

# Verify Trivy Scan

Review the Jenkins build log to confirm that the Trivy scan completed.

Expected outcome:

- Scan completed successfully.
- No Critical vulnerabilities.
- No High vulnerabilities that violate organizational policies.

Security findings should be reviewed before production deployment.

---

# Verify Kubernetes Deployment

Confirm that the application has been deployed.

```bash
kubectl get deployments
```

Example:

```text
NAME               READY

automation-app     1/1
```

Verify running pods.

```bash
kubectl get pods
```

Expected output:

```text
NAME                          READY

automation-app-xxxxx          1/1
```

All application pods should report a **Running** status.

---

# Verify Kubernetes Services

List cluster services.

```bash
kubectl get svc
```

Example:

```text
NAME                 TYPE

automation-service   ClusterIP
```

Confirm that the application service has been created successfully.

---

# Verify Helm Release

Display deployed Helm releases.

```bash
helm list
```

Example:

```text
NAME

automation-app
```

The release status should indicate **deployed**.

---

# Smoke Testing

Validate that the deployed application is accessible.

Typical validation includes:

- Application homepage loads.
- REST endpoints return expected responses.
- Health endpoint reports **UP**.
- No container restart loops.
- Application logs contain no startup errors.

Example:

```bash
curl http://localhost:8080/actuator/health
```

Expected response:

```json
{
  "status":"UP"
}
```

---

# Pipeline Validation Checklist

| Validation | Status |
|------------|--------|
| Jenkins Build Successful | ☐ |
| Maven Build Successful | ☐ |
| Unit Tests Passed | ☐ |
| SonarQube Analysis Completed | ☐ |
| Quality Gate Passed | ☐ |
| Artifact Published | ☐ |
| Docker Image Built | ☐ |
| Trivy Scan Completed | ☐ |
| Kubernetes Deployment Successful | ☐ |
| Helm Release Deployed | ☐ |
| Application Accessible | ☐ |

All validation items should be completed before considering the installation successful.

---

# Best Practices

For reliable CI/CD execution:

- Keep pipeline definitions under version control.
- Fail the pipeline immediately on critical build errors.
- Enforce SonarQube Quality Gates.
- Scan every container image before deployment.
- Version artifacts consistently.
- Keep Jenkins agents clean and reproducible.
- Monitor pipeline execution history regularly.

These practices improve software quality, security, and deployment consistency.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|-------|----------------|------------|
| Pipeline failed during checkout | Git credentials or repository access issue | Verify GitHub credentials and repository URL |
| Maven build failed | Dependency or compilation error | Review Maven build logs |
| SonarQube Quality Gate failed | Code quality issues | Resolve reported issues and rerun the pipeline |
| Artifact not published | Nexus connectivity or credentials | Verify repository configuration |
| Docker image build failed | Docker daemon unavailable or Dockerfile issue | Review Docker build logs |
| Kubernetes deployment failed | Cluster unavailable or manifest error | Verify cluster status and deployment manifests |
| Helm deployment failed | Chart configuration issue | Validate Helm chart syntax and values |
| Application unavailable | Deployment or service issue | Review pod logs and Kubernetes events |

For detailed pipeline diagnostics, refer to:

- **13_Jenkins_Pipeline.md**
- **14_Pipeline_Stages.md**
- **21_Troubleshooting.md**

---

# Section Summary

The CI/CD pipeline has now been executed from source code to application deployment.

A successful execution confirms that:

- Source code is retrieved from GitHub.
- The application builds successfully.
- Code quality checks pass.
- Security scans complete successfully.
- Artifacts are published to Nexus.
- Docker images are created.
- Kubernetes deployment succeeds.
- Helm manages the application release.
- The application is accessible and operational.

The next section completes the installation by performing comprehensive post-installation validation, reviewing the environment, and confirming that the Enterprise DevSecOps platform is ready for day-to-day use.

---

# Post-Installation Validation

After completing all installation phases, perform a comprehensive validation to ensure that the Enterprise DevSecOps platform is fully operational.

This validation confirms that every component has been installed correctly, integrated successfully, and is ready for day-to-day development and deployment activities.

---

# End-to-End Platform Validation

Validate the platform using the following workflow.

```text
Repository
      │
      ▼
GitHub Connectivity
      │
      ▼
Jenkins Pipeline
      │
      ▼
Maven Build
      │
      ▼
SonarQube Analysis
      │
      ▼
Nexus Artifact Repository
      │
      ▼
Docker Image
      │
      ▼
Trivy Security Scan
      │
      ▼
Helm Deployment
      │
      ▼
Kubernetes Cluster
      │
      ▼
Running Application
```

A successful execution of this workflow confirms that the DevSecOps platform is functioning as intended.

---

# Platform Health Checks

Execute the following commands to verify the health of the installed platform.

## Docker

```bash
docker ps
```

Confirm that all required containers are running.

---

## Kubernetes

```bash
kubectl get nodes

kubectl get pods -A

kubectl get svc
```

Verify:

- Kubernetes node status is **Ready**
- System pods are **Running**
- Application pods are **Running**
- Services are available

---

## Helm

```bash
helm list
```

Verify that the application release is listed with a **deployed** status.

---

## Jenkins

Open:

```
http://localhost:8080
```

Verify:

- Jenkins dashboard loads
- Pipeline history is available
- Latest build completed successfully

---

## SonarQube

Open:

```
http://localhost:9000
```

Verify:

- Project analysis completed
- Quality Gate status is **Passed**
- No blocking issues remain

---

## Nexus Repository

Open:

```
http://localhost:8081
```

Verify:

- Repository Manager is accessible
- Artifacts are available
- Docker repositories are reachable (if configured)

---

# Environment Readiness Checklist

Complete the following checklist before considering the platform ready for use.

| Component | Status |
|-----------|--------|
| Git Repository Accessible | ☐ |
| Java Installed | ☐ |
| Maven Installed | ☐ |
| Docker Running | ☐ |
| Docker Compose Available | ☐ |
| Kubernetes Cluster Healthy | ☐ |
| kubectl Configured | ☐ |
| Helm Installed | ☐ |
| Trivy Installed | ☐ |
| Jenkins Operational | ☐ |
| SonarQube Operational | ☐ |
| Nexus Repository Operational | ☐ |
| Jenkins Pipeline Successful | ☐ |
| Application Running | ☐ |

Every item should be completed successfully before beginning regular development activities.

---

# Post-Installation Recommendations

After completing the installation, consider the following best practices.

## Secure Credentials

- Replace default administrative passwords.
- Store credentials securely using Jenkins Credentials.
- Rotate access tokens periodically.

---

## Update Components

Regularly update:

- Jenkins plugins
- Docker Engine
- Kubernetes tools
- Helm
- Trivy vulnerability database

Keeping software up to date improves security and stability.

---

## Backup Critical Data

Implement regular backups for:

- Jenkins Home
- Nexus Repository data
- SonarQube database
- Kubernetes manifests
- Helm charts

Persistent backups simplify disaster recovery.

---

## Monitor Platform Health

Regularly review:

- Jenkins build history
- SonarQube Quality Gates
- Docker disk usage
- Kubernetes events
- Container logs
- Resource utilization

Continuous monitoring helps identify issues before they impact deployments.

---

# Common Post-Installation Tasks

After validating the installation, typical next steps include:

- Create additional Jenkins pipelines
- Configure GitHub webhooks
- Add new Maven projects
- Publish multiple application versions
- Deploy additional Kubernetes workloads
- Customize Helm values
- Integrate monitoring solutions such as Prometheus and Grafana
- Implement GitOps workflows using Argo CD or Flux

These enhancements extend the platform for more advanced enterprise use cases.

---

# Related Documentation

Continue with the following documentation to deepen your understanding of the platform.

## Infrastructure

- 05_GitHub_Setup.md
- 06_Jenkins_Setup.md
- 07_SonarQube_Setup.md
- 08_Nexus_Setup.md
- 09_Docker_Setup.md
- 10_Kind_Setup.md
- 11_Helm_Setup.md
- 12_Trivy_Setup.md

---

## CI/CD Pipeline

- 13_Jenkins_Pipeline.md
- 14_Pipeline_Stages.md
- 15_Scripts_Guide.md
- 16_Commands_Reference.md

---

## Operations

- 17_Build_Guide.md
- 18_Deployment_Guide.md
- 19_Verification_Guide.md
- 20_Rollback_Guide.md

---

## Reference

- 21_Troubleshooting.md
- 22_Lessons_Learned.md
- 23_Best_Practices.md
- 24_FAQ.md
- 25_Future_Enhancements.md

---

# Key Takeaways

By completing this installation guide, you have successfully:

- Prepared a complete development environment.
- Installed a local Kubernetes platform.
- Configured enterprise DevSecOps services.
- Built a fully automated Jenkins CI/CD pipeline.
- Integrated code quality and security scanning.
- Published application artifacts.
- Built and validated Docker images.
- Deployed applications using Helm.
- Verified application availability within Kubernetes.

These capabilities represent the foundation of a modern Enterprise DevSecOps platform.

---

# Summary

The Enterprise DevSecOps CI/CD Pipeline is now fully installed and ready for use.

The platform provides an integrated software delivery environment that supports the complete application lifecycle—from source code management through automated build, testing, security analysis, artifact management, containerization, and Kubernetes deployment.

The remaining documents in this repository build upon this foundation by providing detailed guidance for each infrastructure component, operational procedure, and troubleshooting scenario.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Prerequisites](02_Prerequisites.md) | [🏠 Documentation Portal](../README.md) | [➡️ GitHub Setup](../02-Infrastructure/05_GitHub_Setup.md) |

---

# Conclusion

Congratulations! You have successfully completed the installation of the **Enterprise DevSecOps CI/CD Pipeline**.

Your environment is now ready to:

- Build Java applications
- Execute automated CI/CD pipelines
- Perform code quality analysis
- Scan container images for vulnerabilities
- Manage artifacts through Nexus Repository
- Deploy applications to Kubernetes using Helm
- Support continuous software delivery following modern DevSecOps practices

Continue with the **Infrastructure** documentation to explore each platform component in greater detail and learn how to customize the environment for your specific requirements.
