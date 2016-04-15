Import / Export Eclipse projects
- To import project changes from github use: `./import`
- To export your project updates to github: `./export`
- Modify the scripts to contain the correct paths to files

Setting up mysql database via mysql
(1) Create database moviedb
	- mysql> create database moviedb;
(2) Use database
	- mysql> use moviedb;
(3) Import schema
	- mysql> source ./createtable.sql
(4) Populate database
	- mysql> source ./data.sql;

Setting up mysql database via shell
(1) Create database moviedb
	- shell> echo "create database moviedb;" | mysql -u root -p
(2) Import schema
	- shell> mysql -u root -p -D moviedb < createtable.sql
(3) Populate database
	- shell> mysql -u root -p -D moviedb < data.sql


Useful mysql commands:
- show databases;
- show tables;
- use <dbname>;
- describe <dbname>.<tablename>; (ex. describe moviedb.movies;)


Commands to use terminal interface
(1) To compile:
	- shell> make 

(2) To run:
	- shell> make r

(3) To compile and run:
	- shell> make run

(4) To remove class files:
	- shell> make clean