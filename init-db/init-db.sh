#!/bin/bash
set -e

echo "==== Terraform init ===="
terraform init

echo "==== Terraform plan ===="
terraform plan -out=tfplan

echo "==== Terraform apply ===="
terraform apply -auto-approve tfplan

echo "==== Done ===="
