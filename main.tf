# ================================================================
#  Cloud SQL for PostgreSQL — Terraform IaC 配置
#  功能：PITR + 自动备份 + 删除保护 + 最终备份保留 + 维护窗口
#       + 自定义数据库标志 + 停用 Query Insights
# ================================================================

# -------------------------------
# Cloud SQL 实例
# -------------------------------
resource "google_sql_database_instance" "postgres_dev_instance" {
  name             = var.instance_id
  project          = var.project
  region           = var.region
  database_version = var.database_version

  settings {
    edition           = var.edition
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = var.disk_type
    disk_size         = var.disk_size_gb
    disk_autoresize   = var.disk_autoresize

    # 网络配置：仅私网访问
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.project}/global/networks/${var.vpc}"
    }

    # 自动备份 & PITR
    backup_configuration {
      enabled                        = var.backup_enabled
      start_time                     = var.backup_start_time
      point_in_time_recovery_enabled = var.point_in_time_recovery
      transaction_log_retention_days = var.transaction_log_retention_days

      backup_retention_settings {
        retained_backups = var.backup_retention_count
        retention_unit   = "COUNT"
      }
    }

    # 删除实例时保留最终备份
    final_backup_config {
      enabled        = var.final_backup_enabled
      retention_days = var.final_backup_enabled ? var.final_backup_retention_days : null
    }

    # 维护窗口
    maintenance_window {
      day          = var.maintenance_day    # 6 = Sunday
      hour         = var.maintenance_hour   # 19 UTC = 03:00 Beijing
      update_track = var.maintenance_track  # stable
    }

    # 数据库标志
    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }

    # Query Insights
    insights_config {
      query_insights_enabled  = var.query_insights_enabled
      record_application_tags = var.record_application_tags
      record_client_address   = var.record_client_address
    }

    user_labels = {
      "${var.label_key}" = var.label_value
    }
  }

  # 防止误删实例
  deletion_protection = var.deletion_protection
}

# -------------------------------
# 数据库
# -------------------------------
resource "google_sql_database" "db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres_instance.name
  project  = var.project
}

# -------------------------------
# 用户
# -------------------------------
resource "google_sql_user" "db_user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres_instance.name
  password = local.db_password
  project  = var.project
}
