<!DOCTYPE html>
<html>
<head>
	<title>Reports</title>
<!-- 	<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
 -->
	<style type="text/css">
	
		body, html {
			margin: 0;
 			height: 100%;
 			background: #1C5588;
		}
	
		input[type="submit"] {
			height: 56px;
			background: #1C5588;
			border: 0;
			font-size: 22px;
			font-family: 'Proxima Nova', helvetica;
			color: white;
		}
		
		input[type="submit"]:hover {
			background: #46749D;
		}
		
		a {
			font-size: 22px;
			font-family: inherit;
			color: white;
		}
		
		#wrapper {
		    display: flex;
		    flex-direction: row;
		    justify-content: center;
		    font-family: 'Proxima Nova', helvetica;
		}
		
		#content {
			width: 600px;
		    font-family: inherit;
		    display: flex;
		    flex-direction: column;
		    justify-content: flex-start;
		    /* margin: auto; */
		}
		
		#titleBox {
		    display: flex;
		    flex-direction: row;
		    justify-content: center;
		}
		
		#titleFont {
		    font-size: 120px;
		    font-weight: bold;
		    font-family: inherit;
		    -webkit-font-smoothing: antialiased;
		    color: white;
		}
		
		#reportBox {
			font-family: inherit;
			color: white;
			margin-top: 20px;
			
		}
		
		#errorMessage{
			font-size: 35px;
			font-weight: bold;
			font-family: inherit;
			-webkit-font-smoothing: antialiased;
			color: white;
			text-align: center;

		}
	
		#loginCredentials {
		    display: flex;
		    flex-direction: column;
		    justify-content: center;
		}
		
		.margin40T {
		    margin-top: 25px;
		}
		
		.homeButton {
			align-self: center;
			width: 200px;
		}

	</style>
  	
</head>
<body>
	<div id="wrapper">
		<div id="content">
			<div id="titleBox">
				<span id="titleFont">Report</span>
			</div>
			<div id="reportBox">
<%
		   	 	String report_page = (String) session.getAttribute("report_page"); 
			
				if(report_page != null){
					
					if("like-predicate".equalsIgnoreCase(report_page))
					{	
%>	
				        <%@ include file="../reports/like-predicate.jsp" %>
<%
					}
					else if("readme".equalsIgnoreCase(report_page))
					{
%>	
				        <%@ include file="../reports/readme.jsp" %>
<%
					}
					else
					{
%>	
				        <%@ include file="../reports/index.jsp" %>
<%
					}
%>
					 
<%
					session.setAttribute("report_page", null);
				}
%>
				
			</div>				
				
			<form action="<%=request.getContextPath()%>/main.jsp" id="loginCredentials">
			    <input type="submit" value="Go home?" class="margin40T homeButton">
			</form>
		</div>
	</div>
</body>
</html>