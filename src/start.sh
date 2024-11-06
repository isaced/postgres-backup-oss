# Default schedule
SCHEDULE=${SCHEDULE:-"* * * * *"}

# Set cron to run (crontab)
echo "$SCHEDULE /backup.sh" | crontab -

echo "Automatic backup started with schedule: $SCHEDULE"

# Start cron and keep container running
crond -f -l 8
