<!DOCTYPE html>
<html>
<head>
    <title>Main Page</title>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
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
*/          margin-top: 40px;
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
            flex-flow: row;
            align-self: center;
            background: white;
            z-index: 999;
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

    </style>

  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movies</title>

<script>


<%	
	int offset = Integer.parseInt((String) session.getAttribute("offset"));
	int limit = Integer.parseInt((String) session.getAttribute("limit"));
	int num_of_movies = Integer.parseInt((String) session.getAttribute("num_of_movies"));
	String genre = (String) session.getAttribute("genre");
    String orderby = (String) session.getAttribute("orderby");

	
%>  



    var limit = <%=limit%>;
    var num_of_movies = <%=num_of_movies%>;
    var genre = "<%=genre%>"
    var offset = <%=offset%>;
    var orderby = "<%=orderby%>";


    
    
/*     alert(pre_title); */


function reload(of, li, ge, orb) {
    
    window.location.href = "/Session/ShowGenre?genre=" + ge + "&limit=" + li + "&offset=" + of + "&orderby=" + orb;

}


function next() {
    
/*  /Session/Search?username=a%40email.com&password=a2
 */
 
 	if(num_of_movies > (offset+1)*limit)
    	reload(offset+1, limit, genre, orderby);
    
    /* window.location.href = "/Session/Search?limit=" + limit + "&offset=" + (offset+1); */
}


function prev() {
     
        
    if(<%=offset%> > 0)
    {
        reload(offset-1, limit, genre, orderby);
        /* window.location.href = "/Session/Search?limit=" + limit + "&offset=" + (offset-1); */
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

    $('.buyButton').click( function() {
        
        shopping_cart = readCookie("shopping_cart");
         
        if(shopping_cart != null)
        {
            
            shopping_cart = shopping_cart.toString().split("-");
            shopping_cart_new = "";
        
            console.log("shopping_cart split: " + shopping_cart);
            console.log("shopping_cart size: " + shopping_cart.length);
            
            console.log("------");
            
            var newItem = 1;
            
            for(i = 0; i < shopping_cart.length; ++i)
            {
                
                items = shopping_cart[i].toString().split(" ");
                
                item = items[0];
                qty = items[1];
                
                console.log("item: " + item);
                console.log("qty: " + qty);
                
                console.log("------");
                
                if(item === this.id)
                {
                    qty = parseInt(qty)+1;
                    newItem = 0;
                }
                
                
                shopping_cart_new = shopping_cart_new.concat(item + " " + qty);
                
                if(i < shopping_cart.length-1)
                {
                    shopping_cart_new = shopping_cart_new.concat("-");
                }
                    
            }
            
            if(newItem === 1)
            {
                shopping_cart_new = shopping_cart_new.concat("-"+this.id + " 1");
            }
            
            createCookie("shopping_cart", shopping_cart_new, 0);
            
/*          alert(shopping_cart_new);
 */         
            console.log("new shopping chart: " + shopping_cart_new);
            console.log("------");

        }
        else
        {
            createCookie("shopping_cart", this.id+" 1", 0);
/*          alert(this.id + " added cookie");
 */     
            console.log("new item: " + this.id + " 1");
        }
        
         
         
         
        
       
    });

});

function search(text)
{
	reload(0, limit, text, orderby);
}


</script>

</head>

<body>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*, tester.*" 
       
%>


<table border>

    
            
</table>


    <div id="wrapper">
        <div id="navBarTop">
            <div id="searchBar">
<!--             	<input type="text" name=search_bar placeholder="Search Title" onchange="search($(this).val())">
            	<button type="button" id="search" onclick = "search($(search_bar).val())" >-></button>
 -->
            	
            </div>
            <div>
   
               <%                  
               			List<String> all_genres = (ArrayList<String>) session.getAttribute("all_genres");

               			for(int i = 0; i < all_genres.size(); ++i){
				%>
                           
                           <%if(i < all_genres.size()-1){%>
                               <a href="./ShowGenre?genre=<%=all_genres.get(i)%>&limit=<%=limit%>&offset=0&orderby=<%=orderby%>"><%=all_genres.get(i)%> </a> | 
                           <%}
                           else{%>
                               <a href="./ShowGenre?genre=<%=all_genres.get(i)%>&limit=<%=limit%>&offset=0&orderby=<%=orderby%>"><%=all_genres.get(i)%></a>
                           <%}%>
                           
                                                              
                            <%if(i % 7 == 0){%>
                            	<br>
                            <%}%>
                   
                       <%}%>   
                
          
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
                    <div class="movieImage" style="background-image: url('<%=m.getBannar_url()%>');"></div>
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