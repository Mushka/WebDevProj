#! /bin/bash

MYSQL_USERNAME="classta"
MYSQL_PASSWORD="classta"
XML_MOVIES="./mains243.xml"
XML_STARS="./actors63.xml"
XML_CAST="./casts124.xml"

echo "Creating Tables"
mysql --user="$MYSQL_USERNAME" --password="$MYSQL_PASSWORD" < createtable.sql
echo "COMPLETE"
echo "Compiling Java Resources"
javac ./src/*.java -d ./bin/
echo "COMPLETE"
echo "Running XML Parser"
java -classpath ./bin/:./lib/mysql-connector-java-5.0.8-bin.jar Parser $XML_MOVIES $XML_STARS $XML_CAST
echo "COMPLETE"