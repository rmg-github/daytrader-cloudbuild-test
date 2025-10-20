# =====================================================
# Redis AUTH token 管理
# =====================================================
# 从 Secret Manager 获取 token（仅在 auth_enabled = true 时使用）
data "google_secret_manager_secret_version" "redis_token" {
  count   = var.auth_enabled ? 1 : 0
  secret  = "projects/${var.project}/secrets/redis-token"  # 固定 key 名称
  version = "latest"
}

# -------------------------------
# Redis 实例
# -------------------------------
resource "google_redis_instance" "redis" {
  name                     = var.instance_id
  tier                     = var.tier
  memory_size_gb           = var.size_gb
  region                   = var.region
  project                  = var.project
  redis_version            = var.redis_version
  authorized_network       = var.network
  connect_mode             = var.connect_mode
  transit_encryption_mode  = var.transit_encryption_mode

  auth_enabled = var.auth_enabled

  # 仅当 auth_enabled = true 时，设置 auth_token
  auth_token = var.auth_enabled ? data.google_secret_manager_secret_version.redis_token[0].secret_data : null

  read_replicas_mode = var.read_replicas_mode
  replica_count      = var.read_replicas

  redis_configs = {
    maxmemory-policy = var.maxmemory_policy
  }

  maintenance_policy {
    weekly_maintenance_window {
      day = var.maintenance_day
      start_time {
        hours   = var.maintenance_start_hour
        minutes = var.maintenance_start_minute
      }
    }
  }

  dynamic "persistence_config" {
    for_each = var.enable_persistence ? [1] : []
    content {
      persistence_mode        = var.persistence_mode
      rdb_snapshot_period     = var.rdb_snapshot_period
      rdb_snapshot_start_time = var.rdb_snapshot_start_time
    }
  }

  # 用户自定义标签
  labels = {
    "${var.label_key}" = var.label_value
  }
}

# =====================================================
# 本地文件密码（仅供应用端读取 auth_enabled = false 场景）
# =====================================================
locals {
  redis_local_token = var.auth_enabled ? null : fileexists("./secrets/secrets.txt") ? file("./secrets/secrets.txt") : ""
}

# 输出（应用端可使用）
output "redis_token" {
  value     = var.auth_enabled ? data.google_secret_manager_secret_version.redis_token[0].secret_data : local.redis_local_token
  sensitive = true
}
