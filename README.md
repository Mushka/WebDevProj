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

To compile:
- make 

To run:
- make run

To remove class files:
- make clean
