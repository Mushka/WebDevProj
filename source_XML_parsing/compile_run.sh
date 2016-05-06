#! /bin/bash

echo "Creating Tables"
mysql --user="classta" --password="classta" < createtable.sql
echo "COMPLETE"
echo "Compiling Java Resources"
javac ./src/*.java -d ./bin/
echo "COMPLETE"
echo "Running XML Parser"
java -classpath ./bin/:./lib/mysql-connector-java-5.0.8-bin.jar Parser "./mains243.xml" "./actors63.xml" "./casts124.xml"
echo "COMPLETE"