<html>
<head>
<h1> Transaction status for your bill at <?php echo $_COOKIE["merchant"];?> is <?php echo $_POST["decision"]?>d</h1>
</head>
<body>
<a href="CKHome2.php">Go to HOME</a><br><br>

<?php

$email = $_COOKIE["email"];

$merchant = "'".$_COOKIE["merchant"]."'";
$decision = "'".$_POST["decision"]."'";
$amount = $_COOKIE["amount"];


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

$sql = "CALL loanckr.SP_maketransaction($email,$amount,$merchant,$decision)";

mysqli_query($conn, $sql);

mysqli_close($conn); 
?>