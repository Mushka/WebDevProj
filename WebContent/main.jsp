<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>FlabFix - Home</title>
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Merriweather:700|Quicksand">
	<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
	<link rel="stylesheet" type="text/css" href="./css/shared.css">
    <link rel="stylesheet" type="text/css" href="./css/header.css">
    <link rel="stylesheet" type="text/css" href="./css/footer.css">

    <script src="./javascript/shared.js"></script>

	<style type="text/css">

		body, html {
			height: 100% !important;
		}

		#headerSearch {
			visibility: hidden !important;
		}

		#headerLogo {
			/*visibility: hidden !important;*/
			cursor: default !important;
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

	<script type="text/javascript">
		<%
        // These four lines make it so the page doesn't cache, so the shopping cart updates on back button press
        response.setHeader( "Expires", "Sat, 6 May 1995 12:00:00 GMT" );
        // set standard HTTP/1.1 no-cache headers
        response.setHeader( "Cache-Control", "no-store, no-cache, must-revalidate" );
        // set IE extended HTTP/1.1 no-cache headers
        response.addHeader( "Cache-Control", "post-check=0, pre-check=0" );
        // set standard HTTP/1.0 no-cache header
        response.setHeader( "Pragma", "no-cache" );

        int cart_counter =  Integer.parseInt(session.getAttribute("shopping_cart_size").toString());

        String orderby = (String) session.getAttribute("orderby");
        %>  

        var orderby = "<%=orderby%>";
        var cartCounter = <%=cart_counter%>;


        $(document).ready(function() {
        	$("#headerLogo").text("Welcome!");
        });

	</script>
  	
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