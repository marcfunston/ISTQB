<?php

/*
 * Title: ISS Flashcards Head Page
 * Author: Marc Funston
 * Purpose: This page contains the top part of the html. 
 * Bugs: None known at this time
 * Edit: 4/17/2021 -- Converted entire Bolgowiz project to ISS Flashcards project
 * Edit: 4/18/2021 -- Rough import of data from ASTQB for sample tests 1 and 2
 * 1 - Added function to nav buttons to show / not show
 *   - depending on user admin level or logged in.
 * Last Edit Date: 5/6/2021 Checking before upload to github
 * 
 */

?>

<!DOCTYPE html>
<html>
<title>ISTQB 1</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="style/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<style>
body,
h1,
h2,
h3,
h4,
h5 {
    font-family: "Raleway", sans-serif
}
</style>

<head>

    <script>
    function myFunction() {
        var x = document.getElementById("DEMO");
        var y = document.getElementById("DEMO2");
        if (x.className.indexOf("w3-show") == -1) {
            x.className += " w3-show";
            y.className += " w3-hide";
        } else {
            x.className = x.className.replace(" w3-show", "");
            y.className = y.className.replace(" w3-hide", "");
        }
    }
    </script>

</head>

<?php  

// If no page is set, set to 1:
if (!isset($_COOKIE['page'])) {
    setcookie ('page', 1);	
  } else { // get the page
    $page = $_COOKIE['page'];
  }

?>

<script>
// Script to open and close sidebar
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
}

function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
}
</script>


<body class="w3-light-grey">

    <div class="w3-content" style="max-width:1000px">

        <!-- Header -->
        <header class="w3-container w3-center w3-padding-32">
            <div class="w3-row">
                <div>
                    <h1><b>ISTQB Practice Test 1</b></h1>
                    <h2><b>Knowledge</b></h2>
                    <h3 class="w3-tag">The Gateway to a Bigger World!</h3>
                </div>
            </div>
        </header>

        <!-- Grid -->
        <div class="w3-row">

            <!-- Blog entries -->
            <div class="w3-col l8 s12">