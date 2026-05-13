# EKS Deployment — Production-Grade Kubernetes on AWS

A cloud-native application deployed on Amazon EKS with full infrastructure-as-code, GitOps automation, security scanning, dynamic DNS, TLS certificate management, and observability.

---

## Table of Contents

1. [Overview](#overview)
2. [Tools Used](#tools-used)
3. [Architecture](#architecture)
4. [Architecture Features](#architecture-features)
5. [Directory Structure](#directory-structure)
6. [Local Setup](#local-setup)

---

## Overview

This project provisions and deploys a containerised web application to a production-grade Amazon EKS cluster. Infrastructure is managed entirely through Terraform with remote state, CI/CD is handled by GitHub Actions workflows, and application delivery is automated via ArgoCD GitOps. The application is served over HTTPS with certificates provisioned automatically by CertManager and DNS records managed dynamically by ExternalDNS.

---

## Tools Used

This project leverages the following tools to ensure a robust, scalable, and automated deployment pipeline:

- **AWS**: Cloud provider. EKS hosts the cluster, ECR stores images, Route 53 manages DNS, VPC isolates workloads, and S3 + DynamoDB back Terraform remote state.
- **Terraform**: Provisions all AWS infrastructure (EKS, VPC, IAM, security groups) using reusable modules with remote state management.
- **Docker**: Containerises the application as a lightweight nginx:alpine image for consistent, portable deployments.
- **Kubernetes & Helm**: Kubernetes orchestrates workloads on EKS. Helm manages cluster component installations (Ingress, CertManager, ArgoCD, Prometheus/Grafana).
- **GitHub Actions**: Runs CI/CD pipelines — one for Terraform provisioning, one for image build, security scanning, and deployment to EKS. Uses OIDC for keyless AWS authentication.
- **ArgoCD**: GitOps controller that automatically reconciles cluster state with manifests in Git on every push.
- **CertManager & Let's Encrypt**: Automatically provisions and renews TLS certificates for HTTPS, integrated with the NGINX Ingress Controller.
- **ExternalDNS**: Watches Ingress resources and automatically updates Route 53 DNS records to reflect the live application endpoint.
- **Checkov & Trivy**: Security scanning — Checkov checks Terraform for misconfigurations; Trivy scans Docker images for vulnerabilities before deployment.
- **Prometheus & Grafana**: Cluster observability — Prometheus collects metrics from nodes, pods, and Ingress; Grafana visualises them through custom dashboards.

These tools collectively enable a modern DevOps approach, ensuring the application is production-ready and adheres to best practices.

---

## Architecture

---

## Architecture Features

---

## Directory Structure

```
eks-deployment/
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml
│       ├── terraform-apply.yml
│       ├── terraform-destroy.yml
│       └── docker.yml
│
├── app/
│
├── bootstrap/
│
├── infra/
│   ├── helm-values/
│   ├── kubernetes/
│   ├── modules/
│   └── ...
│
├── Dockerfile
├── .dockerignore
└── .gitignore
```

---

## Local Setup

### Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform >= 1.5
- kubectl
- Helm 3
- Docker

### 1. Bootstrap Remote State & ECR

Before provisioning infrastructure, run the bootstrap to create the S3 bucket (remote state), DynamoDB table (state locking), and ECR repository.

```bash
cd bootstrap
terraform init
terraform apply
```

### 2. Provision Infrastructure

```bash
cd infra
terraform init
terraform plan
terraform apply
```

### 3. Configure kubectl

```bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

### 4. Bootstrap Cluster Components

Helm is installed as part of the cluster. All required Helm values files are located in `infra/`. Once the cluster is running, apply the component installations:

### 5. Run the App Locally

```bash
docker build -t eks-app .
docker run -p 8080:80 eks-app
# Visit http://localhost:8080
```
