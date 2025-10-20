# GCP 项目信息
variable "project" {
  description = "GCP 项目 ID"
  type        = string
  default     = "daytrader-dev-data"
}

variable "region" {
  description = "Cloud SQL 实例所在区域"
  type        = string
  default     = "asia-northeast3"
}

# 已存在 Cloud SQL 实例信息
variable "instance_connection_name" {
  description = "Cloud SQL 实例连接名称"
  type        = string
  default     = "daytrader-dev-data:asia-northeast3:daytrader-demo"
}

variable "instance_port" {
  description = "Cloud SQL PostgreSQL 端口号"
  type        = number
  default     = 5432
}

# 数据库信息
variable "db_name" {
  description = "数据库名称"
  type        = string
  default     = "daytrader"
}

variable "db_user" {
  description = "数据库用户名"
  type        = string
  default     = "daytrader"
}

variable "db_password" {
  description = "数据库密码"
  type        = string
  default     = "daytrader"
}

# 控制初始化 SQL 执行幂等性
variable "db_version" {
  description = "数据库初始化版本号，用于触发 SQL 脚本执行"
  type        = string
  default     = "v1"
}
