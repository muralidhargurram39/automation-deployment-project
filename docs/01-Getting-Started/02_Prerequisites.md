# Prerequisites

> **Enterprise DevSecOps CI/CD Pipeline – Environment Requirements**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Prerequisites |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, DevSecOps Engineers, Platform Engineers, Cloud Engineers, Software Engineers, Students |
| Maintainer | Muralidhar G |

---

# Purpose

The purpose of this document is to describe all prerequisites required to successfully build, configure, deploy, and operate the Enterprise DevSecOps CI/CD Pipeline.

It identifies the minimum hardware, operating system, software, development tools, container platforms, Kubernetes components, and external services required before beginning the installation process.

Completing these prerequisites ensures that the installation process is smooth, reproducible, and aligned with enterprise DevSecOps practices.

---

# Intended Audience

This document is intended for anyone preparing to deploy or evaluate the Enterprise DevSecOps CI/CD Pipeline.

Typical readers include:

- DevOps Engineers
- DevSecOps Engineers
- Platform Engineers
- Cloud Engineers
- Software Developers
- Students learning CI/CD and Kubernetes
- Technical Trainers

Readers should have a basic understanding of:

- Linux command line
- Git version control
- Java applications
- Docker fundamentals
- Kubernetes basics (recommended but not mandatory)

---

# Environment Overview

The Enterprise DevSecOps CI/CD Pipeline integrates multiple technologies into a unified software delivery platform.

Before installation, ensure that the following categories of prerequisites are available:

- Supported Operating System
- Hardware Resources
- Internet Connectivity
- Java Development Kit
- Apache Maven
- Git
- Docker Engine
- Kubernetes (Kind)
- Helm
- Jenkins
- SonarQube
- Nexus Repository
- Trivy
- GitHub Account

These components work together to automate the complete application delivery lifecycle.

---

# Minimum Hardware Requirements

The platform is designed to run comfortably on a modern development workstation.

| Resource | Minimum | Recommended |
|----------|---------|-------------|
| CPU | 4 Cores | 8 Cores or higher |
| Memory (RAM) | 8 GB | 16 GB or more |
| Storage | 40 GB Free | 100 GB SSD |
| Network | Broadband Internet | High-speed Broadband |
| Virtualization | Required | Required |

For the best experience, especially when running Jenkins, SonarQube, Nexus Repository, Docker, and a local Kubernetes cluster simultaneously, 16 GB or more RAM is recommended.

---

# Supported Operating Systems

The project has been validated on the following environments.

| Operating System | Status |
|------------------|--------|
| Ubuntu 22.04 LTS | ✅ Supported |
| Ubuntu 24.04 LTS | ✅ Recommended |
| Windows 11 with WSL2 | ✅ Recommended |
| macOS (Apple Silicon / Intel) | ⚠ Supported with minor adjustments |
| Red Hat Enterprise Linux | ⚠ Compatible |
| Rocky Linux | ⚠ Compatible |

Although the project is primarily documented using Ubuntu and Windows Subsystem for Linux (WSL2), the tooling is portable across most Linux distributions.

---

# Software Prerequisites

Install the following software before proceeding with the installation guide.

| Software | Version |
|----------|---------|
| Git | Latest Stable |
| Java | OpenJDK 17 |
| Apache Maven | 3.8+ |
| Docker Engine | Latest Stable |
| Docker Compose | v2 |
| kubectl | Latest Stable |
| Kind | Latest Stable |
| Helm | v3+ |
| Jenkins | LTS |
| SonarQube Community Edition | Latest |
| Nexus Repository OSS | Latest |
| Trivy | Latest |

Using the latest stable versions ensures compatibility with the pipeline and simplifies troubleshooting.

---

# Development Environment

The recommended development environment consists of the following tools.

| Tool | Purpose |
|------|---------|
| Visual Studio Code | Source code editing |
| Git | Version control |
| GitHub | Source repository |
| Docker Desktop / Docker Engine | Container runtime |
| WSL2 | Linux development environment (Windows) |
| Terminal | Command execution |

This combination provides a consistent and productive environment for developing, testing, and operating the platform.

---

# Prerequisite Checklist

Before proceeding to the installation guide, verify that the following prerequisites are satisfied.

| Requirement | Status |
|-------------|--------|
| Supported Operating System Installed | ☐ |
| Internet Connectivity Available | ☐ |
| Git Installed | ☐ |
| Java 17 Installed | ☐ |
| Maven Installed | ☐ |
| Docker Installed | ☐ |
| Docker Compose Installed | ☐ |
| kubectl Installed | ☐ |
| Kind Installed | ☐ |
| Helm Installed | ☐ |
| GitHub Account Available | ☐ |

Completing this checklist before installation helps reduce setup issues and ensures all required tools are available.

---

# Java Development Kit (JDK)

Java is required to build and package the sample application used throughout this project.

The application is compiled using **OpenJDK 17**, which provides Long-Term Support (LTS) and is widely adopted in enterprise environments.

## Required Version

| Component | Version |
|-----------|---------|
| Java | OpenJDK 17 (LTS) |

Verify the installation:

```bash
java -version
```

Expected output:

```text
openjdk version "17.x.x"
```

Java is required for:

- Maven builds
- Jenkins build agents
- SonarQube Scanner
- Application compilation
- WAR package generation

---

# Apache Maven

Apache Maven is the project's build automation and dependency management tool.

Responsibilities include:

- Downloading project dependencies
- Compiling source code
- Running unit tests
- Packaging the application
- Generating WAR artifacts

## Required Version

| Component | Version |
|-----------|---------|
| Maven | 3.8 or later |

Verify the installation:

```bash
mvn -version
```

Expected output should display:

- Apache Maven version
- Java version
- Maven home
- Operating System

---

# Git

Git is required for source code management and pipeline integration.

The Jenkins Pipeline retrieves application source code directly from GitHub using Git.

Git responsibilities include:

- Repository cloning
- Branch management
- Version control
- Pipeline checkout

Verify Git installation:

```bash
git --version
```

Example:

```text
git version 2.x.x
```

---

# GitHub Account

A GitHub account is required to host the application source code and Jenkins Pipeline.

The repository should include:

- Source code
- Jenkinsfile
- Dockerfile
- Helm Charts
- Kubernetes manifests
- Automation scripts
- Documentation

Recommended GitHub knowledge:

- Repository creation
- Branch management
- Pull Requests
- Personal Access Tokens (PAT)
- SSH Keys

---

# Docker

Docker provides the container runtime used throughout the project.

Docker responsibilities include:

- Building application images
- Running infrastructure services
- Containerizing the application
- Image distribution

Required components:

| Component | Purpose |
|-----------|---------|
| Docker Engine | Container runtime |
| Docker Compose v2 | Multi-container management |

Verify Docker:

```bash
docker version
```

Verify Docker Compose:

```bash
docker compose version
```

Docker must be running before continuing with the installation.

---

# Kubernetes (Kind)

The project deploys the application to a local Kubernetes cluster using **Kind (Kubernetes in Docker)**.

Kind provides a lightweight Kubernetes environment suitable for development, testing, and learning.

Verify Kind:

```bash
kind version
```

Verify Kubernetes CLI:

```bash
kubectl version --client
```

Confirm cluster access:

```bash
kubectl cluster-info
```

A running Kind cluster is required before deploying the application.

---

# Helm

Helm is the Kubernetes package manager used for deploying and managing application releases.

Helm responsibilities include:

- Packaging Kubernetes resources
- Template rendering
- Release management
- Upgrade management
- Rollback support

Verify Helm:

```bash
helm version
```

---

# Trivy

Trivy performs container image vulnerability scanning during the CI/CD pipeline.

It helps identify:

- Operating system vulnerabilities
- Application package vulnerabilities
- Secrets
- Misconfigurations

Verify Trivy:

```bash
trivy --version
```

Integrating Trivy into the pipeline enables early detection of security issues before deployment.

---

# Network Requirements

The platform requires reliable internet connectivity during installation and operation.

Internet access is necessary to:

- Download Maven dependencies
- Pull Docker images
- Install Helm charts
- Access GitHub repositories
- Retrieve vulnerability databases
- Install required packages

If operating in a restricted network, ensure that access to the required repositories and registries is available.

---

# Required Accounts

The following accounts should be available before starting the installation.

| Service | Purpose |
|----------|---------|
| GitHub | Source code hosting |
| Docker Hub *(optional)* | Public image repository |
| Nexus Repository | Private artifact and image repository |
| SonarQube | Code quality analysis |

Some environments may additionally require enterprise credentials for accessing internal repositories or container registries.

---

# Environment Variables

Ensure the following environment variables are configured where applicable.

| Variable | Description |
|----------|-------------|
| JAVA_HOME | Java installation directory |
| MAVEN_HOME | Maven installation directory (optional) |
| PATH | Includes Java, Maven, Docker, kubectl, Helm, and Trivy binaries |

Properly configured environment variables ensure that all required tools are accessible from the command line and Jenkins build agents.

---

# Network and Internet Requirements

A stable network connection is essential for installing, configuring, and operating the Enterprise DevSecOps CI/CD Pipeline.

Internet access is required to:

- Clone source code from GitHub
- Download Maven dependencies
- Pull Docker images
- Download Helm charts
- Retrieve Trivy vulnerability databases
- Install operating system packages
- Download Jenkins plugins
- Access SonarQube updates

In enterprise environments using proxy servers or restricted networks, ensure that the required repositories and registries are accessible.

---

# Required Network Access

The following endpoints should be reachable from the development environment.

| Service | Purpose |
|----------|---------|
| github.com | Source code repository |
| maven.apache.org | Maven documentation |
| repo.maven.apache.org | Maven Central Repository |
| hub.docker.com | Public Docker images |
| registry-1.docker.io | Docker Registry |
| githubusercontent.com | Tool downloads |
| artifacthub.io | Helm charts |
| aquasecurity.github.io | Trivy updates |

Organizations operating behind corporate firewalls should whitelist these endpoints where appropriate.

---

# Default Port Requirements

The following ports are used by the platform.

| Service | Default Port |
|----------|-------------:|
| Jenkins | 8080 |
| SonarQube | 9000 |
| Nexus Repository | 8081 |
| Kubernetes API Server | 6443 |
| Docker Engine | Unix Socket / Named Pipe |
| Application (Sample) | 8080 (container dependent) |

Verify that these ports are not already in use before installation.

Example:

```bash
sudo ss -tulpn
```

or

```bash
netstat -tulpn
```

---

# Disk Space Planning

The platform downloads multiple container images, Maven dependencies, and Kubernetes resources.

Approximate storage requirements are shown below.

| Component | Estimated Space |
|-----------|----------------:|
| Operating System | 20 GB |
| Docker Images | 15 GB |
| Kubernetes (Kind) | 5 GB |
| Maven Repository | 5 GB |
| Jenkins Data | 2 GB |
| Nexus Repository | 10 GB |
| SonarQube | 5 GB |
| Project Source Code | 2 GB |

**Recommended free disk space: 100 GB**

Using an SSD is strongly recommended to improve build, container, and Kubernetes performance.

---

# Resource Allocation Recommendations

Running all services simultaneously can consume significant system resources.

Recommended allocation:

| Component | CPU | Memory |
|-----------|----:|-------:|
| Jenkins | 2 Cores | 2 GB |
| SonarQube | 2 Cores | 4 GB |
| Nexus Repository | 2 Cores | 2 GB |
| Docker Engine | 2 Cores | 2 GB |
| Kubernetes (Kind) | 2 Cores | 4 GB |

Total recommended system resources:

- **CPU:** 8 Cores
- **Memory:** 16 GB or higher
- **Storage:** 100 GB SSD

These recommendations provide sufficient capacity for local development and testing.

---

# Virtualization Requirements

Docker Desktop, Kind, and Kubernetes require virtualization support.

Verify that hardware virtualization is enabled in the system BIOS or UEFI.

For Windows users:

- Enable Hyper-V (if required)
- Enable Virtual Machine Platform
- Enable Windows Subsystem for Linux (WSL2)

For Linux users:

- Verify KVM support if applicable
- Ensure Docker Engine is functioning correctly

---

# Time Synchronization

Accurate system time is important for:

- SSL/TLS certificate validation
- Jenkins build timestamps
- Kubernetes certificates
- Authentication tokens
- Container image metadata

Synchronize the system clock using NTP or the operating system's default time synchronization service.

---

# Pre-Installation Validation

Before beginning the installation process, verify the following.

| Validation | Status |
|------------|--------|
| Supported Operating System Installed | ☐ |
| Internet Connectivity Available | ☐ |
| Hardware Meets Recommended Requirements | ☐ |
| Java Installed | ☐ |
| Maven Installed | ☐ |
| Git Installed | ☐ |
| Docker Installed | ☐ |
| Docker Compose Installed | ☐ |
| kubectl Installed | ☐ |
| Kind Installed | ☐ |
| Helm Installed | ☐ |
| Trivy Installed | ☐ |
| GitHub Account Available | ☐ |
| Required Ports Available | ☐ |
| Disk Space Available | ☐ |

Completing this checklist significantly reduces installation issues and provides a consistent starting point for all users.

---

# Common Environment Issues

The following issues are frequently encountered during environment preparation.

| Issue | Possible Cause | Resolution |
|------|----------------|------------|
| Java not found | JAVA_HOME not configured | Configure JAVA_HOME and update PATH |
| Maven command unavailable | Maven not installed or PATH missing | Install Maven and update PATH |
| Docker daemon not running | Docker service stopped | Start Docker Engine or Docker Desktop |
| kubectl cannot connect | Kubernetes cluster not running | Create or start the Kind cluster |
| Helm command not found | Helm not installed | Install Helm and verify PATH |
| Trivy database download failed | Internet or proxy restriction | Verify network connectivity or proxy configuration |
| Jenkins cannot access GitHub | Missing credentials or firewall restriction | Configure GitHub credentials and verify network access |

Most setup problems can be resolved by verifying tool installation, environment variables, and network connectivity.

---

# Environment Readiness Summary

A properly prepared environment is essential for successfully deploying the Enterprise DevSecOps CI/CD Pipeline.

Before continuing, ensure that:

- Hardware resources meet the recommended specifications.
- The operating system is supported.
- All required development tools are installed.
- Network connectivity is available.
- Required ports are free.
- Virtualization is enabled.
- Docker and Kubernetes are operational.

Once these prerequisites are satisfied, the environment is ready for installation.

---

# Verification Commands

Before proceeding with the installation, verify that all required tools are correctly installed and accessible from the command line.

| Component | Verification Command |
|-----------|----------------------|
| Java | `java -version` |
| Maven | `mvn -version` |
| Git | `git --version` |
| Docker | `docker version` |
| Docker Compose | `docker compose version` |
| kubectl | `kubectl version --client` |
| Kind | `kind version` |
| Helm | `helm version` |
| Trivy | `trivy --version` |

Run each command individually and verify that the expected version information is displayed.

---

# Installation Readiness Checklist

Before continuing to the installation guide, ensure that every prerequisite has been completed.

| Requirement | Status |
|-------------|--------|
| Supported Operating System Installed | ☐ |
| Hardware Meets Recommended Specifications | ☐ |
| Internet Connectivity Available | ☐ |
| Java 17 Installed | ☐ |
| Apache Maven Installed | ☐ |
| Git Installed | ☐ |
| GitHub Account Available | ☐ |
| Docker Engine Installed | ☐ |
| Docker Compose Installed | ☐ |
| kubectl Installed | ☐ |
| Kind Installed | ☐ |
| Helm Installed | ☐ |
| Trivy Installed | ☐ |
| Required Ports Available | ☐ |
| Virtualization Enabled | ☐ |
| Environment Variables Configured | ☐ |

Completing this checklist ensures that your environment is fully prepared for deploying the Enterprise DevSecOps CI/CD Pipeline.

---

# Enterprise Recommendations

For the best experience while following this project, consider the following recommendations.

## Use Long-Term Support (LTS) Releases

Whenever possible, install LTS versions of operating systems and development tools to maximize compatibility and stability.

---

## Keep Tool Versions Updated

Use the latest stable releases of:

- Java
- Maven
- Docker
- kubectl
- Kind
- Helm
- Trivy

Avoid using outdated or end-of-life versions, as they may introduce compatibility or security issues.

---

## Use Solid-State Storage (SSD)

Docker images, Kubernetes clusters, and Maven dependencies generate significant disk I/O.

Using an SSD provides:

- Faster builds
- Improved container startup times
- Better Kubernetes performance
- Reduced overall installation time

---

## Allocate Sufficient Resources

Running multiple infrastructure components simultaneously requires adequate CPU and memory.

Recommended configuration:

- **CPU:** 8 Cores
- **Memory:** 16 GB or more
- **Storage:** 100 GB SSD

These resources provide a smoother development and testing experience.

---

## Maintain a Stable Internet Connection

Several installation steps require downloading dependencies, container images, and vulnerability databases.

Ensure that network connectivity is stable throughout the installation process.

---

# Related Documentation

The following documents build upon the prerequisites described in this guide.

## Getting Started

- [Project Overview](01_Project_Overview.md)
- [Installation Guide](03_Installation_Guide.md)
- [Project Structure](04_Project_Structure.md)

---

## Infrastructure

- [GitHub Setup](../02-Infrastructure/05_GitHub_Setup.md)
- [Jenkins Setup](../02-Infrastructure/06_Jenkins_Setup.md)
- [SonarQube Setup](../02-Infrastructure/07_SonarQube_Setup.md)
- [Nexus Setup](../02-Infrastructure/08_Nexus_Setup.md)

These documents explain how to install and configure each platform component after the environment has been prepared.

---

# Key Takeaways

Before beginning the installation, you should now have:

- A supported operating system
- Recommended hardware resources
- All required development tools installed
- Docker and Kubernetes ready for use
- Network connectivity verified
- Required environment variables configured
- Installation readiness confirmed

A well-prepared environment significantly reduces installation issues and provides a reliable foundation for the remainder of the project.

---

# Summary

This document described the prerequisites required to successfully deploy the Enterprise DevSecOps CI/CD Pipeline.

It covered:

- Hardware requirements
- Operating system compatibility
- Development tools
- Container and Kubernetes tooling
- Network requirements
- Storage planning
- Environment validation
- Common setup issues
- Enterprise recommendations

By completing these prerequisites, readers establish a consistent and reproducible environment that supports the installation and operation of the platform.

---

# Conclusion

Preparing the development environment is a critical first step in building a reliable DevSecOps platform.

Ensuring that the correct operating system, development tools, container runtime, Kubernetes platform, and supporting utilities are installed helps prevent common configuration issues and provides a solid foundation for the installation process.

With the environment now prepared, the next step is to install and configure the platform components that make up the Enterprise DevSecOps CI/CD Pipeline.

---

# Navigation

| Previous | Home | Next |
|-----------|------|------|
| [⬅️ Project Overview](01_Project_Overview.md) | [🏠 Documentation Portal](../README.md) | [➡️ Installation Guide](03_Installation_Guide.md) |

---

