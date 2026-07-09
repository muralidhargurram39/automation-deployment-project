# Enterprise DevSecOps Architecture

                    GitHub
                       │
                       ▼
                  Jenkins Pipeline
                       │
     ┌─────────────────┼─────────────────┐
     ▼                 ▼                 ▼
 SonarQube          Nexus           Docker Build
 Quality             WAR             Docker Image
 Gate             Repository
                                          │
                                          ▼
                                Nexus Docker Registry
                                          │
                                          ▼
                                   Tomcat Deployment
                                          │
                                          ▼
                                    Health Check

Future Roadmap

Docker
↓

Kubernetes
↓

Helm

↓

Argo CD

↓

AWS EKS
