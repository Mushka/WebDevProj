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
    
    $(document).ready(function(){   
    	
    	$( "#headerSearch" ).autocomplete();
    	
        $('#headerSearch').keyup(function(e){
/*         	if(e.keyCode === 13)
        		alert("!"); */
        	var text = document.getElementById('headerSearch').value;
        	
        	var search1 = "";
        	
            if (typeof limit === "undefined")
            {
            	search1 += "adv=true&limit=" + 10 + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
            }
            else
            {
            	search1 += "adv=true&limit=" + limit + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
            }  

            //alert(search);
        	var movie_list  = [];
            
            $.ajax({
                url : 'SearchAjax',
                data : search1,
                success : function(responseText) {

                 if(responseText === "false")
                 {             
                     console.log("Failed to load");
                 }
                 else
               	 {
                	var movies_json = jQuery.parseJSON(responseText);  	               	    
                	$.each(movies_json, function(i,movie) {
            		    movie_list.push(movie['title']);
               		});  
        		}
                 
      	   	}	
		});
        $( "#headerSearch" ).autocomplete({
        	source: movie_list
          });
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