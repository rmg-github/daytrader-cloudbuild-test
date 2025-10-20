在 Cloud Shell 里执行 terrafomr 的步骤：

---

### 1. 确认 Cloud Shell 环境

Cloud Shell 里默认已经安装了 `gcloud` 和 `terraform`

确认 gcloud

```bash
gcloud version
```

确认 terraform

```bash
terraform version
```

一次性检查

```bash
which gcloud terraform
```

如果没有 Terraform，可以执行：

```bash
sudo apt-get update && sudo apt-get install -y terraform
```

---

### 2. 新建 Terraform 配置文件

在 Cloud Shell 打开编辑器或者直接用 `nano`，比如：

```bash
nano main.tf
```

把 terraform 代码粘贴进去保存。

---

### 3. 初始化 Terraform

```bash
terraform init
```

这一步会下载 Google Cloud Provider 插件。

---

### 4. 配置认证

Cloud Shell 已经自带登录信息，你可以设置项目和区域：

```bash
gcloud config set project <YOUR_PROJECT_ID>
gcloud config set compute/region asia-northeast3
```

Terraform 会使用 Cloud Shell 的默认凭证，不需要额外的 service account key。

---

### 5. 查看执行计划

```bash
terraform plan
```

会显示 Terraform 打算创建的 Cloud 资源。

---

### 6. 执行创建

```bash
terraform apply
```

然后输入 `yes` 确认。Terraform 会去 GCP 创建 terraform 代码里的资源。

---

### 7. 验证结果

执行完成后，可以用 `gcloud` 命令查看：

```bash
gcloud sql instances list
gcloud sql databases list --instance=postgres-instance （例）
```

---

👉 把这段代码存成 **Terraform 配置文件**（比如 `main.tf`），然后在 Cloud Shell 里执行 `terraform init → terraform plan → terraform apply`。

