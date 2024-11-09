#!/bin/sh

set -eu
set -o pipefail

# Environment variables
CURRENT_DATETIME=$(date +%Y%m%d%H%M%S)                        # Backup datetime
BACKUP_DIR="/backups"                                         # Backup directory
BACKUP_FILE="${BACKUP_DIR}/backup_${CURRENT_DATETIME}.sql.gz" # Backup file

# Set Postgres password
export PGPASSWORD=${POSTGRES_PASSWORD}

# Create backup directory
mkdir -p /backups

# clean up old backups (keep only 10)
backups_file_count=$(ls ${BACKUP_DIR} -1 | wc -l)
if [ $backups_file_count -gt 10 ]; then
  rm ${BACKUP_DIR}/*.sql.gz
  echo "Old backup files have been deleted!"
fi

echo "Creating backup of $POSTGRES_DATABASE database..."

# Create backup
pg_dump \
  -h $POSTGRES_HOST \
  -p $POSTGRES_PORT \
  -U $POSTGRES_USER \
  -d $POSTGRES_DATABASE |
  gzip >${BACKUP_FILE}

echo "Database export success! -> ${BACKUP_FILE}"

echo "Start uploading backup file..."

ossutil cp ${BACKUP_FILE} oss://${OSS_BUCKET_NAME}/backups/

echo "Backup file uploaded successfully!"
