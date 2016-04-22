<!DOCTYPE html>
<html>
<head>
	<title>Browse By Genre</title>
	<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
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
						List<String> all_genres = (ArrayList<String>) session.getAttribute("all_genres");

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

		List<Movie> movies = (ArrayList<Movie>) session.getAttribute("movies");
		

		for(Movie m : movies)
		{
			
 %>         

			<div class="movieBox">
				<div class="imageAndBuy">
					<div class="movieImage" style="background-image: url('<%=m.getBannar_url()%>');">
	                	<img src='<%=m.getBannar_url()%>' onerror= "this.src = './images/no-image.jpg';">
               		</div>
					<button type="button" id=<%=m.getId()%> class="buyButton">Add to Cart</button> 
				</div>
				<div id="movieInfo">
					<div class="info first">
						<div class="infoTitle">Title:</div>
						<div class="infoDetail">
						
<!--                         <script>var movie_id=</script>
 -->                            <a href="./ShowMovie?movie_id=<%=m.getId()%>"><%=m.getTitle()%></a>
						</div>
					</div>
					<div class="info">
						<div class="infoTitle">Year:</div>
						<div class="infoDetail"><%=m.getYear()%></div>
					</div>
					<div class="info">
						<div class="infoTitle">Director:</div>
						<div class="infoDetail"><%=m.getDirector()%></div>
					</div>
					<div class="info">
						<div class="infoTitle">Movie ID:</div>
						<div class="infoDetail"><%=m.getId()%></div>
					</div>
					<div class="info">
						<div class="infoTitle">Stars:</div>
						<div class="infoDetail">
<%                  
						List<Star> stars = (ArrayList<Star>) m.getStars();
						/* for(String g : genres)  */
						for(int i = 0; i < stars.size(); ++i){
%>
							
							<%if(i < stars.size()-1){%>
								<a href="./ShowStar?star_id=<%=stars.get(i).getId()%>"><%=stars.get(i).getName()%>,</a>
							<%}
							else{%>
								<a href="./ShowStar?star_id=<%=stars.get(i).getId()%>"><%=stars.get(i).getName()%></a>
							<%}%>
					
						<%}%>   
						
						</div>
					</div>
					<div class="info">
						<div class="infoTitle">Genres:</div>
						<div class="infoDetail">
						
						
<%                  
						List<String> m_genres = (ArrayList<String>) m.getGenres();
						/* for(String g : genres)  */
						for(int i = 0; i < m_genres.size(); ++i){
%>
							<%if(i < m_genres.size()-1){%>
								<a href="./ShowGenre?genre=<%=m_genres.get(i)%>&limit=<%=limit%>&offset=0&orderby=<%=orderby%>" ><%=m_genres.get(i)%>,</a>
							<%}
							else{%>
								<a href="./ShowGenre?genre=<%=m_genres.get(i)%>&limit=<%=limit%>&offset=0&orderby=<%=orderby%>" ><%=m_genres.get(i)%></a>
							<%}%>
							
									
						<%}%>   

						</div>
					</div>
					<div class="info">
						<div class="infoTitle">Trailer:</div>
						<div class="infoDetail">
							<a href=<%=m.getTrailer_url()%>>Click here</a>
							 to watch the movie trailer
						</div>
					</div>
					<div class="info">
						<div class="infoTitle">Price:</div>
						<div class="infoDetail">$15.99</div>
					</div>
				</div>
			</div>

		<%

		}

%>  
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