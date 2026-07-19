# Docker Setup

> **Enterprise DevSecOps CI/CD Pipeline – Docker Platform Configuration Guide**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Docker Setup |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, DevSecOps Engineers, Platform Engineers, Cloud Engineers, Software Developers, Students |
| Maintainer | Muralidhar G |

---

# Purpose

Docker is the container platform that standardizes application packaging and execution across development, testing, and production environments.

Within this Enterprise DevSecOps Platform, Docker enables:

- Consistent build environments
- Portable applications
- Immutable deployments
- Efficient resource utilization
- Simplified CI/CD automation
- Kubernetes-ready container images

This document explains how to install, configure, secure, and validate Docker for enterprise environments.

---

# Part 1 – Docker Overview & Installation

---

# Docker Overview

Docker is an open-source container platform that packages applications together with their runtime, libraries, dependencies, and configuration into lightweight containers.

Unlike traditional virtual machines, containers share the host operating system kernel, making them significantly faster and more resource efficient.

Docker enables applications to behave consistently regardless of where they are deployed.

---

# Why Docker?

Modern software delivery requires predictable, repeatable deployment environments.

Docker provides:

- Environment consistency
- Faster deployments
- Application isolation
- Immutable infrastructure
- Easy scaling
- Lightweight execution
- Infrastructure portability
- Kubernetes compatibility

These characteristics make Docker a foundational technology for cloud-native applications.

---

# Containers vs Virtual Machines

| Virtual Machine | Docker Container |
|-----------------|------------------|
| Includes Guest OS | Shares Host OS |
| Larger Image Size | Lightweight Images |
| Slower Startup | Starts in Seconds |
| Higher Memory Usage | Low Memory Usage |
| Hardware Virtualization | OS-Level Virtualization |
| Lower Density | Higher Density |

Containers improve resource utilization while maintaining application isolation.

---

# Docker in the Enterprise DevSecOps Platform

```text
Developer
     │
     ▼
GitHub Repository
     │
     ▼
Jenkins Pipeline
     │
     ▼
Build Docker Image
     │
     ▼
Nexus Docker Registry
     │
     ▼
Kubernetes Deployment
     │
     ▼
Running Containers
```

Docker standardizes the packaging layer between software builds and Kubernetes deployments.

---

# Docker Architecture

Docker follows a client-server architecture.

```text
        Docker CLI
             │
             ▼
      Docker REST API
             │
             ▼
      Docker Daemon
             │
      ┌──────┴─────────┐
      ▼                ▼
 Images           Containers
      │                │
      └──────┬─────────┘
             ▼
          Volumes
```

The Docker Engine manages the lifecycle of images, containers, networks, and storage.

---

# Docker Components

Major Docker components include:

| Component | Purpose |
|-----------|---------|
| Docker Engine | Container runtime |
| Docker CLI | Command-line interface |
| Docker Daemon | Background service |
| Images | Read-only templates |
| Containers | Running instances |
| Volumes | Persistent storage |
| Networks | Container communication |
| Docker Compose | Multi-container orchestration |

---

# Docker Engine

Docker Engine is responsible for:

- Pulling images
- Building images
- Running containers
- Managing networks
- Managing storage
- Monitoring container lifecycle

It serves as the core runtime for all container operations.

---

# Docker CLI

The Docker CLI provides commands to interact with Docker Engine.

Common commands include:

```bash
docker version

docker info

docker images

docker ps

docker pull

docker build

docker run

docker stop

docker rm
```

---

# Docker Desktop vs Linux Installation

| Docker Desktop | Linux Docker Engine |
|----------------|---------------------|
| Development Workstations | Production Servers |
| GUI Included | CLI Only |
| Kubernetes Optional | Kubernetes External |
| Windows/macOS | Linux |

For this project:

- Docker Desktop is suitable for local development.
- Docker Engine on Linux is recommended for production deployments.

---

# Install Docker (Linux)

Update package information:

```bash
sudo apt update
```

Install Docker:

```bash
sudo apt install docker.io -y
```

Enable the Docker service:

```bash
sudo systemctl enable docker

sudo systemctl start docker
```

Verify:

```bash
sudo systemctl status docker
```

---

# Install Docker Compose

Verify Compose availability:

```bash
docker compose version
```

Recent Docker releases include Docker Compose as a built-in plugin.

---

# Verify Installation

Run:

```bash
docker version

docker info
```

Expected output:

- Docker Engine version
- Docker Client version
- Running daemon
- Storage driver
- Available resources

---

# Run Test Container

```bash
docker run hello-world
```

Expected result:

Docker downloads the image and prints a success message confirming that the installation is working correctly.

---

# Installation Validation

| Validation | Status |
|------------|--------|
| Docker Installed | ☐ |
| Docker Engine Running | ☐ |
| Docker CLI Working | ☐ |
| Docker Compose Available | ☐ |
| hello-world Executed | ☐ |

---

# Expected Outcome

At the end of this section:

- Docker is installed.
- Docker Engine is operational.
- Docker Compose is available.
- Container runtime is ready.

---

# Part 2 – Docker Configuration & Security

---

# Configuration Overview

Docker should be configured to support secure, reliable, and scalable container workloads.

Configuration areas include:

- Networks
- Storage
- Images
- Registries
- Users
- Logging
- Security
- Resource Management

---

# Docker Networks

Docker supports multiple network types.

| Network | Purpose |
|----------|---------|
| Bridge | Default container communication |
| Host | Shares host networking |
| None | No networking |
| Overlay | Multi-host networking |
| Macvlan | Physical network integration |

Bridge networks are appropriate for most development environments.

---

# Docker Volumes

Volumes provide persistent storage independent of container lifecycle.

Typical use cases:

- Databases
- Jenkins Home
- SonarQube Data
- Nexus Data
- Application uploads

Example:

```bash
docker volume create jenkins-data
```

---

# Storage Drivers

Common storage drivers include:

- overlay2 (recommended)
- fuse-overlayfs
- btrfs
- zfs

Verify:

```bash
docker info
```

Confirm:

```text
Storage Driver: overlay2
```

---

# Docker Images

Images are immutable templates used to create containers.

Best practices:

- Use official base images.
- Pin image versions.
- Keep images minimal.
- Remove unnecessary packages.
- Scan images for vulnerabilities.

---

# Containers

Containers are running instances of images.

Lifecycle:

```text
Image
   │
   ▼
Container Created
   │
   ▼
Running
   │
   ▼
Stopped
   │
   ▼
Removed
```

---

# Registries

Docker images are stored in registries.

Supported registries:

- Docker Hub
- Nexus Repository
- Amazon ECR
- Azure ACR
- Google Artifact Registry

This project primarily uses:

- Docker Hub
- Nexus Repository

---

# Docker Hub

Docker Hub provides access to public container images.

Common examples:

- nginx
- postgres
- mysql
- sonarqube
- jenkins
- grafana

Official images should always be preferred over unverified community images.

---

# Nexus Docker Registry

Production images should be published to Nexus.

Benefits:

- Internal storage
- Version control
- Access control
- Reduced external dependencies
- Faster deployments

---

# User Permissions

Avoid running Docker as the root user for routine operations.

Add users to the Docker group:

```bash
sudo usermod -aG docker <username>
```

Log out and log back in for the change to take effect.

---

# Logging Drivers

Docker supports multiple logging drivers.

Examples:

- json-file
- local
- journald
- syslog
- fluentd

Select a logging driver that integrates with your organization's monitoring and log management platform.

---

# Resource Limits

Control container resource consumption.

Examples include:

- CPU limits
- Memory limits
- Swap limits
- Restart policies

Resource limits prevent a single container from exhausting host resources.

---

# Security Best Practices

Follow these recommendations:

- Use official images.
- Keep images updated.
- Run containers as non-root where possible.
- Remove unused images.
- Scan images before deployment.
- Enable image signing if supported.
- Limit Docker socket access.
- Use HTTPS for registry communication.
- Avoid privileged containers.

---

# Backup Recommendations

Regularly back up:

- Docker volumes
- Docker Compose files
- Images (when required)
- Registry configuration
- Daemon configuration

Suggested frequency:

| Environment | Frequency |
|-------------|-----------|
| Development | Weekly |
| Test | Daily |
| Production | Daily |

---

# Configuration Validation

| Validation | Status |
|------------|--------|
| Networks Configured | ☐ |
| Volumes Created | ☐ |
| Storage Driver Verified | ☐ |
| Registry Accessible | ☐ |
| Docker Group Configured | ☐ |
| Logging Configured | ☐ |
| Security Settings Reviewed | ☐ |

---

# Section Summary

Docker has now been installed and configured as the container runtime for the Enterprise DevSecOps Platform.

The platform is ready for:

- Jenkins integration
- Image creation
- Container lifecycle management
- Registry integration
- Kubernetes deployment

---

# Next Section

The next section covers:

- Jenkins Integration
- Docker Pipeline Plugin
- Image Lifecycle
- Image Tagging Strategy
- Nexus Registry Integration
- Container Management
- Integration Validation
- Enterprise Best Practices

---

# Part 3 – Jenkins Integration & Container Management

Docker integrates with Jenkins to provide a standardized environment for building, testing, packaging, and publishing containerized applications. Jenkins acts as the automation engine, while Docker provides isolated build environments and immutable application images.

This section focuses on platform integration. Detailed Jenkins Pipeline implementation, Dockerfile authoring, and CI/CD stages are covered in later documents.

---

# Docker Integration Architecture

```text
                   Developer
                        │
                        ▼
                 GitHub Repository
                        │
                        ▼
                    Jenkins Server
                        │
        ┌───────────────┴───────────────┐
        │                               │
        ▼                               ▼
 Docker Engine                    SonarQube
        │
        ▼
 Build Container Image
        │
        ▼
 Nexus Docker Registry
        │
        ▼
 Kubernetes Cluster
        │
        ▼
 Running Containers
```

Docker serves as the container runtime throughout the software delivery lifecycle.

---

# Jenkins and Docker Integration

Jenkins communicates with Docker Engine through the Docker CLI and Docker API.

Integration enables Jenkins to:

- Build container images
- Execute containers for testing
- Remove temporary containers
- Tag images
- Push images to Nexus
- Support containerized build agents

---

# Jenkins Docker Plugin

Install the Docker Pipeline Plugin from Jenkins Plugin Manager.

Common plugins include:

| Plugin | Purpose |
|---------|---------|
| Docker Pipeline | Pipeline integration |
| Docker API | Docker communication |
| Docker Commons | Shared Docker libraries |
| Docker | General Docker support |

These plugins allow Jenkins to interact securely with Docker Engine.

---

# Docker Socket Access

Jenkins requires access to the Docker daemon.

Typical configuration:

```text
Jenkins Container
        │
        ▼
/var/run/docker.sock
        │
        ▼
Docker Engine
```

This enables Jenkins to invoke Docker commands without embedding Docker inside the Jenkins image.

> **Security Note:** Access to the Docker socket effectively grants administrative control over the host. Restrict access to trusted automation services only.

---

# Jenkins Agent Considerations

Docker can be used in two common ways:

1. Docker installed on the Jenkins controller
2. Docker available on Jenkins agents

For larger environments, dedicated build agents provide better scalability and isolation.

---

# Container Image Build Workflow

The typical image creation process is:

```text
Source Code
      │
      ▼
Compile
      │
      ▼
Unit Tests
      │
      ▼
Static Analysis
      │
      ▼
Build Docker Image
      │
      ▼
Tag Image
      │
      ▼
Push to Nexus
```

Only validated builds should produce deployable images.

---

# Image Tagging Strategy

A consistent tagging strategy improves traceability and rollback capability.

Recommended tags:

```text
latest

1.0.0

1.0.1

2.1.0

build-145

release-2026.07
```

Avoid relying exclusively on the `latest` tag in production deployments.

---

# Container Lifecycle

Containers progress through several states.

```text
Image
   │
   ▼
Created
   │
   ▼
Running
   │
   ▼
Paused
   │
   ▼
Stopped
   │
   ▼
Removed
```

Automated cleanup policies help prevent unnecessary resource consumption.

---

# Image Lifecycle

```text
Build
   │
   ▼
Test
   │
   ▼
Scan
   │
   ▼
Publish
   │
   ▼
Deploy
   │
   ▼
Retire
```

Each image should have a defined lifecycle aligned with organizational release policies.

---

# Multi-Stage Build Concepts

Multi-stage builds reduce image size by separating build-time dependencies from runtime components.

Typical stages include:

- Build
- Test
- Package
- Runtime

Benefits:

- Smaller images
- Faster downloads
- Reduced attack surface
- Improved performance

Implementation examples are covered in the CI/CD documentation.

---

# Publishing Images to Nexus

Container images should be stored in the internal Nexus Docker Registry.

Workflow:

```text
Docker Build
      │
      ▼
Image Tag
      │
      ▼
Authenticate
      │
      ▼
Push Image
      │
      ▼
Nexus Docker Repository
```

Benefits include:

- Centralized image management
- Access control
- Version history
- High availability
- Faster deployments

---

# Image Retention

Establish retention policies for container images.

Suggested guidelines:

| Image Type | Retention |
|------------|-----------|
| Development | 30 Days |
| Snapshot | 60 Days |
| Release | Long-term |
| Production | According to organizational policy |

Review storage consumption periodically.

---

# Container Health Checks

Health checks improve reliability by allowing orchestration platforms to detect unhealthy containers.

Typical checks include:

- HTTP endpoint availability
- Process status
- Database connectivity
- API responsiveness

Kubernetes can use these checks for automatic recovery.

---

# Integration Validation

Verify the following after completing Docker integration.

| Validation | Status |
|------------|--------|
| Docker Engine Running | ☐ |
| Jenkins Connected | ☐ |
| Docker CLI Accessible | ☐ |
| Docker Socket Available | ☐ |
| Image Built Successfully | ☐ |
| Image Tagged | ☐ |
| Image Published to Nexus | ☐ |
| Container Started | ☐ |

---

# Best Practices

- Build immutable images.
- Keep images minimal.
- Tag images consistently.
- Publish only validated builds.
- Remove unused containers.
- Rotate registry credentials.
- Scan images for vulnerabilities.
- Restrict Docker socket access.
- Store images only in approved registries.

---

# Section Summary

Docker is now integrated with Jenkins and prepared for enterprise container image management.

The platform supports:

- Automated image creation
- Image versioning
- Registry publishing
- Secure integration
- Container lifecycle management

---

# Part 4 – Validation, Best Practices & Troubleshooting

---

# End-to-End Validation

Before using Docker in production, validate the complete platform.

---

## Docker Engine Validation

Verify the engine.

```bash
docker version
```

```bash
docker info
```

Confirm:

- Engine running
- Storage driver
- CPU
- Memory
- Logging configuration

---

## Container Runtime Validation

Run a sample container.

```bash
docker run hello-world
```

Expected result:

- Image downloads successfully.
- Container starts.
- Success message displayed.

---

## Image Validation

Verify local images.

```bash
docker images
```

Confirm:

- Image name
- Tag
- Image ID
- Size
- Creation date

---

## Container Validation

```bash
docker ps
```

Verify:

- Running containers
- Status
- Ports
- Image names

---

## Network Validation

```bash
docker network ls
```

Verify:

- bridge
- host
- none

Confirm custom networks if configured.

---

## Volume Validation

```bash
docker volume ls
```

Ensure persistent volumes are available for services such as Jenkins, SonarQube, and Nexus.

---

## Registry Validation

Verify that:

- Nexus registry is reachable.
- Authentication succeeds.
- Image push succeeds.
- Image pull succeeds.

---

## Jenkins Validation

Execute a sample Jenkins job.

Confirm:

- Docker commands execute successfully.
- Image builds complete.
- Registry authentication succeeds.
- Image publishing completes without errors.

---

# Operational Checklist

| Validation | Status |
|------------|--------|
| Docker Running | ☐ |
| Images Available | ☐ |
| Networks Verified | ☐ |
| Volumes Healthy | ☐ |
| Registry Accessible | ☐ |
| Jenkins Integration Working | ☐ |
| Backup Completed | ☐ |
| Security Reviewed | ☐ |

---

# Security Recommendations

Implement the following security controls.

- Use official base images.
- Scan images before deployment.
- Apply least privilege.
- Restrict Docker socket access.
- Enable TLS where applicable.
- Remove unused images.
- Remove unused containers.
- Review user permissions regularly.
- Monitor registry access.

---

# Performance Recommendations

Monitor:

- CPU utilization
- Memory consumption
- Disk usage
- Image cache growth
- Volume usage
- Network throughput

Regular housekeeping improves long-term platform performance.

---

# Backup Strategy

Back up:

- Docker volumes
- Docker Compose files
- Daemon configuration
- Registry configuration
- Persistent application data

Suggested schedule:

| Environment | Frequency |
|-------------|-----------|
| Development | Weekly |
| Test | Daily |
| Production | Daily |

Regularly test restore procedures.

---

# Routine Maintenance

Daily:

- Review running containers.
- Monitor failed containers.
- Check available disk space.

Weekly:

- Remove unused images.
- Remove unused networks.
- Remove unused volumes.
- Review registry storage.

Monthly:

- Upgrade Docker Engine.
- Review daemon configuration.
- Validate backups.
- Audit Docker users and permissions.

---

# Common Problems

| Problem | Possible Cause | Resolution |
|----------|----------------|------------|
| Docker daemon not running | Service stopped | Restart Docker service |
| Image build fails | Invalid Dockerfile | Review build logs |
| Registry authentication fails | Incorrect credentials | Verify registry credentials |
| Container exits immediately | Application error | Inspect container logs |
| Port conflict | Port already in use | Change container port mapping |
| Volume not mounted | Incorrect configuration | Verify mount path |
| Disk full | Excess images and volumes | Clean unused resources |

---

# Disaster Recovery

If Docker becomes unavailable:

1. Reinstall Docker Engine.
2. Restore daemon configuration.
3. Restore Docker volumes.
4. Restore Docker Compose files.
5. Verify Docker service.
6. Validate registry connectivity.
7. Execute test containers.
8. Verify Jenkins integration.
9. Resume platform operations.

Disaster recovery procedures should be documented and tested periodically.

---

# Related Documentation

## Infrastructure

- GitHub Setup
- Jenkins Setup
- SonarQube Setup
- Nexus Setup
- Kind Setup
- Helm Setup
- Trivy Setup

## CI/CD

- Jenkins Pipeline
- Pipeline Stages
- Build Guide
- Deployment Guide

---

# Key Takeaways

After completing this guide, you can:

- Install Docker Engine.
- Configure Docker securely.
- Manage images and containers.
- Configure networking and storage.
- Integrate Docker with Jenkins.
- Publish images to Nexus.
- Validate platform health.
- Apply enterprise operational practices.

---

# Summary

Docker provides the standardized container runtime for the Enterprise DevSecOps platform.

By combining secure configuration, centralized image management, automated integration with Jenkins, and operational best practices, Docker enables reliable, repeatable, and scalable application delivery.

The platform is now prepared for container image creation, registry publishing, and Kubernetes deployments.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Nexus Setup](08_Nexus_Setup.md) | [🏠 Documentation Portal](../README.md) | [➡️ Kind Setup](10_Kind_Setup.md) |

---

# Conclusion

Congratulations! You have completed the Docker Setup guide.

Your environment now includes:

- Enterprise Docker Engine installation
- Secure platform configuration
- Networking and storage management
- Jenkins integration
- Nexus Registry integration
- Image lifecycle management
- Validation procedures
- Operational guidance
- Backup and disaster recovery recommendations

Docker is now fully prepared to support containerized application builds and deployments within the Enterprise DevSecOps CI/CD Pipeline.

The next guide, **Kind Setup**, configures the local Kubernetes cluster that will host and validate containerized workloads before production deployment.
