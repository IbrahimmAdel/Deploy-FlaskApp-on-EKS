# Terraform Infrastructure Deployment Documentation

> This document provides detailed instructions for deploying infrastructure using Terraform. The project consists of four modules: `ec2`, `ecr`, `eks`, and `network`. The goal is to create an environment that includes an EC2 instance for Jenkins, an ECR repository, an EKS cluster with worker nodes, and a network infrastructure with subnets and NAT gateways.

## Prerequisites

- Terraform installed.
- AWS credentials and CLI configured.
- Basic understanding of Terraform and AWS services.

## Modules Overview

### [EC2 Module](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Terraform/modules/ec2)

The EC2 module creates an EC2 instance to host Jenkins.

### [ECR Module](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Terraform/modules/ecr)

The ECR module creates an Amazon Elastic Container Registry (ECR) repository for Docker images.

### [EKS Module](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Terraform/modules/eks)

The EKS module creates an Amazon Elastic Kubernetes Service (EKS) cluster with worker nodes.

### [Network Module](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Terraform/modules/network)

The Network module creates a network infrastructure such as subnets, NAT, IGW, and so on .

## Usage

1. Clone the repository:
```
git clone https://github.com/IbrahimmAdel/Full-CICD-Project.git
```
2. Initialize Terraform:
```
terraform init
```
3. Review and adjust variables:  
Open the [variables.tf](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Terraform/variables.tf) file and adjust variables as needed.

4. Deploy the infrastructure:
```
terraform apply
```
5. Destroy the infrastructure (when done):
```
terraform destroy
```

