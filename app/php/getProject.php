<?php
	$list_projet = array(
		0 => 'wiseapp_pres',
		1 => 'ipve_pres',
		2 => 'hotel',
		);
	$height_decoup = 500;
	$projet = array();

	foreach ($list_projet as $key => $value) {
		$name_source = $value;
		$img_source_file = '../images/projet/'.$name_source.'.jpg';
		$img_source = imagecreatefromjpeg($img_source_file);

		$width = imagesx($img_source);
		$height = imagesy($img_source);
		$ratio = ceil($height/$height_decoup);
		$img_dest_height = $height_decoup;

		$nb_img_decoup = 1;
		$img_source_y = 0;
		$projet[$key] = array();

		while ($nb_img_decoup <= $ratio) {
			if ($nb_img_decoup == $ratio) {
				$img_dest_height = $height - $height_decoup*($ratio-1);
			}
			$img_dest = imagecreatetruecolor($width,$img_dest_height);
			imagecopy($img_dest, $img_source, 0, 0, 0, $img_source_y, $width, $img_dest_height);
			$img_dest_file = '../images/projet/'.$name_source.'_'.$nb_img_decoup.'.jpg';
			imagejpeg($img_dest, $img_dest_file);

			$projet[$key][$nb_img_decoup] = $img_dest_file;
			$img_source_y += $height_decoup;
			$nb_img_decoup++;
		}
		imagedestroy($img_source);
		imagedestroy($img_dest);
	}

	if(isset($_GET['list']) && $_GET['list']>=0){
		echo json_encode($projet[$_GET['list']]);
	}
?>
