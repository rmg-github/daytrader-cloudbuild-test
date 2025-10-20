# =====================================================
# Secrets 管理 - Redis AUTH 密码
# 支持：生产环境使用 Secret Manager，本地/测试使用本地 secrets.txt
# =====================================================

# 是否使用 Secrets Manager
variable "use_secret_manager" {
  description = "是否使用 Secret Manager (true=生产, false=本地测试)"
  type        = bool
  default     = false
}

# Secret 所在项目
variable "security_project" {
  description = "Secret Manager 所在的项目 ID（生产环境）"
  type        = string
  default     = "daytrader-dev-security"
}

# Secret ID（Redis 密码）
variable "redis_password_secret_id" {
  description = "Redis 密码在 Secret Manager 中的 Secret ID"
  type        = string
  default     = "redis_password"
}

# 从 Secret Manager 读取 Redis 密码
data "google_secret_manager_secret_version" "redis_password" {
  count   = var.use_secret_manager ? 1 : 0
  project = var.security_project
  secret  = var.redis_password_secret_id
  version = "latest"
}

# 本地密码文件路径（仅本地测试）
variable "password_file" {
  description = "本地密码文件路径，仅测试用"
  type        = string
  default     = "./secrets/secrets.txt"
}

# 本地密码读取
locals {
  file_password = fileexists(var.password_file) ? trimspace(file(var.password_file)) : ""
  redis_password = (
    var.use_secret_manager
    ? data.google_secret_manager_secret_version.redis_password[0].secret_data
    : local.file_password
  )
}
