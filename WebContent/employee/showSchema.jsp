<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import=" model.*"
   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Schema</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>

<script>


	var schemaText = '<%=MySQL.getMetaData().replaceAll("\n", "<br>")%>';
    schemaText = schemaText.replace(/\n/g, "<br>");

	$(document).ready(function() {

        schemaText = schemaText.replace(/\n/g, "<br>");
		$("#schemaText").html("<b> SCHEMA: </b> <br>");
		$("#schemaText").append(schemaText);

	});


</script>


</head>
<body>



<p id="schemaText"> sadface </p>


</body>
</html>