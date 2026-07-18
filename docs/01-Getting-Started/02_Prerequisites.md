# 📋 Prerequisites

> **Previous:** [01_Project_Overview.md](01_Project_Overview.md)  
> **Next:** [03_Installation_Guide.md](03_Installation_Guide.md)

---

# 📌 Purpose

This document outlines the hardware, operating system, software, accounts, and tools required to successfully set up and run the Enterprise DevSecOps CI/CD Pipeline.

Completing these prerequisites before starting the installation ensures a smooth deployment experience.

---

# 🎯 Objectives

After completing this section, you will have:

- A supported operating system
- Required software installed
- Necessary accounts created
- Network connectivity verified
- Sufficient system resources
- Basic familiarity with Git, Docker, and Kubernetes

---

# 💻 Hardware Requirements

| Component | Minimum | Recommended |
|-----------|----------|-------------|
| CPU | 4 Cores | 8 Cores |
| Memory | 8 GB RAM | 16 GB RAM or higher |
| Storage | 30 GB Free | 60 GB Free SSD |
| Internet | Stable Broadband | High-Speed Internet |

---

# 🖥 Supported Operating Systems

The project has been validated on:

| Operating System | Supported |
|------------------|-----------|
| Ubuntu 22.04 LTS | ✅ |
| Ubuntu 24.04 LTS | ✅ |
| Windows 11 + WSL2 | ✅ (Recommended) |
| Windows 10 + WSL2 | ✅ |
| macOS | ⚠️ Expected to work with minor changes |

> **Recommended Environment:** Ubuntu 24.04 LTS running on WSL2.

---

# 🛠 Required Software

| Software | Version |
|----------|---------|
| Git | Latest Stable |
| Java | 17 |
| Maven | 3.9+ |
| Docker Engine / Docker Desktop | Latest |
| Jenkins | LTS |
| SonarQube | Community Edition |
| Nexus Repository | OSS |
| Kind | v0.32.0 or later |
| kubectl | Compatible with Kind |
| Helm | v3.15+ |
| Trivy | Latest |
| Bash | 5.x |

---

# ☁ Required Accounts

Create the following accounts before starting:

| Platform | Purpose |
|----------|---------|
| GitHub | Source Code Repository |
| Docker Hub *(Optional)* | Public Image Repository |
| SonarQube | Code Quality Analysis |
| Nexus Repository | Artifact & Docker Image Storage |

> This project stores Docker images in a Nexus Docker Hosted Repository, so Docker Hub is optional.

---

# 🌐 Network Requirements

Ensure the following ports are available and not blocked by another application.

| Service | Port |
|----------|-----:|
| Jenkins | 8080 |
| SonarQube | 9000 |
| Nexus Repository | 8081 |
| Kubernetes Application (Example) | 8088 |

---

# 📚 Knowledge Prerequisites

A basic understanding of the following topics is recommended:

- Git fundamentals
- Java application build process
- Maven lifecycle
- Docker basics
- Kubernetes concepts
- Helm charts
- CI/CD pipelines
- Linux command line
- Bash scripting

No prior enterprise DevSecOps experience is required.

---

# 📂 Repository Requirements

Clone the project before beginning the installation.

Example directory structure:

```text
/opt/DevOpsPracticeProjects/
└── automation-deployment-project/
```

---

# ✅ Verify Installed Tools

Run the following commands to verify your environment.

### Git

```bash
git --version
```

### Java

```bash
java -version
```

### Maven

```bash
mvn -version
```

### Docker

```bash
docker --version
docker compose version
```

### Kubernetes

```bash
kubectl version --client
```

### Kind

```bash
kind version
```

### Helm

```bash
helm version
```

### Trivy

```bash
trivy --version
```

---

# 📋 Expected Outcome

Before proceeding to the installation guide, ensure that:

- ✅ Required software is installed
- ✅ Tool versions are verified
- ✅ Required accounts are available
- ✅ Internet connectivity is working
- ✅ Docker is running
- ✅ WSL2 (if applicable) is functioning correctly

---

# 💡 Troubleshooting

### Java not found

Ensure Java 17 is installed and the `JAVA_HOME` environment variable is configured correctly.

---

### Docker command not found

Verify Docker Desktop or Docker Engine is installed and the Docker service is running.

---

### kubectl not found

Install the Kubernetes CLI and ensure it is included in your `PATH`.

---

### Helm not found

Install Helm using the official installation instructions and verify it with:

```bash
helm version
```

---

# 📚 Summary

The prerequisite checklist ensures your system is ready for the Enterprise DevSecOps CI/CD pipeline installation.

Verifying these requirements in advance minimizes setup issues and helps ensure a successful deployment experience.

---

## Next Document

➡️ **03_Installation_Guide.md**
