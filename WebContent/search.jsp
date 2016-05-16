<!DOCTYPE html>
<html>
<head>
    <title>Movies</title>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
    <link href="https://code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="./css/shared.css">
    <link rel="stylesheet" type="text/css" href="./css/header.css">
    <link rel="stylesheet" type="text/css" href="./css/search.css">
    <link rel="stylesheet" type="text/css" href="./css/footer.css">
    <script src="./javascript/shared.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <style type="text/css">

        #spacer {
            height: 80px;
        }

    </style>
    
   <%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"

        import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*, model.*"    
    %>

    <script>

        <%
        // These four lines make it so the page doesn't cache, so the shopping cart updates on back button press
        response.setHeader( "Expires", "Sat, 6 May 1995 12:00:00 GMT" );
        // set standard HTTP/1.1 no-cache headers
        response.setHeader( "Cache-Control", "no-store, no-cache, must-revalidate" );
        // set IE extended HTTP/1.1 no-cache headers
        response.addHeader( "Cache-Control", "post-check=0, pre-check=0" );
        // set standard HTTP/1.0 no-cache header
        response.setHeader( "Pragma", "no-cache" );

        int offset = Integer.parseInt(Objects.toString(session.getAttribute("offset"), "10"));
        int limit = Integer.parseInt(Objects.toString(session.getAttribute("limit"), "0"));
        int num_of_movies = Integer.parseInt(Objects.toString(session.getAttribute("num_of_movies"), "0"));
        int cart_counter = Integer.parseInt(Objects.toString(session.getAttribute("shopping_cart_size"), "0"));

        String orderby = Objects.toString(session.getAttribute("orderby"), "asc_t");
        String m_title = Objects.toString(session.getAttribute("title"), "");
        String year = Objects.toString(session.getAttribute("year"), "");
        String director = Objects.toString(session.getAttribute("director"), "");
        String fName = Objects.toString(session.getAttribute("first_name"), "");
        String lName = Objects.toString(session.getAttribute("last_name"), "");
        String adv = Objects.toString(session.getAttribute("adv"), "false");

        %>  

        var limit = <%=limit%>;
        var offset = <%=offset%>;
        var num_of_movies = <%=num_of_movies%>;
        var orderby = "<%=orderby%>";
        var cartCounter = <%=cart_counter%>;
        var m_title = "<%=m_title%>";
        var year = "<%=year%>";
        var director = "<%=director%>";
        var fName = "<%=fName%>";
        var lName = "<%=lName%>";
        var adv = "<%=adv%>";
        
        function reloadMeTitle() {
            if(toggleTitle)
                reload(offset, limit, m_title, 'asc_t', year, director, fName, lName, adv);
            else
                reload(offset, limit, m_title, 'desc_t', year, director, fName, lName, adv);
        }

        function reloadMeYear() {
            if(toggleYear)
                reload(offset, limit, m_title, 'asc_y', year, director, fName, lName, adv);
            else
                reload(offset, limit, m_title, 'desc_y', year, director, fName, lName, adv);
        }

		function reload(of, li, ti, orb, yr, dr, fn, ln, ad) {
	
	        if(ad === "true")
	        {
	         window.location.href = "./Search?adv=true&limit=" + li + "&offset=" + of + "&title=" + ti + "&orderby=" + orb + "&year=" + yr + "&director=" + dr + "&first_name=" + fn + "&last_name=" + ln;
	
	        }
	        else
	        {
	            window.location.href = "./Search?limit=" + li + "&offset=" + of + "&title=" + ti + "&orderby=" + orb;
	        }
	    } 
	
	    function next() {
	        
	        if(num_of_movies > (offset+limit))
	            reload(offset+limit, limit, m_title, orderby, year, director, fName, lName, adv);
	    }
	
	    function prev() {
	           
	        if(offset > 0)
	        {
	            reload(offset-limit, limit, m_title, orderby, year, director, fName, lName, adv);
	        }
	    }

    </script>
    
</head>

<body>


    <div id="wrapper">
        
        <div id="navBarTop">
            
            <%@ include file="header.jsp" %>

            <div id="titleNav">
                <a href="#" class="titleCat noBorderLeft" onclick = "reload(0, limit, '0', orderby, year, director, fName, lName, false);">0</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '1', orderby, year, director, fName, lName, false);">1</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '2', orderby, year, director, fName, lName, false);">2</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '3', orderby, year, director, fName, lName, false);">3</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '4', orderby, year, director, fName, lName, false);">4</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '5', orderby, year, director, fName, lName, false);">5</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '6', orderby, year, director, fName, lName, false);">6</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '7', orderby, year, director, fName, lName, false);">7</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '8', orderby, year, director, fName, lName, false);">8</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, '9', orderby, year, director, fName, lName, false);">9</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'A', orderby, year, director, fName, lName, false);">A</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'B', orderby, year, director, fName, lName, false);">B</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'C', orderby, year, director, fName, lName, false);">C</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'D', orderby, year, director, fName, lName, false);">D</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'E', orderby, year, director, fName, lName, false);">E</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'F', orderby, year, director, fName, lName, false);">F</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'G', orderby, year, director, fName, lName, false);">G</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'H', orderby, year, director, fName, lName, false);">H</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'I', orderby, year, director, fName, lName, false);">I</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'J', orderby, year, director, fName, lName, false);">J</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'K', orderby, year, director, fName, lName, false);">K</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'L', orderby, year, director, fName, lName, false);">L</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'M', orderby, year, director, fName, lName, false);">M</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'N', orderby, year, director, fName, lName, false);">N</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'O', orderby, year, director, fName, lName, false);">O</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'P', orderby, year, director, fName, lName, false);">P</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'Q', orderby, year, director, fName, lName, false);">Q</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'R', orderby, year, director, fName, lName, false);">R</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'S', orderby, year, director, fName, lName, false);">S</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'T', orderby, year, director, fName, lName, false);">T</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'U', orderby, year, director, fName, lName, false);">U</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'V', orderby, year, director, fName, lName, false);">V</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'W', orderby, year, director, fName, lName, false);">W</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'X', orderby, year, director, fName, lName, false);">X</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'Y', orderby, year, director, fName, lName, false);">Y</a>
                <a href="#" class="titleCat" onclick = "reload(0, limit, 'Z', orderby, year, director, fName, lName, false);">Z</a>
            </div>

            <div id="arrangeBy">
                Sort by:
                <a id="byTitle" class="arrangeByLink">Title</a>
                <div id="titleArrow" class="arrow-flat"></div>
                <a id="byYear" class="arrangeByLink">Year</a>
                <div id="yearArrow" class="arrow-flat"></div>
            </div>
        </div>

        <div id="spacer"></div>
        
        <div id="moviesList">
        
            <%

            List<Movie> movies = (session.getAttribute("movies") == null) ? new ArrayList<Movie>() : (ArrayList<Movie>) session.getAttribute("movies");
            
            for(Movie m : movies) { 

                /*  this takes into account if they are null */
                String mv_bannar_url = Objects.toString(m.getBannar_url(), "");
                String mv_id = m.getId() == -1 ? "" :  Integer.toString(m.getId());
                String mv_title = Objects.toString(m.getTitle(), "");
                String mv_year = m.getYear() == -1 ? "" : Integer.toString(m.getYear());
                String mv_director = Objects.toString(m.getDirector(), "");
                String mv_trailer_url = Objects.toString(m.getTrailer_url(), "");
                   
            %>         

                <div class="movieBox">
                	<div class="imageAndTrailer">
		                <img src='<%=mv_bannar_url%>' onerror= "this.src = './images/no-image.jpg';" class="movieImage">
	                    <a class="trailerButton" href=<%=mv_trailer_url%>>Watch Trailer</a>
                    </div>
                  	<a class="movieTitle tt" href="./ShowMovie?movie_id=<%=mv_id%>" title="<%=mv_id%>" ><%=mv_title%> (<%=mv_year%>)</a>
	                <button type="button" id=<%=mv_id%> class="buyButton">Add to Cart</button> 
	            </div>
	
            <%}%>  
	            </div>
	            <div id="navBarBottom">
	            <button type="button" id="prevButton" class="navButton" onclick = "prev();">Prev</button> 
	            <button type="button" id="nextButton" class="navButton" onclick = "next();">Next</button> 
	            <div id="itemsPerPage">
	                <span style="margin: 0px 10px 0px 40px">Items per page:</span>
	                <a href="#" class="pageCount" onclick = "reload(offset, 5, m_title, orderby, year, director, fName, lName, adv);">5</a>
	                <a href="#" class="pageCount" onclick = "reload(offset, 10, m_title, orderby, year, director, fName, lName, adv);">10</a>
	                <a href="#" class="pageCount" onclick = "reload(offset, 15, m_title, orderby, year, director, fName, lName, adv);">15</a>
	                <a href="#" class="pageCount" onclick = "reload(offset, 20, m_title, orderby, year, director, fName, lName, adv);">20</a>
	                <a href="#" class="pageCount" onclick = "reload(offset, 25, m_title, orderby, year, director, fName, lName, adv);">25</a>
	            </div>
        </div>
</body>
</html>