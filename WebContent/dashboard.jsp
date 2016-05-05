<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import=" model.*"
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Dashboard</title>
	<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
	<link rel="stylesheet" type="text/css" href="./css/shared.css">
    <style type="text/css">
    
    	input {
    		padding: 2px !important;
    		margin-top: 10px !important;
    	}
    	
    	input[type="submit"] {
    		height: 30px !important;
    	}

    	#spacer {
            height: 40px;
        }
        
        ul {
		    list-style-type: none;
		}

    </style>
    
    <script>
		var schemaText = '<%=MySQL.getMetaData().replaceAll("\n", "<br>")%>';
		//schemaText = schemaText.replace(/\n/g, "<br>");
		
		function openTab(evt, tabName) {
		    var i, x, tablinks;
		    
		    x = document.getElementsByClassName("dashboardContentItem");
		    for (i = 0; i < x.length; i++) {
		        x[i].style.display = "none";
		    }
		    
		    tablinks = document.getElementsByClassName("dashboardNavItem");
		    for (i = 0; i < x.length; i++) {
		        tablinks[i].className = tablinks[i].className.replace(" dashboardNavItemActive", "");
		    }
		    
		    document.getElementById(tabName).style.display = "block";
		    evt.currentTarget.className += " dashboardNavItemActive";
		}
		
		$(document).ready(function() {
		    //schemaText = schemaText.replace(/\n/g, "<br>");
			$("#schemaText").html("<b> SCHEMA: </b> <br>");
			$("#schemaText").append(schemaText);
			
			//AddStar
			$("#starInfo").on('submit', function (e) {

		 		$.ajax({
			 		/*url is the location of the servlet, i believe */
		            url : '_dashboard/ProcessAddStar',
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
			            	$("#outputStar").html("<b> Output: </b> <br>");
			            	$("#outputStar").append(responseText);
			            }
				    }
				});
		 		   
		 		e.preventDefault();
		 	});
			
			//AddMovie
			$("#movieInfo").on('submit', function (e) {
				
				console.log($(this).serialize());

		 		$.ajax({
			 		/*url is the location of the servlet, i believe */
		            url : '_dashboard/ProcessAddMovie',
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
			            	$("#outputMovie").html("<b> Output: </b> <br>");
			            	$("#outputMovie").append(responseText);
			            }
				    }
				});
		 		   
		 		e.preventDefault();
		 	});
			
			openTab(event, "addStar");
			$(".dashboardNavItem:first").addClass("dashboardNavItemActive");
		});
	</script>
    
</head>
<body>
	<div id="wrapper">

	    <div id="dashboardContent">
	    
			<ul class="dashboardNav">
				<li><a href="#" class="dashboardNavItem" onclick="openTab(event, 'addStar')">Add Star</a></li>
				<li><a href="#" class="dashboardNavItem" onclick="openTab(event, 'addMovie')">Add Movie</a></li>
				<li><a href="#" class="dashboardNavItem" onclick="openTab(event, 'showSchema')">Show Schema</a></li>
			</ul>

			<div id="addStar" class="dashboardContentItem">
				<ol>
					<li> Must provide <b> a first name and or last name </b> for the star to be created.</li>
					<li> Date must be in <b> yyyy-mm-dd format</b>, otherwise it will be treated as NULL.</li>
				</ol>
				
				<form id="starInfo" class="dashboardContentForm" method="GET">
					<input type="text" name="first_name" placeholder="First Name" class="first">
					<input type="text" name="last_name" placeholder="Last Name">
					<input type="text" name="dob" placeholder="yyyy-mm-dd">
					<input type="text" name="photo_url" placeholder="Photo Url">
					<input type="submit" value="Add Star">
				</form>
				
				<p id="outputStar"></p>
			</div>

			<div id="addMovie" class="dashboardContentItem">
				<ol>
					<li> Must provide <b> a title, a year, and a director </b> for movie related updates to occur.</li>
					<li> Must provide a <b>star name</b> for star related updates to occur.</li>
					<li> Must provide a <b>genre</b> for genre related updates to occur.</li>
				</ol>
				
				<form id="movieInfo" class="dashboardContentForm" method="GET">
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
				
				<p id="outputMovie"></p>
			</div>

			<div id="showSchema" class="dashboardContentItem">
				<p id="schemaText"> sadface </p>
			</div>

			<!-- <button type="button" onclick="window.location.href = './_dashboard/AddStar'; ">New Star</button>
			<button type="button" onclick="window.location.href = './_dashboard/ShowSchema'; ">Show Schema</button>
			<button type="button" onclick="window.location.href = './_dashboard/AddMovie'; ">Add Movie</button> -->
			
		</div>
	</div>
</body>
</html>