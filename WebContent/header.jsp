
<script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>

<script type="text/javascript">
	function goHome() {
		window.open("main.jsp","_self");
	}
	
	
    /* it resets the page, and orderby, but keeps the limit if it is set*/
    function search(text)
    {
    	
    	if (typeof limit === "undefined")
    	{
            window.location.href = "./Search?adv=true&limit=" + 10 + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t';
    	}
    	else
    	{
            window.location.href = "./Search?adv=true&limit=" + limit + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t';
    	}    	
    	
    }


</script>

<div id="searchBar">
	<div id="headerLogo" onclick="goHome()">FabFlix</div>
	<input type="text" id="" name=search_bar placeholder="Search Title" style="height: 20px; align-self: center;" onchange="search($(this).val())">
    <button type="button" id="searchBtn" style="height: 20px; align-self: center;" onclick = "search($(search_bar).val())" >-></button>
    <div id="shoppingCartCounter" style="text-align: center;">0</div>
   	<div id="shoppingCartBtn" placeholder="Shopping Cart" onclick="window.location.href = './ShoppingCart'"></div>
</div>