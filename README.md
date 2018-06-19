# wp-backup

## Requirements
- WP-CLI
- Bash
- Crontab

## How it works
This shell script creates the directory `wp-backup/`, and makes the zip file that includes `plugins/` `themes/` `uploads/` `wordpress.sql`(Exported mysql data).
Also you can set the maximum number of zip files. This script will delete oldest zip file when file's number reaches the limit.


## How to use
1. Please place `wp-backup.sh` at under　your WordPress directory.
2. Set `BACKUP_NUM` that is Maximum number of backup files. Also change `BASE_DIR` to your WordPres's path.
3. Set crontab to schedule of backup. 


## Description of Crontab

Fomula

```
*     *     *     *     *  command to be executed
-     -     -     -     -
|     |     |     |     |
|     |     |     |     +----- day of week (0 - 6) (Sunday=0)
|     |     |     +------- month (1 - 12)
|     |     +--------- day of month (1 - 31)
|     +----------- hour (0 - 23)
+------------- min (0 - 59)
```

https://help.ubuntu.com/community/CronHowto


Create schedule of task.

```
$ crontab -e
00 05 * * * ~/apps/wordpress/cron/wp-backup.sh
```

See the tasks that have already created.

```
$ crontab -l
00 05 * * * ~/apps/wordpress/cron/wp-backup.sh
```
