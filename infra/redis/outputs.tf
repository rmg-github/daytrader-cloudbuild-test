output "instance_id" {
  description = "Redis 实例 ID"
  value       = google_redis_instance.redis.id
}

output "redis_host" {
  description = "Redis 主机地址"
  value       = google_redis_instance.redis.host
}

output "redis_port" {
  description = "Redis 端口"
  value       = google_redis_instance.redis.port
}

output "redis_auth_enabled" {
  description = "是否启用 AUTH"
  value       = google_redis_instance.redis.auth_enabled
}
