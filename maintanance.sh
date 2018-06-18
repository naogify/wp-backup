wp cli update --yes
cd ~/apps/wordpress/htdocs/wp-content
cp -r plugins/ themes/ uploads/ -t ~/apps/wordpress/htdocs/wp-backup
wp db export ~/apps/wordpress/htdocs/wp-backup/wordpress.sql
cd ~/apps/wordpress/htdocs/wp-backup
zip -r $(date +%Y%m%d%H%M%S) plugins/ themes/ uploads/ wordpress.sql
rm -r plugins/ themes/ uploads/ wordpress.sql

wp core update
wp plugin update --all
wp theme update --all
wp language core update
