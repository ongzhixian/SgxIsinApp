# Note: Ensure that the line-endings are `<LF>` instead of `<CR><LF>` (Windows) 
cd /usr/share/generic-128mi/sql/
for FILE in *.sql; do mysql -h mysql -u root -p$MYSQL_ROOT_PASSWORD < $FILE; done