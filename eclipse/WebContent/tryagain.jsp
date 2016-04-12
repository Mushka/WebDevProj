<!DOCTYPE html>
<html>
<head>
	<title>FlabFix - Login</title>
	<link href='https://fonts.googleapis.com/css?family=Merriweather:700|Quicksand' rel='stylesheet' type='text/css'>
	<link id="pagestyle" rel="stylesheet" type="text/css" href="mainStyle.css">
	<script type="text/javascript">

	</script>
</head>
<body>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*" 
       
%>

<%@ page import="tester.*" %>
		


<%

			Boolean empty = (Boolean)session.getAttribute("empty");

			if(empty.booleanValue())
			{
%>

  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.js"></script>
  
  				  <script>
  
				toastr.options = {
						  "closeButton": false,
						  "debug": false,
						  "newestOnTop": false,
						  "progressBar": false,
						  "positionClass": "toast-top-center",
						  "preventDuplicates": true,
						  "onclick": null,
						  "showDuration": "300",
						  "hideDuration": "1000",
						  "timeOut": "2000",
						  "extendedTimeOut": "1000",
						  "showEasing": "swing",
						  "hideEasing": "linear",
						  "showMethod": "slideDown",
						  "hideMethod": "slideUp"
						}

				toastr["error"]("Invalid Credentials")
				
				  </script>
						
<%
			}
 %>		

	<div id="wrapper">
		<div id="content">
			<div id="logoBox">
				<span id="logoFont">FabFlix</span>
			</div>
			<div id="loginBox">
				<!-- <div id="loginHeader"> -->
					<!-- <span id="loginHeaderFont">Log In</span> -->
				<!-- </div> -->
				<form id="loginCredentials" action="/Session/TomcatTest" method="POST">
					<input type="text" name="username" placeholder="Username">
					<input type="password" name="password" placeholder="Password" class="margin40T">
					<input type="submit" value="Log In" class="margin40T">
				</form>
			</div>
			<div id="signUpLink">
				<p>
					Don't have an account? <span style="text-decoration: underline;">Sign Up</span>
				</p>
			</div>
		</div>
	</div>

</body>
</html>