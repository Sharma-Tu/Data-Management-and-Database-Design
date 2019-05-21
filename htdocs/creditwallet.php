#creditwallet
<html>
<head>
<h1> Credit Balance</h1>
</head>
<body>
<a href="CKHome2.php">Go to HOME</a><br><br>

<?php
$email = $_COOKIE["email"];

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

$sql = "SELECT creditScore, creditBalance FROM loanckr.accountUser WHERE memberid = $email";
$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);

echo "Your CK score is ".$row["creditScore"]."<br><br>"."Your CK balance is $".$row["creditBalance"];
?>

<body>
</html>