# DayTrader 应用 GCP 迁移项目 — Cloud Development (DBaaS) WBS

## 1. 项目背景
本项目基于 DayTrader Java EE 应用，将现行系统迁移至 Google Cloud Platform (GCP)，以实现对云原生架构和托管服务的学习与实践。  
本小组聚焦 Cloud Development 中的 DBaaS 集成，选用 Cloud SQL for PostgreSQL 与 Memorystore for Redis。  

---

## 2. 项目目标
- 将 Apache Derby 数据库迁移至 GCP Cloud SQL for PostgreSQL。
- 集成 Memorystore for Redis，替代原自建缓存。
- 使用 Terraform 实现基础设施即代码 (IaC)。
- 输出完整的设计文档、迁移文档与评审材料。  

---

## 3. 工作范围
- Cloud SQL、Memorystore 规划与部署。
- 网络、VPC、防火墙及访问控制策略。
- JDBC、Redis 连接及 Secrets 外部化配置。
- 数据迁移方案设计与演练。
- 测试、联调与高可用演练。
- 最终文档与评审材料准备。

---

## 4. 不在本次范围
- Secret Manager 最终策略与安全测试由其他小组负责。
- 性能压测、CI/CD 流水线搭建仅提供方案，不做实施。

---

## 5. 项目团队
- Architecture
- Java Transformation
- Cloud Development（本 WBS 负责）
- PES/SRE

---

## 6. 使用服务
- **Cloud SQL for PostgreSQL**（替代 Apache Derby）
- **Memorystore for Redis**（替代本地缓存）
- **Terraform**（IaC）
- **GKE / Containerized App**（运行环境）

---

## 7. 工作分解结构（WBS）

| WBS 编码 | 工作项 | 说明 |
|-----------|--------|------|
| 1 | 现状调查 | 学习 GCP 服务，分析 DayTrader 现有数据库和缓存使用情况，梳理迁移需求。 |
| 2 | 架构设计 | 确定 Cloud SQL + Memorystore 方案、网络和安全策略，输出初步架构图。 |
| 3 | 基础设施建设 | 编写并部署 Terraform 脚本，实现 VPC、Cloud SQL、Memorystore、网络配置，验证连接。 |
| 4 | 应用改造 / Demo 集成 | 使用现有代码改造出 Demo 应用，完成 Cloud SQL、Redis、Secrets 集成并外部化配置，验证可行性。 |
| 5 | 数据迁移 | 从 Apache Derby 导出数据并导入 Cloud SQL，演练迁移流程并验证连接；编写迁移计划和连接说明文档。 |
| 6 | 测试与演练 | 在预发布环境联调（Demo App ↔ Cloud SQL ↔ Redis）、功能回归测试、高可用与容错演练、收集指标。 |
| 7 | 文档完善 | 根据测试与迁移演练结果完善设计文档、Terraform 文档、架构图和迁移计划最终版。 |
| 8 | 评审准备 | 汇总成果物，准备演示材料和评审汇报，展示 DayTrader / Demo 应用在 GCP 上的运行情况。 |

---

## 8. 时间与里程碑

| 日期 | 概要 | 任务 |
|-------|-------|-------|
| 9/25 | 现状调查 | GCP 服务学习 + 现状分析 + 需求确认 |
| 9/26 | 架构设计 | 确定 DB + Redis + 网络架构方案，制定安全与访问控制策略，输出初步架构图 |
| 9/28 – 9/29 | 基础设施建设 | 编写并部署 Terraform – VPC + Cloud SQL + Memorystore + 网络配置，验证连接，输出连接信息供后续配置 |
| 9/30 – 10/13 | 应用程序改造 / Demo 集成 | 使用现有代码改造出 Demo 应用，完成 Cloud SQL、Redis、Secrets 集成并外部化配置，验证可行性 |
| 10/14 | 数据迁移 | 从 Apache Derby 导出数据并导入 Cloud SQL，验证连接，演练迁移流程；编写迁移计划和连接说明文档 |
| 10/15 | 测试与演练 | 在预发布环境联调（Demo App ↔ Cloud SQL ↔ Redis）、功能回归测试、高可用与容错演练、收集指标 |
| 10/16 | 文档完善 | 根据测试与迁移演练结果完善设计文档、Terraform 文档、架构图和迁移计划最终版 |
| 10/17 | 评审准备 | 汇总成果物、准备演示材料和评审汇报，最终演示 DayTrader / Demo 应用在 GCP 上的运行情况 |

---

## 9. 成果物清单

- **DBaaS 集成设计文档**：Cloud SQL (PostgreSQL) + Memorystore (Redis) 架构、安全、网络、访问策略  
- **Terraform 模板与使用指南**：VPC、Cloud SQL、Memorystore 模块、变量及部署步骤  
- **连接说明文档**：JDBC URL、Redis 地址、驱动、环境变量、Secret 获取方式  
- **数据迁移计划文档**：迁移步骤、工具、校验、回滚与切换策略  
- **Demo 应用改造说明**：记录如何使用现有代码改造实现云服务集成  
- **架构图与评审材料**：架构图、演示 PPT、评审用案例  
- **（可选）**Secret 管理策略文档、CI/CD 集成方案、性能与容量报告

---

## 10. 风险与注意事项
- Cloud SQL 与 Memorystore 的网络访问与权限需要在早期验证。
- 数据迁移需要至少一次演练，避免评审前才遇到问题。
- Demo 与正式应用的差异需在评审前明确，避免误解交付范围。
- 应用代码的 JDBC/Redis 配置改造需与 Secret 管理策略同步。
- 评审材料需在 10/16 前全部完成初稿，留出一天打磨。

---

## 11. 成功标准
- Demo / DayTrader 应用成功在 GCP 上完成部署并可演示数据库和缓存功能。
- 所有 Terraform 模板可一键部署基础设施。
- 迁移、连接、测试文档完整，可供其他团队复用。
- 评审通过，能够演示完整业务流程。

