<!DOCTYPE html>
<html>
<head>
	<title>Movies</title>
	<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
	<link rel="stylesheet" type="text/css" href="./css/shared.css">
	<link rel="stylesheet" type="text/css" href="./css/header.css">
	<link rel="stylesheet" type="text/css" href="./css/search.css">
	<link rel="stylesheet" type="text/css" href="./css/footer.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<style type="text/css">

		input[type="text"] {
			padding: 2px !important;
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
		String pre_title = (String) session.getAttribute("title");
		String orderby = (String) session.getAttribute("orderby");
		
	/*     Object cart_counter_obj = 
		int cart_counter = 0;
		
		if(cart_counter_obj != null) */
		int cart_counter =  Integer.parseInt(session.getAttribute("shopping_cart_size").toString());
		%>  

		var limit = <%=limit%>;
		var offset = <%=offset%>;
		var num_of_movies = <%=num_of_movies%>;
		var pre_title = "<%=pre_title%>";
		var orderby = "<%=orderby%>";
		
		var cartCounter = <%=cart_counter%>;

		function reload(of, li, ti, orb) {
			
			window.location.href = "./Search?limit=" + li + "&offset=" + of + "&title=" + ti + "&orderby=" + orb;

		}

		function next() {
		/*  /FabFlix/Search?username=a%40email.com&password=a2
		 */
			if(num_of_movies > (offset+limit))
				reload(offset+limit, limit, pre_title, orderby);
			/* window.location.href = "/FabFlix/Search?limit=" + limit + "&offset=" + (offset+1); */
		}

		function prev() {
				
			if(offset > 0)
			{
				reload(offset-limit, limit, pre_title, orderby);
				/* window.location.href = "/FabFlix/Search?limit=" + limit + "&offset=" + (offset-1); */
			}
		}

		function createCookie(name,value,days) {
			
			if (days) {
				var date = new Date();
				date.setTime(date.getTime()+(days*24*60*60*1000));
				var expires = "; expires="+date.toGMTString();
			}
			else var expires = "";
			document.cookie = name+"="+value+expires+"; path=/";
		}
			
		function eraseCookie(name) {
			
			createCookie(name,"",-1);
		}

		function readCookie(name) {
			
			var nameEQ = name + "=";
			var ca = document.cookie.split(';');
			for(var i=0;
			i < ca.length;i++) {
				var c = ca[i];
				while (c.charAt(0)==' ') c = c.substring(1,c.length);
				if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
			}
			return null;
		}

		$(document).ready(function() {

			$('.buyButton').click( function(e) {

				$.ajax({
					url : 'ProcessShoppingCart',
					data : "id="+this.id,
					success : function(responseText) {

					 if(responseText === "false")
					 {             
						 console.log("Failed to load");
					 }

					}
				});
				 
				var cart = $('#shoppingCartBtn');
				var imgtodrag = $(this).parent().find("img").eq(0);

				cartCounter++;

				if (imgtodrag) {
					var imgclone = imgtodrag.clone()
						.offset({
						top: imgtodrag.offset().top,
						left: imgtodrag.offset().left
					})
						.css({
						'opacity': '0.5',
							'position': 'absolute',
							'height': '150px',
							'width': '100px',
							'z-index': '9000'
					})
						.appendTo($('html'))
						.animate({
						'top': cart.offset().top + 10,
							'left': cart.offset().left + 10,
							'width': 50,
							'height': 75
					}, 500, 'easeInOutExpo');

					imgclone.animate({
						'width': 0,
							'height': 0
					}, function () {
						$(this).detach()
					});
					
					//checkForCount
					if (cartCounter < 0) {
						$('#shoppingCartCounter').hide();
					}
					else {
						$('#shoppingCartCounter').show();
					}
					
					$('#shoppingCartCounter').text(String(cartCounter));
				}
					
				e.preventDefault();
					
			});
		 

			$('#byTitle').click( function() {
				
				toggleTitle = !toggleTitle;
				if(toggleTitle)
					{
						reload(offset, limit, pre_title, 'asc_t');
					}
				else
					{
						reload(offset, limit, pre_title, 'desc_t');
					}
			});

			$('#byYear').click( function() {
				
				toggleYear = !toggleYear;
				if(toggleYear)
					{
						reload(offset, limit, pre_title, 'asc_y');
					}
				else
					{
						reload(offset, limit, pre_title, 'desc_y');
					}
			});
			
			var toggleTitle = false;
			var toggleYear = false;
			
			if(orderby === "asc_y")
			{
				toggleYear = true;
				$('#yearArrow').removeClass("arrow-flat").addClass("arrow-up");
			}
			else if(orderby === "desc_y") 
			{
				$('#yearArrow').removeClass("arrow-flat").addClass("arrow-down");
			}
			

			if(orderby === "asc_t")
			{
				toggleTitle = true;
				$('#titleArrow').removeClass("arrow-flat").addClass("arrow-up");
			}
			else if(orderby === "desc_t")
			{
				$('#titleArrow').removeClass("arrow-flat").addClass("arrow-down");
			}
			
			
		<%--     <%
				cart_counter =  Integer.parseInt(session.getAttribute("shopping_cart_size").toString());
			%>  

			var cartCounter = <%=cart_counter%>; --%>
			

			$('#shoppingCartCounter').text(String(cartCounter));

			if (cartCounter < 1) 
			{
			   $('#shoppingCartCounter').hide();      
			}
			else 
			{
				$('#shoppingCartCounter').show();
			}       



		});

		/* it resets the page, and orderby*/
		function search(text)
		{
			reload(0, limit, text, "asc_t");
		}

	</script>
	
</head>

<body>

	<%@	page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"

		import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*, model.*"    
	%>

	<div id="wrapper">
		
		<div id="navBarTop">
			
			<%@ include file="header.jsp" %>

			<div id="titleNav">
				<a href="#" class="titleCat first" onclick = "reload(0, limit, '0', orderby);">0</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '1', orderby);">1</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '2', orderby);">2</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '3', orderby);">3</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '4', orderby);">4</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '5', orderby);">5</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '6', orderby);">6</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '7', orderby);">7</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '8', orderby);">8</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, '9', orderby);">9</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'A', orderby);">A</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'B', orderby);">B</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'C', orderby);">C</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'D', orderby);">D</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'E', orderby);">E</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'F', orderby);">F</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'G', orderby);">G</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'H', orderby);">H</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'I', orderby);">I</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'J', orderby);">J</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'K', orderby);">K</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'L', orderby);">L</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'M', orderby);">M</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'N', orderby);">N</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'O', orderby);">O</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'P', orderby);">P</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'Q', orderby);">Q</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'R', orderby);">R</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'S', orderby);">S</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'T', orderby);">T</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'U', orderby);">U</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'V', orderby);">V</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'W', orderby);">W</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'X', orderby);">X</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'Y', orderby);">Y</a>
				<a href="#" class="titleCat" onclick = "reload(0, limit, 'Z', orderby);">Z</a>
			</div>

			<div id="arrangeBy">
				Sort by:
				<a id="byTitle" class="arrangeByLink">Title</a>
				<div id="titleArrow" class="arrow-flat"></div>
				<a id="byYear" class="arrangeByLink">Year</a>
				<div id="yearArrow" class="arrow-flat"></div>
			</div>
		</div>
		
		
		<div id="moviesList">
		
			<%
			List<Movie> movies = (ArrayList<Movie>) session.getAttribute("movies");
			
			for(Movie m : movies) {	
			%>         

				<div class="movieBox">

					<div class="imageAndBuy">

						<div class="movieImage" style="background-image: url('<%=m.getBannar_url()%>');">
							<img src='<%=m.getBannar_url()%>' onerror= "this.src = './images/no-image.jpg';">
						</div>

						<button type="button" id='<%=m.getId()%>' class="buyButton">Add to Cart</button> 
					</div>

					<div id="movieInfo">
						<div class="info first">
							<div class="infoTitle">Title:</div>
							<div class="infoDetail">
								<a href="./ShowMovie?movie_id=<%=m.getId()%>"><%=m.getTitle()%></a>
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
							List<String> genres = (ArrayList<String>) m.getGenres();
							/* for(String g : genres)  */
							for(int i = 0; i < genres.size(); ++i){
							%>
								<%if(i < genres.size()-1){%>
									<a href="./ShowGenre?genre=<%=genres.get(i)%>&limit=<%=limit%>&offset=0" ><%=genres.get(i)%>,</a>
								<%}
								else{%>
									<a href="./ShowGenre?genre=<%=genres.get(i)%>&limit=<%=limit%>&offset=0" ><%=genres.get(i)%></a>
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

			<%}%>  
			</div>
			<div id="navBarBottom">
				<button type="button" id="prevButton" class="navButton" onclick = "prev();">Prev</button> 
				<button type="button" id="nextButton" class="navButton" onclick = "next();">Next</button> 
				<div id="itemsPerPage">
					<span style="margin: 0px 10px 0px 40px">Items per page:</span>
					<a href="#" class="pageCount" onclick = "reload(offset, 5, pre_title, orderby);">5</a>
					<a href="#" class="pageCount" onclick = "reload(offset, 10, pre_title, orderby);">10</a>
					<a href="#" class="pageCount" onclick = "reload(offset, 15, pre_title, orderby);">15</a>
					<a href="#" class="pageCount" onclick = "reload(offset, 20, pre_title, orderby);">20</a>
					<a href="#" class="pageCount" onclick = "reload(offset, 25, pre_title, orderby);">25</a>
				</div>
			</div>
		</div>
</body>
</html>