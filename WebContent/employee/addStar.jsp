<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Star</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script>
	$(document).ready(function() {

		 	$("form").on('submit', function (e) {

		 		$.ajax({
			 		/*url is the location of the servlet, i believe */
		            url : 'ProcessAddStar',
		            data : $(this).serialize(),
		            success : function(responseText) {
		            	
		            	console.log(responseText);
				            	
			            if(responseText === "false")
		            	{		      
		            		// this won't happen
		            	}
			            else
			            {
			            	responseText = responseText.replace(/\n/g, "<br>");
			            	$("#output").html("<b> Output: </b> <br>");
			            	$("#output").append(responseText);
			            }
				    }
				});
		 		   
		 		e.preventDefault();
		 	});
		});

</script>
</head>
<body>

<ol>
	<li> Must provide <b> a first name and or last name </b> for the star to be created.</li>
	<li> Date must be in <b> yyyy-mm-dd format</b>, otherwise it will be treated as NULL.</li>
</ol>

		<form id="starInfo" method="GET">
			<input type="text" name="first_name" placeholder="First Name">
			<input type="text" name="last_name" placeholder="Last Name">
			<input type="text" name="dob" placeholder="yyyy-mm-dd">
			<input type="text" name="photo_url" placeholder="Photo Url">
			<input type="submit" value="Add Star">
		</form>

<p id="output"></p>


</body>
</html>