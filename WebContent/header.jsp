
<script type="text/javascript">
    function goHome() {
        window.open("main.jsp","_self");
    }
    
    
    /* it resets the page, and orderby, but keeps the limit if it is set*/
    function search(text)
    {
        
        if (typeof limit === "undefined")
        {
            window.location.href = "./Search?adv=true&limit=" + 10 + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
        }
        else
        {
            window.location.href = "./Search?adv=true&limit=" + limit + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
        }       
        
    }


</script>

<div id="searchBar">
	<div id="headerLogo" onclick="goHome()">FabFlix</div>
	<input type="text" id="headerSearch" name=search_bar placeholder="Search Title" style="height: 20px; align-self: center;" onchange="search(document.getElementById('headerSearch').value)">
    <div id="shoppingCartCounter" style="text-align: center;">0</div>
    <div id="shoppingCartBtn" placeholder="Shopping Cart" onclick="window.location.href = './ShoppingCart'"></div>
</div>