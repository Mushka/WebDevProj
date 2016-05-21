<!DOCTYPE html>
<html>
<head>
    <title>Movie Page</title>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js" integrity="sha256-xNjb53/rY+WmG+4L6tTl9m6PpqknWZvRt0rO1SRnJzw=" crossorigin="anonymous"></script>
    <link href="https://code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="./css/shared.css">
    <link rel="stylesheet" type="text/css" href="./css/header.css">
    <link rel="stylesheet" type="text/css" href="./css/search.css">
    <link rel="stylesheet" type="text/css" href="./css/footer.css">
    <script src="./javascript/shared.js"></script>
    
    <style type="text/css">

        #spacer {
            height: 40px;
        }
        
        .buyButton {
        	margin-left: 0px !important;
        }

    </style>

    <%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"

        import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*, model.*" 
               
    %>
  
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <script>

        <%
        // These four lines make it so the page doesn't cache, so the shopping cart updates on back button press
        response.setHeader( "Expires", "Sat, 6 May 1995 12:00:00 GMT" );
        // set standard HTTP/1.1 no-cache headers
        response.setHeader( "Cache-Control", "no-store, no-cache, must-revalidate" );
        // set IE extended HTTP/1.1 no-cache headers
        response.addHeader( "Cache-Control", "post-check=0, pre-check=0" );
        // set standard HTTP/1.0 no-cache header
        response.setHeader( "Pragma", "no-cache" );

        int offset = Integer.parseInt(Objects.toString(session.getAttribute("offset"), "10"));
        int limit = Integer.parseInt(Objects.toString(session.getAttribute("limit"), "0"));
        int num_of_movies = Integer.parseInt(Objects.toString(session.getAttribute("num_of_movies"), "0"));
        int cart_counter = Integer.parseInt(Objects.toString(session.getAttribute("shopping_cart_size"), "0"));

        String genre = Objects.toString(session.getAttribute("genre"), "0");
        String orderby = Objects.toString(session.getAttribute("orderby"), "asc_t");

        %>  

        var limit = <%=limit%>;
        var num_of_movies = <%=num_of_movies%>;
        var genre = "<%=genre%>"
        var offset = <%=offset%>;
        var orderby = "<%=orderby%>";
        var cartCounter = <%=cart_counter%>;

        function reload(of, li, ti, orb) {
            
            window.location.href = "./Search?limit=" + li + "&offset=" + of + "&title=" + ti + "&orderby=" + orb;

        }

    </script>

</head>

<body>


    <div id="wrapper">
       
        <div id="navBarTop">
                <%@ include file="header.jsp" %>
        </div>

        <div id="spacer"></div>
        
        <div id="moviesList">
            <%

            Movie m = (session.getAttribute("movie") == null) ? new Movie() : (Movie) session.getAttribute("movie");

            /*  this takes into account if they are null */
            String mv_bannar_url = Objects.toString(m.getBannar_url(), "");
            String mv_id = m.getId() == -1 ? "" :  Integer.toString(m.getId());
            String mv_title = Objects.toString(m.getTitle(), "");
            String mv_year = m.getYear() == -1 ? "" : Integer.toString(m.getYear());
            String mv_director = Objects.toString(m.getDirector(), "");
            String mv_trailer_url = Objects.toString(m.getTrailer_url(), "");
            
            %>         

            <div class="movieBox">
                <div class="imageAndBuy">
                    <div class="movieImage" style="background-image: url('<%=mv_bannar_url%>');">
                        <img src='<%=mv_bannar_url%>' onerror= "this.src = './images/no-image.jpg';">
                    </div>
                    <button type="button" id=<%=mv_id%> class="buyButton">Add to Cart</button> 
                </div>
                <div id="movieInfo">
                    <div class="info first">
                        <div class="infoTitle">Title:</div>
                        <div class="infoDetail">
                            <a href="./ShowMovie?movie_id=<%=mv_id%>"><%=mv_title%></a>
                        </div>
                    </div>
                    <div class="info">
                        <div class="infoTitle">Year:</div>
                        <div class="infoDetail"><%=mv_year%></div>
                    </div>
                    <div class="info">
                        <div class="infoTitle">Director:</div>
                        <div class="infoDetail"><%=mv_director%></div>
                    </div>
                    <div class="info">
                        <div class="infoTitle">Movie ID:</div>
                        <div class="infoDetail"><%=mv_id%></div>
                    </div>
                    <div class="info">
                        <div class="infoTitle">Stars:</div>
                        <div class="infoDetail">
<%                  

                        List<Star> stars = (m.getStars() == null) ? new ArrayList<Star>() : (ArrayList<Star>) m.getStars();

                        for(int i = 0; i < stars.size(); ++i){
%>
                            
                            <%if(i < stars.size()-1){%>
                                <a href="./ShowStar?star_id=<%=stars.get(i).getId()%>"><%=stars.get(i).getName()%>,</a>
                            <%}
                            else{%>
                                <a href="./ShowStar?star_id=<%=stars.get(i).getId()%>"><%=stars.get(i).getName()%></a>
                            <%}%>
                    
                        <%}%>   
                        
                        </div>
                    </div>
                    <div class="info">
                        <div class="infoTitle">Genres:</div>
                        <div class="infoDetail">
                        
                        
<%                  
                        List<String> genres = (m.getGenres() == null) ? new ArrayList<String>() : (ArrayList<String>) m.getGenres();

                        for(int i = 0; i < genres.size(); ++i){
%>
                            <%if(i < genres.size()-1){%>
                                <a href="./ShowGenre?genre=<%=genres.get(i)%>&limit=10&offset=0" ><%=genres.get(i)%>,</a>
                            <%}
                            else{%>
                                <a href="./ShowGenre?genre=<%=genres.get(i)%>&limit=10&offset=0" ><%=genres.get(i)%></a>
                            <%}%>
                                                
                        <%}%>   

                        </div>
                    </div>
                    <div class="info">
                        <div class="infoTitle">Trailer:</div>
                        <div class="infoDetail">
                            <a href=<%=mv_trailer_url%>>Click here</a>
                             to watch the movie trailer
                        </div>
                    </div>
                    <div class="info">
                        <div class="infoTitle">Price:</div>
                        <div class="infoDetail">$15.99</div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>