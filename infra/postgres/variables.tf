# -------------------------------
# 基础信息
# -------------------------------
variable "project" {
  description = "GCP 项目"
  type        = string
  default     = "daytrader-dev-data"
}

variable "region" {
  description = "Cloud SQL 实例所在区域"
  type        = string
  default     = "asia-northeast3"
}

variable "instance_id" {
  description = "Cloud SQL 实例 ID"
  type        = string
  default     = "daytrader-dev"
}

variable "edition" {
  description = "Cloud SQL 类型"
  type        = string
  default     = "ENTERPRISE"
}

variable "database_version" {
  description = "Cloud SQL 数据库版本"
  type        = string
  default     = "POSTGRES_18"
}

variable "tier" {
  description = "机器类型 / vCPU + RAM"
  type        = string
  default     = "db-custom-4-16384"
}

variable "vpc" {
  description = "VPC 网络名称"
  type        = string
  default     = "vpc-daytrader-dev-data"
}

# -------------------------------
# 存储与高可用
# -------------------------------
variable "disk_type" {
  description = "存储类型"
  type        = string
  default     = "PD_SSD"
}

variable "disk_size_gb" {
  description = "存储容量 (GB)"
  type        = number
  default     = 100
}

variable "disk_autoresize" {
  description = "启用自动扩容"
  type        = bool
  default     = true
}

variable "availability_type" {
  description = "ZONAL 或 REGIONAL（PITR 推荐 REGIONAL）"
  type        = string
  default     = "REGIONAL"
}

variable "ca_type" {
  description = "证书授权机构类型"
  type        = string
  default     = "GOOGLE_MANAGED_INTERNAL_CA"
}

# -------------------------------
# 备份与 PITR
# -------------------------------
variable "point_in_time_recovery" {
  description = "是否启用 PITR（仅支持 REGIONAL）"
  type        = bool
  default     = false
}

variable "backup_enabled" {
  description = "是否启用自动每日备份（PITR 必须开启）"
  type        = bool
  default     = false
}

variable "backup_start_time" {
  description = "每日备份开始时间（UTC 时区，例如 01:00）"
  type        = string
  default     = "17:00"
}

variable "backup_retention_count" {
  description = "备份保留份数"
  type        = number
  default     = 3
}

variable "transaction_log_retention_days" {
  description = "PITR 日志保留天数（仅在启用备份时生效）"
  type        = number
  default     = 2
}

variable "final_backup_enabled" {
  description = "是否启用最终备份"
  type        = bool
  default     = false
}

variable "final_backup_retention_days" {
  description = "最终备份保留天数"
  type        = number
  default     = 30
}

variable "deletion_protection" {
  description = "是否启用删除保护（防止实例被误删）"
  type        = bool
  default     = false
}

# -------------------------------
# 维护窗口
# -------------------------------
variable "maintenance_day" {
  description = "维护窗口星期几（实测 6=Sun）"
  type        = number
  default     = 6
}

variable "maintenance_hour" {
  description = "维护窗口小时（UTC），北京时间3:00=UTC19"
  type        = number
  default     = 19
}

variable "maintenance_track" {
  description = "维护轨道 stable 或 canary"
  type        = string
  default     = "stable"
}

# -------------------------------
# 数据库信息
# -------------------------------
variable "db_name" {
  description = "数据库名"
  type        = string
  default     = "daytrader"
}

variable "label_key" {
  description = "Cloud SQL 标签的 key（小写字母、数字、-、_）"
  type        = string
  default     = "environment"
}

variable "label_value" {
  description = "Cloud SQL 标签（仅支持小写字母、数字、-、_）"
  type        = string
  default     = "postgres-instance-daytrader"
}

# -------------------------------
# 数据库标志
# -------------------------------
variable "database_flags" {
  description = "数据库标志（如 max_connections 等）"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# -------------------------------
# Query Insights
# -------------------------------
variable "query_insights_enabled" {
  description = "是否启用 Query Insights"
  type        = bool
  default     = false
}

variable "record_application_tags" {
  description = "是否记录应用标签"
  type        = bool
  default     = false
}

variable "record_client_address" {
  description = "是否记录客户端地址"
  type        = bool
  default     = false
}
