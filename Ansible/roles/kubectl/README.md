kubectl role
=============

A role to install Kubectl and configure credential to EKS cluster.

Requirements
------------
Exicting EKS cluster & AWS CLI pre-installed 

Role Variables
--------------

| Variable                | Required   | Description                     |
|-------------------------|------------|---------------------------------|
| cluster_name            | yes        | EKS cluster name in AWS         |
| aws_region              | yes        | region that cluster deployed on |


