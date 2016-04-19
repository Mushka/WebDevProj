<!DOCTYPE html>
<html>
<head>
    <title>Main Page</title>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
    <style type="text/css">

        @font-face {
            font-family: 'Proxima Nova';
            src: local('Proxima Nova Regular'), url(./fonts/ProximaNova-Regular.ttf);
        }

        body,html {
            /*height: 100%;*/
            margin: 0;
            background: #1C5588;
        }

        .first {
            margin-top: 0px !important;
            border-top: 0px solid white !important;
            border-left: 0px solid white !important;
        }

        #wrapper {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            font-family: 'Proxima Nova';
        }

        #moviesList {
            width: 800px;
/*          height: 100%;
*/          margin-top: 80px;
            margin-bottom: 20px;
            /*border-left: 4px solid white;*/
            /*border-right: 4px solid white;*/
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-self: center;
            background: white;
            font-family: 'Proxima Nova';
        }

        .movieBox {
            width: auto;
            padding: 20px;
            /*margin: 10px 0px 0px 0px;*/
            border-top: 2px solid black;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            font-family: inherit;
            /*background: red;*/
        }

        .imageAndBuy {
            width: 200px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            font-family: inherit;
        }

        .movieImage {
            width: 100px;
            height: 150px;
            overflow: hidden;
            align-self: center;
        }

        .buyButton {
            width: 120px;
            height: 26px;
            margin-top: 25px;
            padding: 3px;
            border: 0px solid white;
            border-radius: 3px;
            font-family: inherit;
            font-size: 20px;
            text-align: center;
            color: white;
            background: green;
            align-self: center;
        }

        .navButton {
            width: 120px;
            height: 20px;
            /*padding: 3px;*/
            margin-right: 5px;
            border: 0px solid white;
            border-radius: 3px;
            font-family: inherit;
            font-size: 15px;
            text-align: center;
            color: white;
            background: grey;
            align-self: center;
        }

        .movieInfo {
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-self: flex-start;
            font-family: inherit;
        }

        .info {
            margin-top: 5px;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            font-family: inherit;
        }

        .infoTitle {
            width: 80px;
            text-align: right;
            font-family: inherit;
            /*background: yellow;*/
        }

        .infoDetail {
            margin: 0px 0px 0px 10px;
            flex-grow: 5;
            text-align: left;
            font-family: inherit;
        }

        #navBarTop {
            width: 800px;
            position: fixed;
            left: 50%;
            margin-left: -400px;
            /*border-top: 2px solid black;*/
            /*border-bottom: 2px solid black;*/
            display: flex;
            flex-flow: column;
            background: white;
            z-index: 999;
        }

        #searchBar {
            width: 800px;
            /*height: 20px;*/
            /*border-top: 2px solid black;*/
            /*border-bottom: 2px solid black;*/
            display: flex;
            flex-direction: row;
            justify-content: space-between;;
            align-self: center;
            background: white;
            z-index: 999;
        }
        
        #searchBtn {
            align-self: flex-start;
            margin-right: auto;
        }

        #titleNav {
            width: 800px;
            /*left: 50%;*/
            /*margin-left: -400px;*/
            border-top: 2px solid black;
            border-bottom: 2px solid black;
            display: flex;
            flex-flow: row;
            background: white;
            z-index: 999;
        }

        #navBarBottom {
            width: 800px;
            /*height: 20px;*/
            position: fixed;
            left: 50%;
            margin-left: -400px;
            bottom: 0px;
            z-index: 999;
            border-top: 2px solid black;
            border-bottom: 2px solid black;
            display: flex;
            flex-flow: row;
            align-self: center;
            justify-content: center;
            background: white;
        }

        .titleCat {
            font-family: inherit;
            font-size: 16px;
            text-align: center;
            color: black;
            border-left: 2px solid black;
            flex-grow: 1;
            align-self: center;
        }

        .pageCount {
            margin-right: 5px;
            font-family: inherit;
            font-size: 16px;
            text-align: center;
            color: black;
            flex-grow: 1;
            align-self: center;
        }
        
         .arrow-up {
            width: 0; 
            height: 0; 
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            margin-left: 10px;
            border-bottom: 10px solid #f00;
            align-self: center;
        }

        .arrow-down {
            width: 0; 
            height: 0; 
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            margin-left: 10px;
            border-top: 10px solid green;
            align-self: center;
        }
        
                
        .arrow-flat {
          width: 10px; 
          height: 2px; 
          margin-left: 10px;
          background: grey;
          align-self: center;
        }

        #arrangeBy {
            width: 800px;
            position: fixed;
            left: 50%;
            margin-left: -400px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            background: white;
            z-index: 999;
            border-bottom: 2px solid black;
        }

        .arrangeByLink {
            color: grey;
            margin-left: 10px;
            text-decoration: underline;
            cursor: pointer;
        }
        
        #headerLogo {
        	font-family: inherit;
        	font-size: 16px;
        	align-self: center;
        	margin-right: 10px;
        	margin-left: 5px;
        }

        #shoppingCartBtn {
            height: 40px;
            width: 40px;
            color: red;
            cursor: pointer;
            align-self: flex-end;
            background: #FFD900;
            background-image: url(./images/shoppingCart.svg);
            background-size: 30px 30px;
            background-repeat: no-repeat;
            background-position: center;
            border-radius: 3px;
        }
        
        #shoppingCartCounter {
            height: 40px;
            width: 20px;
            background: green;
            color: white;
            align-self: flex-end;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        #shoppingCartPreview {
            width: 200px;
            height: auto;
            padding: 10px;
            top:-500px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: red;
            position: fixed;
            z-index: 9001;
        }
        
        #shoppingCartMovieImage {
            align-self: center;
        }


    </style>
    
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movies</title>

<script>


<%  
    int offset = Integer.parseInt((String) session.getAttribute("offset"));
    int limit = Integer.parseInt((String) session.getAttribute("limit"));
    int num_of_movies = Integer.parseInt((String) session.getAttribute("num_of_movies"));
    String orderby = (String) session.getAttribute("orderby");
    
/*     Object cart_counter_obj = 
    int cart_counter = 0;
    
    if(cart_counter_obj != null) */
    int cart_counter =  Integer.parseInt(session.getAttribute("shopping_cart_size").toString());


    String title = (String) session.getAttribute("title");
    String year = (String) session.getAttribute("year");;
    String director = (String) session.getAttribute("director");
    String fName = (String) session.getAttribute("first_name");
    String lName = (String) session.getAttribute("last_name");

    String adv = (String) session.getAttribute("adv");

%>  



    var limit = <%=limit%>;
    var offset = <%=offset%>;
    var num_of_movies = <%=num_of_movies%>;
    var orderby = "<%=orderby%>";
    
    var cartCounter = <%=cart_counter%>;

    var title = "<%=title%>";
    var year = "<%=year%>";
    var director = "<%=director%>";
    var fName = "<%=fName%>";
    var lName = "<%=lName%>";

    var adv = "<%=adv%>";

/*     alert(pre_title); */


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
    
/*  /FabFlix/Search?username=a%40email.com&password=a2
 */
 
    if(num_of_movies > (offset+limit))
        reload(offset+limit, limit, title, orderby, year, director, fName, lName, adv);
    
    /* window.location.href = "/FabFlix/Search?limit=" + limit + "&offset=" + (offset+1); */
}


function prev() {
     
        
    if(offset > 0)
    {
        reload(offset-limit, limit, title, orderby, year, director, fName, lName, adv);
        /* window.location.href = "/FabFlix/Search?limit=" + limit + "&offset=" + (offset-1); */
    }
}

 

$(document).ready(function() {
    
    $('#navBarTop').append("<div id='shoppingCartPreview'></div>");
    $('#shoppingCartPreview').append("<button type='button' id='finalAddToCart'>Add to Cart</button>");

    // $('#shoppingCartCounter').hide();
    
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
         
        
        // $('#shoppingCartPreview').prepend("<div id='shoppingCartMovieImage'>" + this.id + "</div>");
        
        // $('#finalAddToCart').click( function(){

        //     $('#shoppingCartPreview').css('top', -600);
        //     /* $('#shoppingCartPreview').empty(); */
        //     /* $('#shoppingCartPreview').remove(); */
            
        // });
        // $('#shoppingCartPreview').css('left', $('#shoppingCartBtn').offset().left - (100-20));
        // $('#shoppingCartPreview').css('top', 40);
        
        /* shopping_cart = readCookie("shopping_cart"); */
        
        
        
        
        /*  Map<String, Integer> shopping_cart = (Map<String, Integer>) session.getAttribute("offset");  */
        
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
        
    
   <%--  window.onpageshow = function(evt) {

    	<%
    		cart_counter =  Integer.parseInt(session.getAttribute("shopping_cart_size").toString());
    	%>  

    	var cartCounter = <%=cart_counter%>;
    		
    	    $('#shoppingCartCounter').text(String(cartCounter));

    	    if (cartCounter < 1) 
    	    {
    	       $('#shoppingCartCounter').hide();      
    	    }
    	    else 
    	    {
    	        $('#shoppingCartCounter').show();
    	    }  
    	    
            // If persisted then it is in the page cache, force a reload of the page.
    	   	if (evt.persisted) {
/*     	                document.body.style.display = "none";
 */    	        	   	location.reload();

    	   	}
            
    	} --%> 


});

/* $(window).unload( function () 
		{

     
}); */




/* it resets the page, and orderby*/
function search(text)
{
    reload(0, limit, text, "asc_t");
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
        
            <!-- <div id="searchBar">
                <input type="text" id="" name=search_bar placeholder="Search Title" style="height: 20px; align-self: center;" onchange="search($(this).val())">
                <button type="button" id="searchBtn" style="height: 20px; align-self: center;" onclick = "search($(search_bar).val())" >-></button>
                <div id="shoppingCartCounter" style="text-align: center;">0</div>
                <div id="shoppingCartBtn" placeholder="Shopping Cart" onclick="window.location.href = './ShoppingCart'">
                    <a href="./ShoppingCart" class="pageLink">This is a test</a>
                </div>
                -->
        </div>
        <!-- <div id="shoppingCartPreview">test</div> -->
        <div id="titleNav">
            <a href="#" class="titleCat first" onclick = "reload(0, limit, '0', orderby, year, director, fName, lName, false);">0</a>
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
        
        
    <div id="moviesList">
<%

        List<Movie> movies = (ArrayList<Movie>) session.getAttribute("movies");
        

		if(movies != null)
        for(Movie m : movies)
        {
            
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
                        if(stars != null)
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
                        if(genres != null)
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

        <%

        }

%>  
        </div>
        <div id="navBarBottom">
            <button type="button" id="prevButton" class="navButton" onclick = "prev();">Prev</button> 
            <button type="button" id="nextButton" class="navButton" onclick = "next();">Next</button> 
            <div id="itemsPerPage">
                <span style="margin: 0px 10px 0px 40px">Items per page:</span>
                <a href="#" class="pageCount" onclick = "reload(offset, 5, title, orderby, year, director, fName, lName);">5</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 10, title, orderby, year, director, fName, lName);">10</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 15, title, orderby, year, director, fName, lName);">15</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 20, title, orderby, year, director, fName, lName);">20</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 25, title, orderby, year, director, fName, lName);">25</a>
            </div>
        </div>
    </div>
</body>
</html>