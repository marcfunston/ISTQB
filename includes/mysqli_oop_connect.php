<?php 

/*
 * Title: ISS Flashcards Index Page
 * Author: Marc Funston
 * Purpose: ISS Flashcards edit blog page.
 * Bugs: complete page construction needed.
 * Edit: 4/17/2021 -- Converted entire Bolgowiz project to ISS Flashcards project
 * Edit: 4/18/2021 -- Rough import of data from ASTQB for sample tests 1 and 2
 * Last Edit Date: 5/6/2021 Checking before upload to github
 * 
 */

// Script 16.1 - mysqli_oop_connect.php
// This file contains the database access information. 
// This file also establishes a connection to MySQL, 
// selects the database, and sets the encoding.
// The MySQL interactions use OOP

// Set the database access information as constants:
DEFINE ('DB_USER', 'root');
DEFINE ('DB_PASSWORD', '');
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_NAME', 'flashcards');

// Make the connection:
$mysqli = new MySQLi(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

// Verify the connection:
if ($mysqli->connect_error) {
	echo $mysqli->connect_error;
	unset($mysqli);
} else { // Establish the encoding.
	$mysqli->set_charset('utf8');
}