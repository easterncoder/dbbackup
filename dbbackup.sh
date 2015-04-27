#!/bin/bash

# Custom Script for backing up databases
# by Mike Lopez <mike@wishlistproducts.com>

# delete files older than 30 days
find /dbbackup/ -type f -mtime +30 -delete

# delete empty folders
find /dbbackup/ -type d -empty -delete

# create backup folder
dbbak="dbbackup/`date +%Y%m%d%H`"
mkdir -p "/$dbbak"

# backup all databases except mysql and information_schema
mysql -uroot -B -N -e "show databases" | egrep -v 'mysql|information_schema' | while read dbname; do mysqldump -uroot --skip-lock-tables "$dbname" | gzip > "/$dbbak/$dbname.sql.gz";done

