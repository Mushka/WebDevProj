<!DOCTYPE html>
<html>
<head>
	<title>Browse By Genre</title>
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
            height: 60px;
        }

    </style>

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

    String genre = Objects.toString(session.getAttribute("genre"), "0");
    String orderby = Objects.toString(session.getAttribute("orderby"), "asc_t");
	%>  

	var limit = <%=limit%>;
	var num_of_movies = <%=num_of_movies%>;
	var genre = "<%=genre%>"
	var offset = <%=offset%>;
	var orderby = "<%=orderby%>";
	var cartCounter = <%=cart_counter%>;
		
		
	/*     alert(pre_title); */

	function reloadMeTitle() {
        if(toggleTitle)
            reload(offset, limit, genre, 'asc_t');
        else
            reload(offset, limit, genre, 'desc_t');
    }

    function reloadMeYear() {
        if(toggleYear)
            reload(offset, limit, genre, 'asc_y');
        else
            reload(offset, limit, genre, 'desc_y');
    }

	function reload(of, li, ge, orb) {
		
		window.location.href = "./ShowGenre?genre=" + ge + "&limit=" + li + "&offset=" + of + "&orderby=" + orb;

	}


	function next() {
		
	/*  ./Search?username=a%40email.com&password=a2
	 */
	 
		if(num_of_movies > (offset+limit))
			reload(offset+limit, limit, genre, orderby);
		
		/* window.location.href = "./Search?limit=" + limit + "&offset=" + (offset+1); */
	}


	function prev() {
		 	
		if(offset > 0)
		{
			reload(offset-limit, limit, genre, orderby);
			/* window.location.href = "./Search?limit=" + limit + "&offset=" + (offset-1); */
		}
	}


	</script>

</head>

<body>

	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"

	import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*, model.*" 
		   
	%>
	<div id="wrapper">
		<div id="navBarTop">
			
			<%@ include file="header.jsp" %>
			
			<div id="arrangeBy">
				<select onChange="window.document.location.href=this.options[this.selectedIndex].value;" style="width: 200px; z-index: 1000;">
					<option>Select a Genre</option>
			   <%                  
	
						List<String> all_genres = (session.getAttribute("all_genres") == null) ? new ArrayList<String>() : (ArrayList<String>) session.getAttribute("all_genres");


						for(int i = 0; i < all_genres.size(); ++i){
				%>

							<option value="./ShowGenre?genre=<%=all_genres.get(i)%>&limit=<%=limit%>&offset=0&orderby=<%=orderby%>"><%=all_genres.get(i)%></option>
				   
					   <%}%>   
				
				</select>

				<div style="width: 100%; margin-left: -200px; display: flex; flex-direction: row; justify-content: center;">
	                Sort by:
	                <a id="byTitle" class="arrangeByLink">Title</a>
	                <div id="titleArrow" class="arrow-flat"></div>
	                <a id="byYear" class="arrangeByLink">Year</a>
	                <div id="yearArrow" class="arrow-flat"></div>
                </div>
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
				<a href="#" class="pageCount" onclick = "reload(offset, 5, genre, orderby);">5</a>
				<a href="#" class="pageCount" onclick = "reload(offset, 10, genre, orderby);">10</a>
				<a href="#" class="pageCount" onclick = "reload(offset, 15, genre, orderby);">15</a>
				<a href="#" class="pageCount" onclick = "reload(offset, 20, genre, orderby);">20</a>
				<a href="#" class="pageCount" onclick = "reload(offset, 25, genre, orderby);">25</a>
			</div>
		</div>
	</div>
</body>
</html>