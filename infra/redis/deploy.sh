#!/usr/bin/env bash

# =====================================================
# Google Cloud Memorystore for Redis 一键部署脚本
# 参数：
#   1. SERVICE_ACCOUNT
#   2. VAR_ENV_NAME（无 .tfvars 后缀）
# 使用例：
#   ./deploy.sh terraform-deployer@daytrader-dev-data.iam.gserviceaccount.com stage
# =====================================================

set -e
set -o pipefail

# -----------------------------
# 参数校验
# -----------------------------
if [ $# -lt 1 ]; then
  echo "用法: $0 <VAR_ENV_NAME>"
  exit 1
fi

VAR_ENV_NAME="$1"
TERRAFORM_VAR_FILE="${VAR_ENV_NAME}.tfvars"

PROJECT_ID="daytrader-dev-data"
BUCKET_NAME="bucket-daytrader-dev-data"
REGION="asia-northeast3"

# -----------------------------
# 设置 GCP 项目
# -----------------------------
echo "设置 GCP 项目: $PROJECT_ID"
gcloud config set project "$PROJECT_ID"

# -----------------------------
# 检查或创建 GCS 存储桶
# -----------------------------
echo "检查或创建 GCS 存储桶: gs://$BUCKET_NAME"
if gsutil ls -b "gs://$BUCKET_NAME" >/dev/null 2>&1; then
  echo "存储桶已存在: gs://$BUCKET_NAME"
else
  gsutil mb -p "$PROJECT_ID" -l "$REGION" "gs://$BUCKET_NAME"
  echo "存储桶创建完成: gs://$BUCKET_NAME"
fi

# -----------------------------
# Terraform 部署
# -----------------------------
echo "初始化 Terraform"
terraform init

echo "执行 Terraform Plan: $TERRAFORM_VAR_FILE"
terraform plan -var-file="$TERRAFORM_VAR_FILE" -out=plan.out

echo "执行 Terraform Apply"
terraform apply -auto-approve "plan.out"

echo "Redis 部署完成"
