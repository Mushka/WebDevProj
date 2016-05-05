
<script type="text/javascript">
    function goHome() {
        window.open("main.jsp","_self");
    }
    
    
    /* it resets the page, and orderby, but keeps the limit if it is set*/
/*     function search(text)
    {
        
        if (typeof limit === "undefined")
        {
            window.location.href = "./Search?adv=true&limit=" + 10 + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
        }
        else
        {
            window.location.href = "./Search?adv=true&limit=" + limit + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
        }       
        
    } */
    
    $(document).ready(function(){        
        $('#headerSearch').keyup(function(){
        	
        	
        	var text = document.getElementById('headerSearch').value;
        	
        	var search = "";
        	
            if (typeof limit === "undefined")
            {
            	search += "adv=true&limit=" + 10 + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
            }
            else
            {
            	search += "adv=true&limit=" + limit + "&offset=" + 0 + "&title=" + text + "&orderby=" + 'asc_t' + "&year=&director=&first_name=&last_name=";
            }  

            //alert(search);
        	
            
            $.ajax({
                url : 'SearchAjax',
                data : search,
                success : function(responseText) {

                 if(responseText === "false")
                 {             
                     console.log("Failed to load");
                 }
                 else
               	 {
                   
                    
                    $( "#moviesList" ).empty();
 
                	//alert(responseText);
                	//console.log(responseText);  	       	
                	var movies_json = jQuery.parseJSON(responseText);
                	
               	 	console.log("----");  	       	

                	
                	$.each(movies_json, function(i,movie) {
              
                		console.log( "Movie: " + i);          
	            			console.log( "  id: " + movie['id'] );    
	            			console.log( "  title: " + movie['title'] );    
	            			console.log( "  year: " + movie['year'] );    
	            			console.log( "  director: " + movie['director'] );    
	            			console.log( "  bannar_url: " + movie['bannar_url'] );  
	            			console.log( "  trailer_url: " + movie['trailer_url'] );  
	            			
	                    	if(movie['stars'] != 'undefined'){

		                    	$.each( movie['stars'], function(j, star) {
		                            
	                    			console.log( "  Star: " + j);          
	    	            			console.log( "     name: " + star['full_name']);    
	    	            			console.log( "     id: " + star['id'] );        
	                    		}); 
	                    	}
                    	
	                    	
	                    	if(movie['genres'] != 'undefined'){
                    	
		                    	$.each(movie['genres'], function(j, genre) {
		                    		
	                    			console.log( "  Genre: " + j);          
	    	            			console.log( "     genre: " + genre );    
	                    		}); 
	                    	}

                	
	                	$("#moviesList").append('\
	                        <div class="movieBox">\
	                        <div class="imageAndBuy">\
	                            <div class="movieImage" style="background-image: url(' + movie["bannar_url"] + ');">\
	                            <img src=' + movie["bannar_url"] + ' onerror= "this.src =\'./images/no-image.jpg\';">\
                                </div>\
	                            <button type="button" id=' + movie["id"] + ' class="buyButton">Add to Cart</button>\
	                        </div>\
	                        <div id="movieInfo">\
	                            <div class="info first">\
	                                <div class="infoTitle">Title:</div>\
	                                <div class="infoDetail">\
	                                    <a href="./ShowMovie?movie_id=' + movie["id"] + '">' + movie["title"] + '</a>\
	                                </div>\
	                            </div>\
	                            <div class="info">\
	                                <div class="infoTitle">Year:</div>\
	                                <div class="infoDetail">' + movie["year"] + ' </div>\
	                            </div>\
	                            <div class="info">\
	                                <div class="infoTitle">Director:</div>\
	                                <div class="infoDetail">' + movie["director"] + ' </div>\
	                            </div>\
	                            <div class="info">\
	                                <div class="infoTitle">Movie ID:</div>\
	                                <div class="infoDetail">' + movie["id"] + ' </div>\
	                            </div>\
	                            <div class="info">\
	                                <div class="infoTitle">Price:</div>\
	                                <div class="infoDetail">$15.99</div>\
	                            </div>\
	                        </div>\
	                    </div>');
	                    	
               		});  
        		}
      	   	}	
		});
     });
});
    


</script>

<div id="searchBar">
	<div id="headerLogo" onclick="goHome()">FabFlix</div>
	<input type="text" id="headerSearch" name=search_bar placeholder="Search Title" style="height: 20px; align-self: center;">
    <div id="shoppingCartCounter" style="text-align: center;">0</div>
    <div id="shoppingCartBtn" placeholder="Shopping Cart" onclick="window.location.href = './ShoppingCart'"></div>
</div>