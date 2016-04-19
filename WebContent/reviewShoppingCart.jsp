<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="./css/shared.css">
    <link rel="stylesheet" type="text/css" href="./css/header.css">
    <link rel="stylesheet" type="text/css" href="./css/search.css">
    <link rel="stylesheet" type="text/css" href="./css/footer.css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <style type="text/css">

        input[type="text"] {
            padding: 2px !important;
        }

        #shoppingCartCounter, #shoppingCartBtn {
            visibility: hidden;
        }

        #spacer {
            height: 40px;
        }

    </style>

    <script>


        <%  
        int offset = Integer.parseInt((String) session.getAttribute("offset"));
        int limit = Integer.parseInt((String) session.getAttribute("limit"));
        int num_of_movies = Integer.parseInt((String) session.getAttribute("num_of_movies"));
        String orderby = (String) session.getAttribute("orderby");
        %>  

        var limit = <%=limit%>;
        var offset = <%=offset%>;
        var num_of_movies = <%=num_of_movies%>;
        var orderby = "<%=orderby%>";


        function reload(of, li, orb) {
        	
            window.location.href = "./ShoppingCart?limit=" + li + "&offset=" + of + "&orderby=" + orb + "&title=" + ti + "&year=" + yr + "&director=" + dr + "&first_name=" + fn + "&last_name=" + ln;

        }

        function checkOut() {
        
    	/*  /FabFlix/Search?username=a%40email.com&password=a2
    	 */
        	window.location.href = "./checkout.jsp";
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

        function movieQuantityMinus(m_id)
        {
            if (parseInt($('#movieQuantity'+m_id).text()) == 1) {
                if(confirm("Are you sure you wish to remove the item from your cart?")) {
                    
                    $.ajax({
                        url : 'ProcessShoppingCart',
                        data : "id="+m_id+"&del=true",
                        success : function(responseText) {
                        	
                            if(responseText === "false") {             
                                console.log("Failed to load");
                            }
                            else {
                                console.log("deleted: " + m_id);
                                $('#movie'+m_id).remove();
                          	}
                        }
                    });
                    return;
                }
                else {
                    return;
                }
            }      
            
        	$.ajax({
                url : 'ProcessShoppingCart',
                data : "id="+m_id+"&dec=true",
                success : function(responseText) {
                	
                    if(responseText === "false") {             
                        console.log("Failed to load");
                    }
                    else {
                        console.log("subtracted to: " + m_id);
                        var tmp = parseInt($('#movieQuantity'+m_id).text());
                        $('#movieQuantity'+m_id).text((tmp-1));
                        tmp=(tmp-1)*15.99;
                        $('#moviePrice'+m_id).text('$'+tmp);
                  	}
                }
            });
        }

        function movieQuantityPlus(m_id)
        {	

        	$.ajax({
                url : 'ProcessShoppingCart',
                data : "id="+m_id,
                success : function(responseText) {
                 	
                    if(responseText === "false") {             
                        
                        console.log("Failed to load");
                    }
                     
                    else {

                        console.log("added to: " + m_id);
                        var tmp = parseInt($('#movieQuantity'+m_id).text());
                        $('#movieQuantity'+m_id).text((tmp+1));
                        tmp=(tmp+1)*15.99;
                        $('#moviePrice'+m_id).text('$'+tmp);
                   	}
                 }
             });
        }


        $(document).ready(function() {
            // $("#shoppingCartCounter").remove();
            // $("#shoppingCartBtn").remove();
        });


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
        </div>

        <div id="spacer"></div>
        
        
    <div id="moviesList">
<%

		Map<String, Integer> shopping_cart = (Map<String, Integer>) request.getSession().getAttribute("shopping_cart");

        int itemCounter = 0;

		for (Map.Entry<String, Integer> item : shopping_cart.entrySet()) 
		{
			Movie m = Movie.getMovie(Integer.parseInt(item.getKey()));
 %>         

            <div class="movieBox" id="movie<%=item.getKey()%>">
                <div class="imageAndBuy">
                        <div class="movieImage" style="background-image: url('<%=m.getBannar_url()%>');">
                            <img src='<%=m.getBannar_url()%>' onerror= "this.src = './images/no-image.jpg';">
                        </div>
                        <div class="incDecBox">
                            <button class="incDecBtn" id="movieQuantityMinus<%=item.getKey()%>" onclick= "movieQuantityMinus(<%=item.getKey()%>);">-</button>
                            <div class="incDecDisplay" id="movieQuantity<%=item.getKey()%>"><%=item.getValue()%></div> 
                            <button class="incDecBtn" id="movieQuantityPlus<%=item.getKey()%>" onclick= "movieQuantityPlus(<%=item.getKey()%>);">+</button> 
                        </div>
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
                        <div class="infoTitle" >Price:</div>
                      <script>  
	                      	var price = 15.99*<%=item.getValue()%>;
	                      	document.write('<div id="moviePrice<%=item.getKey()%>" class="infoDetail">$'+price+'</div>');
                      </script>
                        
                    </div>

                </div>
            </div>

        <%

            itemCounter++;

        }

%>  
        </div>
        <div id="navBarBottom">
            <button type="button" id="checkOutButton" class="navButton" onclick = "checkOut();">CheckOut</button> 
        </div>
    </div>
</body>
</html>