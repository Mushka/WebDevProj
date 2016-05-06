#! /bin/bash

echo "Removing Class Files"
rm -f ./bin/*.class
echo "COMPLETE"
echo "Dropping Database: moviedb_project3_grading"
mysql --user="classta" --password="classta" -e 'DROP DATABASE IF EXISTS moviedb_project3_grading;' 
echo "COMPLETE"
