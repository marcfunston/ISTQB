<?php 

/*
 * Title: ISS Flashcards Post Page
 * Author: Marc Funston
 * Purpose: This script performs an INSERT query to add a record to the posts table.
 *          After checking the data for bad things.  
 * Bugs: None known at this time
 * Edit: 4/17/2021 -- Converted entire Bolgowiz project to ISS Flashcards project
 * Edit: 4/18/2021 -- Rough import of data from ASTQB for sample tests 1 and 2
 * 
 */

// If no cookie is present, redirect the user:
if (!$_COOKIE['logged_in']) {
 	/* Redirect browser */
	header("Location: /Blog_Code/login.php");

	/* Make sure that code below does not get executed when we redirect. */
	exit;	
}

$page_title = 'Post';
include ('includes/head.php');

// Check for form submission:
if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_FILES['upload'])) {

	require ('includes/mysqli_connect.php'); // Connect to the db.
		
	$errors = array(); // Initialize an error array.
	
	// Check for a card_title:
	if (empty($_POST['card_title'])) {
		$errors[] = 'You forgot to enter Question Number.';
	} else {
		$et = strip_tags(mysqli_real_escape_string($dbc, trim($_POST['card_title'])));
	}
	
	// Check for a question:
	if (empty($_POST['question'])) {
		$errors[] = 'You forgot to enter the question.';
	} else {
		$st = strip_tags(mysqli_real_escape_string($dbc, trim($_POST['question'])));
	}
	
	// Check for an answer:
	if (empty($_POST['answer'])) {
		$errors[] = 'You forgot to enter the answer.';
	} else {
		$lt = strip_tags(mysqli_real_escape_string($dbc, trim($_POST['answer'])));
    }
    
    // Skip Check for an image name:
	// if this uncomment out, fix form and query
	/*
	if (empty($_POST['image_name'])) {
		$errors[] = 'You forgot to enter the image link.';
	} else {
		$in = strip_tags(mysqli_real_escape_string($dbc, trim($_POST['image_name'])));
	}
	*/

	
	if (empty($errors)) { // If everything's OK.
	
		// Post the entry in the database...
		
		// Make the query:
		$q = "INSERT INTO cards (card_title, question, answer, image_name, views, card_date) VALUES ('$et', '$st', '$lt', 'ISS.jpg', 0, NOW() )";		
		$r = @mysqli_query ($dbc, $q); // Run the query.
		if ($r) { // If it ran OK.
        
			// Print a message:
            echo"   <div class=\"w3-card-4 w3-margin w3-white\">\n";
            echo"       <div class=\"w3-container\">\n";
            echo"       <h1>Post Complete</h1>\n";
            echo"       </div>\n";
            echo"   </div>\n";	
        
        } else { // If it did not run OK.
            
            // Print a message:
            echo"   <div class=\"w3-card-4 w3-margin w3-white\">\n";
            echo"       <div class=\"w3-container\">\n";
            echo"       <h1>System Error</h1>\n";
            echo"       <h2>You could not post due to a system error. We apologize for any inconvenience.</h2>\n";
            // Debugging message:
			echo '<p>' . mysqli_error($dbc) . '<br /><br />Query: ' . $q . '</p>';
            echo"       </div>\n";
            echo"   </div>\n";

			// Public message:
			echo '<h1></h1>
			<p class="error">You could not post due to a system error. We apologize for any inconvenience.</p>'; 

		} // End of if ($r) IF.
		
		mysqli_close($dbc); // Close the database connection.

		// Include the footer and quit the script:
        include ('includes/footerPlain.php'); 
		exit();
		
	} else { // Report the errors.
	
        echo"<div class=\"w3-card-4 w3-margin w3-white\">\n";
        echo"<div class=\"w3-container\">\n";
		echo '<h1>Error!</h1>
		<p class="error">The following error(s) occurred:<br />';
		foreach ($errors as $msg) { // Print each error.
			echo " - $msg<br />\n";
		}
        echo '</p><p>Please try again.</p><p><br /></p>';
        echo"</div>\n</div>\n";
		
	} // End of if (empty($errors)) IF.
	
	mysqli_close($dbc); // Close the database connection.

} // End of the main Submit conditional.

?>

<div class="w3-card-4 w3-margin w3-white"> 

<!-- ISS Image at the top of the card-->
<img src="./images/ISS.png" alt="Image is Missing!" style="width:100%">

	<!-- Main data entry container of the card-->
    <div class="w3-container">
        <!--h1>Post</h1-->
        <form action="post.php" method="post">

        <p>Entry Title:</p> 
	    <textarea rows="1" cols="65" name="card_title" value="<?php if (isset($_POST['card_title'])) echo $_POST['card_title']; ?>"></textarea> 
        
		<p>Question:</p> 
	    <textarea rows="3" cols="65" name="question" value="<?php if (isset($_POST['question'])) echo $_POST['question']; ?>"></textarea> 
		
		<p>Answer:</p>
	    <textarea rows="3" cols="65" name="answer" value="<?php if (isset($_POST['answer'])) echo $_POST['answer']; ?>"></textarea> 
        
		<!--p>Image Name: </p>
		<p><input type="text" name="image_name" size="65" maxlength="60" value="<?php /*if (isset($_POST['image_name'])) echo $_POST['image_name'];*/ ?>"  /> </p-->

		<p><input  type="submit" name="submit" value="Post" /></p>

        </form>
		<!--p>Example:<br>&nbsp Entry Title: Question #42<br>&nbsp Question: What is the answer to Life?<br>&nbsp Answer: 42<br>&nbsp Image Name: Deep Thought Computer.jpg</p-->
    </div>
</div>
<hr>

<?php include ('includes/footerPlain.php'); ?>