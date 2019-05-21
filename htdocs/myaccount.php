<html>
<head>
<h1> Account Update</h1>
</head>
<body>
<a href="CKHome2.php">Go to HOME</a><br><br>

<?php
$email = $_COOKIE["email"];

$income = $addressstreet = $addressextra = $zipcode = $city = $state = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
	$income = $_POST["income"];
	$addressstreet = "'".$_POST["addressstreet"]."'";
	$addressextra = "'".$_POST["addressextra"]."'";
	$zipcode = $_POST["zipcode"];
	$city = "'".$_POST["city"]."'";
	$state = "'".$_POST["state"]."'";
}

?>

<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
	Annual Income($): <input type="text" name="income"><br><br>
	Street Address: <input type="text" name="addressstreet"><br><br>
	Address Line 2(Optional): <input type="text" name="addressextra"><br><br>
	City: <input type="text" name="city"><br><br>
	State: <input type="text" name="state"><br><br>
	ZIP Code: <input type="text" name="zipcode"><br><br>
	<input type="submit" name = 'Submit' value = 'Update Info'>
</form>

<?php

$servername = "localhost";
$username = "webapp";
$password = "1413";
$dbname = "loanckr";

$sql = "CALL loanckr.SP_useraccount($email, $income, $addressstreet, $addressextra, $zipcode, $city , $state);";

///////////////////////////////////////////// Create connection /////////////////////////////////////////////
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($income != "")
{
mysqli_query($conn, $sql);
}

mysqli_close($conn);

?>
</body>
</html>