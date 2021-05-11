<?php

/*
 * Title: ISS Flashcards mysql
 * Author: Marc Funston
 * Purpose: condenses code to log in to database.
 * Bugs: .
 * Edit: 4/17/2021 -- Converted entire Bolgowiz project to ISS Flashcards project
 * Edit: 4/18/2021 -- Rough import of data from ASTQB for sample tests 1 and 2
 * Last Edit Date: 5/6/2021 Checking before upload to github
 * 
 */

DEFINE ('DB_USER', 'root');
DEFINE ('DB_PASSWORD', '');
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_NAME', 'istqb1');


// make the connection:
$dbc = @mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) OR die ('Could not connect to MYSQL: ' . mysqli_connect_error());

// Set the encoding
mysqli_set_charset($dbc, 'utf8');


?>