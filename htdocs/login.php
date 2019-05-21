<!DOCTYPE HTML>
<html>
<head>
<title>CK</title><br><br>
</head>
<h1> CK Login</h1>
<body>


<form action= CKHome.php method="post">
	Email: <input type="text" name="Email"><br><br>
	Password: <input type="text" name="Password"><br><br>
	<input type="submit" name = 'Submit' value = 'Log In'>
</form>

<p>
	Not a member yet? <a href="appInstall.php">Sign up</a>
</p>


<?php
if (isset($_POST['go']))
{
$email = "'".$_POST["Email"]."'";
$passkey = "'".$_POST["Password"]."'";
};
?>

</body>
</html>