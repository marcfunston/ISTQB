<?php
/*
 * Title: ISS Flashcards Blog card Object
 * Author: Marc Funston
 * Purpose: This page provides the object used to build blog entries. 
 * Bugs: None known at this time
 * Edit Date: 4/16/2021 - Corrected get functions
 * Set imgs to be stored / retrieved from folder
 * Last Edit Date: 4/16/21
 * Last Edit Date: 5/6/2021 Checking before upload to github
 * 
 */

class Card
{
    public $card_title;
    public $card_date;
    public $card_number;
    public $image_name;
    public $question;
    public $answer; 
    public $view_number;
    public $comment = array('Bob' => 'wow!','fred' => 'no way');
    
    public function setCard_title($card_title) { 
        $this->card_title = $card_title; 
    }
    public function getCard_title() { 
        return $this->card_title; 
    }

    public function setCard_date($card_date) { 
        $this->card_date = $card_date; 
    }
    public function getCard_date() { 
        return $this->card_date; 
    }

    public function setCard_number($card_number) { 
        $this->card_number = $card_number; 
    }
    public function getCard_number() { 
        return $this->card_number; 
    }

    public function setImage_name($image_name) { 
        $this->image_name = $image_name; 
    }
    public function getImage_name() { 
        return $this->image_name; 
    }

    public function setquestion($question) { 
        $this->question = $question; 
    }
    public function getquestion() { 
        return $this->questiont; 
    }

    public function setanswer($answer) { 
        $this->answer = $answer; 
    }
    public function getanswer() { 
        return $this->answer; 
    }

    public function setView_number($view_number) { 
        $this->view_number = $view_number; 
    }
    public function getView_number() { 
        return $this->view_number; 
    }

    public function setComment($comment) { 
        $this->comment = $comment; 
    }
    public function getComment() { 
        return $this->comment; 
    } 

    function StartCard()
    {
        
		
        echo"	<div class=\"w3-container w3-show\">\n";
        echo"        <!--h2>Card Example</h2-->\n";
        echo"        <div class=\"w3-card-4 w3-light-grey \" style=\"width:100%\">\n";
        echo"            <div class=\"w3-container\">\n";
        echo"                <div class=\"w3-container w3-left\">\n";
        echo"                    <h5>$this->card_title</h5>\n";
        echo"                </div>\n";
        echo"                <div id=\"DEMO2\"B class=\"w3-container w3-left\">\n";
        echo"                   <h3>$this->question</h3>\n";
        echo"                </div>\n";
        echo"           <div id=\"DEMO\"A class=\"w3-container w3-left w3-hide\">\n";
        echo"                    <h3>$this->answer</h3>\n";
        echo"                </div>\n";
        echo"                <div class=\"w3-section w3-right\">\n";
        echo"                    <button onclick=\"myFunction('card$this->card_number')\" class=\"w3-button w3-white\">Answer</button>\n";
        echo"                </div>\n";
        echo"            </div>\n";
        echo"        </div>\n";
        echo"    </div>\n";
        echo"   <br><br>\n";
    }



    function EndCard()
    {

    }


}
?>