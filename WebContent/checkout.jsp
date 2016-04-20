<!DOCTYPE html>
<html>
<head>
	<title>FlabFix - Advanced Search</title>
	<link href='https://fonts.googleapis.com/css?family=Merriweather:700|Quicksand' rel='stylesheet' type='text/css'>
	<link id="pagestyle" rel="stylesheet" type="text/css" href="mainStyle.css">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>

	<style type="text/css">
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

		.first {
			margin-top: 0px !important;
		}

		.searchItem {
			margin-top: 10px;
		}

	</style>
  	
  	<%@ include file="header.jsp" %>
  	
  	
  	<%
  		Object shopping_cart = request.getSession().getAttribute("shopping_cart");

			if (shopping_cart == null)
			{
				request.getSession().setAttribute("error_message","The shopping cart is empty");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
			}
			
	%>
  	
</head>
<body>
	<div id="wrapper">
		<div id="content">
			<div id="logoBox">
				<span id="logoFont">Information</span>
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

				/*         		shake($('#loginBox'));
        		$('#wrapper').append('<div id="error" class="errorMessage"><span style="align-self: center;">Invalid Credentials</span></div>');
				$('#error').animate({top:0+'px'}, {duration: 500, complete: function() {
					setTimeout(function() {
						$('#error').animate({top:-60+'px'}, {duration: 500, complete: function() {
							$('#error').remove();
						}})
					},3000);
				}}); */
				
				
				alert(responseText);
            }
	    }
	});
		   
		e.preventDefault();
	});

</script>
	
	
</body>
</html>