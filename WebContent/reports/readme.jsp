<h2><strong>122B Spring 2016 </strong></h2>

<p><strong><em>Josh Angelesberg </br>
Max Ushkalov</br>
Josh Alpert</em></strong> </p>

<strong>Master </strong><br>
&nbsp;&nbsp;Public IP: 52.39.228.78 <br>
&nbsp;&nbsp;Internal IP: 172.31.31.47 <br>
<br>
<strong>Slave </strong><br>
&nbsp;&nbsp;Public IP: 52.40.73.138<br>
&nbsp;&nbsp;Internal IP: 172.31.29.128 <br>

<p><strong>The python script:</strong></p>

<p>This script prints the average of all the TS and TJ values inside the logFile.txt and then clears the log file. The log file is accessed via an absolute url; therefore, you can run this script from any location. The logFile.txt is located at: /home/ubuntu/logFile.txt</p>

<p> NOTE: once you run this python script, the log will be cleared.</p>

<p><strong>How to use the python script:</strong></p>

<p>To print the output of the script, run:<br>
shell> python avg.py </p>

<p>To store the output into a file, run: <br>
shell> python avg.py >> output</p>


<p><strong>How to compile:</strong></p>

<p>	NOTE: We used eclipse and exported as a WAR file so all the compilation is done in eclipse
	BUT to compile manually </p>

<p>	1. cd /var/lib/tomcat7/webapps/fabflix/WEB-INF/sources</br>
	2. sudo javac -classpath .:../lib/mysql-connector-java-5.0.8-bin.jar:../lib/servlet-api.jar ./servlets/*.java ./filters/*.java ./model/*java -d ../classes/</br>
	3. Open tomcat7 manager and reload the fabflix directory </p>
<p>
<strong>How to create war file</strong></p>

<p>	1. cd /var/lib/tomcat7/webapps/fabflix/</br>
	2. sudo jar -cvf fabflix.war *</p>

<p><strong>How to deploy a war file</strong></p>

<p>	1. Open tomcat7 manager </br>
	2. choose file from select WAR file to upload</br>
	3. Upload fabflix.war and Deploy</br>
	4. And if application not already started then click start</p>
