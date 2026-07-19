# Trivy Setup

> **Enterprise DevSecOps CI/CD Pipeline – Trivy Security Platform Configuration Guide**

---

# Document Information

| Item | Details |
|------|---------|
| Document Name | Trivy Setup |
| Project | Enterprise DevSecOps CI/CD Pipeline |
| Repository | automation-deployment-project |
| Version | 1.0 |
| Audience | DevSecOps Engineers, DevOps Engineers, Security Engineers, Platform Engineers, Developers |
| Maintainer | Muralidhar G |

---

# Purpose

Software security should be integrated into every stage of the software development lifecycle rather than treated as a final verification step.

Trivy is a comprehensive vulnerability scanner that enables organizations to detect vulnerabilities, misconfigurations, exposed secrets, and software supply chain risks before applications reach production.

Within the Enterprise DevSecOps Platform, Trivy provides:

- Container image vulnerability scanning
- Filesystem scanning
- Git repository scanning
- Kubernetes manifest scanning
- Infrastructure-as-Code (IaC) scanning
- Secret detection
- Software Bill of Materials (SBOM) generation
- License identification
- Security policy enforcement

This guide explains how to install, configure, secure, and validate Trivy for enterprise environments.

---

# Part 1 – Trivy Overview, Architecture & Installation

---

# DevSecOps Overview

Traditional software delivery often places security validation at the end of the release cycle.

DevSecOps integrates security into every phase of development.

```text
Plan
 │
 ▼
Develop
 │
 ▼
Build
 │
 ▼
Test
 │
 ▼
Security Scan
 │
 ▼
Deploy
 │
 ▼
Monitor
```

This approach reduces risk, shortens remediation time, and improves software quality.

---

# Shift-Left Security

Shift-left security means identifying security issues as early as possible.

Benefits include:

- Faster remediation
- Lower remediation cost
- Reduced production risk
- Better developer feedback
- Continuous compliance

Trivy supports this strategy by scanning artifacts throughout the development lifecycle.

---

# What is Trivy?

Trivy is an open-source security scanner developed by Aqua Security.

It supports scanning:

- Container images
- Filesystems
- Git repositories
- Kubernetes manifests
- Helm charts
- Terraform configurations
- Dockerfiles
- SBOM documents

Trivy combines multiple scanning capabilities into a single tool, simplifying security operations.

---

# Why Trivy?

Enterprise DevSecOps requires a scanner that is:

- Fast
- Accurate
- Easy to automate
- Lightweight
- Continuously updated
- CI/CD friendly

Trivy meets these requirements while supporting multiple artifact types and reporting formats.

---

# Trivy Architecture

```text
                Source Code
                     │
                     ▼
              Build Process
                     │
                     ▼
             Docker Image
                     │
                     ▼
                Trivy Scanner
          ┌─────────┼───────────┐
          ▼         ▼           ▼
 Vulnerabilities Misconfigurations Secrets
          │
          ▼
      Security Report
          │
          ▼
   Jenkins Security Gate
```

---

# Vulnerability Database

Trivy downloads and maintains an up-to-date vulnerability database.

The database includes:

- CVEs
- Vendor advisories
- Package metadata
- Security fixes

Regular database updates ensure accurate vulnerability detection.

---

# Scanner Types

Trivy supports several scanners.

| Scanner | Purpose |
|----------|---------|
| Vulnerability | CVE detection |
| Misconfiguration | Configuration auditing |
| Secret | Credential detection |
| License | License identification |
| SBOM | Software inventory |

Each scanner addresses a different aspect of software security.

---

# Supported Targets

Trivy can analyze:

| Target | Supported |
|----------|-----------|
| Docker Images | ✓ |
| OCI Images | ✓ |
| Local Filesystem | ✓ |
| Git Repository | ✓ |
| Kubernetes YAML | ✓ |
| Helm Charts | ✓ |
| Dockerfiles | ✓ |
| Terraform | ✓ |
| Kubernetes Cluster | ✓ |

---

# Installation

Install Trivy using the official package for your operating system.

Verify installation:

```bash
trivy --version
```

Expected output:

```text
Version: x.x.x
```

---

# Initialize Vulnerability Database

The first scan downloads the vulnerability database automatically.

Alternatively:

```bash
trivy image alpine:latest
```

This initializes the local database cache.

---

# Verify Installation

Run:

```bash
trivy image alpine:latest
```

Successful execution confirms:

- Installation
- Database initialization
- Scanner operation

---

# Installation Validation

| Validation | Status |
|------------|--------|
| Trivy Installed | ☐ |
| Version Verified | ☐ |
| Database Downloaded | ☐ |
| Test Scan Successful | ☐ |

---

# Expected Outcome

At the end of this section:

- Trivy is installed.
- Vulnerability database is initialized.
- Scanner is operational.
- Platform is ready for configuration.

---

# Part 2 – Scanner Configuration & Security Policies

---

# Scanner Configuration Overview

Trivy supports multiple scan modes depending on the artifact being analyzed.

Recommended scan order:

```text
Filesystem
      │
      ▼
Repository
      │
      ▼
Docker Image
      │
      ▼
Kubernetes Manifest
      │
      ▼
Running Cluster
```

---

# Filesystem Scanning

Filesystem scanning analyzes local project directories.

Typical findings include:

- Vulnerable packages
- Secrets
- Misconfigurations
- Dependency issues

Filesystem scanning should be performed before container image creation.

---

# Repository Scanning

Repository scanning evaluates the complete Git repository.

It includes:

- Source code dependencies
- Configuration files
- Infrastructure definitions
- Hidden credentials

Scanning repositories early helps prevent insecure code from entering the build process.

---

# Container Image Scanning

Container image scanning evaluates:

- Operating system packages
- Language dependencies
- Installed libraries
- Container metadata

This scan should occur immediately after image creation and before publishing to Nexus.

---

# Kubernetes Configuration Scanning

Trivy analyzes Kubernetes resource definitions for common security issues.

Examples include:

- Privileged containers
- Missing resource limits
- Insecure capabilities
- HostPath usage
- Missing security contexts

Configuration scanning improves Kubernetes security posture before deployment.

---

# Infrastructure-as-Code (IaC) Scanning

Trivy supports scanning:

- Terraform
- Kubernetes YAML
- Helm Charts
- Dockerfiles

This enables security validation before infrastructure is provisioned.

---

# Secret Scanning

Secret detection identifies accidentally committed credentials.

Examples include:

- API keys
- Access tokens
- Passwords
- Private keys
- Cloud credentials

Secrets should never be stored in source control.

---

# SBOM Generation

Software Bill of Materials (SBOM) provides a complete inventory of software components.

Supported formats include:

- CycloneDX
- SPDX

Benefits:

- Supply chain visibility
- Compliance reporting
- License management
- Vulnerability tracking

---

# Vulnerability Severity Levels

Trivy categorizes findings by severity.

| Severity | Description |
|----------|-------------|
| Critical | Immediate action required |
| High | High business risk |
| Medium | Moderate risk |
| Low | Minor issue |
| Unknown | Classification unavailable |

Organizations should define remediation policies for each severity level.

---

# CVSS Overview

Many vulnerabilities include a Common Vulnerability Scoring System (CVSS) score.

General interpretation:

| Score | Risk |
|--------|------|
| 9.0–10.0 | Critical |
| 7.0–8.9 | High |
| 4.0–6.9 | Medium |
| 0.1–3.9 | Low |

CVSS should be considered alongside organizational risk and asset criticality.

---

# Ignore Policies

Some findings may be accepted temporarily.

Ignore policies should:

- Be documented.
- Include business justification.
- Have an expiration date.
- Be reviewed periodically.

Avoid creating permanent exceptions without review.

---

# Offline Mode

For restricted environments, Trivy supports offline scanning using a locally synchronized vulnerability database.

Offline environments should establish a controlled process for regularly updating the vulnerability database.

---

# Database Updates

Regularly update the vulnerability database to ensure current vulnerability information.

Update frequency should align with organizational security requirements.

---

# Performance Considerations

For large projects:

- Cache the vulnerability database.
- Scan incrementally where appropriate.
- Schedule regular database updates.
- Separate development and production scans.

These practices improve scanning efficiency.

---

# Security Best Practices

- Scan every container image.
- Scan before publishing artifacts.
- Review Critical and High findings before deployment.
- Protect SBOM documents.
- Restrict access to security reports.
- Rotate credentials identified during scans.
- Maintain updated vulnerability databases.

---

# Configuration Validation

| Validation | Status |
|------------|--------|
| Filesystem Scanner Working | ☐ |
| Repository Scanner Working | ☐ |
| Image Scanner Working | ☐ |
| Kubernetes Scanner Working | ☐ |
| Secret Scanner Working | ☐ |
| SBOM Generation Verified | ☐ |
| Database Updated | ☐ |

---

# Section Summary

Trivy is now configured to provide comprehensive security scanning across source code, container images, Kubernetes resources, and infrastructure definitions.

The next section integrates Trivy with Jenkins, introduces security gates, reporting formats, vulnerability thresholds, and enterprise release security policies.

---

# Part 3 – Jenkins Integration & Enterprise Security Workflow

With Trivy installed and configured, the next step is integrating security scanning into the CI/CD platform.

This section focuses on enterprise security workflows, security gates, reporting, and release validation. Detailed Jenkins pipeline implementation is covered in the CI/CD documentation.

---

# Enterprise Security Architecture

```text
                     Developer
                          │
                          ▼
                   GitHub Repository
                          │
                          ▼
                       Jenkins
                          │
              Source Code Checkout
                          │
                          ▼
                  Build Application
                          │
                          ▼
                 SonarQube Analysis
                          │
                          ▼
                  Docker Image Build
                          │
                          ▼
                     Trivy Scan
          ┌───────────┼────────────┐
          ▼           ▼            ▼
 Vulnerabilities  Misconfigurations  Secrets
          │
          ▼
     Security Report
          │
          ▼
     Security Gate
          │
     ┌────┴────┐
     ▼         ▼
   Pass      Fail
     │         │
     ▼         ▼
 Push Image   Stop Pipeline
     │
     ▼
 Deploy to Kubernetes
```

---

# Jenkins Integration Overview

Trivy integrates into Jenkins as an automated security validation stage.

The integration enables:

- Filesystem scanning
- Container image scanning
- Kubernetes manifest scanning
- Secret detection
- SBOM generation
- Security reporting
- Build policy enforcement

Every build should be scanned before artifacts are published.

---

# Security Gate Concept

The Security Gate determines whether a deployment may continue.

```text
Scan Results
      │
      ▼
Evaluate Severity
      │
 ┌────┴────┐
 ▼         ▼
Accept   Reject
 │         │
 ▼         ▼
Deploy   Stop Build
```

Typical enterprise policy:

| Severity | Action |
|----------|--------|
| Critical | Fail Build |
| High | Fail or Manual Approval |
| Medium | Warning |
| Low | Informational |

---

# Image Scanning Workflow

Container image scanning occurs immediately after image creation.

Workflow:

```text
Docker Build
      │
      ▼
Trivy Image Scan
      │
      ▼
Generate Report
      │
      ▼
Security Gate
      │
      ▼
Publish Image
```

Only approved images should be pushed to the internal registry.

---

# Filesystem Scanning Workflow

Filesystem scanning identifies issues before containerization.

```text
Source Code
      │
      ▼
Filesystem Scan
      │
      ▼
Fix Issues
      │
      ▼
Build Image
```

This reduces unnecessary build failures later in the pipeline.

---

# Kubernetes Manifest Scanning

Infrastructure definitions should be scanned before deployment.

Resources include:

- Deployments
- Services
- Ingress
- ConfigMaps
- Secrets
- Network Policies
- RoleBindings
- Service Accounts

Scanning detects insecure configurations before they reach the cluster.

---

# Infrastructure-as-Code Validation

Recommended scan targets include:

- Terraform
- Dockerfiles
- Helm Charts
- Kubernetes YAML

Infrastructure security should be validated before provisioning.

---

# SBOM Generation

Generate Software Bill of Materials for every production release.

Benefits include:

- Supply chain visibility
- License compliance
- Vulnerability tracking
- Regulatory compliance
- Faster incident response

Maintain SBOMs alongside release artifacts.

---

# Report Formats

Trivy supports multiple report formats.

| Format | Purpose |
|----------|----------|
| Table | Console output |
| JSON | Automation |
| SARIF | Security platforms |
| CycloneDX | SBOM |
| SPDX | SBOM |

Choose report formats based on integration requirements.

---

# Security Reports

Security reports should include:

- Vulnerabilities
- CVE identifiers
- Severity
- Installed package
- Fixed version
- File location
- Risk summary

Reports should be retained according to organizational audit policies.

---

# Exit Codes

Trivy exit codes allow CI/CD platforms to enforce security policies.

Typical workflow:

```text
No Critical Issues
        │
        ▼
 Exit Code = Success
```

```text
Critical Vulnerability
        │
        ▼
 Exit Code = Failure
```

Jenkins interprets exit codes to determine pipeline status.

---

# Build Failure Policies

Organizations should define clear security thresholds.

Example policy:

| Severity | Pipeline Action |
|----------|-----------------|
| Critical | Block Deployment |
| High | Security Review |
| Medium | Create Ticket |
| Low | Monitor |

Policies should align with organizational risk management.

---

# Nexus Integration

Before publishing images:

1. Scan image.
2. Review findings.
3. Pass Security Gate.
4. Publish to Nexus.

Only validated artifacts should enter enterprise repositories.

---

# Kubernetes Deployment Validation

Before deployment:

- Verify scan completion.
- Review Critical findings.
- Validate SBOM.
- Confirm security approval.
- Archive scan reports.

Deployment should proceed only after successful validation.

---

# Integration Validation

Verify:

| Validation | Status |
|------------|--------|
| Jenkins Connected | ☐ |
| Trivy Installed | ☐ |
| Image Scan Successful | ☐ |
| Filesystem Scan Successful | ☐ |
| Manifest Scan Successful | ☐ |
| SBOM Generated | ☐ |
| Reports Archived | ☐ |
| Security Gate Operational | ☐ |

---

# Enterprise Best Practices

- Scan every build.
- Scan every image.
- Generate SBOMs.
- Enforce Security Gates.
- Review High and Critical findings.
- Protect scan reports.
- Keep vulnerability database updated.
- Integrate security early.

---

# Section Summary

Trivy is now integrated into the DevSecOps workflow, enabling automated vulnerability detection, policy enforcement, and release validation before software reaches production.

---

# Part 4 – Validation, Operations & Troubleshooting

---

# End-to-End Validation

Before production use, validate the complete Trivy platform.

---

## Installation Validation

Verify installation.

```bash
trivy --version
```

Expected:

- Version displayed
- No execution errors

---

## Database Validation

Confirm vulnerability database availability.

Verify:

- Database downloaded
- Database current
- Updates successful

---

## Filesystem Validation

Execute a filesystem scan.

Verify:

- Files analyzed
- Report generated
- Findings categorized

---

## Container Image Validation

Scan a sample container image.

Confirm:

- Image analyzed
- Vulnerabilities detected correctly
- Severity classification displayed

---

## Kubernetes Validation

Validate Kubernetes manifests.

Verify:

- Configuration reviewed
- Security findings reported
- Recommendations generated

---

## Secret Detection Validation

Confirm Trivy identifies exposed credentials.

Typical findings:

- API Keys
- Tokens
- Passwords
- Private Keys

Immediately rotate any exposed credentials discovered during testing.

---

## SBOM Validation

Verify:

- SBOM generated
- Components listed
- Versions accurate
- Output format correct

---

## Jenkins Validation

Execute a sample pipeline.

Confirm:

- Scan executed.
- Reports generated.
- Security Gate evaluated.
- Pipeline status correct.

---

# Operational Checklist

| Validation | Status |
|------------|--------|
| Trivy Installed | ☐ |
| Database Updated | ☐ |
| Filesystem Scan Verified | ☐ |
| Image Scan Verified | ☐ |
| Kubernetes Scan Verified | ☐ |
| Secret Detection Verified | ☐ |
| SBOM Generated | ☐ |
| Jenkins Integration Verified | ☐ |

---

# Security Best Practices

Implement the following controls:

- Scan every release.
- Block Critical vulnerabilities.
- Monitor High findings.
- Secure vulnerability reports.
- Protect SBOM documents.
- Rotate exposed credentials.
- Restrict scanner permissions.
- Audit security policies regularly.

---

# Performance Recommendations

Monitor:

- Database size
- Scan duration
- Image size
- Report generation time
- Vulnerability trends
- False-positive rate

Schedule database updates during maintenance windows where appropriate.

---

# Database Maintenance

Regularly:

- Update vulnerability database.
- Remove obsolete cache.
- Verify database integrity.
- Validate scanner version compatibility.

Routine maintenance improves detection accuracy.

---

# Backup Strategy

Retain:

- Scan reports
- SBOM documents
- Ignore policy files
- Security configuration
- CI/CD security settings

Store backups in secure, access-controlled locations.

---

# Routine Maintenance

### Daily

- Review Critical findings.
- Monitor failed scans.
- Verify database availability.

### Weekly

- Review vulnerability trends.
- Validate policy exceptions.
- Confirm report archival.

### Monthly

- Upgrade Trivy.
- Audit security policies.
- Test Security Gate.
- Review ignored vulnerabilities.

---

# Common Problems

| Problem | Possible Cause | Resolution |
|----------|----------------|------------|
| Database download fails | Network restriction | Verify connectivity or mirror configuration |
| Image scan fails | Image unavailable | Verify image reference |
| Kubernetes scan fails | Invalid manifest | Validate YAML syntax |
| False positives | Dependency metadata | Review findings and apply justified exceptions |
| Slow scans | Large image | Optimize image layers and cache database |
| Report generation fails | Invalid output path | Verify permissions and destination |

Always investigate findings before suppressing them.

---

# Disaster Recovery

If the Trivy platform becomes unavailable:

1. Reinstall Trivy.
2. Restore configuration.
3. Restore ignore policies.
4. Update vulnerability database.
5. Validate scanner functionality.
6. Execute test scans.
7. Verify Jenkins integration.
8. Resume pipeline operations.

---

# Related Documentation

## Infrastructure

- GitHub Setup
- Jenkins Setup
- SonarQube Setup
- Nexus Setup
- Docker Setup
- Kind Setup
- Helm Setup

## CI/CD

- Jenkins Pipeline
- Pipeline Stages
- Build Guide
- Deployment Guide
- Verification Guide

---

# Appendix A – Severity Classification

| Severity | Recommended Action |
|----------|--------------------|
| Critical | Immediate remediation. Block deployment. |
| High | Resolve before production or require formal approval. |
| Medium | Prioritize according to business risk. |
| Low | Track and remediate during routine maintenance. |
| Unknown | Investigate and classify. |

---

# Appendix B – Supported Artifact Types

| Artifact | Supported |
|----------|-----------|
| Docker Images | ✓ |
| OCI Images | ✓ |
| Local Filesystem | ✓ |
| Git Repository | ✓ |
| Kubernetes YAML | ✓ |
| Helm Charts | ✓ |
| Terraform | ✓ |
| Dockerfiles | ✓ |
| SBOM Documents | ✓ |

---

# Key Takeaways

After completing this guide, you can:

- Install and configure Trivy.
- Scan source code, images, and infrastructure.
- Generate SBOMs.
- Detect vulnerabilities and secrets.
- Integrate security into Jenkins.
- Enforce Security Gates.
- Maintain vulnerability databases.
- Troubleshoot common scanning issues.

---

# Summary

Trivy provides a unified security platform for modern DevSecOps environments. By combining vulnerability scanning, misconfiguration detection, secret scanning, SBOM generation, and policy enforcement, organizations can identify and remediate security risks early in the software delivery lifecycle.

Integrated with Jenkins, Docker, Kubernetes, Nexus, and Helm, Trivy helps ensure that only validated, compliant artifacts progress through the Enterprise DevSecOps CI/CD Pipeline.

---

# Navigation

| Previous | Home | Next |
|----------|------|------|
| [⬅️ Helm Setup](11_Helm_Setup.md) | [🏠 Documentation Portal](../README.md) | [➡️ Jenkins Pipeline](../03-CI-CD-Pipeline/13_Jenkins_Pipeline.md) |

---

# Conclusion

Congratulations! You have completed the Infrastructure section of the Enterprise DevSecOps documentation.

Your platform now includes:

- GitHub for source control
- Jenkins for automation
- SonarQube for code quality
- Nexus for artifact management
- Docker for containerization
- Kind for Kubernetes
- Helm for package management
- Trivy for DevSecOps security

With the infrastructure fully documented and validated, the next phase focuses on **CI/CD Pipeline implementation**, beginning with **`13_Jenkins_Pipeline.md`**, where these components are orchestrated into an end-to-end automated software delivery workflow.
