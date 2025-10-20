output "instance_connection_name" {
  description = "Cloud SQL 连接名称"
  value       = google_sql_database_instance.postgres_instance.connection_name
}

output "instance_private_ip" {
  description = "实例私有 IP"
  value       = google_sql_database_instance.postgres_instance.private_ip_address
}

output "db_user" {
  description = "数据库用户名"
  value       = google_sql_user.db_user.name
}

output "db_name" {
  description = "数据库名称"
  value       = google_sql_database.db.name
}
