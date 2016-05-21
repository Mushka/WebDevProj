#! /bin/bash

echo "Removing Class Files"
rm -f ./bin/*.class
echo "COMPLETE"
echo "Dropping Database: moviedb"
mysql --user="root" --password="password234" -e 'DROP DATABASE IF EXISTS moviedb;' 
echo "COMPLETE"
