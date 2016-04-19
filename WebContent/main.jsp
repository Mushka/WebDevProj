<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>FlabFix - Home</title>
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Merriweather:700|Quicksand">
	<link rel="stylesheet" type="text/css" href="./css/shared.css">
    <link rel="stylesheet" type="text/css" href="./css/header.css">
    <link rel="stylesheet" type="text/css" href="./css/footer.css">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>

	<style type="text/css">

		body {
			height: 100% !important;
		}

		#searchBox {
			width: 600px;
			display: flex;
			flex-direction: row;
			justify-content: center;
		}

		#searchInput {
			width: 500px;
			height: 30px;
			font-family: inherit;
			box-shadow: 0px 3px 7px rgba(0, 0, 0, 0.3)
		}
		
		#linksBox {
			width: 600px;
			margin-top: 30px;
			display: flex;
			flex-direction: row;
			justify-content: center;
		}

		.pageLink {
			font-family: inherit;
			color: white;
			margin-left: 40px;
		}
	</style>
  	
</head>
<body>
	<div id="wrapper">

		<div id="navBarTop">
			<%@ include file="header.jsp" %>
		</div>

		<div id="content">
			<div id="logoBox">
				<span id="logoFont">FabFlix</span>
			</div>
			<div id="searchBox">
				<input type="text"  id="searchInput" placeholder="Search movies by title" onchange="window.location.href = './Search?title='+$(this).val()">
			</div>
			<div id="linksBox">
				<a href="./ShowGenre" class="pageLink" style="margin-left: 0px;">Browse By Genre</a>
				<a href="./Search" class="pageLink">Browse By Title</a>
				<a href="./advanceInfo.jsp" class="pageLink">Advanced Search</a>
			</div>
		</div>
	</div>
</body>
</html>