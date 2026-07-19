# Nexus Setup

> **Enterprise DevSecOps CI/CD Pipeline – Nexus Repository Manager Configuration Guide**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Nexus Repository Manager Setup |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, DevSecOps Engineers, Platform Engineers, Cloud Engineers, Software Developers, Students |
| Maintainer | Muralidhar G |

---

# Purpose

This document explains how to install, configure, and validate Sonatype Nexus Repository Manager as the centralized artifact repository for the Enterprise DevSecOps CI/CD Pipeline.

Nexus Repository Manager provides secure storage, versioning, and distribution of build artifacts, enabling repeatable deployments and traceable software releases.

By the end of this guide, you will have:

- Nexus Repository Manager installed using Docker
- Administrator account configured
- Repository Manager accessible through the web interface
- Persistent storage configured
- Platform prepared for repository configuration and Jenkins integration

---

# Nexus Repository Manager Overview

Nexus Repository Manager is an enterprise artifact repository that stores, manages, and distributes software packages produced during the software development lifecycle.

Instead of downloading dependencies from multiple external sources or storing build outputs on local systems, organizations use Nexus as a centralized repository for artifacts.

Nexus enables teams to:

- Store build artifacts
- Manage software dependencies
- Host internal packages
- Proxy external repositories
- Version application releases
- Secure software distribution
- Improve build reproducibility

It serves as the authoritative source for application artifacts throughout the CI/CD pipeline.

---

# Why Nexus?

Modern CI/CD platforms generate numerous software artifacts, including compiled binaries, libraries, container images, and deployment packages.

Without a centralized repository:

- Artifacts become difficult to track.
- Releases may not be reproducible.
- Dependency management becomes inconsistent.
- Security and governance become more challenging.

Nexus addresses these challenges by providing:

- Centralized artifact storage
- Version management
- Repository governance
- Access control
- Dependency caching
- High availability support
- Integration with build automation tools

---

# Artifact Management in DevSecOps

Artifact management ensures that every deployment uses verified, versioned, and traceable software packages.

A typical workflow is:

```text
Developer
     │
     ▼
GitHub Repository
     │
     ▼
Jenkins Build
     │
     ▼
Compile Application
     │
     ▼
SonarQube Analysis
     │
     ▼
Package Artifact
     │
     ▼
Nexus Repository
     │
     ▼
Deployment Platform
```

Only validated artifacts should progress beyond the repository into deployment environments.

---

# Repository Types

Nexus supports multiple repository types to meet different software delivery requirements.

| Repository Type | Purpose |
|-----------------|---------|
| Hosted | Stores internally produced artifacts |
| Proxy | Caches artifacts from external repositories |
| Group | Combines multiple repositories into a single endpoint |

These repository types simplify dependency management while improving build performance and reliability.

---

# Supported Package Formats

Nexus Repository Manager supports a wide range of package formats.

Common examples include:

- Maven
- Docker
- Helm
- npm
- NuGet
- PyPI
- RubyGems
- Raw repositories
- Yum
- APT

The Enterprise DevSecOps project primarily uses:

- Maven
- Docker
- Helm
- Raw repositories (where appropriate)

---

# Nexus in the DevSecOps Platform

The following diagram illustrates Nexus within the overall delivery workflow.

```text
                 Developer
                      │
                      ▼
              GitHub Repository
                      │
                      ▼
                  Jenkins
                      │
          Build & Static Analysis
                      │
                      ▼
              Nexus Repository
                      │
         ┌────────────┼────────────┐
         │            │            │
         ▼            ▼            ▼
    Maven Artifacts Docker Images Helm Charts
                      │
                      ▼
               Kubernetes Cluster
```

Nexus acts as the central repository for all approved build outputs.

---

# Nexus Architecture

A standard Nexus deployment consists of the following components.

```text
              Docker Host
                   │
                   ▼
      Nexus Repository Container
                   │
        ┌──────────┴──────────┐
        ▼                     ▼
 Repository Storage      Web Interface
        │
        ▼
 Persistent Volumes
```

For production deployments, persistent storage should be backed by enterprise storage solutions and protected through regular backups.

---

# Installation Method

Nexus supports several deployment models.

| Installation Method | Supported | Recommended |
|---------------------|-----------|-------------|
| ZIP Installation | Yes | No |
| Native Package | Yes | No |
| Docker | Yes | ✅ Yes |
| Kubernetes | Yes | Future Enhancement |

This project standardizes on Docker to simplify installation, maintenance, and portability.

---

# Docker-Based Installation

Pull the latest Nexus Repository Manager image.

```bash
docker pull sonatype/nexus3:latest
```

Verify the image.

```bash
docker images
```

Expected output:

```text
sonatype/nexus3
```

---

# Create Persistent Storage

Create a Docker volume to preserve repository data.

```bash
docker volume create nexus-data
```

This volume stores:

- Repository data
- Blob stores
- User accounts
- Security configuration
- Repository configuration
- Logs

Persistent storage ensures that data survives container recreation.

---

# Run the Nexus Container

Example Docker command:

```bash
docker run -d \
  --name nexus \
  -p 8081:8081 \
  -v nexus-data:/nexus-data \
  sonatype/nexus3:latest
```

This configuration:

- Runs Nexus in detached mode.
- Exposes the web interface on port `8081`.
- Persists repository data using a Docker volume.

The first startup may take several minutes while Nexus initializes.

---

# Verify the Container

Confirm that Nexus is running.

```bash
docker ps
```

Expected output:

```text
CONTAINER ID   IMAGE                    STATUS
xxxxxxxxxxxx   sonatype/nexus3:latest   Up
```

If the container takes time to initialize, review the logs.

```bash
docker logs nexus
```

Wait until the logs indicate that the application has started successfully.

---

# Access Nexus Repository Manager

Open a web browser and navigate to:

```text
http://localhost:8081
```

The Nexus welcome page should appear once initialization is complete.

---

# Retrieve the Initial Administrator Password

Nexus generates a temporary administrator password during the first startup.

Retrieve it from the container.

```bash
docker exec nexus cat /nexus-data/admin.password
```

Copy the generated password for the initial login.

---

# Initial Login

Use the following credentials.

| Field | Value |
|------|-------|
| Username | `admin` |
| Password | Generated password from `admin.password` |

After successful authentication, Nexus prompts you to change the administrator password.

Select a strong password that complies with your organization's security standards.

---

# Dashboard Overview

After logging in, familiarize yourself with the primary administrative areas.

Common navigation includes:

- Browse
- Repositories
- Blob Stores
- Security
- Cleanup Policies
- Tasks
- System Information
- Support

These areas will be configured in subsequent sections of this guide.

---

# Installation Validation

Verify the installation using the following checks.

```bash
docker ps

docker logs nexus

curl http://localhost:8081
```

Validation checklist:

| Validation | Status |
|------------|--------|
| Docker image downloaded | ☐ |
| Nexus container running | ☐ |
| Persistent volume created | ☐ |
| Port 8081 accessible | ☐ |
| Administrator password retrieved | ☐ |
| Login successful | ☐ |
| Password changed | ☐ |
| Dashboard accessible | ☐ |

Complete all checks before proceeding.

---

# Expected Outcome

At the completion of this section:

- Nexus Repository Manager is installed using Docker.
- Persistent storage is configured.
- Administrator access is secured.
- Dashboard is accessible.
- Platform is ready for repository configuration and Jenkins integration.

---

# Related Documentation

Review the following guides if required.

## Infrastructure

- [GitHub Setup](05_GitHub_Setup.md)
- [Jenkins Setup](06_Jenkins_Setup.md)
- [SonarQube Setup](07_SonarQube_Setup.md)
- [Docker Setup](09_Docker_Setup.md)

## Getting Started

- [Installation Guide](../01-Getting-Started/03_Installation_Guide.md)
- [Project Structure](../01-Getting-Started/04_Project_Structure.md)

These documents provide the prerequisite knowledge for integrating Nexus Repository Manager into the Enterprise DevSecOps platform.

---

# Next Section

The next section focuses on **Repository Configuration & Security**, including:

- Blob Stores
- Hosted repositories
- Proxy repositories
- Group repositories
- Maven repositories
- Docker repositories
- User and role management
- Security realms
- Repository permissions
- HTTPS considerations
- Backup recommendations
- Operational best practices

---

# Repository Configuration & Security

With Nexus Repository Manager installed successfully, the next step is to configure repositories, storage, security, and governance for enterprise artifact management.

This section covers:

- Blob Stores
- Hosted repositories
- Proxy repositories
- Group repositories
- Maven repositories
- Docker repositories
- Repository naming standards
- Users and roles
- Security configuration
- Backup recommendations
- Operational best practices

At the end of this section, Nexus will be ready to integrate with Jenkins and securely manage software artifacts throughout the CI/CD lifecycle.

---

# Configuration Overview

The following diagram illustrates the primary configuration areas within Nexus Repository Manager.

```text
                  Nexus Repository Manager
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
   Blob Stores       Repositories        Security
        │                  │                  │
        ▼                  ▼                  ▼
 Storage           Hosted / Proxy /     Users & Roles
                   Group Repositories
```

Each configuration area contributes to secure, scalable, and maintainable artifact management.

---

# Blob Stores

Blob Stores provide the physical storage location for repository content.

Navigate to:

```text
Administration
    └── Repository
            └── Blob Stores
```

By default, Nexus creates a blob store named:

```text
default
```

For enterprise environments, consider creating separate blob stores for:

- Maven artifacts
- Docker images
- Helm charts
- Raw repositories
- Temporary repositories

This separation improves storage management and simplifies backup and cleanup operations.

---

# Hosted Repositories

Hosted repositories store artifacts produced internally.

Navigate to:

```text
Administration
    └── Repositories
            └── Create Repository
```

Common hosted repositories include:

| Repository | Purpose |
|------------|---------|
| maven-releases | Production-ready Maven artifacts |
| maven-snapshots | Development snapshot artifacts |
| docker-hosted | Internal Docker images |
| helm-hosted | Internal Helm charts |
| raw-hosted | Generic files |

Hosted repositories should be used for artifacts generated by your organization.

---

# Proxy Repositories

Proxy repositories cache packages from external repositories.

Examples:

| Proxy Repository | Remote Source |
|------------------|---------------|
| maven-central | Maven Central |
| docker-hub | Docker Hub |
| npm-proxy | npm Registry |
| pypi-proxy | PyPI |

Benefits include:

- Reduced internet dependency
- Faster builds
- Lower external bandwidth usage
- Improved availability
- Better dependency control

---

# Group Repositories

Group repositories provide a single endpoint that aggregates multiple repositories.

Example:

```text
maven-all

├── maven-central
├── maven-releases
└── maven-snapshots
```

Benefits:

- Simplified client configuration
- Centralized dependency resolution
- Reduced maintenance
- Transparent repository management

Developers and build tools typically interact with group repositories rather than individual repositories.

---

# Maven Repository Configuration

Recommended Maven repositories:

| Repository | Type |
|------------|------|
| maven-central | Proxy |
| maven-releases | Hosted |
| maven-snapshots | Hosted |
| maven-all | Group |

Repository policies:

| Repository | Version Policy |
|------------|----------------|
| Releases | Release |
| Snapshots | Snapshot |
| Group | Mixed |

This configuration supports both development and production artifact lifecycles.

---

# Docker Repository Configuration

Recommended Docker repositories:

| Repository | Type |
|------------|------|
| docker-hosted | Hosted |
| docker-proxy | Proxy |
| docker-group | Group |

Configure a dedicated HTTP or HTTPS connector for Docker clients according to your deployment requirements.

For production environments, HTTPS is strongly recommended.

---

# Helm Repository Configuration

For Kubernetes deployments, create repositories for Helm charts.

Recommended repositories:

| Repository | Type |
|------------|------|
| helm-hosted | Hosted |
| helm-proxy | Proxy (optional) |
| helm-group | Group |

Helm repositories enable centralized storage and versioning of deployment packages.

---

# Repository Naming Standards

Adopt consistent naming conventions to simplify administration.

Recommended examples:

```text
maven-releases
maven-snapshots
maven-central
maven-all

docker-hosted
docker-proxy
docker-group

helm-hosted
helm-group

raw-hosted
```

Naming standards improve readability and reduce configuration errors.

---

# User Management

Create individual user accounts where appropriate.

Navigate to:

```text
Administration
    └── Security
            └── Users
```

Recommended user categories:

| User | Purpose |
|------|---------|
| Administrator | Platform administration |
| Jenkins | CI/CD automation |
| Developer | Artifact consumption |
| Release Manager | Release administration |
| Auditor | Read-only access |

Avoid sharing administrative accounts.

---

# Role Management

Assign permissions using roles rather than individual privileges.

Typical roles:

- nx-admin
- Jenkins Publisher
- Developer
- Read Only
- Release Manager

Role-based access control simplifies long-term administration.

---

# Privilege Management

Apply the principle of least privilege.

Example:

| Privilege | Administrator | Jenkins | Developer |
|-----------|--------------|----------|------------|
| Repository Administration | ✅ | ❌ | ❌ |
| Publish Artifacts | ✅ | ✅ | ❌ |
| Browse Artifacts | ✅ | ✅ | ✅ |
| Delete Artifacts | ✅ | Optional | ❌ |

Review privileges periodically.

---

# Security Realms

Navigate to:

```text
Administration
    └── Security
            └── Realms
```

Enable only the authentication realms required by your organization.

Examples:

- Local Authentication
- LDAP Authentication
- Docker Bearer Token Realm

Remove unused authentication mechanisms to reduce the attack surface.

---

# Anonymous Access

Anonymous access should generally be disabled for internal repositories.

Navigate to:

```text
Administration
    └── Security
            └── Anonymous Access
```

Recommended setting:

```text
Disabled
```

Enable anonymous access only when there is a clear business requirement.

---

# SSL / HTTPS Considerations

For production deployments:

- Terminate HTTPS using a reverse proxy or load balancer.
- Use trusted TLS certificates.
- Redirect HTTP traffic to HTTPS.
- Protect administrative interfaces.
- Encrypt all client communications.

HTTPS protects credentials and artifact transfers.

---

# Cleanup Policies

Repository storage grows continuously.

Configure Cleanup Policies to remove:

- Old snapshots
- Temporary artifacts
- Obsolete builds
- Expired components

Navigate to:

```text
Administration
    └── Repository
            └── Cleanup Policies
```

Automated cleanup improves storage efficiency.

---

# Repository Tasks

Nexus includes scheduled maintenance tasks.

Common tasks:

- Compact Blob Store
- Rebuild Maven Metadata
- Delete Unused Components
- Cleanup Snapshots
- Repository Health Check

Schedule maintenance during periods of low activity.

---

# Backup Recommendations

Back up the following regularly:

- Blob Stores
- Repository configuration
- Security configuration
- Users
- Roles
- Scheduled tasks
- System configuration

Suggested frequency:

| Environment | Frequency |
|-------------|-----------|
| Development | Weekly |
| Test | Daily |
| Production | Daily (or according to organizational policy) |

Verify backup restoration procedures periodically.

---

# Operational Best Practices

Maintain a healthy Nexus environment by following these recommendations.

- Separate hosted, proxy, and group repositories.
- Use dedicated repositories for releases and snapshots.
- Enable cleanup policies.
- Remove obsolete repositories.
- Review repository growth regularly.
- Restrict administrative access.
- Monitor available disk space.
- Keep Nexus updated to supported releases.
- Use HTTPS for all production deployments.

These practices improve reliability, security, and long-term maintainability.

---

# Configuration Validation

Verify the following after completing configuration.

| Validation | Status |
|------------|--------|
| Blob Store Configured | ☐ |
| Hosted Repositories Created | ☐ |
| Proxy Repositories Created | ☐ |
| Group Repositories Created | ☐ |
| Maven Repositories Ready | ☐ |
| Docker Repository Ready | ☐ |
| Helm Repository Ready | ☐ |
| Users Configured | ☐ |
| Roles Configured | ☐ |
| Security Realms Reviewed | ☐ |
| Cleanup Policies Enabled | ☐ |

Complete all applicable items before integrating Nexus with Jenkins.

---

# Best Practices

Follow these recommendations for enterprise artifact management.

- Store only approved artifacts in release repositories.
- Separate development and production artifacts.
- Restrict deletion permissions.
- Use meaningful repository names.
- Apply cleanup policies consistently.
- Monitor blob store utilization.
- Keep repositories organized by package format.
- Document repository purposes and ownership.

These practices improve governance and operational efficiency.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|-------|----------------|------------|
| Repository creation fails | Insufficient permissions | Verify user role and repository privileges |
| Artifact upload denied | Missing publish permission | Review user roles and privileges |
| Docker push fails | Incorrect Docker connector configuration | Verify Docker repository connector and client settings |
| Proxy repository unavailable | External repository unreachable | Check network connectivity and remote URL |
| Blob Store full | Insufficient storage | Expand storage or enable cleanup policies |
| Slow repository performance | Large repository size or limited resources | Review storage, JVM settings, and cleanup tasks |
| Anonymous access unexpectedly enabled | Security configuration issue | Review Anonymous Access settings |

Consult Nexus logs and the System Information page for additional diagnostics.

---

# Section Summary

Nexus Repository Manager has now been configured as an enterprise artifact repository.

You have:

- Configured Blob Stores.
- Created Hosted, Proxy, and Group repositories.
- Configured Maven, Docker, and Helm repositories.
- Applied repository naming standards.
- Configured users, roles, and privileges.
- Reviewed security settings.
- Established backup and maintenance practices.

The platform is now ready to integrate with Jenkins for automated artifact publication and lifecycle management.

---

# Next Section

The next section focuses on **Jenkins Integration & Artifact Management**, including:

- Jenkins credentials
- Nexus authentication
- Maven settings configuration
- Artifact publishing workflow
- Snapshot and release repositories
- Docker image publishing
- Artifact versioning
- Repository cleanup integration
- Integration validation
- Enterprise best practices

---

# Jenkins Integration & Artifact Management

With Nexus Repository Manager configured and secured, the next step is integrating it with Jenkins to automate artifact storage and distribution.

This integration ensures that every successful build publishes versioned artifacts to a centralized repository, enabling consistent deployments, traceability, and artifact reuse.

At the end of this section, Jenkins will:

- Connect securely to Nexus Repository Manager
- Authenticate using managed credentials
- Publish Maven artifacts
- Publish Docker images
- Support artifact versioning
- Prepare artifacts for deployment

---

# Integration Architecture

The following diagram illustrates the relationship between Jenkins and Nexus.

```text
                  Developer
                       │
                       ▼
               GitHub Repository
                       │
                       ▼
                   Jenkins
                       │
              Build & Test
                       │
                       ▼
              SonarQube Analysis
                       │
              Quality Gate Passed
                       │
                       ▼
               Package Artifact
                       │
                       ▼
          Nexus Repository Manager
           ┌─────────┼──────────┐
           ▼         ▼          ▼
      Maven Repo Docker Repo Helm Repo
                       │
                       ▼
             Deployment Platforms
```

Nexus becomes the single source of truth for all build outputs.

---

# Jenkins Integration Overview

Jenkins publishes build outputs only after:

1. Source code checkout completes.
2. Application compilation succeeds.
3. Unit tests pass.
4. Static code analysis passes.
5. Quality Gate approval is received.

Only validated artifacts should be stored in release repositories.

---

# Configure Nexus Credentials

Store Nexus credentials securely in Jenkins.

Navigate to:

```text
Manage Jenkins
    └── Credentials
```

Create credentials:

| Field | Value |
|------|-------|
| Kind | Username with Password |
| Username | nexus-publisher |
| Password | ******** |
| ID | nexus-credentials |

Never hard-code credentials in Jenkinsfiles or application source code.

---

# Configure Maven Settings

Maven deployments use a configured server definition.

Typical configuration:

```text
settings.xml

Servers
    └── Nexus Repository
```

The server identifier should match the repository configuration used during builds.

Repository credentials should be referenced through Jenkins-managed secrets.

> **Note:** Detailed `settings.xml` examples and Maven deployment configuration are covered in **13_Jenkins_Pipeline.md**.

---

# Nexus Authentication Flow

```text
Jenkins
     │
     ▼
Credentials Store
     │
     ▼
Username / Password
     │
     ▼
Nexus Repository
```

This approach ensures that authentication information remains encrypted and centrally managed.

---

# Artifact Publishing Workflow

A typical artifact publishing workflow follows this sequence.

```text
Source Code
      │
      ▼
Compile
      │
      ▼
Test
      │
      ▼
Static Analysis
      │
      ▼
Package
      │
      ▼
Publish to Nexus
      │
      ▼
Deployment
```

Each stage contributes to artifact quality and traceability.

---

# Maven Artifact Publishing

The Enterprise DevSecOps project primarily publishes:

- JAR files
- WAR files
- Parent POMs
- Maven metadata

Artifacts are uploaded to one of the following repositories:

| Repository | Purpose |
|------------|---------|
| maven-snapshots | Development builds |
| maven-releases | Production releases |

Release artifacts should be immutable once published.

---

# Snapshot Repositories

Snapshot repositories are intended for active development.

Characteristics:

- Frequently updated
- Version suffix includes `-SNAPSHOT`
- Used for continuous integration builds
- Automatically overwritten by newer snapshots

Example:

```text
1.0.0-SNAPSHOT
```

Snapshots should not be promoted directly to production.

---

# Release Repositories

Release repositories contain approved software versions.

Characteristics:

- Immutable
- Versioned
- Production-ready
- Traceable
- Reproducible

Example:

```text
1.0.0
1.1.0
2.0.0
```

Release repositories should accept only validated artifacts.

---

# Docker Image Publishing

Nexus can also function as a Docker Registry.

Typical workflow:

```text
Docker Build
      │
      ▼
Image Tag
      │
      ▼
Docker Login
      │
      ▼
Push Image
      │
      ▼
Docker Hosted Repository
```

Example image tags:

```text
latest
1.0.0
1.1.0
build-105
release-2026.07
```

Meaningful image tags improve deployment traceability.

---

# Helm Chart Publishing

Helm charts should be versioned and stored centrally.

Typical workflow:

```text
Package Helm Chart
        │
        ▼
Publish
        │
        ▼
helm-hosted Repository
```

Helm repositories provide version-controlled deployment packages for Kubernetes environments.

---

# Artifact Versioning Strategy

Use consistent versioning across all artifact types.

Recommended Semantic Versioning (SemVer):

```text
MAJOR.MINOR.PATCH
```

Examples:

```text
1.0.0
1.1.0
1.1.1
2.0.0
```

Development builds:

```text
2.0.0-SNAPSHOT
```

Semantic versioning improves compatibility tracking and release management.

---

# Artifact Lifecycle

Artifacts typically progress through the following lifecycle.

```text
Development
      │
      ▼
Snapshot
      │
      ▼
Testing
      │
      ▼
Release Candidate
      │
      ▼
Production Release
      │
      ▼
Archived
```

A clearly defined lifecycle supports governance and compliance requirements.

---

# Artifact Promotion Concepts

Production repositories should receive only approved artifacts.

Typical promotion path:

```text
Snapshots
      │
      ▼
Quality Validation
      │
      ▼
Release Repository
      │
      ▼
Production Deployment
```

Promotion should occur only after:

- Successful builds
- Passing tests
- Successful static analysis
- Quality Gate approval
- Security scanning
- Release approval (where applicable)

---

# Cleanup Policy Integration

Repository cleanup policies help control storage growth.

Recommended cleanup targets:

- Expired snapshots
- Temporary builds
- Development artifacts
- Obsolete versions

Release repositories should generally exclude automatic deletion policies.

---

# Integration Validation

Verify the following after completing the integration.

| Validation | Status |
|------------|--------|
| Nexus Credentials Created | ☐ |
| Authentication Successful | ☐ |
| Maven Repository Accessible | ☐ |
| Snapshot Repository Working | ☐ |
| Release Repository Working | ☐ |
| Docker Repository Accessible | ☐ |
| Helm Repository Accessible | ☐ |
| Artifact Published Successfully | ☐ |
| Artifact Visible in Nexus | ☐ |

Complete all validation steps before enabling automated artifact publication.

---

# Best Practices

Follow these recommendations for reliable artifact management.

- Publish only successful builds.
- Separate snapshot and release repositories.
- Use Semantic Versioning consistently.
- Store immutable release artifacts.
- Restrict artifact deletion.
- Apply cleanup policies to snapshot repositories.
- Monitor repository growth.
- Document repository ownership and retention policies.
- Protect release repositories with appropriate access controls.

These practices improve reproducibility, governance, and operational efficiency.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|-------|----------------|------------|
| Authentication failed | Incorrect Jenkins credentials | Verify stored credentials and repository permissions |
| Artifact upload fails | Repository URL or permissions incorrect | Validate repository configuration and user privileges |
| Maven deployment fails | Server ID mismatch | Verify Maven server identifier and Nexus repository configuration |
| Docker push rejected | Registry authentication failure | Confirm Docker login and hosted repository settings |
| Helm chart upload fails | Repository configuration issue | Verify Helm hosted repository configuration |
| Snapshot uploaded to release repository | Incorrect deployment target | Review repository selection and versioning strategy |
| Artifact not visible | Upload incomplete or indexing delay | Verify upload logs and refresh repository view |

Review Jenkins console logs and Nexus server logs for detailed diagnostic information.

---

# Section Summary

Nexus Repository Manager is now fully integrated with Jenkins.

You have:

- Configured secure authentication.
- Prepared Maven repository integration.
- Established Docker image publishing.
- Configured Helm chart storage.
- Implemented artifact versioning.
- Defined artifact lifecycle and promotion concepts.
- Validated the integration between Jenkins and Nexus.

With this integration complete, Nexus provides centralized, secure, and version-controlled artifact management for the Enterprise DevSecOps CI/CD Pipeline.

---

# Next Section

The final section covers:

- End-to-end validation
- Repository health checks
- Operational checklist
- Security best practices
- Performance recommendations
- Backup and restore
- Routine maintenance
- Common issues and troubleshooting
- Disaster recovery
- Related documentation
- Summary and conclusion

This completes the Nexus Repository Manager configuration and operational guidance for the Enterprise DevSecOps platform.

---

# Validation, Best Practices & Troubleshooting

With Nexus Repository Manager installed, configured, and integrated with Jenkins, the final step is to verify that the platform is healthy, secure, and ready for enterprise artifact management.

This section provides validation procedures, operational guidance, backup recommendations, disaster recovery planning, and troubleshooting techniques.

---

# End-to-End Validation

Before enabling automated artifact publishing in production, validate the complete Nexus environment.

---

## Service Validation

Verify that the Nexus container is running.

```bash
docker ps
```

Expected output:

```text
CONTAINER ID   IMAGE                    STATUS
xxxxxxxxxxxx   sonatype/nexus3:latest   Up
```

---

## Web Interface Validation

Open the Nexus dashboard.

```text
http://localhost:8081
```

Confirm that:

- Login page loads successfully.
- Dashboard is accessible.
- Repository Manager is fully initialized.
- Administration menu is available.
- Repository pages load correctly.
- No critical system warnings are displayed.

---

## Repository Validation

Navigate to:

```text
Administration
    └── Repositories
```

Verify that the expected repositories are present.

Typical repositories include:

- maven-releases
- maven-snapshots
- maven-central
- maven-all
- docker-hosted
- docker-group
- helm-hosted

Confirm that each repository is online and accessible.

---

## Blob Store Validation

Navigate to:

```text
Administration
    └── Blob Stores
```

Verify:

- Blob store exists.
- Storage path is correct.
- Available disk space is sufficient.
- Blob store reports a healthy status.

---

## Jenkins Integration Validation

Execute a sample Jenkins build.

Verify that:

- Jenkins authenticates successfully.
- Artifact upload completes.
- Build finishes successfully.
- Published artifact appears in the correct repository.
- Build logs contain no authentication or deployment errors.

---

## Artifact Validation

Browse the published artifact.

Confirm:

- Artifact version is correct.
- Metadata is available.
- Checksums are generated.
- Download succeeds.
- Repository indexing completes successfully.

Repeat the validation for each supported artifact type, such as Maven packages, Docker images, and Helm charts.

---

# Health Checks

Perform routine health checks to maintain a reliable repository service.

Recommended checks:

- Verify container status.
- Review repository health.
- Monitor Blob Store utilization.
- Check scheduled tasks.
- Review storage capacity.
- Confirm repository availability.
- Monitor JVM memory usage.
- Verify backup completion.

Routine monitoring helps identify issues before they affect software delivery.

---

# Operational Checklist

| Validation | Status |
|------------|--------|
| Nexus Running | ☐ |
| Dashboard Accessible | ☐ |
| Blob Store Healthy | ☐ |
| Hosted Repositories Available | ☐ |
| Proxy Repositories Available | ☐ |
| Group Repositories Available | ☐ |
| Jenkins Connected | ☐ |
| Artifact Publishing Successful | ☐ |
| Docker Registry Operational | ☐ |
| Helm Repository Operational | ☐ |
| Backup Completed | ☐ |

Complete this checklist before onboarding development teams.

---

# Security Best Practices

Nexus stores software artifacts that are deployed into downstream environments. Protecting these artifacts is essential for software supply chain security.

## Authentication

- Change the default administrator password immediately.
- Create individual administrator accounts.
- Rotate service account credentials regularly.
- Store CI/CD credentials only in Jenkins Credentials.

---

## Authorization

- Apply the principle of least privilege.
- Restrict repository administration.
- Separate publishing and browsing permissions.
- Audit user roles regularly.

---

## Repository Security

- Separate snapshot and release repositories.
- Restrict deletion of release artifacts.
- Disable anonymous access unless explicitly required.
- Archive obsolete repositories.
- Review repository permissions periodically.

---

## Infrastructure Security

- Use HTTPS for production deployments.
- Protect the administrative interface behind trusted networks.
- Keep Nexus updated to supported releases.
- Secure persistent storage.
- Restrict container runtime permissions.

---

# Performance Best Practices

To maintain responsive repository performance:

- Allocate sufficient JVM heap memory.
- Monitor CPU utilization.
- Monitor storage growth.
- Use cleanup policies for snapshot repositories.
- Compact Blob Stores periodically.
- Separate storage for large repositories when appropriate.
- Remove obsolete repositories and components.
- Review scheduled maintenance task execution.

Performance tuning requirements will increase as repository usage grows.

---

# Backup Strategy

Back up the following components regularly.

## Blob Stores

Contains:

- Maven artifacts
- Docker images
- Helm charts
- Raw repositories

Blob Stores represent the primary artifact storage.

---

## Configuration

Back up:

- Repository configuration
- Security configuration
- Users
- Roles
- Cleanup policies
- Scheduled tasks

---

## Suggested Backup Frequency

| Environment | Frequency |
|-------------|-----------|
| Development | Weekly |
| Test | Daily |
| Production | Daily (or according to organizational policy) |

Regularly perform restore testing to verify backup integrity.

---

# Routine Maintenance

Perform the following maintenance activities.

### Daily

- Review failed artifact uploads.
- Monitor storage utilization.
- Verify repository availability.

### Weekly

- Review cleanup policy execution.
- Compact Blob Stores if required.
- Review inactive users.
- Verify scheduled task completion.

### Monthly

- Upgrade to supported Nexus releases.
- Audit repository permissions.
- Review repository growth trends.
- Review JVM memory usage.
- Validate backup restoration procedures.

Routine maintenance helps ensure long-term platform reliability.

---

# Common Problems

| Problem | Possible Cause | Resolution |
|---------|----------------|------------|
| Nexus not starting | Container initialization failure | Review Docker logs and verify system resources |
| Login fails | Incorrect administrator credentials | Verify credentials or reset the administrator password |
| Artifact upload denied | Missing publish privileges | Review repository permissions and Jenkins credentials |
| Maven deployment fails | Repository configuration mismatch | Verify repository URL and Maven settings |
| Docker push fails | Registry authentication issue | Confirm Docker connector configuration and credentials |
| Helm chart upload fails | Hosted repository configuration issue | Review Helm repository settings |
| Repository unavailable | Storage or JVM issue | Review system resources and Nexus logs |
| Slow repository performance | Large Blob Store or insufficient memory | Monitor storage utilization and JVM configuration |

Consult Docker logs, Nexus logs, and Jenkins build logs for additional diagnostic information.

---

# Disaster Recovery

If Nexus becomes unavailable:

1. Restore Blob Store data.
2. Restore repository configuration.
3. Restore security configuration.
4. Recreate the Nexus container.
5. Verify administrator access.
6. Confirm repository availability.
7. Execute a sample Jenkins build.
8. Validate artifact publication and download.
9. Verify Docker image and Helm chart access.

Document recovery procedures and test them periodically.

---

# Related Documentation

Continue with the following guides.

## Infrastructure

- [GitHub Setup](05_GitHub_Setup.md)
- [Jenkins Setup](06_Jenkins_Setup.md)
- [SonarQube Setup](07_SonarQube_Setup.md)
- [Docker Setup](09_Docker_Setup.md)
- [Kind Setup](10_Kind_Setup.md)
- [Helm Setup](11_Helm_Setup.md)
- [Trivy Setup](12_Trivy_Setup.md)

## CI/CD

- [Jenkins Pipeline](../03-CI-CD-Pipeline/13_Jenkins_Pipeline.md)
- [Pipeline Stages](../03-CI-CD-Pipeline/14_Pipeline_Stages.md)

---

# Key Takeaways

After completing this guide, you should be able to:

- Install Nexus Repository Manager using Docker.
- Configure enterprise repositories.
- Manage Blob Stores and repository storage.
- Configure secure authentication and authorization.
- Integrate Nexus with Jenkins.
- Publish Maven artifacts, Docker images, and Helm charts.
- Apply artifact versioning and lifecycle management.
- Validate the complete artifact repository platform.
- Implement backup, maintenance, and disaster recovery procedures.

Nexus Repository Manager is now prepared to serve as the centralized artifact repository for the Enterprise DevSecOps CI/CD Pipeline.

---

# Summary

Nexus Repository Manager provides centralized artifact storage, version management, and distribution for the Enterprise DevSecOps platform.

By combining secure repository configuration, centralized artifact management, automated publishing, and operational best practices, Nexus ensures that software artifacts remain traceable, reproducible, and available throughout the software delivery lifecycle.

The configuration completed in this guide establishes a robust artifact management foundation that integrates seamlessly with Jenkins and supports automated CI/CD workflows.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Jenkins Integration & Artifact Management](08_Nexus_Setup.md#jenkins-integration--artifact-management) | [🏠 Documentation Portal](../README.md) | [➡️ Docker Setup](09_Docker_Setup.md) |

---

# Conclusion

Congratulations! You have completed the **Nexus Repository Manager Setup** guide.

Your environment now includes:

- A Docker-based Nexus Repository Manager installation.
- Enterprise-ready repository configuration.
- Secure user, role, and permission management.
- Hosted, Proxy, and Group repositories.
- Integration with Jenkins for automated artifact publication.
- Maven, Docker, and Helm repository support.
- Validation procedures and operational guidance.
- Backup, maintenance, and disaster recovery recommendations.

Nexus Repository Manager is now fully prepared to serve as the centralized artifact repository within the Enterprise DevSecOps CI/CD Pipeline.

The next document, **Docker Setup**, will configure the container runtime used to build, package, and run application workloads throughout the CI/CD pipeline, providing the foundation for containerized builds and Kubernetes deployments.
