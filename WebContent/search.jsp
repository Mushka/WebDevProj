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
        }

        #moviesList {
            width: 800px;
/*          height: 100%;
*/          margin-top: 60px;
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

		#shoppingCartBtn {
			color: red;
			cursor: pointer;
			align-self: flex-end;
		}

    </style>
    
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movies</title>

<script>


<%  
    int offset = Integer.parseInt((String) session.getAttribute("offset"));
    int limit = Integer.parseInt((String) session.getAttribute("limit"));
    int num_of_movies = Integer.parseInt((String) session.getAttribute("num_of_movies"));
    String pre_title = (String) session.getAttribute("title");
    String orderby = (String) session.getAttribute("orderby");
%>  



    var limit = <%=limit%>;
    var offset = <%=offset%>;
    var num_of_movies = <%=num_of_movies%>;
    var pre_title = "<%=pre_title%>";
    var orderby = "<%=orderby%>";
    

/*     alert(pre_title); */


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
    	
    
        
        
        /* shopping_cart = readCookie("shopping_cart"); */
        
		
        
        
        /* 	Map<String, Integer> shopping_cart = (Map<String, Integer>) session.getAttribute("offset");  */
        
        var cart = $('#shoppingCartBtn');
		var imgtodrag = $(this).parent().find("img").eq(0);
        
        $.ajax({
	            url : 'ProcessShoppingCart',
	            data : "id="+this.id,
	            success : function(responseText) {
			            	
		            if(responseText === "false")
	            	{		      
	            		console.log("Failed to load");
	            	}
		            else
		            {
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
		                }
		            }
			    }
			});
        
        	
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
    


});

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


<table border>

    
            
</table>


    <div id="wrapper">
        <div id="navBarTop">
            <div id="searchBar">
                <input type="text" id="" name=search_bar placeholder="Search Title" onchange="search($(this).val())">
                <button type="button" id="searchBtn" onclick = "search($(search_bar).val())" >-></button>
                <div id="shoppingCartBtn">Shopping Cart</div>
            </div>
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

        <%

        }

%>  
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