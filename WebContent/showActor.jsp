<!DOCTYPE html>
<html>
<head>
    <title>Main Page</title>
    <script src="https://code.jquery.com/jquery-2.2.3.min.js" integrity="sha256-a23g1Nt4dtEYOj7bR+vTu7+T8VP13humZFBJNIYoEJo=" crossorigin="anonymous"></script>
    <style type="text/css">

        @font-face {
            font-family: 'Proxima Nova';
            src: local('Proxima Nova Regular'), url(./fonts/ProximaNova-Regular.ttf);
        }

        body,html {
            /*height: 100%;*/
            margin: 0;
            background: #1C5588;
        }

        .first {
            margin-top: 0px !important;
            border-top: 0px solid white !important;
            border-left: 0px solid white !important;
        }

        #wrapper {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        #moviesList {
            width: 800px;
/*          height: 100%;
*/          margin-top: 40px;
            margin-bottom: 20px;
            /*border-left: 4px solid white;*/
            /*border-right: 4px solid white;*/
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-self: center;
            background: white;
            font-family: 'Proxima Nova';
        }

        .movieBox {
            width: auto;
            padding: 20px;
            /*margin: 10px 0px 0px 0px;*/
            border-top: 2px solid black;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            font-family: inherit;
            /*background: red;*/
        }

        .imageAndBuy {
            width: 200px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            font-family: inherit;
        }

        .movieImage {
            width: 100px;
            height: 150px;
            overflow: hidden;
            align-self: center;
        }

        .buyButton {
            width: 120px;
            height: 26px;
            margin-top: 25px;
            padding: 3px;
            border: 0px solid white;
            border-radius: 3px;
            font-family: inherit;
            font-size: 20px;
            text-align: center;
            color: white;
            background: green;
            align-self: center;
        }

        .navButton {
            width: 120px;
            height: 20px;
            /*padding: 3px;*/
            margin-right: 5px;
            border: 0px solid white;
            border-radius: 3px;
            font-family: inherit;
            font-size: 15px;
            text-align: center;
            color: white;
            background: grey;
            align-self: center;
        }

        .movieInfo {
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-self: flex-start;
            font-family: inherit;
        }

        .info {
            margin-top: 5px;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            font-family: inherit;
        }

        .infoTitle {
            width: 80px;
            text-align: right;
            font-family: inherit;
            /*background: yellow;*/
        }

        .infoDetail {
            margin: 0px 0px 0px 10px;
            flex-grow: 5;
            text-align: left;
            font-family: inherit;
        }

        #navBarTop {
            width: 800px;
            position: fixed;
            left: 50%;
            margin-left: -400px;
            /*border-top: 2px solid black;*/
            /*border-bottom: 2px solid black;*/
            display: flex;
            flex-flow: column;
            background: white;
            z-index: 999;
        }

        #searchBar {
            width: 800px;
            /*height: 20px;*/
            /*border-top: 2px solid black;*/
            /*border-bottom: 2px solid black;*/
            display: flex;
            flex-flow: row;
            align-self: center;
            background: white;
            z-index: 999;
        }

        #titleNav {
            width: 800px;
            /*left: 50%;*/
            /*margin-left: -400px;*/
            border-top: 2px solid black;
            border-bottom: 2px solid black;
            display: flex;
            flex-flow: row;
            background: white;
            z-index: 999;
        }

        #navBarBottom {
            width: 800px;
            /*height: 20px;*/
            position: fixed;
            left: 50%;
            margin-left: -400px;
            bottom: 0px;
            z-index: 999;
            border-top: 2px solid black;
            border-bottom: 2px solid black;
            display: flex;
            flex-flow: row;
            align-self: center;
            justify-content: center;
            background: white;
        }

        .titleCat {
            font-family: inherit;
            font-size: 16px;
            text-align: center;
            color: black;
            border-left: 2px solid black;
            flex-grow: 1;
            align-self: center;
        }

        .pageCount {
            margin-right: 5px;
            font-family: inherit;
            font-size: 16px;
            text-align: center;
            color: black;
            flex-grow: 1;
            align-self: center;
        }

    </style>
    <script>

        $(document).ready(function() {

            $('.buyButton').click( function() {
                alert(this.id);
            });

        });

    </script>

  <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movies</title>

<script>

<%

    Star actor = (Star) session.getAttribute("actor");
%>  

<%--     var offset = <%=offset%>;
    var limit = <%=limit%>;
    var pre_title = "<%=pre_title%>"; --%>
    
/*     alert(pre_title); */



</script>

</head>

<body>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

import="java.sql.*, java.util.*, javax.sql.*, java.io.IOException, javax.servlet.http.*, javax.servlet.*, model.*" 
       
%>

    <div id="wrapper">
    <div id="moviesList">
<%

/*         List<Movie> movies = (ArrayList<Movie>) session.getAttribute("movies");
 */        
            
 %>         

            <div class="movieBox">
                <div class="imageAndBuy">
                    <div class="movieImage" style="background-image: url('<%=actor.getPhoto_url()%>');"></div>
                </div>
                <div id="movieInfo">
                    <div class="info first">
                        <div class="infoTitle">Star Name:</div>
                        <div class="infoDetail">
                        
<!--                         <script>var movie_id=</script>
 -->                            <%=actor.getName()%>
                        </div>
                    </div>
                     <div class="info">
                        <div class="infoTitle">DOB:</div>
                        <div class="infoDetail"><%=actor.getDob()%></div>
                    </div>
 <%--                   <div class="info">
                        <div class="infoTitle">Director:</div>
                        <div class="infoDetail"><%=m.getDirector()%></div>
                    </div>--%>
                    <div class="info">
                        <div class="infoTitle">Star ID:</div>
                        <div class="infoDetail"><%=actor.getId()%></div>
                    </div> 
                    <div class="info">
                        <div class="infoTitle">Starred in:</div>
                        <div class="infoDetail">
<%                  
                        List<Movie> movies_starred_in = (ArrayList<Movie>) actor.getStarred_in();
                        /* for(String g : genres)  */
                        for(int i = 0; i < movies_starred_in.size(); ++i){
%>
                            
                            <%if(i < movies_starred_in.size()-1){%>
                                <a href="./ShowMovie?movie_id=<%=movies_starred_in.get(i).getId()%>"> <%=movies_starred_in.get(i).getTitle()%> <br></a>
                            <%}
                            else{%>
                                <a href="./ShowMovie?movie_id=<%=movies_starred_in.get(i).getId()%>"><%=movies_starred_in.get(i).getTitle()%></a>
                            <%}%>
                    
                        <%}%>   
                        
                        </div>
                    </div>
<!--                     <div class="info">
                        <div class="infoTitle">Genres:</div>
                        <div class="infoDetail">
                        
                        </div>
                    </div> -->
                </div>
            </div>

        </div>
<!--         <div id="navBarBottom">
            <button type="button" id="prevButton" class="navButton" onclick = "prev();">Prev</button> 
            <button type="button" id="nextButton" class="navButton" onclick = "next();">Next</button> 
            <div id="itemsPerPage">
                <span style="margin: 0px 10px 0px 40px">Items per page:</span>
                <a href="#" class="pageCount" onclick = "reload(offset, 5, pre_title);">5</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 10, pre_title);">10</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 15, pre_title);">15</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 20, pre_title);">20</a>
                <a href="#" class="pageCount" onclick = "reload(offset, 25, pre_title);">25</a>
            </div>
        </div> -->
    </div>
</body>
</html>