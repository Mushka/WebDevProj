
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
        	
            
            $.ajax({
                url : 'SearchAjax',
                data : "id="+this.id,
                success : function(responseText) {

                 if(responseText === "false")
                 {             
                     console.log("Failed to load");
                 }
                 else
               	 {
                   /*   alert("whoo");
 */                     
                     $( "#moviesList" ).empty();
 
 
 					
                    <%-- <%--  $( "#moviesList" ).append(String("<%@ include file="movieList.jsp" %>")); --%>
                     
                    <%--  var div = document.getElementById('moviesList');

                     div.innerHTML = div.innerHTML + <%@ include file="movieList.jsp" %>; --%>
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