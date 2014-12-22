<?php
	$_POST["mail"]=trim(stripslashes($_POST["mail"]));
	if (filter_var($_POST["mail"], FILTER_VALIDATE_EMAIL));
	$header = "From: ".$_POST["mail"]."\n";
	$header .= "MIME-Version: 1.0\n";
	$header .= "Content-type: text/html; charset= iso-8859-1\n";

	$message = 'De :'.$_POST["nom"]."<br />".' Sujet :'.$_POST["raison"]."<br /><br />".$_POST["message"];
	$message = wordwrap($message, 70, "\r\n");

	$to = 'silphidecrea@gmail.com';
	$subject = 'Contact Web Portfolio';

	mail($to, $subject, $message, $header);
?>