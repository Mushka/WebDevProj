<!DOCTYPE html>
<html>
<head>
	<title>Reports</title>
	<link href='https://fonts.googleapis.com/css?family=Merriweather:700|Quicksand' rel='stylesheet' type='text/css'>
	<link id="pagestyle" rel="stylesheet" type="text/css" href="../css/shared.css">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>

	<style type="text/css">
		#advSearchBox {
			width: 535px;
			padding: 40px;
			border-radius: 3px;
			background: white;
			font-family: inherit;
			box-shadow: 0px 3px 7px rgba(0, 0, 0, 0.4);
			display: flex;
			flex-direction: column;
			justify-content: flex-start;
		}
		
		#errorMessage{
			font-size: 35px;
			font-weight: bold;
			font-family: inherit;
			-webkit-font-smoothing: antialiased;
			color: white;
			text-align: center;

		}
		

		.first {
			margin-top: 0px !important;
		}

		.searchItem {
			margin-top: 10px;
		}

	</style>
  	
</head>
<body>
	<div id="wrapper">
		<div id="content">
			<div id="logoBox">
				<span id="logoFont">Report</span>
			</div>
				<%
			   	 	String reports_page = (String) session.getAttribute("reports_page"); 
				
					if(reports_page != null){
				%>		
				
						<div id="errorMessage"><%=reports_page%></div> 
							 
				<%
						session.setAttribute("reports_page", null);
				}%>
				
				
				<div id="errorMessage">
				                <a href="../css/shared.css">lol</a>
				
				
			</div> 
				
				
				<form action="." id="loginCredentials">
				    <input type="submit" value="Go home?" class="margin40T">
				</form>
		</div>
	</div>
</body>
</html>