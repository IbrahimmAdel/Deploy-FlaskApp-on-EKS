# Ansible Playbook

> This document provides an overview of the Ansible playbook for installing and configuring Jenkins on an EC2 instance, along with additional roles for AWS CLI, kubectl, and Docker.

## Playbook Overview

The Ansible playbook performs the following tasks:

1. **Install Jenkins:** Installs Jenkins on the EC2 instance and fetches the initialAdminPassword.

2. **Install AWS CLI:** Installs AWS CLI for interacting with AWS services.

3. **Configure AWS credentials:** Configures AWS credentials and region for the `default` profile.

4. **Install kubectl:** Installs kubectl to interact with an EKS cluster.

5. **configure cluster credentials:** configure EKS credentials (.kube/config)

6. **Install Docker:** Installs Docker on the EC2 instance and configures Jenkins to use Docker.

## Role Details

### [jenkins Role](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Ansible/roles/jenkins)

- Updates APT cache.
- Installs OpenJDK 11.
- Configures Jenkins repository and installs Jenkins.
- Fetches Jenkins initialAdminPassword and prints it.

### [awscli Role](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Ansible/roles/awscli)

- Installs unzip package on Ubuntu.
- Downloads and installs AWS CLI.
- Configures AWS credentials using `aws configure`.

### [kubectl Role](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Ansible/roles/kubectl)

- Installs kubectl for interacting with Kubernetes clusters.
- Configures Kubernetes cluster credentials using `aws eks update-kubeconfig`.

### [docker Role](https://github.com/IbrahimmAdel/Full-CICD-Project/tree/master/Ansible/roles/docker)

- Installs Docker on the EC2 instance.
- Adds the Jenkins user to the Docker group.
- Adjusts ownership and permissions of `/var/run/docker.sock`.
- Restarts Jenkins and Docker services.

## Usage

1. Ensure you have Ansible installed on your local machine.
2. Update variables (e.g., `aws_access_key`, `aws_secret_key`, `aws_region`, `cluster_name`) in your playbook as needed.
3. Run the playbook using the following command:

```
ansible-playbook -i <inventory-file> <playbook-name>.yml
```
Replace <inventory-file> with your inventory file and <playbook-name> with the name of your playbook.

The playbook will execute the specified tasks on the target EC2 instance.

-----

> This is all what you need to connect to your EKS cluster
> ![](https://github.com/IbrahimmAdel/Full-CICD-Project/blob/master/Screenshots/check_.aws_.kube.png)
