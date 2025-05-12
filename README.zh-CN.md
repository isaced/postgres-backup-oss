# postgres-backup-oss

[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/isaced/postgres-backup-oss)

[English](README.md) | 简体中文

该项目提供 Docker 镜像，用于定期将 PostgreSQL 数据库备份到阿里云对象存储服务 (OSS)。

## 特性

- 最小的镜像大小 (15MB)
- 低内存占用 (空闲状态下小于 1MB)
- 支持自定义调度间隔时间 (使用 cron 格式)

## 使用方法

创建一个 `docker-compose.yml` 文件，内容如下：

```yaml
services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: dbname

  backup:
    image: isaced/postgres-backup-oss:latest
    depends_on:
      - postgres
    environment:
      SCHEDULE: '0 0 * * *'         # 可选, 默认 '0 0 * * *' (每天)
      POSTGRES_HOST: postgres
      POSTGRES_PORT: 5432           # 可选, 默认 5432
      POSTGRES_DATABASE: dbname
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      OSS_BUCKET_NAME: ${OSS_BUCKET_NAME}
      OSS_REGION: ${OSS_REGION}
      OSS_ACCESS_KEY_ID: ${OSS_ACCESS_KEY_ID}
      OSS_ACCESS_KEY_SECRET: ${OSS_ACCESS_KEY_SECRET}
```

然后运行 `docker-compose up -d` 来启动备份服务。

## OSS 配置

您需要在[阿里云控制台](https://home.console.aliyun.com/)创建一个 OSS 存储桶 (Bucket) 和一个 AccessKey 对。然后在 `docker-compose.yml` 文件中填写相应的环境变量。

更多 OSS 配置信息，请参考：[配置 ossutil - 环境变量](https://help.aliyun.com/zh/oss/developer-reference/configure-ossutil2)，只需添加到环境变量即可生效。
