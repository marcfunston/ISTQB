<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Images</title>
	<script type="text/javascript" charset="utf-8" src="js/function.js"></script>
</head>
<body>
<p>Click on an image to view it in a separate window.</p>
<ul>
<?php # Script 11.4 - images.php
// This script lists the images in the uploads directory.

$dir = '../uploads'; // Define the directory to view.

$files = scandir($dir); // Read all the images into an array.

// Display each image caption as a link to the JavaScript function:
foreach ($files as $image) {

	if (substr($image, 0, 1) != '.') { // Ignore anything starting with a period.
	
		// Get the image's size in pixels:
		$image_size = getimagesize ("$dir/$image");

		// Make the image's name URL-safe:
		$image_name = urlencode($image);
		
		// Print the information:
		echo "<li><a href=\"javascript:create_window('$image_name',$image_size[0],$image_size[1])\">$image</a></li>\n";
	
	} // End of the IF.
    
} // End of the foreach loop.
?>
</ul>
</body>
<script>



// Make a pop-up window function:
function create_window (image, width, height) {

// Add some pixels to the width and height:
width = width + 10;
height = height + 10;

// If the window is already open, 
// resize it to the new dimensions:
if (window.popup && !window.popup.closed) {
    window.popup.resizeTo(width, height);
} 

// Set the window properties:
var specs = "location=no, scrollbars=no, menubars=no, toolbars=no, resizable=yes, left=0, top=0, width=" + width + ", height=" + height;

// Set the URL:
var url = "show_image.php?image=" + image;

// Create the pop-up window:
popup = window.open(url, "ImageWindow", specs);
popup.focus();

} // End of function.
</script>
</html>