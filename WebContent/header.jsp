<script type="text/javascript">
	function goHome() {
		window.open("main.jsp","_self");
	}
</script>

<div id="searchBar">
	<div id="headerLogo" onclick="goHome()">FabFlix</div>
	<input type="text" id="" name=search_bar placeholder="Search Title" style="height: 20px; align-self: center;" onchange="search($(this).val())">
    <button type="button" id="searchBtn" style="height: 20px; align-self: center;" onclick = "search($(search_bar).val())" >-></button>
    <div id="shoppingCartCounter" style="text-align: center;">0</div>
   	<div id="shoppingCartBtn" placeholder="Shopping Cart" onclick="window.location.href = './ShoppingCart'"></div>
</div>