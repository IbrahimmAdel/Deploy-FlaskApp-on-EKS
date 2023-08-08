# Infrastructure Automation Script 
> This document provides a detailed guide for using the Bash script to automate the configuration of infrastructure using Terraform and Ansible. The script orchestrates the deployment of resources using Terraform, updates the Ansible inventory with EC2 IP, and executes an Ansible playbook.

## Prerequisites
- Bash-compatible terminal.
- Terraform installed.
- Ansible installed .


### Script Structure
#### The script is designed to streamline the infrastructure deployment process through the following steps:

1. Run Terraform: Initializes Terraform and applies the defined infrastructure.

2. Update Ansible Inventory: Extracts EC2 IP from Terraform output, updates Ansible inventory, and configures the SSH access details.

3. Clean EC2 IP: Removes the stored EC2 IP to ensure fresh updates in future runs.

4. Run Ansible Playbook: Executes an Ansible playbook using the updated inventory.


### Usage

#### set script variables
- set terraform directory in `terraform_dir` variable
- set ansible directory in `ansible_dir` variable
```
terraform_dir="/home/ibrahim/ibrahim/DevOps/Final Project/Terraform"
ansible_dir="/home/ibrahim/ibrahim/DevOps/Final Project/Ansible"
```

#### change script permissions
```
chmod u+x run-project.sh
```

#### Execute the script to deploy the infrastructure:

```
./run-project.sh
```
