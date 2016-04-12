<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome</title>


<script>
	function readCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for(var i=0;
		i < ca.length;i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1,c.length);
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	}
	
	function yesnoCheck() {
	    if (document.getElementById('yesCheck').checked) {
	        document.getElementById('ifYes').style.display = 'block';
	    }
	    else document.getElementById('ifYes').style.display = 'none';
	}

</script>

</head>
<body>

<%-- <%@ 

import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*" 
       
%> --%>

<%@ page import="tester.*" %>

<h1> Welcome 

<script> 



document.write(readCookie("loggedin")) 

		function doSomething() {
			/* alert(document.getElementById('titleSearch').value); */
			
			
			var title = document.getElementById('titleSearch').value;
			
			$.ajax({
		 			/*url is the location of the servlet, i believe */
	            url : 'Search',
	            data : title,
	            success : function(responseText) {
	            	
	            	document.write(responseText);
	            }
	        });
		}

</script>

</h1> <br>

Search <input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="yesCheck"> Browse <input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="noCheck"><br>
    <div id="ifYes" style="display:blocked">
        Title  <input type='text' id='titleSearch' name='title'  
        onkeydown = "if (event.keyCode == 13)
                        document.getElementById('btnSearch').click()"><br>
           
        <input type = "button"
       id = "btnSearch"
       value = "Search"
       onclick = "doSomething();"
/>
    </div>
    
    
   

</body>
</html>


