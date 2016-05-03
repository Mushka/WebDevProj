<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Movie</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script>

	$(document).ready(function() {

		 	$("form").on('submit', function (e) {

		 		$.ajax({
			 		/*url is the location of the servlet, i believe */
		            url : 'AddMovie',
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
	<li> Must provide <b> a title, a year, and a director </b> for movie related updates to occur.</li>
	<li> Must provide a <b>star name</b> for star related updates to occur.</li>
	<li> Must provide a <b>genre</b> for genre related updates to occur.</li>
</ol>
		<form id="movieInfo" method="GET">
			<input type="text" name="title_m" placeholder="Title">
			<input type="text" name="year_m" placeholder="Year">
			<input type="text" name="director_m" placeholder="Director">
			<input type="text" name="banner_url_m" placeholder="Banner Url">
			<input type="text" name="trailer_url_m" placeholder="Trailer Url">
			
			<input type="text" name="first_name_s" placeholder="Star First Name">
			<input type="text" name="last_name_s" placeholder="Star Last Name">
			<input type="text" name="dob_s" placeholder="Star DOB: yyyy-mm-dd">
			<input type="text" name="photo_url_s" placeholder="Star Photo Url">
				
			<input type="text" name="genre" placeholder="Genre">

			<input type="submit" value="Add Info">
		</form>


<p id="output"></p>

</body>
</html>