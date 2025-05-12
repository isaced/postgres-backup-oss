# postgres-backup-oss

[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/isaced/postgres-backup-oss)

English | [简体中文](README.zh-CN.md)

This project provides Docker images to periodically back up a PostgreSQL database to Alibaba Cloud Object Storage Service (OSS).

## Features

- Minimal image size (15MB)
- Low memory usage (less than 1MB in idle state)
- Support custom scheduling interval time (with cron format)

## Usage

Create a `docker-compose.yml` file with the following content:

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
      SCHEDULE: '0 0 * * *'         # optional, default '0 0 * * *' (daily)
      POSTGRES_HOST: postgres
      POSTGRES_PORT: 5432           # optional, default 5432
      POSTGRES_DATABASE: dbname
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      OSS_BUCKET_NAME: ${OSS_BUCKET_NAME}
      OSS_REGION: ${OSS_REGION}
      OSS_ACCESS_KEY_ID: ${OSS_ACCESS_KEY_ID}
      OSS_ACCESS_KEY_SECRET: ${OSS_ACCESS_KEY_SECRET}
```

Then run `docker-compose up -d` to start the backup service.

## OSS Configuration

You need to create an OSS bucket and an AccessKey pair in the [Alibaba Cloud console](https://home-intl.console.aliyun.com/). Then fill in the environment variables in the `docker-compose.yml` file.

About more OSS configuration, please refer to：[Configure ossutil - Environment variables](https://www.alibabacloud.com/help/en/oss/developer-reference/configure-ossutil2#8d24444ae2hnb), just add to environment to take effect.