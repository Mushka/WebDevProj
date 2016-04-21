<!DOCTYPE html>
<html>
<head>
	<title>Checkout</title>
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

        Object shopping_cart = request.getSession().getAttribute("shopping_cart");

			if (shopping_cart == null)
			{
				request.getSession().setAttribute("error_message","The shopping cart is empty");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
			}

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
				<span id="logoFont" class="titleFont">Customer Information</span>
			</div>
			<form id="advSearchBox" action="./Checkout">
				<input type="text" name="ccn" class="first searchItem" placeholder="Creditcard Number">
				<input type="text" name="exp_date" class="searchItem" placeholder="Expiration Date">
				<input type="text" name="first_name" class="searchItem" placeholder="First name of creditcard holder">
				<input type="text" name="last_name" class="searchItem" placeholder="Last name of creditcard holder">
				<input type="submit" class="searchItem" value="Checkout">
			</form>
		</div>
	</div>
	
	
	
<script>

function shake(div){                                
    var interval = 100;                                                                                                 
    var distance = 10;                                                                                                  
    var times = 4;                                                                                                      

    $(div).css('position','relative');                         

    for(var iter=0;iter<(times+1);iter++){                                                                              
        $(div).animate({ 
            left:((iter%2==0 ? distance : distance*-1))
            },interval);
    }

    $(div).animate({ left: 0},interval);
}


$("form").on('submit', function (e) {

		$.ajax({
 		/*url is the location of the servlet, i believe */
        url : 'TryToCheckout',
        data : $(this).serialize(),
        success : function(responseText) {
	            	
        	
        	console.log(responseText);
        	
            if(responseText === "true")
        	{		      
				window.location.href = './confirmation.jsp'; 
        	}
            else
            {

         		shake($('#advSearchBox'));
        		$('#wrapper').append('<div id="error" class="errorMessage"><span style="align-self: center;">Credentials Not Found</span></div>');
				$('#error').animate({top:0+'px'}, {duration: 500, complete: function() {
					setTimeout(function() {
						$('#error').animate({top:-60+'px'}, {duration: 500, complete: function() {
							$('#error').remove();
						}})
					},3000);
				}}); 
				
/* 				alert(responseText); */
            }
	    }
	});
		   
		e.preventDefault();
	});

</script>
	
	
</body>
</html>