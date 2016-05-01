<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Movie</title>
</head>
<body>

		<form id="movieInfo" action="<%=request.getContextPath()%>/employee/AddMovie" method="GET">
			<input type="text" name="title_m" placeholder="Title">
			<input type="text" name="year_m" placeholder="Year">
			<input type="text" name="director_m" placeholder="Director">
			<input type="text" name="banner_url_m" placeholder="Banner Url">
			<input type="text" name="trailer_url_m" placeholder="Trailer Url">
			
			<input type="text" name="first_name_s" placeholder="Star First Name">
			<input type="text" name="last_name_s" placeholder="Star Last Name">
			<input type="text" name="dob_s" placeholder="Star DOB: yyyy-mm-dd">
			<input type="text" name="photo_url_s" placeholder="Star Photo Url">
				
			<input type="text" name="genre" placeholder="Genre [Main]">

			<input type="submit" value="Add Movie">
		</form>
</body>
</html>