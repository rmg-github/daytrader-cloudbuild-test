# 是否使用 Secrets Manager
variable "use_secret_manager" {
  description = "是否使用 Secrets Manager (true=生产, false=本地测试)"
  type        = bool
  default     = false
}

# Secret 所在项目
variable "security_project" {
  description = "Secret Manager 所在的项目 ID（生产环境）"
  type        = string
  default     = "daytrader-dev-security"
}

# Secret ID
variable "db_password_secret_id" {
  description = "数据库密码在 Secret Manager 中的 Secret ID"
  type        = string
  default     = "db-password"
}

# 从 Secret Manager 读取密码
data "google_secret_manager_secret_version" "db_password" {
  count   = var.use_secret_manager ? 1 : 0
  project = var.security_project
  secret  = var.db_password_secret_id
  version = "latest"
}

# 本地文件路径（仅本地测试）
variable "password_file" {
  description = "本地密码文件路径，仅测试用"
  type        = string
  default     = "./secrets/secrets.txt"
}

# 密码选择逻辑
locals {
  # 如果文件存在才读取，避免报错
  file_password = fileexists(var.password_file) ? file(var.password_file) : ""

  db_password = (
    var.use_secret_manager
    ? data.google_secret_manager_secret_version.db_password[0].secret_data
    : local.file_password
  )
}

variable "db_user" {
  description = "数据库用户名"
  type        = string
  default     = "daytrader"
}
