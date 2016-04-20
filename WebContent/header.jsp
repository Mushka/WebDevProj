
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
	<input type="text" id="search_bar" name=search_bar placeholder="Search Title" style="height: 20px; align-self: center;" onchange="search(document.getElementById('search_bar').value)">
    <button type="button" id="searchBtn" style="height: 20px; align-self: center;" onclick = "search(document.getElementById('search_bar').value)" >-></button>
    <div id="shoppingCartCounter" style="text-align: center;">0</div>
   	<div id="shoppingCartBtn" placeholder="Shopping Cart" onclick="window.location.href = './ShoppingCart'"></div>
</div>