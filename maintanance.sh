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

if [ $FILE_NUM -gt 1  ]; then

  declare -A ZIP;
  ZIP=$(find ./ -name "*.zip" -type f)

  for item in ${ZIP[@]}; do
    echo ZIP[$(stat --printf=%Z $item)]=$item
  done

fi

wp core update
wp plugin update --all
wp theme update --all
wp language core update
