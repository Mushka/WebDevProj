<script type="text/javascript">

    function goHome() {
        window.open("main.jsp","_self");
    }
    
    
    /* it resets the page, and orderby, but keeps the limit if it is set*/
    function search(text) {        
    	
    	var newLim = (limit === "undefined" ? 10 : limit);
      
        window.location.href = "./Search?adv=true&limit=" + newLim + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
    } 
    
    $(document).ready(function(){   
    	
    	$("#headerSearch").autocomplete({
    		delay: 0,
    		minLength: 1,
    		source: function(request, response) {

            	var newLim = (limit === "undefined" ? 10 : limit);
                search1 = "adv=true&limit=" + newLim + "&offset=" + 0 + "&title=" + request.term + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
                
                $.ajax({
                	url : 'SearchAjax',
                    data : search1,
                    success : function(responseText) {
						if(responseText === "false")            
						    console.log("Failed to load");
						else
							var movie_list = JSON.parse(responseText).map(function(movie){return movie.title;});
						
						response(movie_list);
          	   		}
    			});
    		}
    	});
    	
    	$("#headerSearch").keydown(function(event){
    	    if(event.keyCode == 13) {
    			search(document.getElementById('headerSearch').value);
    	    }
    	});
	});
    


</script>
<div id="searchBar">
	<div id="headerLogo" onclick="goHome()">FabFlix</div>
<input type="text" id="headerSearch" name=search_bar placeholder="Search Title" style="height: 20px; align-self: center;">
    <div id="shoppingCartCounter" style="text-align: center;">0</div>
    <div id="shoppingCartBtn" placeholder="Shopping Cart" onclick="window.location.href = './ShoppingCart'"></div>
</div>