<h2><strong>122B Spring 2016 </strong></h2>

<p><strong><em>
Josh Angelesberg </br>
Max Ushkalov</br>
Josh Alpert
</em></strong></p>

<p>Our XML parser used a SAX parser to grab values from each tag and process them accordingly</p> 

<p><strong>Optimizations:</strong></p>

<p>
1) We used a cache to store our values for searching (This was done efficiently using a hashMap)<br>
2) We used batch processing to add all our values into our database, this allowed for much quicker insert times<br>
3) We turned off auto-commit so it would not process everything at once<br>
4) We used stringBuilder to build up all our queries to get rid of the bottle neck of String appending<br>
5) We used HashMaps to track ID insertions after a select allowing us to only have to do one pass through on the XMLs<br>
6) We used HashMaps to have O(1) searchTimes for finding movies(each movie also had a list of stars and vice versa)<br>
7) We used HashSets to get rid of all duplicates of Movies (String of Title + String of Director) <br>
8) We used HashSets to get rid of all duplicate Genres
<p>