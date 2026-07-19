# Helm Setup

> **Enterprise DevSecOps CI/CD Pipeline – Helm Platform Configuration Guide**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Helm Setup |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, Platform Engineers, Cloud Engineers, Developers |
| Maintainer | Muralidhar G |

---

# Purpose

Helm is the package manager for Kubernetes. It simplifies application deployment by packaging Kubernetes resources into reusable, versioned Helm Charts.

Within the Enterprise DevSecOps Platform, Helm provides:

- Standardized deployments
- Version-controlled application releases
- Rollback capabilities
- Configuration management
- Reusable deployment templates
- Consistent deployments across environments

This guide explains how to install, configure, secure, and validate Helm for enterprise Kubernetes environments.

---

# Part 1 – Helm Overview & Installation

---

# Helm Overview

Helm is an open-source package manager that manages Kubernetes applications using **Charts**.

A Helm Chart bundles:

- Deployments
- Services
- ConfigMaps
- Secrets
- Ingress
- Persistent Volumes
- Custom Resources

into a single version-controlled deployment package.

Helm simplifies Kubernetes application lifecycle management while reducing configuration duplication.

---

# Why Helm?

Managing raw Kubernetes YAML manifests becomes increasingly difficult as applications grow.

Helm addresses these challenges by providing:

- Reusable templates
- Parameterized configuration
- Versioned releases
- Easy upgrades
- Rollbacks
- Repository management
- Dependency handling

These capabilities make Helm the preferred deployment mechanism for Kubernetes applications.

---

# Helm Architecture

```text
               Developer
                    │
                    ▼
               Helm CLI
                    │
                    ▼
             Kubernetes API
                    │
                    ▼
             Kubernetes Cluster
                    │
       ┌────────────┼────────────┐
       ▼            ▼            ▼
  Deployments   Services   ConfigMaps
```

Helm communicates directly with the Kubernetes API Server to manage application releases.

---

# Helm Components

| Component | Purpose |
|-----------|---------|
| Helm CLI | Command-line interface |
| Chart | Kubernetes package |
| Repository | Collection of charts |
| Release | Installed chart instance |
| Values File | Configuration parameters |
| Templates | Kubernetes resource definitions |

---

# Helm Chart Structure

Typical chart structure:

```text
mychart/
├── Chart.yaml
├── values.yaml
├── charts/
├── templates/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── configmap.yaml
│   └── secret.yaml
└── README.md
```

---

# Install Helm

Install Helm using the official binary package for your operating system.

Verify installation:

```bash
helm version
```

Expected output:

```text
version.BuildInfo
```

---

# Verify Kubernetes Connectivity

Confirm Helm communicates with the cluster.

```bash
helm list
```

Expected output:

```text
No releases found
```

if no applications are currently installed.

---

# Helm Environment

Display Helm environment variables.

```bash
helm env
```

Verify:

- Cache directory
- Configuration directory
- Data directory

---

# Installation Validation

| Validation | Status |
|------------|--------|
| Helm Installed | ☐ |
| Version Verified | ☐ |
| Kubernetes Connected | ☐ |
| Helm Environment Verified | ☐ |

---

# Expected Outcome

At the end of this section:

- Helm is installed.
- Helm communicates with Kubernetes.
- The environment is ready for repository configuration.

---

# Part 2 – Repository Management, Charts & Security

---

# Repository Overview

Helm repositories store versioned Helm Charts.

Common repositories include:

- Bitnami
- Artifact Hub
- Nexus Helm Repository
- Internal Enterprise Repository

Repositories centralize chart distribution.

---

# Adding Repositories

Add a repository.

```bash
helm repo add <repository-name> <repository-url>
```

Update repositories.

```bash
helm repo update
```

List configured repositories.

```bash
helm repo list
```

---

# Repository Strategy

Recommended repository separation:

| Repository | Purpose |
|------------|----------|
| Public | Third-party charts |
| Internal | Organization charts |
| Development | Testing |
| Production | Approved releases |

---

# Chart Versioning

Use Semantic Versioning.

```text
MAJOR.MINOR.PATCH
```

Examples:

```text
1.0.0
1.2.0
2.0.1
```

Chart version and application version should be managed independently.

---

# Helm Releases

Each chart installation creates a release.

Release lifecycle:

```text
Install
   │
   ▼
Upgrade
   │
   ▼
Rollback
   │
   ▼
Uninstall
```

---

# Values Management

Helm uses `values.yaml` for configurable settings.

Typical parameters include:

- Image
- Tag
- Replica count
- Resources
- Service configuration
- Ingress settings

Environment-specific values should be maintained separately.

---

# Dependency Management

Charts may reference other charts.

Example dependencies:

- PostgreSQL
- Redis
- RabbitMQ
- Prometheus

Dependencies improve modularity and reuse.

---

# Security Best Practices

- Use trusted repositories.
- Sign charts where supported.
- Scan container images before deployment.
- Store Secrets securely.
- Review third-party charts.
- Restrict repository access.
- Apply RBAC.

---

# Backup Recommendations

Regularly back up:

- Internal charts
- Repository configuration
- Values files
- Release history

---

# Configuration Validation

| Validation | Status |
|------------|--------|
| Repository Added | ☐ |
| Repository Updated | ☐ |
| Chart Accessible | ☐ |
| Values Validated | ☐ |
| Security Review Completed | ☐ |

---

# Section Summary

Helm is now installed and configured with repository management, versioning, values management, and enterprise security practices.

The next section integrates Helm with Jenkins and introduces release management.

---

# Part 3 – Jenkins Integration & Release Management

With Helm installed and repositories configured, the next step is integrating Helm with Jenkins to automate Kubernetes application deployments.

This section focuses on platform integration, release management, authentication, and operational concepts. Helm chart development and pipeline implementation are covered in the CI/CD documentation.

---

# Integration Architecture

```text
                   Developer
                        │
                        ▼
                 GitHub Repository
                        │
                        ▼
                     Jenkins
                        │
              Helm Credentials
                        │
                        ▼
                    Helm CLI
                        │
                        ▼
              Kubernetes API Server
                        │
                        ▼
                 Kubernetes Cluster
                        │
        ┌───────────────┼────────────────┐
        ▼               ▼                ▼
   Deployments      Services      ConfigMaps
                        │
                        ▼
                     Running Pods
```

Helm communicates with the Kubernetes API Server to install, upgrade, rollback, and uninstall application releases.

---

# Jenkins Integration Overview

Helm enables Jenkins to:

- Deploy Kubernetes applications
- Upgrade releases
- Roll back failed deployments
- Validate deployments
- Manage release history
- Standardize application delivery

Jenkins should execute Helm commands using authenticated Kubernetes credentials.

---

# Helm Credentials

Store Kubernetes authentication securely in Jenkins.

Navigate to:

```text
Manage Jenkins
    └── Credentials
```

Typical credentials include:

- kubeconfig
- Service Account
- Kubernetes Token
- Cloud Provider Credentials

Avoid embedding cluster credentials within pipeline definitions.

---

# Helm Release Workflow

A standard Helm deployment follows this sequence.

```text
Source Code
      │
      ▼
Build Application
      │
      ▼
Build Docker Image
      │
      ▼
Push Image
      │
      ▼
Update Values
      │
      ▼
Helm Upgrade
      │
      ▼
Verify Deployment
```

Only validated container images should be referenced by production Helm releases.

---

# Helm Release Lifecycle

Each Helm release progresses through a controlled lifecycle.

```text
Install
   │
   ▼
Upgrade
   │
   ▼
Rollback
   │
   ▼
Uninstall
```

Release history allows previous revisions to be restored when necessary.

---

# Release Versioning

Maintain consistent versioning.

Recommended strategy:

```text
Chart Version

1.0.0

1.1.0

2.0.0
```

Application version:

```text
Application

1.0.12

1.0.15

2.0.0
```

Chart versions and application versions should be managed independently.

---

# Upgrade Strategy

Helm upgrades should be:

- Incremental
- Validated
- Repeatable

Recommended process:

```text
Validate
     │
     ▼
Backup
     │
     ▼
Upgrade
     │
     ▼
Health Check
     │
     ▼
Complete
```

Verify deployment health before promoting releases.

---

# Rollback Strategy

Rollback enables rapid recovery after deployment failures.

```text
Release 5
     │
Deployment Failed
     │
     ▼
Rollback
     │
     ▼
Release 4 Restored
```

Rollback procedures should be documented and regularly tested.

---

# Helm Repository Integration

Internal Helm repositories centralize chart distribution.

Recommended repositories:

| Repository | Purpose |
|------------|----------|
| Development | Testing |
| Staging | Pre-production |
| Production | Approved charts |

Nexus Repository Manager can serve as the organization's internal Helm repository.

---

# Release History

Maintain release history for:

- Auditing
- Troubleshooting
- Rollback
- Compliance

Review release history periodically to ensure obsolete releases are archived or removed according to retention policies.

---

# Integration Validation

Verify:

| Validation | Status |
|------------|--------|
| Helm Connected | ☐ |
| Kubernetes Accessible | ☐ |
| Repository Available | ☐ |
| Chart Installed | ☐ |
| Release Created | ☐ |
| Upgrade Successful | ☐ |
| Rollback Verified | ☐ |

---

# Best Practices

- Version every release.
- Maintain separate values files per environment.
- Store charts in internal repositories.
- Review release history.
- Validate upgrades before promotion.
- Keep chart dependencies updated.
- Restrict production deployments.
- Automate release validation.

---

# Section Summary

Helm is now integrated with Jenkins and prepared for enterprise Kubernetes release management.

The platform supports:

- Automated deployments
- Controlled upgrades
- Release history
- Rollback capabilities
- Repository integration

---

# Part 4 – Validation, Best Practices & Troubleshooting

---

# End-to-End Validation

Before deploying production workloads, validate the Helm platform.

---

## Helm Validation

Verify Helm installation.

```bash
helm version
```

Confirm:

- Client version
- Build information

---

## Repository Validation

List repositories.

```bash
helm repo list
```

Confirm:

- Repository available
- URL correct
- Repository reachable

---

## Chart Validation

Search configured repositories.

```bash
helm search repo
```

Verify required charts are available.

---

## Release Validation

List installed releases.

```bash
helm list
```

Confirm:

- Release name
- Namespace
- Revision
- Status

---

## Kubernetes Validation

Verify Kubernetes connectivity.

```bash
kubectl cluster-info
```

Ensure the cluster is reachable before executing Helm operations.

---

## Deployment Validation

Deploy a sample chart.

Verify:

- Release created
- Pods running
- Services available
- Application accessible

---

## Jenkins Validation

Execute a sample deployment pipeline.

Confirm:

- Helm commands succeed.
- Release installs successfully.
- Deployment completes.
- Health verification passes.

---

# Operational Checklist

| Validation | Status |
|------------|--------|
| Helm Installed | ☐ |
| Repository Configured | ☐ |
| Kubernetes Connected | ☐ |
| Chart Available | ☐ |
| Release Installed | ☐ |
| Upgrade Verified | ☐ |
| Rollback Tested | ☐ |
| Backup Completed | ☐ |

---

# Security Best Practices

Implement the following controls.

- Use trusted chart repositories.
- Restrict repository access.
- Apply RBAC.
- Protect kubeconfig files.
- Store Secrets securely.
- Validate chart sources.
- Rotate credentials regularly.
- Limit production deployment permissions.

---

# Performance Recommendations

Monitor:

- Release count
- Repository synchronization
- Deployment duration
- Failed upgrades
- Rollback frequency
- Kubernetes resource usage

Regular monitoring improves deployment reliability.

---

# Backup Strategy

Back up:

- Charts
- Values files
- Repository configuration
- Release metadata
- Kubernetes manifests
- Infrastructure definitions

Test restoration procedures regularly.

---

# Routine Maintenance

### Daily

- Review failed releases.
- Monitor deployment health.
- Verify repository availability.

### Weekly

- Update repositories.
- Review release history.
- Remove obsolete test releases.

### Monthly

- Upgrade Helm.
- Review chart dependencies.
- Validate backups.
- Audit repository permissions.

---

# Common Problems

| Problem | Possible Cause | Resolution |
|----------|----------------|------------|
| Chart not found | Repository outdated | Run repository update |
| Release failed | Invalid values | Validate values configuration |
| Upgrade failed | Kubernetes resource conflict | Review deployment status |
| Rollback unsuccessful | Missing release history | Verify retained revisions |
| Repository unavailable | Network or authentication issue | Verify repository configuration |
| Kubernetes connection failed | Invalid kubeconfig | Review Kubernetes credentials |

Review Helm output, Kubernetes Events, and Pod logs before retrying deployments.

---

# Disaster Recovery

If Helm operations become unavailable:

1. Restore Helm repositories.
2. Restore values files.
3. Restore Kubernetes credentials.
4. Restore chart packages.
5. Verify Kubernetes connectivity.
6. Validate repository synchronization.
7. Test release installation.
8. Resume deployment operations.

Maintain version-controlled chart definitions and values files to simplify recovery.

---

# Related Documentation

## Infrastructure

- GitHub Setup
- Jenkins Setup
- SonarQube Setup
- Nexus Setup
- Docker Setup
- Kind Setup
- Trivy Setup

## CI/CD

- Jenkins Pipeline
- Pipeline Stages
- Build Guide
- Deployment Guide
- Verification Guide

---

# Key Takeaways

After completing this guide, you can:

- Install and configure Helm.
- Manage chart repositories.
- Package Kubernetes applications.
- Configure release management.
- Integrate Helm with Jenkins.
- Perform upgrades and rollbacks.
- Validate Helm deployments.
- Troubleshoot common release issues.

---

# Summary

Helm provides standardized package management for Kubernetes applications.

By combining reusable charts, centralized repositories, controlled release management, and Jenkins integration, Helm enables consistent, repeatable, and version-controlled application deployments across Kubernetes environments.

The Helm platform is now ready to support automated application delivery within the Enterprise DevSecOps CI/CD Pipeline.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Kind Setup](10_Kind_Setup.md) | [🏠 Documentation Portal](../README.md) | [➡️ Trivy Setup](12_Trivy_Setup.md) |

---

# Conclusion

Congratulations! You have completed the Helm Setup guide.

Your environment now includes:

- Enterprise Helm installation
- Repository management
- Chart versioning
- Release lifecycle management
- Jenkins integration
- Upgrade and rollback procedures
- Validation guidance
- Operational best practices
- Backup and disaster recovery recommendations

Helm is now fully prepared to manage Kubernetes application releases within the Enterprise DevSecOps CI/CD Pipeline.

The next guide, **Trivy Setup**, completes the Infrastructure section by introducing container image, filesystem, Kubernetes, and configuration scanning, establishing the security foundation for the DevSecOps pipeline.
