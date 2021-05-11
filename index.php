<?php

/*
 * Title: ISS Flashcards Index Page
 * Author: Marc Funston
 * Purpose: ISS Flashcards Index page.
 * Bugs: None known at this time
 * Edit: 4/17/2021 -- Converted entire Bolgowiz project to ISS Flashcards project
 * Edit: 4/18/2021 -- Rough import of data from ASTQB for sample tests 1 and 2
 *  Last Edit Date: 5/6/2021 Checking before upload to github
 * 
 */

// Variables
$pagination = 1; // number of posts per page


require("includes/mysqli_connect.php");
require("includes/flashcard.php");
include("includes/head.php");

// set page number
if($_SERVER['REQUEST_METHOD'] == 'GET') {

    $page = 1; // start at home page of Flashcards

}elseif($_SERVER['REQUEST_METHOD'] == 'POST') {

    $page = $_REQUEST['page']; // get current page of Flashcards
    if($page < 1)
        $page = 1; // prevent under run of entries

}

// card object to load up from data base
$card = new Card();

// Make the query:
$q = "SELECT card_number, card_title, question, answer, image_name, views, card_date FROM cards";		

$r = @mysqli_query ($dbc, $q); // Run the query.

// Count the number of returned rows:
$num = mysqli_num_rows($r);

// number of pages
$pages = ceil($num / $pagination);

// check and correct over run of pages
if($page > $pages)
    $page = $pages;

if ($num > 0) { // If it ran OK, display the records.
    
    // display the first 4
    $increment = 0;

	// Fetch and print all the records:
	while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {

    // determine which entries are shown
    $start_card = $page * $pagination - $pagination;
    //echo"<p>startcard = $start_card</p>";
    $end_card = $page * $pagination + 1;
    //echo"<p>endcard = $end_card</p>";

    if($row['card_number'] > $start_card && $row['card_number'] < $end_card){

        //set values in blog card
        $card->setCard_title($row['card_title']);
        $card->setCard_date($row['card_date']);
        $card->setCard_number($row['card_number']);
        $card->setImage_name($row['image_name']);
        $card->setquestion($row['question']);
        $card->setanswer($row['answer']);
        $card->setView_number($row['views']);

        // update views
        $new_total = $card->getView_number() + 1;
        $blog = $card->getcard_number();
        $q = "UPDATE posts SET views = $new_total WHERE card_number = $blog";		
        @mysqli_query($dbc, $q);
         
        // publish blog card to html
        $card->StartCard();
        }
    }

	mysqli_free_result ($r); // Free up the resources.	

} else { // If no records were returned.
	echo '<p class="error">There are currently no blog entries or the data base is busy.</p>';
}
// end of fill table ==================================================================

// set page values
$previousPage = $page - 1;
$nextPage = $page + 1;

?>
<div class="w3-row">
<div class="w3-half w3-container">
    <form action="index.php" method="post">
        <input type="hidden" name="page" value=<?php echo"$previousPage"; ?>>
        <button class="w3-button w3-black w3-padding-large w3-margin-bottom w3-right" input type="submit"
            name="submit" value="Next" />Previous</button>
    </form>
</div>

<div class="w3-half w3-container">
    <form action="index.php" method="post">
        <input type="hidden" name="page" value=<?php echo"$nextPage"; ?>>
        <button class="w3-button w3-black w3-padding-large w3-margin-bottom" input type="submit"
            name="submit" value="Next" />Next</button>
    </form>
</div>
</div>
<?php

// footer to include pages
include("includes/footer.php");

// close db
mysqli_close($dbc);


?>


