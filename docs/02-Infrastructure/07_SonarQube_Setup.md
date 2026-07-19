# SonarQube Setup

> **Enterprise DevSecOps CI/CD Pipeline – SonarQube Configuration Guide**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | SonarQube Setup |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevOps Engineers, DevSecOps Engineers, Platform Engineers, Cloud Engineers, Software Developers, Students |
| Maintainer | Muralidhar G |

---

# Purpose

This document explains how to install, configure, and validate SonarQube as the static code analysis and code quality platform for the Enterprise DevSecOps CI/CD Pipeline.

SonarQube continuously analyzes source code to detect bugs, vulnerabilities, code smells, duplicated code, and maintainability issues before software reaches production.

By the end of this guide, you will have:

- SonarQube installed using Docker
- Administrator account configured
- Initial access verified
- Platform ready for project configuration
- Foundation prepared for Jenkins integration

---

# SonarQube Overview

SonarQube is an enterprise code quality platform that performs static analysis on application source code.

Unlike unit testing or integration testing, static analysis examines source code without executing the application.

SonarQube provides continuous feedback about:

- Code quality
- Security vulnerabilities
- Reliability issues
- Maintainability
- Technical debt
- Code duplication
- Coding standard violations

It enables development teams to identify and resolve issues early in the software development lifecycle.

---

# Why SonarQube?

High-quality software is easier to maintain, more secure, and less expensive to operate.

SonarQube helps organizations:

- Improve code quality
- Detect security vulnerabilities early
- Reduce technical debt
- Enforce coding standards
- Prevent quality regressions
- Support secure software development
- Measure maintainability over time
- Integrate quality checks into CI/CD pipelines

These capabilities make SonarQube a key component of modern DevSecOps practices.

---

# Static Code Analysis

Static code analysis evaluates source code without running the application.

Typical analysis includes:

- Syntax validation
- Bug detection
- Security vulnerability detection
- Code smell identification
- Complexity measurement
- Duplicate code detection
- Maintainability assessment

This analysis complements automated testing by identifying issues that tests alone may not detect.

---

# SonarQube in the DevSecOps Platform

The following diagram illustrates SonarQube's role within the software delivery lifecycle.

```text
                 Developer
                      │
                      ▼
              GitHub Repository
                      │
                      ▼
                  Jenkins
                      │
                      ▼
              SonarQube Analysis
                      │
          ┌───────────┴───────────┐
          │                       │
          ▼                       ▼
   Quality Gate Passed     Quality Gate Failed
          │                       │
          ▼                       ▼
   Continue Pipeline       Stop Pipeline
```

SonarQube acts as a quality checkpoint before artifacts are published or deployments begin.

---

# Benefits of Quality Gates

Quality Gates define the minimum quality standards that code must satisfy before progressing through the CI/CD pipeline.

Typical Quality Gate checks include:

- No blocker issues
- No critical vulnerabilities
- Minimum code coverage threshold
- Limited duplicated code
- Acceptable maintainability rating
- Security rating compliance

If a Quality Gate fails, Jenkins can stop the pipeline automatically.

---

# SonarQube Components

SonarQube consists of several major components.

| Component | Purpose |
|-----------|---------|
| Web Server | User interface and REST APIs |
| Compute Engine | Background analysis processing |
| Database | Stores analysis results and configuration |
| Scanner | Submits analysis from build tools |
| Quality Profiles | Coding rules |
| Quality Gates | Pass/fail evaluation |

Together, these components provide centralized code quality management.

---

# Supported Languages

SonarQube supports analysis for many programming languages.

Examples include:

- Java
- JavaScript
- TypeScript
- Python
- C#
- C++
- Go
- PHP
- Kotlin
- Terraform (via community plugins and external tooling)

The Enterprise DevSecOps project primarily analyzes Java applications while remaining extensible to other languages.

---

# SonarQube Architecture

The following diagram illustrates a typical deployment.

```text
                Docker Host
                     │
                     ▼
            SonarQube Container
                     │
         ┌───────────┼───────────┐
         │           │           │
         ▼           ▼           ▼
   Web Interface  Compute Engine  Scanner API
                     │
                     ▼
                 PostgreSQL
```

In production environments, PostgreSQL is the recommended database. Embedded databases are intended only for evaluation and development.

---

# Installation Method

SonarQube supports multiple installation approaches.

| Installation Method | Supported | Recommended |
|---------------------|-----------|-------------|
| ZIP Installation | Yes | No |
| Native Package | Yes | No |
| Docker | Yes | ✅ Yes |
| Kubernetes | Yes | Future Enhancement |

This project standardizes on Docker to simplify deployment and ensure consistency across environments.

---

# Docker-Based Installation

Pull the latest Long-Term Active (LTA) SonarQube image.

```bash
docker pull sonarqube:lts-community
```

Verify the image.

```bash
docker images
```

Expected output:

```text
sonarqube    lts-community
```

---

# Run the SonarQube Container

Example Docker command:

```bash
docker run -d \
  --name sonarqube \
  -p 9000:9000 \
  -v sonarqube_data:/opt/sonarqube/data \
  -v sonarqube_extensions:/opt/sonarqube/extensions \
  -v sonarqube_logs:/opt/sonarqube/logs \
  sonarqube:lts-community
```

This configuration:

- Runs SonarQube in detached mode.
- Exposes the web interface on port `9000`.
- Persists data, extensions, and logs using Docker volumes.

> **Note:** For production deployments, configure SonarQube to use an external PostgreSQL database rather than the embedded evaluation database.

---

# Verify the Container

Confirm that SonarQube is running.

```bash
docker ps
```

Expected output:

```text
CONTAINER ID   IMAGE                      STATUS
xxxxxxxxxxxx   sonarqube:lts-community    Up
```

If startup takes longer than expected, review the logs.

```bash
docker logs sonarqube
```

Allow several minutes for the initial startup, particularly on slower systems.

---

# Access SonarQube

Open a web browser and navigate to:

```text
http://localhost:9000
```

The login page should appear after initialization completes.

---

# Initial Login

Default credentials:

| Field | Value |
|------|-------|
| Username | `admin` |
| Password | `admin` |

After the first login, SonarQube prompts you to change the default administrator password.

Choose a strong, unique password that complies with your organization's security policies.

---

# Dashboard Overview

After logging in, familiarize yourself with the main areas of the user interface.

Typical navigation includes:

- Projects
- Issues
- Rules
- Quality Profiles
- Quality Gates
- Administration
- Marketplace

These areas will be configured in subsequent sections of this guide.

---

# Installation Validation

Run the following checks.

```bash
docker ps

docker logs sonarqube

curl http://localhost:9000/api/system/status
```

Expected API response:

```json
{
  "status": "UP"
}
```

Validation checklist:

| Validation | Status |
|------------|--------|
| Docker image downloaded | ☐ |
| SonarQube container running | ☐ |
| Port 9000 accessible | ☐ |
| Login page available | ☐ |
| Administrator login successful | ☐ |
| Password changed | ☐ |
| Dashboard accessible | ☐ |

Complete all checks before proceeding.

---

# Expected Outcome

At the completion of this section:

- SonarQube is installed using Docker.
- Persistent storage is configured.
- Administrator account is secured.
- Dashboard is accessible.
- Platform is ready for project configuration and Jenkins integration.

---

# Related Documentation

Review the following guides if required.

## Infrastructure

- [GitHub Setup](05_GitHub_Setup.md)
- [Jenkins Setup](06_Jenkins_Setup.md)
- [Docker Setup](09_Docker_Setup.md)

## Getting Started

- [Installation Guide](../01-Getting-Started/03_Installation_Guide.md)
- [Project Structure](../01-Getting-Started/04_Project_Structure.md)

These documents provide prerequisite knowledge for integrating SonarQube into the Enterprise DevSecOps platform.

---

# Next Section

The next section covers enterprise configuration and security, including:

- Project creation
- Authentication tokens
- Quality Profiles
- Quality Gates
- Rule management
- User and group administration
- Permissions
- Security settings
- Backup recommendations
- Operational best practices

---

# Configuration & Security

With SonarQube installed successfully, the next step is to configure the platform for enterprise use.

This section covers:

- Project creation
- Authentication
- Quality Profiles
- Quality Gates
- Rule management
- User administration
- Permissions
- Security configuration
- Backup recommendations
- Operational best practices

At the end of this section, SonarQube will be ready to integrate with Jenkins and enforce quality standards across the CI/CD pipeline.

---

# Configuration Overview

The following diagram illustrates the primary configuration areas.

```text
                  SonarQube
                      │
      ┌───────────────┼────────────────┐
      │               │                │
      ▼               ▼                ▼
   Projects     Quality Profiles   Administration
      │               │                │
      ▼               ▼                ▼
 Quality Gates     Rules         Users & Groups
      │
      ▼
 Authentication Tokens
```

Each configuration area contributes to a consistent and secure code quality process.

---

# Create a Project

Each application analyzed by SonarQube requires a project.

Navigate to:

```text
Projects
    └── Create Project
```

Recommended values:

| Field | Example |
|------|---------|
| Project Name | Enterprise DevSecOps Pipeline |
| Project Key | automation-deployment-project |
| Visibility | Private (recommended) |

The Project Key uniquely identifies analysis results and is referenced by scanners and CI/CD pipelines.

---

# Project Keys

Project Keys should remain stable throughout the lifecycle of the application.

Recommended format:

```text
organization:application

Example:

devops:automation-deployment-project
```

Guidelines:

- Use lowercase characters.
- Avoid spaces.
- Keep names descriptive.
- Do not change Project Keys after integration unless absolutely necessary.

Changing a Project Key can affect historical analysis and CI/CD configurations.

---

# Authentication Tokens

Jenkins authenticates to SonarQube using a generated authentication token.

Navigate to:

```text
My Account
    └── Security
            └── Generate Token
```

Recommended token name:

```text
jenkins-sonarqube-token
```

Store the generated token securely in the Jenkins Credentials Store.

Never expose authentication tokens in source code or pipeline scripts.

---

# Quality Profiles

A Quality Profile defines the coding rules applied during analysis.

Navigate to:

```text
Quality Profiles
```

A Quality Profile contains:

- Coding standards
- Security rules
- Reliability rules
- Maintainability rules
- Language-specific checks

Assign an appropriate profile for each programming language used within the project.

---

# Recommended Quality Profiles

Typical profiles include:

| Language | Recommended Profile |
|----------|---------------------|
| Java | Sonar way |
| JavaScript | Sonar way |
| Python | Sonar way |
| TypeScript | Sonar way |

The built-in **Sonar way** profiles provide a strong baseline and are suitable for most projects. Organizations may create custom profiles to enforce additional standards.

---

# Quality Gates

Quality Gates determine whether code is acceptable for promotion through the CI/CD pipeline.

Navigate to:

```text
Quality Gates
```

A typical enterprise Quality Gate evaluates:

- New Bugs
- New Vulnerabilities
- Security Hotspots Reviewed
- Code Coverage
- Duplicated Lines
- Maintainability Rating
- Reliability Rating
- Security Rating

If the configured Quality Gate fails, the Jenkins pipeline should stop until issues are resolved.

---

# Rule Management

Rules define the checks that SonarQube performs during analysis.

Navigate to:

```text
Rules
```

Rules are categorized by:

- Bugs
- Vulnerabilities
- Code Smells
- Security Hotspots
- Maintainability
- Reliability

Avoid disabling rules without documenting the business justification.

---

# Language Configuration

Verify that the required programming languages are available.

Navigate to:

```text
Administration
    └── Languages
```

Ensure support for:

- Java
- JavaScript
- TypeScript
- Python

Additional languages can be enabled as project requirements evolve.

---

# User Management

Create individual user accounts for administrators and developers when appropriate.

Navigate to:

```text
Administration
    └── Security
            └── Users
```

Recommended roles:

| Role | Responsibilities |
|------|------------------|
| Administrator | Full platform administration |
| DevOps Engineer | Project and Quality Gate administration |
| Developer | View analysis results and resolve issues |
| Viewer | Read-only access |

Avoid sharing administrator accounts.

---

# Group Management

Groups simplify permission management.

Typical groups include:

- Administrators
- DevOps
- Developers
- Auditors
- Viewers

Assign permissions to groups rather than individual users wherever possible.

---

# Permission Management

Configure permissions using the principle of least privilege.

Recommended permissions:

| Permission | Administrators | Developers | Viewers |
|------------|---------------|------------|---------|
| Administer System | ✅ | ❌ | ❌ |
| Administer Projects | ✅ | Optional | ❌ |
| Execute Analysis | ✅ | ✅ | ❌ |
| Browse Projects | ✅ | ✅ | ✅ |

Regularly review permissions to ensure that access remains appropriate.

---

# Security Configuration

Review the following security settings.

- Change the default administrator password immediately.
- Enable external authentication (LDAP, SAML, or OAuth) where available.
- Restrict anonymous access.
- Review active user sessions periodically.
- Keep SonarQube updated to supported releases.
- Enable HTTPS when deployed outside local development environments.

Strong security controls help protect both source code and analysis results.

---

# Database Considerations

For enterprise deployments, SonarQube should use PostgreSQL.

Benefits include:

- Improved performance
- Better scalability
- Backup support
- High availability options
- Vendor-supported configuration

The embedded evaluation database is intended only for demonstrations and development.

---

# Backup Recommendations

Back up the following components regularly.

- Database
- Extensions
- Configuration
- Plugins
- Custom Quality Profiles
- Custom Quality Gates

Suggested backup frequency:

| Environment | Frequency |
|-------------|-----------|
| Development | Weekly |
| Test | Daily |
| Production | Daily (or according to organizational policy) |

Test restoration procedures periodically to verify recoverability.

---

# Operational Best Practices

To maintain a healthy SonarQube environment:

- Review Quality Gates regularly.
- Keep Quality Profiles aligned with organizational coding standards.
- Update SonarQube to supported releases.
- Remove unused projects.
- Review inactive users.
- Archive obsolete analysis data where appropriate.
- Monitor disk usage and database growth.

Routine maintenance helps ensure accurate and reliable analysis.

---

# Configuration Validation

Verify the following after completing the configuration.

| Validation | Status |
|------------|--------|
| Project Created | ☐ |
| Project Key Configured | ☐ |
| Authentication Token Generated | ☐ |
| Quality Profile Assigned | ☐ |
| Quality Gate Configured | ☐ |
| Required Rules Available | ☐ |
| Users Configured | ☐ |
| Groups Configured | ☐ |
| Permissions Reviewed | ☐ |
| Security Settings Applied | ☐ |

Complete all applicable items before integrating SonarQube with Jenkins.

---

# Best Practices

Follow these recommendations to maintain a secure and effective code quality platform.

- Use dedicated authentication tokens for CI/CD systems.
- Keep Quality Gates simple and measurable.
- Prefer built-in profiles before creating custom ones.
- Review rule changes before enabling them organization-wide.
- Grant administrative privileges sparingly.
- Use groups to simplify permission management.
- Review Quality Gate failures promptly.
- Maintain documentation for custom rules and profiles.

These practices improve consistency, governance, and long-term maintainability.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|-------|----------------|------------|
| Unable to create project | Insufficient permissions | Verify user role and project administration permissions |
| Authentication token rejected | Invalid or expired token | Generate a new token and update Jenkins credentials |
| Quality Gate not available | Incorrect profile assignment | Verify Quality Gate configuration and project association |
| Missing language rules | Language plugin unavailable | Confirm language support and plugin installation |
| Users cannot access projects | Incorrect permission assignment | Review user groups and project permissions |
| Dashboard performance issues | Large database or insufficient resources | Review system resources and database health |

Consult SonarQube logs and the Administration pages for additional diagnostic information.

---

# Section Summary

SonarQube has now been configured as an enterprise code quality platform.

You have:

- Created projects.
- Configured authentication tokens.
- Assigned Quality Profiles.
- Defined Quality Gates.
- Reviewed coding rules.
- Configured users, groups, and permissions.
- Applied security recommendations.
- Established backup and operational practices.

The platform is now ready to integrate with Jenkins and participate in automated CI/CD quality enforcement.

---

# Next Section

The next section focuses on **Jenkins Integration & Quality Gates**, including:

- Jenkins plugin installation
- SonarQube Scanner configuration
- Jenkins credentials
- Pipeline integration
- Scanner execution
- Quality Gate enforcement
- Pull Request analysis
- Branch analysis
- Integration validation

---

# Jenkins Integration & Quality Gates

With SonarQube configured and secured, the next step is integrating it with Jenkins so that every code change is automatically analyzed during the CI/CD process.

This integration ensures that code quality becomes an automated checkpoint rather than a manual review activity.

At the end of this section, Jenkins will:

- Connect securely to SonarQube
- Execute static code analysis
- Publish analysis results
- Evaluate Quality Gates
- Stop pipeline execution when quality standards are not met

---

# Integration Architecture

The following diagram illustrates the interaction between GitHub, Jenkins, and SonarQube.

```text
                Developer
                     │
                     ▼
            GitHub Repository
                     │
                     ▼
                 Jenkins
                     │
              Source Checkout
                     │
                     ▼
              Maven Build
                     │
                     ▼
           SonarQube Scanner
                     │
                     ▼
              SonarQube Server
                     │
         Code Quality Analysis
                     │
                     ▼
              Quality Gate
         ┌───────────┴───────────┐
         │                       │
         ▼                       ▼
      PASS                    FAIL
         │                       │
         ▼                       ▼
 Continue Pipeline       Stop Pipeline
```

Quality Gate evaluation acts as an automated approval step before artifacts are published or deployments begin.

---

# Install the SonarQube Scanner Plugin

Jenkins communicates with SonarQube through the SonarQube Scanner plugin.

Navigate to:

```text
Dashboard
    └── Manage Jenkins
            └── Plugins
```

Install:

- SonarQube Scanner

Restart Jenkins if prompted.

This plugin enables Jenkins pipelines to submit analysis results to SonarQube.

---

# Configure SonarQube Server

Navigate to:

```text
Manage Jenkins
    └── System
            └── SonarQube Servers
```

Add a new server.

Example configuration:

| Field | Value |
|------|-------|
| Name | SonarQube |
| Server URL | `http://localhost:9000` |
| Authentication Token | Jenkins Credential |

The server name should remain consistent because it is referenced within Jenkins Pipelines.

---

# Configure Scanner Installation

Navigate to:

```text
Manage Jenkins
    └── Tools
            └── SonarQube Scanner
```

Example configuration:

| Field | Value |
|------|-------|
| Name | SonarScanner |
| Version | Latest supported release |

Jenkins will automatically install the scanner if automatic installation is enabled.

---

# Configure Jenkins Credentials

Store the SonarQube authentication token securely.

Navigate to:

```text
Manage Jenkins
    └── Credentials
```

Create:

| Credential Type | Secret Text |
|-----------------|-------------|
| ID | sonar-token |
| Secret | Generated SonarQube Token |

Pipelines should reference the credential by its ID rather than embedding secrets directly.

---

# Jenkins Authentication Flow

```text
Jenkins
     │
     ▼
Credentials Store
     │
     ▼
SonarQube Token
     │
     ▼
SonarQube Server
```

This approach protects authentication information and prevents accidental exposure in build logs.

---

# Pipeline Integration

The repository contains a version-controlled `Jenkinsfile` that defines the CI/CD workflow.

During execution:

1. Jenkins checks out the source code.
2. Maven compiles the application.
3. SonarQube Scanner analyzes the code.
4. Results are uploaded to SonarQube.
5. Jenkins waits for the Quality Gate result.
6. Pipeline execution continues only if the Quality Gate passes.

Pipeline implementation details are covered in **13_Jenkins_Pipeline.md**.

---

# Analysis Workflow

```text
Source Code
      │
      ▼
Compile Application
      │
      ▼
SonarQube Scanner
      │
      ▼
Upload Analysis
      │
      ▼
Compute Engine
      │
      ▼
Quality Gate Evaluation
      │
      ▼
Pipeline Decision
```

This process ensures that every build is evaluated consistently.

---

# Quality Gate Enforcement

Quality Gates provide automated pass/fail criteria.

Typical checks include:

- No blocker bugs
- No critical vulnerabilities
- Minimum code coverage
- Acceptable duplication percentage
- Maintainability rating
- Reliability rating
- Security rating

If any mandatory condition fails, Jenkins should terminate the pipeline.

---

# Build Failure Strategy

Recommended pipeline behavior:

| Quality Gate Result | Pipeline Action |
|---------------------|-----------------|
| Passed | Continue build |
| Failed | Stop pipeline |
| Scanner Error | Mark build as failed |
| SonarQube Unavailable | Fail fast and notify |

Failing early prevents low-quality code from progressing through the deployment pipeline.

---

# Pull Request Analysis

SonarQube supports Pull Request analysis to review changes before they are merged.

Typical workflow:

```text
Developer
      │
      ▼
Feature Branch
      │
      ▼
Pull Request
      │
      ▼
Jenkins Analysis
      │
      ▼
SonarQube Report
      │
      ▼
Code Review
      │
      ▼
Merge
```

This enables reviewers to assess code quality alongside functional changes.

---

# Branch Analysis

Separate analysis results should be maintained for long-lived branches.

Typical branches:

- main
- develop
- release/*
- feature/* (optional)

Branch analysis helps teams monitor quality trends across different development streams.

---

# Analysis Reports

After each successful scan, SonarQube provides:

- Bugs
- Vulnerabilities
- Security Hotspots
- Code Smells
- Coverage
- Duplication
- Maintainability Rating
- Reliability Rating
- Security Rating
- Technical Debt

These reports should be reviewed regularly as part of the development workflow.

---

# Notification Strategy

Organizations may configure notifications for:

- Failed Quality Gates
- New vulnerabilities
- Critical bugs
- Pull Request analysis completion
- Project quality degradation

Notifications improve visibility and reduce response time.

---

# Integration Validation

Verify the following after completing the integration.

| Validation | Status |
|------------|--------|
| SonarQube Plugin Installed | ☐ |
| Scanner Configured | ☐ |
| SonarQube Server Added | ☐ |
| Authentication Token Working | ☐ |
| Jenkins Credential Created | ☐ |
| Scanner Executes Successfully | ☐ |
| Analysis Published | ☐ |
| Quality Gate Evaluated | ☐ |
| Pipeline Stops on Failure | ☐ |

All validation items should pass before enabling production CI/CD pipelines.

---

# Best Practices

To maintain reliable quality analysis:

- Keep SonarQube and scanner versions compatible.
- Store authentication tokens in Jenkins Credentials.
- Fail pipelines when Quality Gates fail.
- Review Security Hotspots regularly.
- Monitor technical debt trends.
- Analyze Pull Requests before merging.
- Use branch analysis for long-lived branches.
- Keep Quality Profiles aligned with organizational coding standards.

These practices ensure consistent code quality across the software lifecycle.

---

# Troubleshooting

| Issue | Possible Cause | Resolution |
|-------|----------------|------------|
| Scanner not found | Scanner not installed | Configure SonarQube Scanner under Global Tools |
| Authentication failed | Invalid token | Generate a new token and update Jenkins Credentials |
| Server connection failed | Incorrect URL | Verify SonarQube server URL and network connectivity |
| Analysis not appearing | Project Key mismatch | Verify the configured Project Key |
| Quality Gate unavailable | Incorrect Quality Gate assignment | Review project Quality Gate configuration |
| Pipeline hangs waiting for Quality Gate | Webhook or server communication issue | Verify Jenkins–SonarQube communication and webhook configuration |

Review Jenkins build logs and the SonarQube background task logs for detailed diagnostics.

---

# Section Summary

SonarQube is now fully integrated with Jenkins.

You have:

- Installed the SonarQube Scanner plugin.
- Configured the SonarQube server.
- Added secure authentication.
- Enabled automated code analysis.
- Configured Quality Gate enforcement.
- Established Pull Request and branch analysis workflows.
- Validated the complete integration.

With this integration complete, code quality becomes an automated control point within the Enterprise DevSecOps CI/CD Pipeline.

---

# Next Section

The final section covers:

- End-to-end validation
- Dashboard verification
- Scanner verification
- Security recommendations
- Backup and maintenance
- Operational best practices
- Common issues and troubleshooting
- Related documentation
- Summary and conclusion

This completes the technical integration of SonarQube within the Enterprise DevSecOps platform.

---

# Validation, Best Practices & Troubleshooting

With SonarQube installed, configured, and integrated with Jenkins, the final step is to verify that the platform is healthy, secure, and ready for production CI/CD workloads.

This section provides validation procedures, operational guidance, maintenance recommendations, backup strategies, and troubleshooting techniques.

---

# End-to-End Validation

Before enabling automated code quality checks in production, validate the complete SonarQube environment.

---

## Service Validation

Verify that the SonarQube container is running.

```bash
docker ps
```

Expected output:

```text
CONTAINER ID   IMAGE                      STATUS
xxxxxxxxxxxx   sonarqube:lts-community    Up
```

---

## Web Interface Validation

Open the SonarQube dashboard.

```text
http://localhost:9000
```

Confirm that:

- Login page loads successfully.
- Dashboard is accessible.
- No system warnings are displayed.
- Projects page opens correctly.
- Administration menu is available.
- Background tasks show no critical failures.

---

## API Validation

Verify that the SonarQube server is operational.

```bash
curl http://localhost:9000/api/system/status
```

Expected response:

```json
{
  "status": "UP"
}
```

This confirms that the application is fully initialized.

---

## Scanner Validation

Verify that the SonarQube Scanner is available from the Jenkins environment.

Example command:

```bash
sonar-scanner --version
```

Expected outcome:

- Scanner executes successfully.
- Version information is displayed.
- No missing dependency errors occur.

---

## Jenkins Integration Validation

Execute a sample Jenkins build.

Verify that:

- Source code is checked out successfully.
- SonarQube Scanner starts.
- Analysis completes.
- Results appear in SonarQube.
- Jenkins receives the Quality Gate result.
- Pipeline behaves according to the Quality Gate outcome.

---

## Quality Gate Validation

Review the latest project analysis.

Confirm:

- Bugs detected correctly.
- Vulnerabilities reported.
- Code Smells listed.
- Coverage calculated.
- Duplication measured.
- Maintainability Rating generated.
- Reliability Rating generated.
- Security Rating generated.
- Overall Quality Gate status displayed.

---

# Health Checks

Perform regular health checks to maintain platform stability.

Recommended checks:

- Verify container status.
- Review system logs.
- Monitor background task queue.
- Check database connectivity.
- Verify scanner execution.
- Review Quality Gate history.
- Monitor disk usage.
- Confirm backup completion.

Routine monitoring helps identify operational issues before they impact development teams.

---

# Operational Checklist

| Validation | Status |
|------------|--------|
| SonarQube Running | ☐ |
| Dashboard Accessible | ☐ |
| Projects Available | ☐ |
| Authentication Working | ☐ |
| Scanner Installed | ☐ |
| Jenkins Connected | ☐ |
| Quality Profiles Assigned | ☐ |
| Quality Gates Configured | ☐ |
| Analysis Successful | ☐ |
| Quality Gate Evaluated | ☐ |
| Backup Completed | ☐ |

Complete this checklist before onboarding development teams.

---

# Security Best Practices

Because SonarQube stores source code analysis results and security findings, protecting the platform is essential.

## Authentication

- Change the default administrator password immediately.
- Use individual administrator accounts.
- Enable enterprise authentication (LDAP, SAML, or OAuth) where applicable.
- Rotate authentication tokens periodically.

---

## Authorization

- Apply the principle of least privilege.
- Use groups for permission management.
- Grant project administration only where required.
- Audit user permissions regularly.

---

## Projects

- Use private projects unless public visibility is explicitly required.
- Restrict project administration.
- Archive inactive projects.
- Remove obsolete projects periodically.

---

## Tokens

- Generate dedicated tokens for Jenkins.
- Store tokens only in the Jenkins Credentials Store.
- Never commit tokens to version control.
- Revoke unused tokens promptly.

---

## Infrastructure

- Use HTTPS for production deployments.
- Deploy behind a reverse proxy where appropriate.
- Keep SonarQube updated.
- Secure the backing PostgreSQL database.
- Restrict administrative access to trusted networks.

---

# Performance Best Practices

To maintain responsive analysis and reporting:

- Use PostgreSQL for production deployments.
- Monitor CPU and memory utilization.
- Allocate sufficient JVM heap memory.
- Clean obsolete projects regularly.
- Archive historical analysis when appropriate.
- Review database growth.
- Update scanners and plugins regularly.

Performance monitoring becomes increasingly important as project size and team usage grow.

---

# Backup Strategy

Back up the following components regularly.

## Database

Contains:

- Projects
- Issues
- Quality Profiles
- Quality Gates
- Users
- Permissions
- Historical analysis

This is the most critical component.

---

## Configuration

Back up:

- Configuration files
- Custom Quality Profiles
- Custom Quality Gates
- Plugins
- Extensions

---

## Suggested Backup Frequency

| Environment | Frequency |
|-------------|-----------|
| Development | Weekly |
| Test | Daily |
| Production | Daily (or according to organizational policy) |

Regularly perform restore tests to verify backup integrity.

---

# Routine Maintenance

Perform the following maintenance activities.

Daily

- Review failed analyses.
- Monitor background tasks.
- Check Quality Gate failures.

Weekly

- Review plugin updates.
- Remove obsolete projects.
- Review inactive users.
- Verify backups.

Monthly

- Upgrade supported releases.
- Audit permissions.
- Review custom Quality Profiles.
- Review custom Quality Gates.
- Clean historical data where appropriate.

Routine maintenance improves long-term reliability and performance.

---

# Common Problems

| Problem | Possible Cause | Resolution |
|---------|----------------|------------|
| SonarQube not starting | Container startup failure | Review Docker logs and verify available memory |
| Login fails | Invalid credentials | Reset administrator password or verify authentication configuration |
| Scanner cannot connect | Incorrect server URL | Verify server URL and network connectivity |
| Authentication rejected | Invalid token | Generate a new token and update Jenkins credentials |
| Project not visible | Insufficient permissions | Review project permissions and user groups |
| Analysis fails | Project Key mismatch | Verify Project Key configuration |
| Quality Gate not evaluated | Scanner configuration issue | Confirm scanner execution and server communication |
| Background tasks failing | Database or resource issue | Review Compute Engine logs and database health |
| Slow dashboard | Insufficient resources or database growth | Monitor JVM, CPU, memory, and database performance |

Consult Docker logs, SonarQube logs, and Jenkins build logs for detailed diagnostics.

---

# Disaster Recovery

If SonarQube becomes unavailable:

1. Restore the PostgreSQL database.
2. Restore configuration files.
3. Restore plugins and extensions.
4. Start the SonarQube container.
5. Verify administrator access.
6. Confirm project visibility.
7. Execute a sample Jenkins analysis.
8. Validate Quality Gate evaluation.

Document and periodically test recovery procedures to ensure business continuity.

---

# Related Documentation

Continue with the following guides.

## Infrastructure

- [GitHub Setup](05_GitHub_Setup.md)
- [Jenkins Setup](06_Jenkins_Setup.md)
- [Nexus Setup](08_Nexus_Setup.md)
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

- Install SonarQube using Docker.
- Configure projects and Quality Profiles.
- Create and enforce Quality Gates.
- Secure the SonarQube platform.
- Integrate SonarQube with Jenkins.
- Automate static code analysis.
- Validate the complete quality analysis workflow.
- Apply operational, backup, and maintenance best practices.

SonarQube is now prepared to serve as the enterprise code quality platform for the DevSecOps CI/CD Pipeline.

---

# Summary

SonarQube provides centralized static code analysis, code quality governance, and security assessment within the Enterprise DevSecOps platform.

By combining secure configuration, automated analysis, Quality Gate enforcement, and continuous monitoring, SonarQube enables development teams to identify and resolve issues early in the software delivery lifecycle.

The configuration completed in this guide establishes a robust quality assurance foundation that integrates seamlessly with Jenkins and supports automated CI/CD workflows.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Jenkins Integration & Quality Gates](07_SonarQube_Setup.md#jenkins-integration--quality-gates) | [🏠 Documentation Portal](../README.md) | [➡️ Nexus Setup](08_Nexus_Setup.md) |

---

# Conclusion

Congratulations! You have completed the **SonarQube Setup** guide.

Your environment now includes:

- A Docker-based SonarQube installation.
- Enterprise-ready project configuration.
- Secure authentication and permission management.
- Quality Profiles and Quality Gates.
- Integration with Jenkins for automated code analysis.
- Validation procedures and operational guidance.
- Backup, maintenance, and disaster recovery recommendations.

SonarQube is now fully prepared to enforce code quality standards throughout the Enterprise DevSecOps CI/CD Pipeline.

The next document, **Nexus Setup**, will configure the artifact repository that stores versioned build outputs and container images, providing a centralized repository for software artifacts used throughout the CI/CD workflow.
