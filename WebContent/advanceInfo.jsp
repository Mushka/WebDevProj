<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

	</style>
  	
<%@ include file="header.jsp" %>
  	
</head>
<body>
	<div id="wrapper">
		<div id="content">
			<div id="logoBox">
				<span id="logoFont">FabFlix</span>
			</div>
			<form id="advSearchBox" action="./AdvanceSearch">
				<input type="text" name="title" class="first searchItem" placeholder="Title">
				<input type="text" name="year" class="searchItem" placeholder="Year">
				<input type="text" name="director" class="searchItem" placeholder="Director">
				<input type="text" name="first_name" class="searchItem" placeholder="Actor first name">
				<input type="text" name="last_name" class="searchItem" placeholder="Actor last name">
				<input type="submit" class="searchItem" value="Search">
			</form>
		</div>
	</div>
</body>
</html>