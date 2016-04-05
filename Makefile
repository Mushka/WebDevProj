all: 
	javac ./JDBC/src/MyJDBCConnector.java -d ./JDBC/bin/

r: 
	java -classpath ./JDBC/bin/:./JDBC/lib/mysql-connector-java-5.0.8-bin.jar MyJDBCConnector

run: all
	java -classpath ./JDBC/bin/:./JDBC/lib/mysql-connector-java-5.0.8-bin.jar MyJDBCConnector

clean:
	rm -f ./JDBC/bin/*.class
