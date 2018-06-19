#!/usr/bin/env bash

set -ex

# PLEASE SET MAXIMUM NUMBER OF BUCKUP DATA.
BACKUP_NUM=1

wp cli update --yes

BASE_DIR=~/apps/wordpress/htdocs
cd ${BASE_DIR}

# create wp-backup directory.
if [ ! -e wp-backup/ ]; then
  mkdir wp-backup
  mv maintanance.sh wp-backup/
fi

# copy files to backup.
cd ${BASE_DIR}/wp-content
cp -r plugins/ themes/ uploads/ -t ${BASE_DIR}/wp-backup

# export database.
wp db export ${BASE_DIR}/wp-backup/wordpress.sql

cd ${BASE_DIR}/wp-backup

# zip backup files.
zip -r $(date +%Y%m%d%H%M%S) plugins/ themes/ uploads/ wordpress.sql
rm -r plugins/ themes/ uploads/ wordpress.sql


FILE_NUM=$(find ./ -name "*.zip" | wc -l)
#get .zip files by find, and sort by number.
ZIP=($(find ./ -name "*.zip" -type f | sort -n))

# if the number of backup data is more than limit, delete oldest one.
if [ $FILE_NUM -gt $BACKUP_NUM  ]; then
  rm ${ZIP[0]}
  unset ZIP[0]
  #Put data to array again because unset just makes it's value empty.
  ZIP=("${ZIP[@]}")
fi

wp core update
wp plugin update --all
wp theme update --all
wp language core update