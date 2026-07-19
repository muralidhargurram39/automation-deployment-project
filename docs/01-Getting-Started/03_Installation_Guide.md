# 🚀 Installation Guide

> **Previous:** [02_Prerequisites.md](02_Prerequisites.md)  
> **Next:** [04_Project_Structure.md](04_Project_Structure.md)

---

# 📌 Purpose

This guide explains how to install, configure, and run the Enterprise DevSecOps CI/CD Pipeline from a clean environment.

By following this guide, you will prepare the required infrastructure, configure the supporting services, execute the Jenkins pipeline, and verify a successful deployment.

---

# 🎯 Installation Overview

The installation process consists of the following phases:

1. Prepare the development environment
2. Clone the repository
3. Configure Jenkins
4. Configure SonarQube
5. Configure Nexus Repository
6. Create the Kubernetes cluster
7. Install Helm
8. Configure Trivy
9. Execute the Jenkins pipeline
10. Verify the deployment

---

# 🏗 Installation Architecture

![Enterprise Architecture](../../images/architecture-overview.png)

---

# Step 1 – Prepare the Environment

Verify all prerequisite software is installed.

```bash
git --version
java -version
mvn -version
docker --version
docker compose version
kubectl version --client
kind version
helm version
trivy --version
```

Expected Result:

- All commands execute successfully.
- No "command not found" errors are displayed.

---

# Step 2 – Clone the Repository

Clone the project into the working directory.

```bash
cd /opt/DevOpsPracticeProjects

git clone <repository-url>

cd automation-deployment-project
```

Verify:

```bash
tree -L 2
```

---

# Step 3 – Start the DevSecOps Infrastructure

Navigate to the infrastructure project.

```bash
cd /opt/DevOpsPracticeProjects/ci-cd-lab
```

Start all services.

```bash
docker compose up -d
```

Verify running containers.

```bash
docker ps
```

Expected services:

- Jenkins
- SonarQube
- Nexus Repository
- Tomcat

---

# Step 4 – Verify Jenkins

Open:

```
http://localhost:8080
```

Verify:

- Jenkins loads successfully.
- Required plugins are installed.
- Pipeline job exists (or create a new Pipeline job pointing to the repository).

---

# Step 5 – Verify SonarQube

Open:

```
http://localhost:9000
```

Verify:

- SonarQube dashboard loads.
- Quality Gate is configured.
- Authentication token is available for Jenkins.

---

# Step 6 – Verify Nexus Repository

Open:

```
http://localhost:8081
```

Verify:

- Maven Hosted Repository
- Docker Hosted Repository
- Docker Proxy Repository

Confirm credentials configured in Jenkins match Nexus.

---

# Step 7 – Create the Kubernetes Cluster

Create the local Kubernetes cluster.

```bash
kind create cluster \
--name automation-deployment \
--config kind/kind-config.yaml
```

Verify cluster.

```bash
kubectl cluster-info

kubectl get nodes
```

Expected Result:

One Ready control-plane node.

---

# Step 8 – Verify Helm

Check Helm installation.

```bash
helm version
```

Validate the chart.

```bash
helm lint helm/automation-deployment
```

Expected:

```
1 chart(s) linted, 0 chart(s) failed
```

---

# Step 9 – Verify Trivy

Filesystem scan:

```bash
trivy fs .
```

Image scan example:

```bash
trivy image nginx:latest
```

Expected:

Security scan completes successfully.

---

# Step 10 – Configure Jenkins Pipeline

The Jenkins pipeline is defined in:

```
Jenkinsfile
```

The pipeline performs:

- Checkout
- Maven Build
- Unit Test
- SonarQube Analysis
- Quality Gate
- Package WAR
- Publish Artifact
- Filesystem Scan
- Docker Build
- Image Scan
- Push Image
- Load Image into Kind
- Generate Runtime Helm Values
- Helm Validation
- Helm Deployment
- Deployment Verification
- Smoke Test

No manual intervention is required after the pipeline starts.

---

# Step 11 – Execute the Pipeline

From Jenkins:

- Open the Pipeline job.
- Select **Build Now**.

Monitor execution.

The pipeline should complete successfully.

---

# Step 12 – Verify Deployment

Check Helm release.

```bash
helm list
```

Check pods.

```bash
kubectl get pods
```

Check services.

```bash
kubectl get svc
```

Check deployment.

```bash
kubectl get deployment
```

Expected:

Application pods are in the **Running** state.

---

# Step 13 – Access the Application

Port-forward the application.

```bash
kubectl port-forward svc/automation-deployment-service 8088:8080
```

Open:

```
http://localhost:8088
```

Verify the application loads successfully.

---

# Step 14 – Verify Security Reports

Generated reports are stored in:

```
reports/
```

Including:

- Filesystem Scan Reports
- Image Scan Reports
- Summary Reports

Verify report generation after every pipeline execution.

---

# Step 15 – Rollback (Optional)

Rollback using Helm.

```bash
helm rollback automation-deployment
```

Verify rollout.

```bash
kubectl rollout status deployment/automation-deployment
```

---

# Troubleshooting

| Issue | Resolution |
|--------|------------|
| Docker not running | Start Docker Desktop or Docker Engine |
| Jenkins unavailable | Verify Docker container status |
| SonarQube unavailable | Wait for service initialization |
| Nexus login failure | Verify credentials and repositories |
| Kubernetes cluster missing | Recreate the Kind cluster |
| Helm deployment failed | Run `helm lint` and inspect templates |
| Trivy scan failed | Update Trivy vulnerability database |

---

# Verification Checklist

Before considering the installation complete, ensure:

- ✅ Jenkins is running
- ✅ SonarQube is accessible
- ✅ Nexus Repository is accessible
- ✅ Docker is running
- ✅ Kubernetes cluster is Ready
- ✅ Helm is operational
- ✅ Trivy is installed
- ✅ Jenkins pipeline completes successfully
- ✅ Application is deployed
- ✅ Smoke test passes

---

# Summary

The Enterprise DevSecOps environment is now fully installed and operational.

You are ready to build, scan, package, deploy, verify, and manage the application using the automated Jenkins pipeline.

---

## Next Document

➡️ **04_Project_Structure.md**
