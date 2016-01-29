<?php

$headers = getallheaders();
$server = $_SERVER;
$access_token = $headers['OIDC_access_token'];
$timestamp = $headers['OIDC_access_token_expires'];
$url = "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=".$access_token;
date_default_timezone_set('America/New_York');

?>

<h2>Access Token:</h2>
<b>access_token:</b> <?php echo $access_token; ?>&nbsp;
(<a href="<?php echo $url; ?>">token info</a>)<br \>
<b>expires: </b> <?php echo $timestamp; ?>&nbsp;

(<?php echo date("Y-m-d H:i:s T", $timestamp); ?>)

<h2>HTTP Headers:</h2>
<?php
foreach ($headers as $name => $value) {
	if ($name == 'Cookie') {
		$cookies = split(' ', $value);
		echo "<b>$name:</b><br />\n";
		foreach ($cookies as $cookie) {
			$c = split('=', $cookie);
			echo "&nbsp;<b>".$c[0]."</b>= ".$c[1]."<br />\n";
		}
	} else {
		echo "<b>$name:</b> $value<br \>\n";
	}
}
?>

<h2>Server Environment:</h2>
<?php
foreach ($server as $name => $value) {
	echo "<b>$name:</b> $value<br \>\n";
}

?>
