# Daily Backup Script

## Features:
- Backs up a specified directory (default: /var/www)
- Retains last 7 backups
- Sends email alert on failure
- Rotates logs, keeping last 5

## How to Use:
1. Edit `BACKUP_SOURCE`, `EMAIL`, etc.
2. Make script executable:
   ```bash
   chmod +x backup.sh

## Add to Crontab
crontab -e
time(https://crontab.guru/) /path/to/your/script.sh
