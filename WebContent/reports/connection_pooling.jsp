<h2><strong>How to use connection pooling for a single server</strong></h2>

<p><strong><em>Josh Angelesberg </br>
Max Ushkalov</br>
Josh Alpert</em></strong> </p>


<p>1. add a context.xml to your META-INF folder in your webcontent directory of your webapp </p>

<p>2. under your context tag add a resource tag with these parameters or the parameters you see fit for your pool of connections, in this case we use moviedb as the name of our database and jdbc/moviedb as our resource name</p>

<p><strong>Context.xml</strong></p>

<p>
&lt;Resource name="jdbc/moviedb" auth="Container" type="javax.sql.DataSource" </br>
&emsp;&emsp;maxActive="1000" maxIdle="300" maxWait="10000"</br>
&emsp;&emsp;maxAge="20000" </br>
&emsp;&emsp;testOnBorrow="true" </br>
&emsp;&emsp;testWhileIdle="true" </br>
&emsp;&emsp;validationInterval="0" </br>
&emsp;&emsp;validationQuery="Select 1" </br>
&emsp;&emsp;username="root" password="password" driverClassName="com.mysql.jdbc.Driver" </br>
&emsp;&emsp;url="jdbc:mysql://localhost:3306/moviedb?autoReconnect=true"&gt;
</p>

<p>3. next add a resource-ref in your Web.xml under your WEB-INF folder in your webcontent directory inside of your webapp</p>

<p><strong>Web.xml</strong></p>

<p>
&lt;resource-ref&gt;</br>
&emsp;&emsp;&lt;description&gt;DB Connection&lt;/description&gt;</br>
&emsp;&emsp;&lt;res-ref-name&gt;jdbc/moviedb&lt;/res-ref-name&gt;</br>
&emsp;&emsp;&lt;res-type&gt;javax.sql.DataSource&lt;/res-type&gt;</br>
&emsp;&emsp;&lt;res-auth&gt;Container&lt;/res-auth&gt;</br>
&lt;/resource-ref&gt;</br>
</p>


<p>4.Now when anytime a connection is established you want to grab the connections from the pool of connections rather than creating a new one, here is the java code of making it so you can do that.</p>

<p><strong>Any Instance of connections</strong></p>

<p>
Context initContext = new InitialContext();</br>
Context envContext = (Context) initContext.lookup("java:/comp/env");</br>
DataSource datasource = (DataSource) envContext.lookup("jdbc/moviedb");</br>
</br>
Connection db_connection = null;</br>
if(datasource == null){</br>
&emsp;&emsp;Class.forName("com.mysql.jdbc.Driver").newInstance();</br>
&emsp;&emsp;db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);</br>
}else</br>
&emsp;&emsp;db_connection = datasource.getConnection();</br>
</p>

<p>5. Now make sure that on your machine that you have your proper drivers for mySql and the correct .jar to use connection pooling on your system.</p>


<p>6. These files should reside in you /usr/share/tomcat7/lib on your linux machine, and have the names similar too "mysql-connector-java-5.0.8-bin.jar" and "bz53367-jdbc-pool.jar". Also make sure that the mySql driver is in your WEB-INF/lib folder as well as depending on your version of tomcat it will look in this directory for the driver </p>

<p>7. Now in you /etc/mysql/ directory open your my.conf file and change you "bind-address" to equal = 127.0.0.1 or 0.0.0.0 if it already equals that.</p>

<p>8. Now restart your tomcat server (sudo service tomcat7 restart) and your mySql database (sudo service mysql restart)</p>

<p>9. Connection pooling is now enabled </p>


<h2><strong>How to use connection pooling for multiple backend servers (master and slave)</strong></h2>

<p>1. add a context.xml to your META-INF folder in your webcontent directory of your webapp </p>

<p>2. under your context tag add a resource tag with these parameters or the parameters you see fit for your pool of connections, in this case we use moviedb as the name of our database and jdbc/moviedb as our resource name for our slaves and jdbc/master_moviedb for our master. We have to create two pools for our servers, as our master is the only one writing to our database and our slave is only reading. Make sure to make the IP address of your master match the IP Address of your master's instance</p>


<p><strong>Context.xml</strong></p>

<p>
&lt;Resource name="jdbc/moviedb" auth="Container" type="javax.sql.DataSource" </br>
&emsp;&emsp;maxActive="1000" maxIdle="300" maxWait="10000"</br>
&emsp;&emsp;maxAge="20000" </br>
&emsp;&emsp;testOnBorrow="true" </br>
&emsp;&emsp;testWhileIdle="true" </br>
&emsp;&emsp;validationInterval="0" </br>
&emsp;&emsp;validationQuery="Select 1" </br>
&emsp;&emsp;username="root" password="password" driverClassName="com.mysql.jdbc.Driver" </br>
&emsp;&emsp;url="jdbc:mysql://localhost:3306/moviedb?autoReconnect=true"&gt;
</p>

<p>
&lt;Resource name="jdbc/master_moviedb" auth="Container" type="javax.sql.DataSource" </br>
&emsp;&emsp;maxActive="1000" maxIdle="300" maxWait="10000"</br>
&emsp;&emsp;maxAge="20000" </br>
&emsp;&emsp;testOnBorrow="true" </br>
&emsp;&emsp;testWhileIdle="true" </br>
&emsp;&emsp;validationInterval="0" </br>
&emsp;&emsp;validationQuery="Select 1" </br>
&emsp;&emsp;username="repl" password="password" driverClassName="com.mysql.jdbc.Driver" </br>
&emsp;&emsp;url="jdbc:mysql://172.31.31.47:3306/moviedb?autoReconnect=true"&gt;
</p>

<p>3. next add a resource-ref in your Web.xml under your WEB-INF folder in your webcontent directory inside of your webapp</p>

<p><strong>Web.xml</strong></p>

<p>
&lt;resource-ref&gt;</br>
&emsp;&emsp;&lt;description&gt;DB Connection&lt;/description&gt;</br>
&emsp;&emsp;&lt;res-ref-name&gt;jdbc/moviedb&lt;/res-ref-name&gt;</br>
&emsp;&emsp;&lt;res-type&gt;javax.sql.DataSource&lt;/res-type&gt;</br>
&emsp;&emsp;&lt;res-auth&gt;Container&lt;/res-auth&gt;</br>
&lt;/resource-ref&gt;</br>
</p>

<p>
&lt;resource-ref&gt;</br>
&emsp;&emsp;&lt;description&gt;DB Connection&lt;/description&gt;</br>
&emsp;&emsp;&lt;res-ref-name&gt;jdbc/master_moviedb&lt;/res-ref-name&gt;</br>
&emsp;&emsp;&lt;res-type&gt;javax.sql.DataSource&lt;/res-type&gt;</br>
&emsp;&emsp;&lt;res-auth&gt;Container&lt;/res-auth&gt;</br>
&lt;/resource-ref&gt;</br>
</p>

<p>4.Now when anytime a connection is established you want to grab the connections from the pool of connections rather than creating a new one, here is the java code of making it so you can do that for writing for reading you will do the same thing, but use the name jdbc/moviedb as that is the resource name of the pool for reading.</p>

<p><strong>Any Instance of connections</strong></p>

<p>
Context initContext = new InitialContext();</br>
Context envContext = (Context) initContext.lookup("java:/comp/env");</br>
DataSource datasource = (DataSource) envContext.lookup("jdbc/master_moviedb");</br>
</br>
Connection db_connection = null;</br>
if(datasource == null){</br>
&emsp;&emsp;Class.forName("com.mysql.jdbc.Driver").newInstance();</br>
&emsp;&emsp;db_connection = DriverManager.getConnection(loginUrl, loginUser, loginPasswd);</br>
}else</br>
&emsp;&emsp;db_connection = datasource.getConnection();</br>
</p>

<p>5. Now make sure that on your machine that you have your proper drivers for mySql and the correct .jar to use connection pooling on your system.</p>


<p>6. These files should reside in you /usr/share/tomcat7/lib on your linux machine, and have the names similar too "mysql-connector-java-5.0.8-bin.jar" and "bz53367-jdbc-pool.jar". Also make sure that the mySql driver is in your WEB-INF/lib folder as well as depending on your version of tomcat it will look in this directory for the driver </p>

<p>7. Now in you /etc/mysql/ directory open your my.conf file and change you "bind-address" to equal = 127.0.0.1 or 0.0.0.0 if it already equals that.</p>

<p>8. Now restart your tomcat server (sudo service tomcat7 restart) and your mySql database (sudo service mysql restart)</p>

<p>9. Connection pooling is now enabled </p>

