<html>
<head>
<h1> Merchant Transaction</h1>
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

$sql = "SELECT UPPER(merchant) merchant, 
			CAST(CONCAT(F_randNum(3),'.',F_randNum(2)) AS DECIMAL(10,2)) amount  
			FROM (SELECT F_randNum(1) num) A JOIN loanckr.merchants B ON A.num = B.merchantid;";

$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);

echo "<h2>".$row["merchant"]." has requested a payment of $".$row["amount"]." from you."."</h2>";

#$sql2 = "CALL loanckr.SP_maketransaction($email,$amount,$merchantid)";

setcookie("merchant", $row["merchant"], time()+3600, "/","", 0);
setcookie("amount", $row["amount"], time()+3600, "/","", 0);


mysqli_close($conn); 
?>


<form method="post" action="transactionresult.php">
	Please Select an option below to proceed:
  <input type="radio" name="decision" value="Accept">Approve
  <input type="radio" name="decision" value="Decline">Decline
  <br><br>
	<input type="submit" name = 'Submit' value = 'Proceed'>
</form>

<body>
</html>