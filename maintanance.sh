#!/usr/bin/env bash

set -ex

wp cli update --yes

BASE_DIR=~/apps/wordpress/htdocs

cd ${BASE_DIR}

if [ ! -e wp-backup/ ]; then
  mkdir wp-backup
  mv maintanance.sh wp-backup/
fi

cd ${BASE_DIR}/wp-content
cp -r plugins/ themes/ uploads/ -t ${BASE_DIR}/wp-backup
wp db export ${BASE_DIR}/wp-backup/wordpress.sql
cd ${BASE_DIR}/wp-backup
zip -r $(date +%Y%m%d%H%M%S) plugins/ themes/ uploads/ wordpress.sql
rm -r plugins/ themes/ uploads/ wordpress.sql

FILE_NUM=$(find ./ -name "*.zip" | wc -l)
ZIP=($(find ./ -name "*.zip" -type f | sort -n))

if [ $FILE_NUM -gt 1  ]; then

rm ${ZIP[0]}
unset ZIP[0]
ZIP=("${ZIP[@]}")

fi


wp core update
wp plugin update --all
wp theme update --all
wp language core update
