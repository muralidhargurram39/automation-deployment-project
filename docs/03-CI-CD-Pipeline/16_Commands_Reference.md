# Commands Reference

> Enterprise DevSecOps CI/CD Pipeline – Operations Command Reference

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Commands Reference |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, Platform Engineers, Cloud Engineers, SREs, System Administrators |
| Maintainer | Muralidhar G |

---

# Purpose

Enterprise DevSecOps platforms integrate multiple tools including Git, Jenkins, SonarQube, Nexus Repository, Docker, Kubernetes, Helm, and Trivy.

Each tool exposes hundreds of commands. This guide consolidates the most commonly used operational commands into a single reference for daily administration, deployment, troubleshooting, validation, and maintenance.

---

# Scope

This document includes commands for:

- Linux
- Git
- Jenkins
- SonarQube
- Nexus Repository
- Docker
- Docker Compose
- Kubernetes (kubectl)
- Kind
- Helm
- Trivy
- System Validation
- Log Collection
- Troubleshooting
- Operational Checklists

---

# Part 1 – Command Conventions & Linux Administration

---

# How to Use This Guide

Commands are organized by platform.

Each command includes:

- Purpose
- Syntax
- Example
- Expected Result
- Operational Notes

---

# Command Conventions

Throughout this guide:

| Symbol | Meaning |
|---------|----------|
| `<value>` | Replace with actual value |
| `[optional]` | Optional parameter |
| `...` | Additional values |
| `#` | Comment |
| `$` | Shell prompt |

Examples are illustrative and should be adapted to your environment.

---

# Linux File System Commands

Frequently used commands include:

| Purpose | Command |
|----------|---------|
| Current directory | `pwd` |
| List files | `ls -la` |
| Change directory | `cd <directory>` |
| Create directory | `mkdir <directory>` |
| Remove directory | `rm -rf <directory>` |
| Copy files | `cp` |
| Move files | `mv` |
| Remove file | `rm` |
| Find files | `find` |

---

# File Inspection

Useful commands include:

- `cat`
- `less`
- `more`
- `head`
- `tail`
- `tail -f`

These commands assist with viewing configuration files and monitoring logs.

---

# Process Management

Common commands:

- `ps`
- `top`
- `htop`
- `kill`
- `killall`

Use these commands to inspect and manage running processes.

---

# Service Management

Systemd commands:

- `systemctl status`
- `systemctl start`
- `systemctl stop`
- `systemctl restart`
- `systemctl enable`

These commands manage system services such as Docker or Jenkins.

---

# Networking Commands

Frequently used commands include:

- `ip addr`
- `ip route`
- `ss`
- `ping`
- `curl`
- `wget`
- `dig`
- `nslookup`

These commands assist with connectivity and DNS troubleshooting.

---

# Disk Management

Useful commands:

- `df -h`
- `du -sh`
- `mount`
- `lsblk`
- `free -h`

These commands help monitor storage and memory utilization.

---

# Archive Utilities

Common archive commands:

- `tar`
- `gzip`
- `gunzip`
- `zip`
- `unzip`

Use these commands for backup and artifact packaging.

---

# Text Processing

Frequently used utilities:

- `grep`
- `awk`
- `sed`
- `sort`
- `uniq`
- `cut`

These commands simplify log analysis and automation tasks.

---

# Environment Variables

Typical commands:

- `env`
- `printenv`
- `export`
- `unset`

Environment variables are widely used throughout Jenkins pipelines.

---

# Permission Management

Common commands:

- `chmod`
- `chown`
- `groups`
- `id`

Proper permission management is essential for secure automation.

---

# Section Summary

Linux provides the foundation for operating the DevSecOps platform. Familiarity with file management, process monitoring, networking, storage, and permissions enables administrators to troubleshoot issues efficiently before moving to platform-specific tooling.

---

# Part 2 – Platform Commands

This section provides commonly used operational commands for managing the Enterprise DevSecOps platform.

Each command includes:

- Purpose
- Syntax
- Example
- Operational Notes

These commands are intended for day-to-day administration, validation, troubleshooting, and maintenance.

---

# Git Commands

Git is the primary source control system for managing application code, infrastructure definitions, and pipeline configurations.

---

## Repository Management

| Purpose | Command |
|----------|---------|
| Clone repository | `git clone <repository-url>` |
| Initialize repository | `git init` |
| Check repository status | `git status` |
| View configured remotes | `git remote -v` |
| Add remote | `git remote add origin <repository-url>` |

---

## Branch Management

| Purpose | Command |
|----------|---------|
| List branches | `git branch` |
| List remote branches | `git branch -r` |
| Create branch | `git checkout -b <branch>` |
| Switch branch | `git checkout <branch>` |
| Delete local branch | `git branch -d <branch>` |
| Delete remote branch | `git push origin --delete <branch>` |

---

## Commit Management

| Purpose | Command |
|----------|---------|
| Stage changes | `git add .` |
| Commit changes | `git commit -m "message"` |
| View commit history | `git log --oneline` |
| View latest commit | `git log -1` |
| Show commit details | `git show <commit-id>` |

---

## Synchronization

| Purpose | Command |
|----------|---------|
| Pull latest changes | `git pull` |
| Fetch updates | `git fetch` |
| Push commits | `git push` |
| Push new branch | `git push --set-upstream origin <branch>` |

---

## Useful Git Commands

| Purpose | Command |
|----------|---------|
| View differences | `git diff` |
| View staged differences | `git diff --cached` |
| Restore file | `git restore <file>` |
| Reset changes | `git reset --hard` |
| Clean untracked files | `git clean -fd` |

---

# Jenkins Commands

Jenkins automates CI/CD workflows and integrates with the DevSecOps toolchain.

---

## Service Management

| Purpose | Command |
|----------|---------|
| Check Jenkins service | `systemctl status jenkins` |
| Start Jenkins | `systemctl start jenkins` |
| Stop Jenkins | `systemctl stop jenkins` |
| Restart Jenkins | `systemctl restart jenkins` |
| Enable Jenkins | `systemctl enable jenkins` |

---

## Log Management

| Purpose | Command |
|----------|---------|
| View service logs | `journalctl -u jenkins` |
| Follow logs | `journalctl -u jenkins -f` |
| Jenkins log directory | `ls -la /var/log/jenkins` |

---

## Jenkins CLI

| Purpose | Command |
|----------|---------|
| List jobs | `java -jar jenkins-cli.jar -s <url> list-jobs` |
| Build job | `java -jar jenkins-cli.jar -s <url> build <job>` |
| Get build info | `java -jar jenkins-cli.jar -s <url> console <job>` |

---

## Jenkins REST API Examples

| Purpose | Endpoint |
|----------|----------|
| Server information | `/api/json` |
| Job information | `/job/<job-name>/api/json` |
| Build information | `/job/<job-name>/<build>/api/json` |
| Queue information | `/queue/api/json` |

---

# SonarQube Commands

SonarQube performs static code quality analysis.

---

## Service Management

| Purpose | Command |
|----------|---------|
| Check service | `systemctl status sonarqube` |
| Start service | `systemctl start sonarqube` |
| Restart service | `systemctl restart sonarqube` |

---

## Scanner Commands

| Purpose | Command |
|----------|---------|
| Run analysis | `sonar-scanner` |
| Show version | `sonar-scanner --version` |
| Display help | `sonar-scanner --help` |

---

## Validation

| Purpose | Command |
|----------|---------|
| Verify server | `curl http://<server>:9000/api/system/status` |
| List projects | `curl http://<server>:9000/api/projects/search` |

---

# Nexus Repository Commands

Nexus Repository stores build artifacts and container images.

---

## Service Management

| Purpose | Command |
|----------|---------|
| Check service | `systemctl status nexus` |
| Start service | `systemctl start nexus` |
| Restart service | `systemctl restart nexus` |

---

## Repository Validation

| Purpose | Command |
|----------|---------|
| Check repository | `curl http://<server>:8081` |
| Repository status | `curl http://<server>:8081/service/rest/v1/status` |

---

## Docker Registry Login

```bash
docker login <nexus-server>:<port>
```

---

## Docker Push

```bash
docker push <repository>/<image>:<tag>
```

---

## Docker Pull

```bash
docker pull <repository>/<image>:<tag>
```

---

# Docker Commands

Docker packages applications into portable container images.

---

## Container Management

| Purpose | Command |
|----------|---------|
| List running containers | `docker ps` |
| List all containers | `docker ps -a` |
| Start container | `docker start <container>` |
| Stop container | `docker stop <container>` |
| Restart container | `docker restart <container>` |
| Remove container | `docker rm <container>` |

---

## Image Management

| Purpose | Command |
|----------|---------|
| List images | `docker images` |
| Build image | `docker build -t <image>:<tag> .` |
| Pull image | `docker pull <image>` |
| Push image | `docker push <image>` |
| Remove image | `docker rmi <image>` |

---

## Log Commands

| Purpose | Command |
|----------|---------|
| View logs | `docker logs <container>` |
| Follow logs | `docker logs -f <container>` |
| Last 100 lines | `docker logs --tail 100 <container>` |

---

## Container Inspection

| Purpose | Command |
|----------|---------|
| Inspect container | `docker inspect <container>` |
| Execute shell | `docker exec -it <container> bash` |
| View processes | `docker top <container>` |
| View resource usage | `docker stats` |

---

## Docker Cleanup

| Purpose | Command |
|----------|---------|
| Remove stopped containers | `docker container prune` |
| Remove unused images | `docker image prune` |
| Remove unused volumes | `docker volume prune` |
| Remove unused networks | `docker network prune` |
| Full cleanup | `docker system prune -a` |

---

# Docker Compose Commands

Docker Compose manages multi-container applications.

---

## Compose Lifecycle

| Purpose | Command |
|----------|---------|
| Start services | `docker compose up -d` |
| Stop services | `docker compose down` |
| Restart services | `docker compose restart` |
| View running services | `docker compose ps` |

---

## Logs

| Purpose | Command |
|----------|---------|
| View logs | `docker compose logs` |
| Follow logs | `docker compose logs -f` |
| Service logs | `docker compose logs <service>` |

---

## Build Operations

| Purpose | Command |
|----------|---------|
| Build services | `docker compose build` |
| Build without cache | `docker compose build --no-cache` |
| Pull latest images | `docker compose pull` |

---

## Validation

| Purpose | Command |
|----------|---------|
| Validate configuration | `docker compose config` |
| List services | `docker compose config --services` |

---

# Platform Validation Commands

Use the following commands to verify that core platform components are operational.

| Component | Validation Command |
|-----------|--------------------|
| Git | `git --version` |
| Jenkins | `systemctl status jenkins` |
| SonarQube | `curl http://<server>:9000/api/system/status` |
| Nexus Repository | `curl http://<server>:8081` |
| Docker | `docker version` |
| Docker Compose | `docker compose version` |

---

# Operational Notes

- Execute commands using an account with the required permissions.
- Validate configuration changes in non-production environments before applying them to production.
- Prefer scripted automation for repetitive administrative tasks.
- Record significant operational actions in change management or deployment records.
- Review command output carefully before proceeding with dependent operations.

---

# Section Summary

This section introduced the core operational commands for Git, Jenkins, SonarQube, Nexus Repository, Docker, and Docker Compose. These commands form the foundation of daily administration, CI/CD execution, artifact management, and container operations within the Enterprise DevSecOps platform.

The next section expands the reference to Kubernetes, Kind, Helm, and Trivy, covering cluster management, deployments, security scanning, and operational validation.

---

# Part 3 – Kubernetes & Security Commands

This section provides operational commands for Kubernetes-based deployments and security validation.

The commands are organized into the following categories:

- Kubernetes (kubectl)
- Kind
- Helm
- Trivy
- Cluster Validation
- Deployment Operations
- Security Validation
- Troubleshooting

---

# Kubernetes (kubectl) Commands

`kubectl` is the primary command-line tool for interacting with Kubernetes clusters.

---

## Cluster Information

| Purpose | Command |
|----------|---------|
| Display client version | `kubectl version --client` |
| Display cluster information | `kubectl cluster-info` |
| Display cluster nodes | `kubectl get nodes` |
| Display Kubernetes version | `kubectl version` |
| Display current context | `kubectl config current-context` |

---

## Context Management

| Purpose | Command |
|----------|---------|
| List contexts | `kubectl config get-contexts` |
| Use context | `kubectl config use-context <context>` |
| View configuration | `kubectl config view` |

---

## Namespace Commands

| Purpose | Command |
|----------|---------|
| List namespaces | `kubectl get namespaces` |
| Create namespace | `kubectl create namespace <name>` |
| Delete namespace | `kubectl delete namespace <name>` |
| Describe namespace | `kubectl describe namespace <name>` |

---

# Pod Management

## List Pods

```bash
kubectl get pods
```

---

## List All Pods

```bash
kubectl get pods -A
```

---

## Wide Output

```bash
kubectl get pods -o wide
```

---

## Describe Pod

```bash
kubectl describe pod <pod-name>
```

---

## Delete Pod

```bash
kubectl delete pod <pod-name>
```

---

## Execute Command

```bash
kubectl exec -it <pod-name> -- bash
```

---

## View Pod Logs

```bash
kubectl logs <pod-name>
```

---

## Follow Logs

```bash
kubectl logs -f <pod-name>
```

---

## Previous Container Logs

```bash
kubectl logs --previous <pod-name>
```

---

# Deployment Commands

| Purpose | Command |
|----------|---------|
| List deployments | `kubectl get deployments` |
| Describe deployment | `kubectl describe deployment <name>` |
| Create deployment | `kubectl apply -f deployment.yaml` |
| Delete deployment | `kubectl delete deployment <name>` |
| Restart deployment | `kubectl rollout restart deployment/<name>` |

---

# Rollout Commands

| Purpose | Command |
|----------|---------|
| Rollout status | `kubectl rollout status deployment/<name>` |
| Rollout history | `kubectl rollout history deployment/<name>` |
| Undo rollout | `kubectl rollout undo deployment/<name>` |

---

# Scaling

| Purpose | Command |
|----------|---------|
| Scale deployment | `kubectl scale deployment <name> --replicas=3` |
| Autoscaler | `kubectl autoscale deployment <name>` |

---

# Service Commands

| Purpose | Command |
|----------|---------|
| List services | `kubectl get svc` |
| Describe service | `kubectl describe svc <name>` |
| Delete service | `kubectl delete svc <name>` |

---

# ConfigMaps

| Purpose | Command |
|----------|---------|
| List ConfigMaps | `kubectl get configmaps` |
| Describe ConfigMap | `kubectl describe configmap <name>` |
| Create ConfigMap | `kubectl create configmap` |

---

# Secrets

| Purpose | Command |
|----------|---------|
| List Secrets | `kubectl get secrets` |
| Describe Secret | `kubectl describe secret <name>` |
| Create Secret | `kubectl create secret generic` |

---

# Events

```bash
kubectl get events
```

Sort by newest:

```bash
kubectl get events --sort-by=.metadata.creationTimestamp
```

---

# Resource Usage

Requires Metrics Server.

| Purpose | Command |
|----------|---------|
| Node utilization | `kubectl top nodes` |
| Pod utilization | `kubectl top pods` |

---

# Kind Commands

Kind provides local Kubernetes clusters for development and testing.

---

## Cluster Operations

| Purpose | Command |
|----------|---------|
| Create cluster | `kind create cluster` |
| List clusters | `kind get clusters` |
| Delete cluster | `kind delete cluster` |
| Export kubeconfig | `kind export kubeconfig` |

---

## Cluster Information

```bash
kind get clusters
```

---

## Load Docker Image

```bash
kind load docker-image <image-name>
```

---

## Display Nodes

```bash
kubectl get nodes
```

---

# Helm Commands

Helm simplifies Kubernetes application deployment and lifecycle management.

---

## Repository Management

| Purpose | Command |
|----------|---------|
| List repositories | `helm repo list` |
| Add repository | `helm repo add` |
| Update repositories | `helm repo update` |
| Remove repository | `helm repo remove` |

---

## Chart Management

| Purpose | Command |
|----------|---------|
| Search charts | `helm search repo` |
| Show values | `helm show values` |
| Show chart | `helm show chart` |

---

## Release Management

| Purpose | Command |
|----------|---------|
| Install release | `helm install` |
| Upgrade release | `helm upgrade` |
| Rollback release | `helm rollback` |
| Uninstall release | `helm uninstall` |

---

## Release Validation

| Purpose | Command |
|----------|---------|
| List releases | `helm list` |
| Release status | `helm status <release>` |
| Release history | `helm history <release>` |

---

# Trivy Commands

Trivy performs vulnerability scanning for images, filesystems, Kubernetes resources, and Infrastructure as Code.

---

## Version

```bash
trivy --version
```

---

## Database Update

```bash
trivy image --download-db-only
```

---

## Filesystem Scan

```bash
trivy fs .
```

---

## Container Image Scan

```bash
trivy image <image-name>
```

---

## Kubernetes Scan

```bash
trivy kubernetes cluster
```

---

## Repository Scan

```bash
trivy repo .
```

---

## Configuration Scan

```bash
trivy config .
```

---

## Secret Scan

```bash
trivy fs --scanners secret .
```

---

## SBOM Generation

```bash
trivy image --format cyclonedx <image-name>
```

---

## JSON Report

```bash
trivy image --format json <image-name>
```

---

## HTML Report

```bash
trivy image --format template \
--template "@contrib/html.tpl" \
-o report.html <image-name>
```

---

# Cluster Validation Commands

| Validation | Command |
|------------|---------|
| Nodes | `kubectl get nodes` |
| Pods | `kubectl get pods -A` |
| Deployments | `kubectl get deployments -A` |
| Services | `kubectl get svc -A` |
| Ingress | `kubectl get ingress -A` |
| PVC | `kubectl get pvc -A` |

---

# Deployment Validation

```bash
kubectl rollout status deployment/<deployment>
```

---

Health verification:

```bash
kubectl get pods
```

---

Application logs:

```bash
kubectl logs <pod>
```

---

# Kubernetes Troubleshooting

Useful commands include:

| Purpose | Command |
|----------|---------|
| Describe Pod | `kubectl describe pod <pod>` |
| View Events | `kubectl get events` |
| View Logs | `kubectl logs <pod>` |
| Execute Shell | `kubectl exec -it <pod> -- bash` |
| Check Rollout | `kubectl rollout status deployment/<deployment>` |

---

# Security Validation Workflow

```text
Docker Image
      │
      ▼
Trivy Image Scan
      │
      ▼
Security Report
      │
      ▼
Policy Validation
      │
      ▼
Helm Deployment
      │
      ▼
Kubernetes Verification
```

Only images that satisfy organizational security policies should proceed to deployment.

---

# Operational Notes

- Validate cluster connectivity before deployment.
- Review rollout status after every release.
- Scan all container images before publishing.
- Use immutable image tags for deployments.
- Archive vulnerability reports for audit purposes.
- Monitor Kubernetes events during incident investigation.

---

# Section Summary

This section presented the operational commands required for Kubernetes cluster administration, Helm-based application deployment, Kind cluster management, and Trivy security scanning.

Together, these commands support the secure deployment, validation, monitoring, and troubleshooting of workloads running on the Enterprise DevSecOps platform.

The final section provides platform-wide validation commands, health checks, log collection, incident response procedures, disaster recovery references, and operational checklists for day-to-day administration.

---

# Part 4 – Validation, Troubleshooting & Operational Checklists

An Enterprise DevSecOps platform must provide administrators with a consistent set of commands to validate platform health, investigate incidents, recover services, and perform routine maintenance.

This section consolidates the most frequently used validation and troubleshooting commands across the platform.

---

# Platform Health Validation

Validate every major platform component before executing deployments.

| Component | Validation Command |
|-----------|--------------------|
| Git | `git --version` |
| Jenkins | `systemctl status jenkins` |
| SonarQube | `curl http://<server>:9000/api/system/status` |
| Nexus Repository | `curl http://<server>:8081/service/rest/v1/status` |
| Docker | `docker version` |
| Docker Compose | `docker compose version` |
| Kubernetes | `kubectl cluster-info` |
| Helm | `helm version` |
| Trivy | `trivy --version` |

All services should report healthy status before pipeline execution.

---

# End-to-End Platform Validation

Use the following sequence to validate the complete DevSecOps workflow.

```text
Git Repository
      │
      ▼
Jenkins Pipeline
      │
      ▼
Application Build
      │
      ▼
SonarQube Analysis
      │
      ▼
Docker Image
      │
      ▼
Trivy Scan
      │
      ▼
Nexus Repository
      │
      ▼
Helm Deployment
      │
      ▼
Kubernetes
      │
      ▼
Application Verification
```

Successful completion confirms that the CI/CD platform is operational.

---

# Log Collection Commands

## Linux

| Purpose | Command |
|----------|---------|
| System logs | `journalctl` |
| Follow logs | `journalctl -f` |
| Kernel messages | `dmesg` |

---

## Jenkins

| Purpose | Command |
|----------|---------|
| Service logs | `journalctl -u jenkins -f` |
| Service status | `systemctl status jenkins` |

---

## Docker

| Purpose | Command |
|----------|---------|
| Container logs | `docker logs <container>` |
| Follow logs | `docker logs -f <container>` |
| Running containers | `docker ps` |

---

## Kubernetes

| Purpose | Command |
|----------|---------|
| Pod logs | `kubectl logs <pod>` |
| Previous logs | `kubectl logs --previous <pod>` |
| Describe pod | `kubectl describe pod <pod>` |
| Cluster events | `kubectl get events` |

---

# Incident Response Commands

When responding to incidents, collect information before making changes.

| Activity | Command |
|----------|---------|
| Verify node status | `kubectl get nodes` |
| Verify pod status | `kubectl get pods -A` |
| Review deployment | `kubectl describe deployment <name>` |
| Check rollout | `kubectl rollout status deployment/<name>` |
| View recent events | `kubectl get events --sort-by=.metadata.creationTimestamp` |
| Container resource usage | `docker stats` |
| Node resource usage | `kubectl top nodes` |
| Pod resource usage | `kubectl top pods` |

Capture logs and events before restarting workloads to preserve diagnostic information.

---

# Backup Verification Commands

Backups should be validated periodically.

| Component | Validation Command |
|-----------|--------------------|
| Jenkins Home | `ls -la $JENKINS_HOME` |
| Docker Volumes | `docker volume ls` |
| Kubernetes Resources | `kubectl get all -A` |
| Helm Releases | `helm list -A` |
| Nexus Storage | Verify repository and blob store availability |

A backup strategy is only effective if restore procedures have been tested.

---

# Deployment Verification Commands

After deployment, validate the application.

| Purpose | Command |
|----------|---------|
| Verify rollout | `kubectl rollout status deployment/<deployment>` |
| List pods | `kubectl get pods` |
| List services | `kubectl get svc` |
| View ingress | `kubectl get ingress` |
| View endpoints | `kubectl get endpoints` |
| Check logs | `kubectl logs <pod>` |

Verification should confirm both infrastructure health and application availability.

---

# Performance Validation Commands

Monitor platform resource utilization.

| Purpose | Command |
|----------|---------|
| CPU & Memory | `top` |
| Interactive monitoring | `htop` |
| Disk usage | `df -h` |
| Directory usage | `du -sh *` |
| Memory usage | `free -h` |
| Docker resource usage | `docker stats` |
| Kubernetes node metrics | `kubectl top nodes` |
| Kubernetes pod metrics | `kubectl top pods` |

Review resource trends regularly to identify capacity or performance issues.

---

# Common Troubleshooting Commands

| Problem | Command |
|----------|---------|
| Verify DNS | `nslookup <host>` |
| Test connectivity | `ping <host>` |
| Test HTTP endpoint | `curl http://<url>` |
| Verify listening ports | `ss -tuln` |
| Running processes | `ps -ef` |
| Disk usage | `df -h` |
| File search | `find <path> -name "<file>"` |
| Search logs | `grep "<pattern>" <file>` |

---

# Troubleshooting Workflow

```text
Incident Detected
        │
        ▼
Identify Affected Component
        │
        ▼
Collect Logs
        │
        ▼
Review Metrics
        │
        ▼
Determine Root Cause
        │
        ▼
Implement Corrective Action
        │
        ▼
Validate Recovery
        │
        ▼
Document Findings
```

Follow a structured workflow to minimize recovery time and improve consistency.

---

# Daily Operational Checklist

| Task | Status |
|------|--------|
| Jenkins Healthy | ☐ |
| Docker Running | ☐ |
| Kubernetes Healthy | ☐ |
| SonarQube Reachable | ☐ |
| Nexus Reachable | ☐ |
| Helm Releases Healthy | ☐ |
| Security Database Updated | ☐ |
| Recent Builds Reviewed | ☐ |

---

# Weekly Operational Checklist

| Task | Status |
|------|--------|
| Review Failed Pipelines | ☐ |
| Clean Old Docker Images | ☐ |
| Archive Build Logs | ☐ |
| Review Security Findings | ☐ |
| Validate Backup Jobs | ☐ |
| Review Resource Utilization | ☐ |

---

# Monthly Operational Checklist

| Task | Status |
|------|--------|
| Upgrade Jenkins Plugins | ☐ |
| Review Shared Libraries | ☐ |
| Rotate Credentials | ☐ |
| Validate Disaster Recovery | ☐ |
| Review Pipeline Performance | ☐ |
| Audit User Access | ☐ |
| Update Documentation | ☐ |

---

# Disaster Recovery Validation

After a platform recovery:

1. Verify infrastructure connectivity.
2. Confirm Jenkins availability.
3. Validate Git repository access.
4. Execute a sample pipeline.
5. Verify SonarQube analysis.
6. Confirm artifact publication to Nexus.
7. Validate Kubernetes deployment.
8. Execute application health checks.
9. Review monitoring dashboards.

Recovery is complete only after a successful end-to-end pipeline execution.

---

# Operational Best Practices

- Standardize operational procedures across environments.
- Prefer automation over manual execution.
- Record administrative actions in change management systems.
- Archive logs before cleanup.
- Test backups and recovery procedures regularly.
- Review operational metrics to identify trends.
- Keep command references and runbooks up to date.

---

# Related Documentation

## Getting Started

- [Project Overview](../01-Getting-Started/01_Project_Overview.md)
- [Prerequisites](../01-Getting-Started/02_Prerequisites.md)
- [Installation Guide](../01-Getting-Started/03_Installation_Guide.md)
- [Project Structure](../01-Getting-Started/04_Project_Structure.md)

---

## Infrastructure

- [GitHub Setup](../02-Infrastructure/05_GitHub_Setup.md)
- [Jenkins Setup](../02-Infrastructure/06_Jenkins_Setup.md)
- [SonarQube Setup](../02-Infrastructure/07_SonarQube_Setup.md)
- [Nexus Setup](../02-Infrastructure/08_Nexus_Setup.md)
- [Docker Setup](../02-Infrastructure/09_Docker_Setup.md)
- [Kind Setup](../02-Infrastructure/10_Kind_Setup.md)
- [Helm Setup](../02-Infrastructure/11_Helm_Setup.md)
- [Trivy Setup](../02-Infrastructure/12_Trivy_Setup.md)

---

## CI/CD Pipeline

- [Jenkins Pipeline](13_Jenkins_Pipeline.md)
- [Pipeline Stages](14_Pipeline_Stages.md)
- [Scripts Guide](15_Scripts_Guide.md)

---

## Deployment & Operations

- [Build Guide](../04-Deployment-Operations/17_Build_Guide.md)
- [Deployment Guide](../04-Deployment-Operations/18_Deployment_Guide.md)
- [Verification Guide](../04-Deployment-Operations/19_Verification_Guide.md)
- [Rollback Guide](../04-Deployment-Operations/20_Rollback_Guide.md)

---

## Reference

- [Troubleshooting](../05-Reference/21_Troubleshooting.md)
- [Best Practices](../05-Reference/23_Best_Practices.md)
- [FAQ](../05-Reference/24_FAQ.md)
- [Future Enhancements](../05-Reference/25_Future_Enhancements.md)

---

# Key Takeaways

After completing this guide, you can:

- Use platform-specific commands confidently.
- Validate the health of the DevSecOps platform.
- Perform deployments and operational checks.
- Troubleshoot common issues across Git, Jenkins, Docker, Kubernetes, Helm, and Trivy.
- Collect logs and metrics for incident response.
- Verify backup and disaster recovery procedures.
- Apply consistent operational practices.

---

# Summary

The **Commands Reference** provides a centralized operational handbook for the Enterprise DevSecOps platform.

By consolidating frequently used administrative, deployment, validation, and troubleshooting commands into a single guide, it enables engineers to perform day-to-day operations consistently and efficiently. Combined with the architecture, pipeline, and scripting guides, this document forms an essential reference for operating and supporting the CI/CD platform.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Scripts Guide](15_Scripts_Guide.md) | [🏠 Documentation Portal](../README.md) | [➡️ Build Guide](../04-Deployment-Operations/17_Build_Guide.md) |

---

# Conclusion

Congratulations! You have completed the **Commands Reference** guide.

This document serves as the operational command handbook for the Enterprise DevSecOps platform, covering:

- Linux administration
- Git operations
- Jenkins administration
- SonarQube validation
- Nexus repository management
- Docker and Docker Compose
- Kubernetes and Kind
- Helm deployments
- Trivy security scanning
- Platform validation
- Incident response
- Operational maintenance
- Disaster recovery

Together with the previous guides, it provides both the conceptual understanding and the practical command reference required to operate an enterprise-grade DevSecOps environment.

The next document, **`17_Build_Guide.md`**, begins the **Deployment & Operations** section by documenting the complete build lifecycle—from source retrieval and dependency resolution to artifact generation, validation, and publishing—using the CI/CD platform established throughout the previous chapters.
