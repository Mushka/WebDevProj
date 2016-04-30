<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

		<form id="starInfo" action="<%=request.getContextPath()%>/employee/AddStar" method="GET">
			<input type="text" name="first_name" placeholder="First Name">
			<input type="text" name="last_name" placeholder="Last Name">
			<input type="text" name="dob" placeholder="yyyy-mm-dd">
			<input type="text" name="photo_url" placeholder="Photo Url">
			<input type="submit" value="Add Star">
		</form>

</body>
</html>