# Project Structure

> **Enterprise DevSecOps CI/CD Pipeline – Repository Structure and Organization Guide**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Project Structure |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, DevSecOps Engineers, Platform Engineers, Cloud Engineers, Students |
| Maintainer | Muralidhar G |

---

# Purpose

This document explains the organization of the **Enterprise DevSecOps CI/CD Pipeline** repository and the purpose of each major directory and file.

Understanding the repository structure helps contributors, developers, and platform engineers quickly locate source code, infrastructure definitions, deployment artifacts, automation scripts, and documentation.

A well-structured repository improves:

- Maintainability
- Readability
- Collaboration
- Scalability
- Automation
- Onboarding experience

---

# Repository Philosophy

The repository follows an **Infrastructure as Code (IaC)** and **Documentation as Code (DaC)** approach.

Every infrastructure component, deployment configuration, pipeline definition, and operational procedure is version-controlled alongside the application source code.

This design ensures that:

- Infrastructure changes are traceable.
- Documentation evolves with the project.
- Deployments are reproducible.
- Configuration drift is minimized.
- Teams collaborate using a single source of truth.

---

# Design Objectives

The repository has been designed with the following objectives:

- Keep application code isolated from infrastructure code.
- Organize deployment assets logically.
- Separate operational scripts from application logic.
- Provide comprehensive documentation.
- Support automated CI/CD pipelines.
- Simplify onboarding for new contributors.
- Enable future scalability without major restructuring.

These principles align with modern DevOps and DevSecOps practices.

---

# High-Level Repository Layout

At a high level, the repository is organized into five primary areas.

```text
automation-deployment-project/
│
├── Application Source Code
├── Infrastructure & Deployment
├── Automation Scripts
├── Documentation
└── Project Configuration
```

Each area has a clearly defined responsibility and should evolve independently while remaining integrated through the CI/CD pipeline.

---

# Repository Organization Principles

The repository follows several organizational principles.

## Separation of Concerns

Application source code, infrastructure definitions, documentation, and automation scripts are maintained in separate directories.

This reduces complexity and improves maintainability.

---

## Infrastructure as Code

Infrastructure components such as Docker, Kubernetes, and Helm are stored as version-controlled configuration files.

This enables repeatable deployments and simplifies environment recreation.

---

## Documentation as Code

All documentation resides within the repository and is maintained alongside the codebase.

Benefits include:

- Version-controlled documentation
- Peer review through pull requests
- Synchronization with implementation changes
- Consistent documentation standards

---

## Automation First

Manual processes are minimized.

Wherever possible, repetitive tasks are automated using:

- Jenkins Pipelines
- Shell scripts
- Docker Compose
- Helm
- Kubernetes manifests

Automation reduces human error and improves deployment consistency.

---

# Repository Architecture Overview

The repository supports the complete software delivery lifecycle.

```text
                    Source Code
                         │
                         ▼
                    Build System
                         │
                         ▼
                 Quality & Security
                         │
                         ▼
                Artifact Management
                         │
                         ▼
                 Containerization
                         │
                         ▼
                 Kubernetes Deployment
                         │
                         ▼
                Operations & Monitoring
```

Each repository directory contributes to one or more stages of this lifecycle.

---

# Intended Audience

This document is intended for:

- DevOps Engineers
- DevSecOps Engineers
- Platform Engineers
- Cloud Engineers
- Software Developers
- Students learning CI/CD
- Open-source contributors

It assumes readers have completed the previous Getting Started documents and have successfully installed the project.

---

# Repository Standards

To ensure consistency, contributors should follow these standards:

- Use meaningful directory names.
- Keep related resources together.
- Avoid duplicate configurations.
- Store reusable scripts in the `scripts` directory.
- Place documentation only under the `docs` directory.
- Keep build artifacts outside version control unless intentionally published.
- Use lowercase file and directory names where practical.

Following these standards helps maintain a clean and scalable repository structure.

---

# Expected Outcome

After reading this document, you will understand:

- The purpose of each top-level directory.
- Where to find application code.
- Where infrastructure definitions are stored.
- How deployment assets are organized.
- The role of automation scripts.
- The purpose of key configuration files.
- How the repository supports the complete DevSecOps workflow.

---

# Related Documentation

Before continuing, review the following documents if needed:

## Getting Started

- [Project Overview](01_Project_Overview.md)
- [Prerequisites](02_Prerequisites.md)
- [Installation Guide](03_Installation_Guide.md)

These documents provide the architectural context and installation steps required before exploring the repository structure.

---

# Next Section

The next section provides a detailed walkthrough of the repository directory structure, explaining the purpose and contents of every major directory and configuration file.

---

# Repository Directory Structure

The repository is organized into logical directories that separate application code, infrastructure, automation, documentation, and configuration.

This structure follows enterprise repository organization principles and supports long-term maintainability.

---

# Complete Repository Structure

The following represents the recommended repository layout.

> **Note:** The exact directory structure may evolve over time. Update this diagram whenever significant structural changes are introduced.

```text
automation-deployment-project/
│
├── application/
│   ├── src/
│   ├── target/
│   ├── pom.xml
│   └── Dockerfile
│
├── docker/
│
├── kubernetes/
│
├── helm/
│
├── scripts/
│
├── docs/
│   ├── 01-Getting-Started/
│   ├── 02-Infrastructure/
│   ├── 03-CI-CD-Pipeline/
│   ├── 04-Deployment-Operations/
│   └── 05-Reference/
│
├── images/
│
├── Jenkinsfile
├── docker-compose.yml
├── README.md
├── LICENSE
└── .gitignore
```

Each directory serves a specific purpose within the DevSecOps lifecycle.

---

# Top-Level Directory Overview

| Directory | Purpose |
|-----------|---------|
| `application/` | Application source code and build configuration |
| `docker/` | Docker-related configuration and images |
| `kubernetes/` | Kubernetes manifests |
| `helm/` | Helm charts for Kubernetes deployment |
| `scripts/` | Automation and utility scripts |
| `docs/` | Project documentation |
| `images/` | Architecture diagrams, screenshots, and supporting graphics |

Separating these responsibilities keeps the repository clean and easier to navigate.

---

# Application Directory

```text
application/
```

The **application** directory contains the business application and all files required to build it.

Typical contents include:

- Java source code
- Unit tests
- Maven configuration
- Dockerfile
- Application resources

Example:

```text
application/

├── src/

├── target/

├── pom.xml

└── Dockerfile
```

The `target/` directory is generated during the build process and typically should not be committed to version control.

---

# Docker Directory

```text
docker/
```

This directory stores Docker-specific resources.

Typical contents include:

- Dockerfiles
- Docker Compose overrides
- Initialization scripts
- Custom container configurations

Responsibilities:

- Build container images
- Define local development environments
- Configure container runtime behavior

---

# Kubernetes Directory

```text
kubernetes/
```

This directory contains Kubernetes resource definitions.

Examples include:

- Deployments
- Services
- ConfigMaps
- Secrets (templates only)
- Ingress resources
- Persistent Volume Claims

Example:

```text
kubernetes/

├── deployment.yaml

├── service.yaml

├── ingress.yaml

└── configmap.yaml
```

These manifests describe how the application should run within Kubernetes.

---

# Helm Directory

```text
helm/
```

Helm packages Kubernetes resources into reusable deployment charts.

Typical contents include:

```text
helm/

└── automation-app/

    ├── Chart.yaml

    ├── values.yaml

    └── templates/
```

Benefits of Helm include:

- Parameterized deployments
- Versioned releases
- Simplified upgrades
- Easy rollbacks
- Environment-specific configuration

---

# Scripts Directory

```text
scripts/
```

The **scripts** directory contains reusable automation utilities.

Examples:

- Build scripts
- Deployment scripts
- Cleanup scripts
- Validation scripts
- Environment setup scripts

Example:

```text
scripts/

├── build.sh

├── deploy.sh

├── cleanup.sh

└── verify.sh
```

Keeping automation scripts in a dedicated location improves discoverability and reuse.

---

# Documentation Directory

```text
docs/
```

All project documentation is maintained under the `docs` directory.

Structure:

```text
docs/

├── README.md

├── 01-Getting-Started/

├── 02-Infrastructure/

├── 03-CI-CD-Pipeline/

├── 04-Deployment-Operations/

└── 05-Reference/
```

Documentation is version-controlled and evolves alongside the project.

---

# Images Directory

```text
images/
```

This directory stores graphical assets used throughout the documentation.

Typical contents:

- Architecture diagrams
- Pipeline flowcharts
- Deployment screenshots
- Kubernetes diagrams
- Infrastructure illustrations

Keeping visual assets centralized simplifies documentation maintenance.

---

# Root-Level Configuration Files

Several important files are located in the repository root.

| File | Purpose |
|------|---------|
| `README.md` | Project overview and quick start |
| `Jenkinsfile` | Pipeline definition |
| `docker-compose.yml` | Local multi-container environment |
| `LICENSE` | Project license |
| `.gitignore` | Git exclusion rules |

These files provide the primary entry point for developers working with the repository.

---

# Build Output

During compilation, build artifacts are generated automatically.

Typical output:

```text
application/

└── target/

    ├── classes/

    ├── test-classes/

    ├── generated-sources/

    └── application.war
```

Generated artifacts should generally be excluded from version control unless explicitly required.

---

# Repository Navigation Tips

To navigate the repository efficiently:

- Start with `README.md` for an overview.
- Use `docs/` for detailed documentation.
- Modify application logic under `application/`.
- Store deployment manifests under `kubernetes/`.
- Update Helm charts under `helm/`.
- Keep reusable automation in `scripts/`.
- Place architecture diagrams in `images/`.

Following this organization reduces confusion and promotes consistency across the project.

---

# Section Summary

The repository is organized into clearly defined functional areas:

- **Application** – Source code and build configuration
- **Infrastructure** – Docker, Kubernetes, and Helm
- **Automation** – Utility scripts and deployment helpers
- **Documentation** – Comprehensive project guides
- **Configuration** – Root-level project settings

This structure enables scalable development, straightforward navigation, and effective collaboration.

The next section explains the role of the most important configuration files and how they support the overall DevSecOps workflow.

---

# Important Files Explained

In addition to the repository directories, several configuration and automation files are essential to the operation of the Enterprise DevSecOps CI/CD Pipeline.

This section explains the purpose of each file and how it contributes to the software delivery lifecycle.

---

# README.md

```text
README.md
```

The `README.md` file serves as the primary entry point for the repository.

It provides:

- Project overview
- Architecture summary
- Prerequisites
- Quick Start instructions
- Repository structure
- Documentation links
- Contribution guidelines

Every contributor should begin by reading this document.

---

# Jenkinsfile

```text
Jenkinsfile
```

The `Jenkinsfile` defines the CI/CD pipeline using **Pipeline as Code**.

Typical responsibilities include:

- Source code checkout
- Maven build
- Unit testing
- SonarQube analysis
- Quality Gate validation
- Artifact publication
- Docker image creation
- Trivy vulnerability scanning
- Kubernetes deployment
- Post-deployment verification

Example pipeline flow:

```text
Checkout
    │
    ▼
Build
    │
    ▼
Test
    │
    ▼
SonarQube
    │
    ▼
Nexus
    │
    ▼
Docker
    │
    ▼
Trivy
    │
    ▼
Helm Deploy
```

Keeping the pipeline definition in version control ensures consistent and repeatable builds.

---

# pom.xml

```text
application/pom.xml
```

The `pom.xml` file is the Maven project descriptor.

It defines:

- Project metadata
- Dependencies
- Plugins
- Build configuration
- Packaging type
- Java version
- Repository definitions

The Maven build lifecycle is driven entirely by this file.

Typical Maven phases include:

```text
Validate
Compile
Test
Package
Verify
Install
Deploy
```

Any changes to project dependencies or build behavior should be made within `pom.xml`.

---

# Dockerfile

```text
application/Dockerfile
```

The `Dockerfile` defines how the application container image is built.

Typical responsibilities include:

- Selecting the base image
- Copying application artifacts
- Installing required packages
- Exposing application ports
- Defining the container startup command

Example build process:

```text
Source Code
      │
      ▼
Maven Build
      │
      ▼
WAR File
      │
      ▼
Dockerfile
      │
      ▼
Docker Image
```

A well-designed Dockerfile improves build speed, image size, and security.

---

# docker-compose.yml

```text
docker-compose.yml
```

The `docker-compose.yml` file defines a multi-container local development environment.

Typical services include:

- Jenkins
- SonarQube
- Nexus Repository
- Supporting databases (if required)

Responsibilities:

- Container orchestration
- Network creation
- Volume management
- Environment variables
- Port mappings

Example startup:

```bash
docker compose up -d
```

This file simplifies local infrastructure deployment.

---

# Helm Chart Files

```text
helm/
```

Helm packages Kubernetes resources into reusable deployment charts.

Important files include:

| File | Purpose |
|------|---------|
| `Chart.yaml` | Chart metadata and version information |
| `values.yaml` | Default configuration values |
| `templates/` | Kubernetes resource templates |

Helm enables:

- Parameterized deployments
- Environment-specific configuration
- Version-controlled releases
- Rollback support

---

# Kubernetes Manifests

```text
kubernetes/
```

This directory contains declarative Kubernetes resource definitions.

Common manifests include:

- Deployment
- Service
- ConfigMap
- Ingress
- Secret templates
- PersistentVolumeClaim

These files describe the desired state of the application within the Kubernetes cluster.

---

# Shell Scripts

```text
scripts/
```

The `scripts` directory contains reusable automation scripts.

Typical examples include:

| Script | Purpose |
|---------|---------|
| `build.sh` | Build the application |
| `deploy.sh` | Deploy to Kubernetes |
| `verify.sh` | Validate deployment |
| `cleanup.sh` | Remove temporary resources |

Automating repetitive tasks improves consistency and reduces manual effort.

---

# Documentation Portal

```text
docs/README.md
```

The documentation portal serves as the central index for all project documentation.

It organizes content into five major sections:

- Getting Started
- Infrastructure
- CI/CD Pipeline
- Deployment & Operations
- Reference

This structure provides a guided learning path for users and contributors.

---

# .gitignore

```text
.gitignore
```

The `.gitignore` file specifies files and directories that should not be tracked by Git.

Typical exclusions include:

- Build artifacts
- IDE configuration
- Temporary files
- Log files
- Local environment files

Example:

```text
target/
*.log
.idea/
.vscode/
.env
```

Maintaining an appropriate `.gitignore` keeps the repository clean and avoids committing unnecessary files.

---

# LICENSE

```text
LICENSE
```

The `LICENSE` file defines how the project may be used, modified, and distributed.

Including a license:

- Clarifies legal permissions
- Encourages collaboration
- Supports open-source best practices
- Protects contributors and users

---

# File Relationships

The following diagram illustrates how the major files interact during a CI/CD pipeline execution.

```text
README.md
      │
      ▼
Developer
      │
      ▼
GitHub Repository
      │
      ▼
Jenkinsfile
      │
      ▼
pom.xml
      │
      ▼
Dockerfile
      │
      ▼
Docker Image
      │
      ▼
Helm Chart
      │
      ▼
Kubernetes Deployment
```

Each file contributes to a specific stage of the software delivery lifecycle.

---

# Configuration Management Principles

To maintain a reliable repository:

- Keep configuration under version control.
- Avoid hardcoding secrets.
- Use environment variables for sensitive values.
- Store reusable deployment logic in Helm charts.
- Maintain consistent file naming conventions.
- Review configuration changes through pull requests.

These practices improve maintainability and reduce configuration drift.

---

# Section Summary

The key files within the repository define:

- Project metadata
- Build automation
- Containerization
- Infrastructure deployment
- CI/CD pipeline logic
- Documentation
- Repository behavior

Together, they form the foundation of the Enterprise DevSecOps platform and enable automated, repeatable software delivery.

The next section explains the recommended development workflow, repository best practices, branching strategy, and contribution guidelines.

---

# Development Workflow

The repository is designed to support a standardized software development lifecycle that integrates development, quality assurance, security, and deployment into a single automated workflow.

The typical lifecycle begins with a developer making a code change and ends with the application being deployed to Kubernetes.

```text
Developer
     │
     ▼
Clone Repository
     │
     ▼
Create Feature Branch
     │
     ▼
Implement Changes
     │
     ▼
Local Testing
     │
     ▼
Git Commit
     │
     ▼
Push Changes
     │
     ▼
Pull Request
     │
     ▼
Code Review
     │
     ▼
Merge to Main
     │
     ▼
Jenkins Pipeline
     │
     ▼
Build
     │
     ▼
Quality Analysis
     │
     ▼
Security Scan
     │
     ▼
Artifact Publication
     │
     ▼
Docker Image
     │
     ▼
Helm Deployment
     │
     ▼
Kubernetes
```

Every stage contributes to a secure, automated, and repeatable software delivery process.

---

# Developer Workflow

The recommended daily workflow for contributors is:

1. Pull the latest changes from the main branch.
2. Create a new feature or bug-fix branch.
3. Implement the required changes.
4. Execute local builds and tests.
5. Commit changes with descriptive commit messages.
6. Push the branch to GitHub.
7. Create a Pull Request.
8. Address review comments.
9. Merge the Pull Request.
10. Allow the Jenkins Pipeline to validate and deploy the changes.

Following this workflow ensures code quality and minimizes integration issues.

---

# Repository Navigation Guide

The following table provides guidance on where to work based on the type of change being made.

| Task | Location |
|------|----------|
| Modify application code | `application/` |
| Update Docker configuration | `docker/` |
| Change Kubernetes manifests | `kubernetes/` |
| Update Helm deployment | `helm/` |
| Modify CI/CD pipeline | `Jenkinsfile` |
| Update build configuration | `application/pom.xml` |
| Add automation scripts | `scripts/` |
| Update documentation | `docs/` |
| Add architecture diagrams | `images/` |

Keeping changes isolated to the appropriate directory improves readability and simplifies reviews.

---

# Branching Strategy

A lightweight Git branching strategy is recommended.

```text
main
 │
 ├── feature/add-helm-support
 │
 ├── feature/update-pipeline
 │
 ├── bugfix/docker-build
 │
 ├── hotfix/security-patch
 │
 └── release/v1.0
```

Recommended branch naming conventions:

| Branch Type | Example |
|-------------|---------|
| Feature | `feature/add-monitoring` |
| Bug Fix | `bugfix/fix-build-error` |
| Hotfix | `hotfix/log4j-update` |
| Release | `release/v1.1.0` |

Consistent branch names make repository history easier to understand.

---

# Commit Message Guidelines

Commit messages should clearly describe the intent of the change.

Recommended format:

```text
<type>: <short description>
```

Examples:

```text
feat: add Helm deployment support

fix: resolve Docker build failure

docs: update installation guide

refactor: simplify deployment script

test: add integration tests

chore: update project dependencies
```

Meaningful commit messages improve traceability and simplify troubleshooting.

---

# Pull Request Guidelines

Every Pull Request should:

- Have a clear title.
- Include a concise description of the change.
- Reference related issues (if applicable).
- Pass all CI/CD pipeline stages.
- Be reviewed before merging.
- Keep changes focused on a single objective.

Small, focused Pull Requests are easier to review and reduce the likelihood of merge conflicts.

---

# Repository Best Practices

Follow these practices to maintain a healthy repository.

## Source Code

- Keep classes and modules focused on a single responsibility.
- Remove unused code.
- Write unit tests for new functionality.
- Follow established coding standards.

---

## Infrastructure

- Treat infrastructure as code.
- Version all deployment configurations.
- Avoid manual production changes.
- Validate Kubernetes manifests before deployment.

---

## Security

- Never commit secrets or credentials.
- Use Jenkins Credentials for sensitive information.
- Scan dependencies regularly.
- Review Trivy scan results before deployment.

---

## Documentation

- Update documentation whenever functionality changes.
- Keep examples synchronized with implementation.
- Use relative links between documentation pages.
- Store diagrams in the `images/` directory.

---

# Collaboration Guidelines

To support effective teamwork:

- Discuss significant architectural changes before implementation.
- Review Pull Requests constructively.
- Maintain a consistent coding style.
- Keep commits small and focused.
- Resolve merge conflicts promptly.
- Communicate breaking changes clearly.

Collaboration practices are just as important as technical implementation for long-term project success.

---

# Repository Maintenance

Regular maintenance activities include:

- Updating project dependencies.
- Removing obsolete code.
- Reviewing security vulnerabilities.
- Cleaning unused Docker images.
- Refreshing documentation.
- Updating CI/CD pipeline definitions.
- Reviewing Kubernetes manifests.
- Monitoring build stability.

Routine maintenance helps keep the project secure, stable, and maintainable.

---

# Related Documentation

Continue with the following documents to explore the infrastructure components in detail.

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

# Key Takeaways

After reading this document, you should understand:

- The overall repository organization.
- The purpose of each major directory.
- The role of key configuration files.
- How developers interact with the repository.
- Recommended branching and commit practices.
- Repository maintenance and collaboration guidelines.

A consistent repository structure enables efficient development, simplifies onboarding, and supports long-term scalability.

---

# Summary

The **Enterprise DevSecOps CI/CD Pipeline** repository is organized around clear architectural principles that separate application code, infrastructure, automation, and documentation.

This organization promotes maintainability, repeatability, and collaboration while supporting a fully automated software delivery lifecycle.

Understanding the repository layout will make it easier to navigate the project, contribute new features, troubleshoot issues, and extend the platform as it evolves.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Installation Guide](03_Installation_Guide.md) | [🏠 Documentation Portal](../README.md) | [➡️ GitHub Setup](../02-Infrastructure/05_GitHub_Setup.md) |

---

# Conclusion

Congratulations! You have completed the **Getting Started** section of the Enterprise DevSecOps CI/CD Pipeline documentation.

You now have:

- An understanding of the project's architecture.
- A prepared development environment.
- A fully installed local platform.
- A clear understanding of the repository structure.
- Guidance on development workflows and collaboration practices.

You are now ready to move into the **Infrastructure** section, beginning with **GitHub Setup**, where you'll configure the source control platform and integrate it with the CI/CD pipeline.
