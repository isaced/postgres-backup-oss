# postgres-backup-oss

This project provides Docker images to periodically back up a PostgreSQL database to Alibaba Cloud Object Storage Service (OSS).

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
      SCHEDULE: '* * * * *'         # optional, default '* * * * *'
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
