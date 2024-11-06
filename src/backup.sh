#!/bin/sh

set -eu
set -o pipefail

# Environment variables
CURRENT_DATETIME=$(date +%Y%m%d%H%M%S)                   # Backup datetime
BACKUP_FILE="/backups/backup_${CURRENT_DATETIME}.sql.gz" # Backup file

# Set Postgres password
export PGPASSWORD=${POSTGRES_PASSWORD}

echo "Creating backup of $POSTGRES_DATABASE database..."

# Create backup directory
mkdir -p /backups

# Create backup
pg_dump --format=custom \
  -h $POSTGRES_HOST \
  -p $POSTGRES_PORT \
  -U $POSTGRES_USER \
  -d $POSTGRES_DATABASE \
  >${BACKUP_FILE}

echo "Database export success! -> ${BACKUP_FILE}"

echo "Start uploading backup file..."

ossutil cp ${BACKUP_FILE} oss://${OSS_BUCKET_NAME}/backups/

echo "Backup file uploaded successfully!"
