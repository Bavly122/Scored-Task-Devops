#!/bin/bash

DATE=$(date +%Y-%m-%d)
BACKUP_SOURCE="/var/www"
BACKUP_DIR="/var/backup"
LOG_DIR="/var/log/backup"
BACKUP_FILE="$BACKUP_DIR/backup-$DATE.tar.gz"
LOG_FILE="$LOG_DIR/backup-$DATE.log"
RETENTION_DAYS=7
LOG_RETENTION=5
EMAIL="bavlyadel70@gmail.com"

mkdir -p /var/backup
mkdir -p /var/log

cd /
echo "[$(date)] 🔄 Starting backup..." >> "$LOG_FILE"
tar -czf "$BACKUP_FILE" "$BACKUP_SOURCE" 2>> "$LOG_FILE"

if [ $? -eq 0 ]; then
    echo "[$(date)] ✅ Backup successful: $BACKUP_FILE" >> "$LOG_FILE"
    echo "Backup Successful on $(date)" | mail -s "✅ Daily Backup Successful" "$EMAIL"
else
    echo "[$(date)] ❌ Backup FAILED" >> "$LOG_FILE"
    echo "Backup FAILED on $(date)" | mail -s "❌ Daily Backup Failed" "$EMAIL"
fi

find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -name "*.tar.gz" -exec rm {} \;

find "$LOG_DIR" -type f -mtime +$LOG_RETENTION -name "*.log" -exec rm {} \;


#crontab -e
#0 0 * * * /home/bavly/Devops/Bash/Daily_Backup.sh