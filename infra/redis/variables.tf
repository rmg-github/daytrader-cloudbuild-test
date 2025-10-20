# =====================================================
# GCP 项目和基础配置
# =====================================================
variable "project" {
  description = "GCP 项目 ID"
  type        = string
  default     = "daytrader-dev-data"
}

variable "region" {
  description = "GCP 区域"
  type        = string
  default     = "asia-northeast3"
}

variable "network" {
  description = "VPC 网络名称"
  type        = string
  default     = "vpc-daytrader-dev-data"
}

# =====================================================
# Redis 实例配置
# =====================================================
variable "instance_id" {
  description = "Redis 实例 ID"
  type        = string
  default     = "daytrader-redis"
}

variable "tier" {
  description = "Redis 层级"
  type        = string
  default     = "STANDARD_HA"
}

variable "size_gb" {
  description = "Redis 存储空间（GB）"
  type        = number
  default     = 8
}

variable "redis_version" {
  description = "Redis 版本"
  type        = string
  default     = "REDIS_7_2"
}

variable "maxmemory_policy" {
  description = "Redis 内存淘汰策略"
  type        = string
  default     = "allkeys-lru"
}

variable "read_replicas" {
  description = "读取副本数"
  type        = number
  default     = 2
}

variable "read_replicas_mode" {
  description = "读取副本模式"
  type        = string
  default     = "READ_REPLICAS_ENABLED"
}

variable "auth_enabled" {
  description = "是否启用 AUTH 认证"
  type        = bool
  default     = true
}

variable "connect_mode" {
  description = "Redis 连接模式"
  type        = string
  default     = "PRIVATE_SERVICE_ACCESS"
}

variable "transit_encryption_mode" {
  description = "传输加密模式"
  type        = string
# default     = "SERVER_AUTHENTICATION"
  default     = "DISABLED"
}

# =====================================================
# 维护和快照配置
# =====================================================
variable "maintenance_day" {
  description = "维护日期（SUNDAY, MONDAY...）"
  type        = string
  default     = "SUNDAY"
}

variable "maintenance_start_hour" {
  description = "维护开始小时"
  type        = number
  default     = 19
}

variable "maintenance_start_minute" {
  description = "维护开始分钟"
  type        = number
  default     = 0
}

variable "enable_persistence" {
  description = "是否安排截取 Redis 数据库 (RDB) 快照的时间"
  type        = bool
  default     = true
}

variable "persistence_mode" {
  description = "Redis 持久化模式"
  type        = string
  default     = "RDB"
}

variable "rdb_snapshot_period" {
  description = "RDB 快照周期"
  type        = string
  default     = "ONE_HOUR"
}

variable "rdb_snapshot_start_time" {
  description = "RDB 快照开始时间（UTC）"
  type        = string
  default     = "2025-10-12T03:00:00Z"
}

# -------------------------------
# 数据库信息
# -------------------------------
variable "label_key" {
  description = "Cloud SQL 标签的 key（小写字母、数字、-、_）"
  type        = string
  default     = "environment"
}

variable "label_value" {
  description = "Cloud SQL 标签（仅支持小写字母、数字、-、_）"
  type        = string
  default     = "redis-instance-daytrader"
}