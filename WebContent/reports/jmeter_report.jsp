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
    <td>A single user does not put a lot of strain on the server. Most delay is from network permeation.</td>
  </tr>
  <tr>
    <td>Case 2: HTTP/10 threads</td>
    <td><img src="../images/graph_results_case2.png" alt="Graph Results Screenshot Case 2" style="width:304px;height:228px;"></td>
    <td>86</td>
    <td>38.11</td>
    <td>37.88</td>
    <td>Ten users put more strain on the server, but connection pooling and prepared statments make the delay increase non-linear.</td>
  </tr>
  <tr>
    <td>Case 3: HTTPS/10 threads</td>
    <td><img src="../images/graph_results_case3.png" alt="Graph Results Screenshot Case 3" style="width:304px;height:228px;"></td>
    <td>95</td>
    <td>39.75</td>
    <td>39.45</td>
    <td>Due to the additional level of security, HTTPS added a slight increase in delay</td>
  </tr>
  <tr>
    <td>Case 4: HTTP/10 threads/No prepared statements</td>
    <td><img src="../images/graph_results_case4.png" alt="Graph Results Screenshot Case 4" style="width:304px;height:228px;"></td>
    <td>87</td>
    <td>34.32</td>
    <td>34.15</td>
    <td>Our prepared statements were created once per querey. Removing them decreased the delay very slightly, but opened the system to malicous misconduct.</td>
  </tr>
  <tr>
    <td>Case 5: HTTP/10 threads/No connection pooling</td>
    <td><img src="../images/graph_results_case5.png" alt="Graph Results Screenshot Case 4" style="width:304px;height:228px;"></td>
    <td>279</td>
    <td>221.69</td>
    <td>220.78</td>
    <td>Removing connection pooling forces the server to create new connections every time a request is made, greatly increasing delay time.</td>
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
    <td>Not much of a difference can be seen for a single user on a scaled system.</td>
  </tr>
  <tr>
    <td>Case 2: HTTP/10 threads</td>
    <td><img src="../images/graph_results_case7.png" alt="Graph Results Screenshot Case 7" style="width:304px;height:228px;"></td>
    <td>88</td>
    <td>35.17</td>
    <td>34.98</td>
    <td>In theory this should be quite a bit faster than the single instance, but since all the threads went to one instance (due to sticky sessions) it is only slightly different than the single instance test above.</td>
  </tr>
  <tr>
    <td>Case 3: HTTP/10 threads/No prepared statements</td>
    <td><img src="../images/graph_results_case8.png" alt="Graph Results Screenshot Case 8" style="width:304px;height:228px;"></td>
    <td>63</td>
    <td>8.89</td>
    <td>8.64</td>
    <td>Removing prepared statements once again significantly decreased the delay in lieu of added security. Since this was paired with connection pooling, among two severs, the result was blazing fast. </td>
  </tr>
  <tr>
    <td>Case 4: HTTP/10 threads/No connection pooling</td>
    <td><img src="../images/graph_results_case9.png" alt="Graph Results Screenshot Case 9" style="width:304px;height:228px;"></td>
    <td>246</td>
    <td>184.48</td>
    <td>183.20</td>
    <td>No connection pooling proves to be inefficient once again, but sharing the workload among two severs is still faster than the same test on a single instance</td>
  </tr>

</table> 

</body>
</html>
