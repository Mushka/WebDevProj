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
		}

        .incDecBox {
        	margin-top: 20px;
            align-self: center;
            display: flex;
            flex-direction: row;
            justify-content: center;
            background: #D8D8D8;
        }

        .incDecBtn {
            width: 30px;
            height: 25px;
            border: 0px solid white;
            font-family: inherit;
            font-size: 20px;
            text-align: center;
            color: white;
            background: grey;
        }

        .incDecDisplay {
            width: 30px;
            height: 25px;
            font-family: inherit;
            font-size: 20px;
            text-align: center;
            color: black;
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
    String orderby = (String) session.getAttribute("orderby");
%>  



    var limit = <%=limit%>;
    var offset = <%=offset%>;
    var num_of_movies = <%=num_of_movies%>;
    var orderby = "<%=orderby%>";


/*     alert(pre_title); */


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
        if(confirm("Are you sure you wish to remove the item from your cart?"))
        {
            
            $.ajax({
                url : 'ProcessShoppingCart',
                data : "id="+m_id+"&del=true",
                success : function(responseText) {
                	
                    if(responseText === "false")
                    {             
                        console.log("Failed to load");
                    }
                    else
                  	{
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
        	
            if(responseText === "false")
            {             
                console.log("Failed to load");
            }
            
            else
          	{
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
         	
            if(responseText === "false")
            {             
                console.log("Failed to load");
            }
             
            else
           	{
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
    
    
});




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
        </div>
        
        
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
                    <div class="movieImage" style="background-image: url('<%=m.getBannar_url()%>');"></div>
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