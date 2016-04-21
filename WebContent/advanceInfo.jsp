<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Advanced Search</title>
	<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="./css/shared.css">
    <link rel="stylesheet" type="text/css" href="./css/header.css">
    <link rel="stylesheet" type="text/css" href="./css/search.css">
    <link rel="stylesheet" type="text/css" href="./css/footer.css">
    <script src="./javascript/shared.js"></script>

	<style type="text/css">

		body, html {
			height: 100% !important;
		}

		#headerSearch {
			visibility: hidden !important;
		}

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

        int offset = Integer.parseInt((String) session.getAttribute("offset"));
        int limit = Integer.parseInt((String) session.getAttribute("limit"));
        int num_of_movies = Integer.parseInt((String) session.getAttribute("num_of_movies"));

        int cart_counter =  Integer.parseInt(session.getAttribute("shopping_cart_size").toString());

        String genre = (String) session.getAttribute("genre");
        String orderby = (String) session.getAttribute("orderby");
        %>  

        var limit = <%=limit%>;
        var num_of_movies = <%=num_of_movies%>;
        var genre = "<%=genre%>"
        var offset = <%=offset%>;
        var orderby = "<%=orderby%>";
        var cartCounter = <%=cart_counter%>;

        function reload(of, li, ti, orb) {
            
            window.location.href = "./Search?limit=" + li + "&offset=" + of + "&title=" + ti + "&orderby=" + orb;

        }

	</script>
  	
</head>
<body>
	<div id="wrapper">
		
		<div id="navBarTop">
                <%@ include file="header.jsp" %>
        </div>

		<div id="content">
			<div id="logoBox">
				<span id="logoFont" class="titleFont">Advanced Search</span>
			</div>
			<form id="advSearchBox" action="./Search">
				<input type="hidden" name="adv" value="true">
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