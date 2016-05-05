#! /bin/bash

MYSQL_USERNAME="classta"
MYSQL_PASSWORD="classta"
DATABASE_NAME="moviedb_project3_grading"

echo "Removing Class Files"
rm ./bin/*.class
echo "COMPLETE"
echo "Dropping Database: $DATABASE_NAME"
mysql --user="$MYSQL_USERNAME" --password="$MYSQL_PASSWORD" -e 'DROP DATABASE IF EXISTS $DATABASE_NAME'
echo "COMPLETE"

