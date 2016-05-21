#! /bin/bash

echo "Creating Tables"
mysql --user="root" --password="password12" < createtable_fts.sql
echo "COMPLETE"
echo "Loading data.sql"
mysql --user="root" --password="password12" -D moviedb < data.sql
echo "Compiling Java Resources"
mkdir -p ./bin
javac ./src/*.java -d ./bin/
echo "COMPLETE"
echo "Running XML Parser"
java -classpath ./bin/:./lib/mysql-connector-java-5.0.8-bin.jar Parser "./mains243.xml" "./actors63.xml" "./casts124.xml"
echo "COMPLETE"
