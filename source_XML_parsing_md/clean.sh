#! /bin/bash

echo "Removing Class Files"
rm -f ./bin/*.class
echo "COMPLETE"
echo "Dropping Database: moviedb"
mysql --user="classta" --password="classta" -e 'DROP DATABASE IF EXISTS moviedb;' 
echo "COMPLETE"
