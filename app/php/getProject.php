<?php
session_start();
$projet = $_SESSION['array'];

if(isset($_GET['list']) && $_GET['list']>=0){
	echo json_encode($projet[$_GET['list']]);
}
?>
