# WebDevProj

To import schema use: mysql -u root -p < createtable.sql

To add data from file:
- use \<dbname\>;
- source ./data.sql

#### Useful commands:
- show databases;
- show tables;
- use \<dbname\>;
- describe \<dbname\>.\<tablename\>; (ex. describe moviedb.movies;)


#### JDBC
###### You *must* be in the JDBC folder:

To compile:
- javac ./src/MyJDBCConnector.java -d ./bin/

To run:
- java -classpath ./bin/:./lib/mysql-connector-java-5.0.8-bin.jar MyJDBCConnector
