 <!DOCTYPE html>
<html>
<head>
<style>
body {
}

td {
    border-top-style: solid;
}

#content {
  width: 100%;
}

</style>
</head>
<body>

<table style="width:100%">
  <tr style="font-weight:bold; background-color: orange">
    <td width="300px">Single-instance version cases</td>
    <td>Graph Results Screenshot</td>
    <td>Average Query Time(ms)</td>
    <td>Average Search Servlet Time(ms)</td>
    <td>Average JDBC Time(ms)</td>
    <td>Analysis</td>
  </tr>
  <tr>
    <td>Case 1: HTTP/1 thread</td>
    <td><img src="../images/graph_results_case1.png" alt="Graph Results Screenshot Case 1" style="width:304px;height:228px;"></td>
    <td>54</td>
    <td>8.57</td>
    <td>8.23</td>
    <td>--</td>
  </tr>
  <tr>
    <td>Case 2: HTTP/10 threads</td>
    <td><img src="../images/graph_results_case2.png" alt="Graph Results Screenshot Case 2" style="width:304px;height:228px;"></td>
    <td>86</td>
    <td>38.11</td>
    <td>37.88</td>
    <td>--</td>
  </tr>
  <tr>
    <td>Case 3: HTTPS/10 threads</td>
    <td><img src="../images/graph_results_case3.png" alt="Graph Results Screenshot Case 3" style="width:304px;height:228px;"></td>
    <td>95</td>
    <td>39.75</td>
    <td>39.45</td>
    <td>--</td>
  </tr>
  <tr>
    <td>Case 4: HTTP/10 threads/No prepared statements</td>
    <td><img src="../images/graph_results_case4.png" alt="Graph Results Screenshot Case 4" style="width:304px;height:228px;"></td>
    <td>87</td>
    <td>34.32</td>
    <td>34.15</td>
    <td>--</td>
  </tr>
  <tr>
    <td>Case 5: HTTP/10 threads/No connection pooling</td>
    <td><img src="../images/graph_results_case5.png" alt="Graph Results Screenshot Case 4" style="width:304px;height:228px;"></td>
    <td>279</td>
    <td>221.69</td>
    <td>220.78</td>
    <td>--</td>
  </tr>

</table> 


<table style="width:100%">
  <tr style="font-weight:bold; background-color: orange">
    <td width="300px">Scaled version cases</td>
    <td>Graph Results Screenshot</td>
    <td>Average Query Time(ms)</td>
    <td>Average Search Servlet Time(ms)</td>
    <td>Average JDBC Time(ms)</td>
    <td>Analysis</td>
  </tr>
  <tr>
    <td>Case 1: HTTP/1 thread</td>
    <td><img src="../images/graph_results_case6.png" alt="Graph Results Screenshot Case 6" style="width:304px;height:228px;"></td>
    <td>51</td>
    <td>3.68</td>
    <td>3.36</td>
    <td>--</td>
  </tr>
  <tr>
    <td>Case 2: HTTP/10 threads</td>
    <td><img src="../images/graph_results_case7.png" alt="Graph Results Screenshot Case 7" style="width:304px;height:228px;"></td>
    <td>88</td>
    <td>35.17</td>
    <td>34.98</td>
    <td>--</td>
  </tr>
  <tr>
    <td>Case 3: HTTP/10 threads/No prepared statements</td>
    <td><img src="../images/graph_results_case8.png" alt="Graph Results Screenshot Case 8" style="width:304px;height:228px;"></td>
    <td>63</td>
    <td>8.89</td>
    <td>8.64</td>
    <td>--</td>
  </tr>
  <tr>
    <td>Case 4: HTTP/10 threads/No connection pooling</td>
    <td><img src="../images/graph_results_case9.png" alt="Graph Results Screenshot Case 9" style="width:304px;height:228px;"></td>
    <td>246</td>
    <td>184.48</td>
    <td>183.20</td>
    <td>--</td>
  </tr>

</table> 

</body>
</html>
