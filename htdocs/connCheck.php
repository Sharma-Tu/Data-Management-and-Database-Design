<?php
$servername = "localhost";
$username = "root";
$password = "1413";
$dbname = "sakila";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

function getIpAddress() {
//whether ip is from share internet	
    if (!empty($_SERVER['HTTP_CLIENT_IP']))   
  {
    $ip_address = $_SERVER['HTTP_CLIENT_IP'];
  }
//whether ip is from proxy
elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))  
  {
    $ip_address = $_SERVER['HTTP_X_FORWARDED_FOR'];
  }
//whether ip is from remote address
else
  {
    $ip_address = $_SERVER['REMOTE_ADDR'];
  }
return $ip_address;
}

echo getIpAddress();

$sql = "SELECT * FROM mysql.user;";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
    // output data of each row
    while($row = mysqli_fetch_assoc($result)) {
        echo "User: " . $row["User"] . "</br>" . "Host: " . $row["Host"] . "</br>";
    }
} else {
    echo "0 results";
}

mysqli_close($conn);
?>