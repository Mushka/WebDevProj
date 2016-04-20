<!DOCTYPE html>
<html>
<head>
	<title>FlabFix - Advanced Search</title>
	<link href='https://fonts.googleapis.com/css?family=Merriweather:700|Quicksand' rel='stylesheet' type='text/css'>
	<link id="pagestyle" rel="stylesheet" type="text/css" href="mainStyle.css">
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

		.first {
			margin-top: 0px !important;
		}

		.searchItem {
			margin-top: 10px;
		}
		
		#shoppingMessage{
			font-size: 40px;
			font-weight: bold;
			font-family: inherit;
			-webkit-font-smoothing: antialiased;
			color: white;
			text-align: center;
		}
				
		#confirmationFont {
			font-size: 80px;
			font-weight: bold;
			font-family: inherit;
			-webkit-font-smoothing: antialiased;
			color: white;
			text-align: center;
		}

	</style>
  	
</head>
<body>
	<div id="wrapper">
		<div id="content">
			<div id="logoBox">
				<span id="confirmationFont">Thank you for choosing FabFlix</span>
			</div>
				<div id="shoppingMessage">Items will be shipping soon</div> 
				<form action="." id="loginCredentials">
				    <input type="submit" value="Go home?" class="margin40T">
				</form>
		</div>
	</div>
</body>
</html>