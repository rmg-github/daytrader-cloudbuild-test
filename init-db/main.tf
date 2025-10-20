terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.1"
    }
  }
}

resource "null_resource" "db_init" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = <<EOT
set -e
export PGPASSWORD=${var.db_password}

# 启动 Cloud SQL Proxy 前台运行
cloud_sql_proxy -instances=${var.instance_connection_name}=tcp:${var.instance_port} &
PROXY_PID=$!

# 捕获脚本退出时信号，保证 Proxy 被杀掉
trap "kill $PROXY_PID" EXIT

# 等待 Proxy 启动
sleep 5

DB_IP="127.0.0.1"
DB_PORT="${var.instance_port}"

# 执行 DDL
echo "Applying derby-schema.sql..."
psql -h $DB_IP -U ${var.db_user} -d ${var.db_name} -p $DB_PORT -f init-db/scripts/derby-schema.sql

# 执行 DML
echo "Applying populate.sql..."
psql -h $DB_IP -U ${var.db_user} -d ${var.db_name} -p $DB_PORT -f init-db/scripts/populate.sql
EOT
  }

  triggers = {
    db_version = var.db_version
  }
}
