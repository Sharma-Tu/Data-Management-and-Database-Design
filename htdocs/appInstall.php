<?php

$servername = "localhost";
$username = "webapp";
$password = "1413";
$dbname = "loanckr";

///////////////////////////////////////////// Create connection /////////////////////////////////////////////
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

//////////////////////////////////////////////SQL Appinstall push////////////////////////////////////////////
$sql = "CALL loanckr.SP_appInstall()";

mysqli_query($conn, $sql);
//$result = mysqli_query($conn, $sql);
/* if (mysqli_num_rows($result) > 0) {
    // output data of each row
    while($row = mysqli_fetch_assoc($result)) {
        echo "User: " . $row["User"] . "</br>" . "Host: " . $row["Host"] . "</br>";
    }
} else {
    echo "0 results";
}
 */
mysqli_close($conn);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
?>

<!DOCTYPE HTML>  
<html>
<head>
</head>
<body>  

<?php

// define variables and set to empty values
$firstname = $lastname = $cellnumber =$ssn = $email = $passkey =$age = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $firstname = test_input($_POST["firstname"]);
  $lastname = test_input($_POST["lastname"]);
  $cellnumber = test_input($_POST["cellnumber"]);
  $ssn = test_input($_POST["ssn"]);
  $email = test_input($_POST["email"]);
  $passkey = test_input($_POST["passkey"]);
  $age = test_input($_POST["age"]);
  
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>

<h2>SignUp On CK</h2>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">  
First Name: <input type="text" name="firstname"><br><br>
Last Name: <input type="text" name="lastname"><br><br>
Cell Number: <input type="text" name="cellnumber"> eg: 8570000000 (10 digit)<br><br>
Social Security Number: <input type="text" name="ssn"> eg: 956000000 (9 digit)<br><br>
E-mail: <input type="text" name="email"><br><br>
Password: <input type="text" name="passkey"><br><br>
Age:<input type="text" name="age"><br><br>
<input type="submit" name="submit" value="Submit">  
</form>

<?php 
$servername = "localhost";
$username = "webapp";
$password = "1413";
$dbname = "loanckr";

$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

$deviceid = "SELECT deviceid FROM loanckr.appinstall WHERE deviceid NOT IN (SELECT deviceid FROM loanckr.signupinfo) LIMIT 1;";
$result = mysqli_query($conn, $deviceid);

if (mysqli_num_rows($result) > 0) {
    // output data of each row
    while($row = mysqli_fetch_assoc($result)) {
        $deviceid = "'".$row["deviceid"]."'";
    }
}
else {
    $deviceid = '';
}


$firstName = "'".$firstname."'";
$lastName = "'".$lastname."'";
$email = "'".$email."'";

$passkey = "'".$passkey."'";

$sql = "CALL loanckr.SP_signupInfo($firstName,$lastName,$cellnumber,$ssn,$email,$passkey,$age,$deviceid,@errmsg)";

if(mysqli_query($conn, $sql)){
};

$select = mysqli_query($conn, 'SELECT @errmsg;');
$result1 = mysqli_fetch_assoc($select);
$procOutput= $result1['@errmsg'];

if ($procOutput != ''){
echo "Error: $procOutput";
};

mysqli_close($conn);

?>

<form action="login.php" method="post">
	<br>Do you agree to our Terms and Conditions?<br>
	<input type="radio" name="tandc" value="yes">Yes
	<input type="submit"> <br>Click on submit after signing up.
	</form>

<p>
  		Already a member? <a href="login.php">Log In</a>
</p>
</body>
</html>