<html>
<head>
<h1> CK Home</h1>
</head>
<body>

<?php

$email = "'".$_POST["Email"]."'";
$passkey = "'".$_POST["Password"]."'";

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

$sql = "CALL loanckr.SP_login($email, $passkey, @phpmsg);";

mysqli_query($conn, $sql);

$select = mysqli_query($conn, 'SELECT @phpmsg;');
$result1 = mysqli_fetch_assoc($select);
$procOutput= $result1['@phpmsg'];

if($procOutput == 'Wrong Password! Go back to')
{echo $procOutput."<a href='"."login.php"."'> Log In</a>";}
else if ($procOutput == 'You were not found. Click on ')
{echo $procOutput."<a href='"."appinstall.php"."'> Sign Up </a>"."Or"."<a href='"."login.php"."'> Log In</a>";};

if($procOutput == 'CKHome.php')
{	echo "<dl><dt><a href='"."myaccount.php"."'>My Account</a></dt>".
		 "<dt><a href='"."creditwallet.php"."'>Credit Wallet</a></dt>".
		 "<dt><a href='"."maketransaction.php"."'>Make a Transaction</a></dt>".
		 "<dt><a href='"."billpay.php"."'>Add an Auto Bill Payment(COMING SOON)</a></dt>".
		 "<dt><a href='"."expensehistory.php"."'>View Expense Report (COMING SOON)</a></dt>".
		 "<dt><a href='"."payback.php"."'>Pay CK credit bill (COMING SOON)</a></dt></dl>";}
mysqli_close($conn);

setcookie("email", $email, time()+3600, "/","", 0);
?>

</body>
</html>