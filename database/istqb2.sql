/*ASTQB -- American Software Testing Qualification Board*/
/*Version 1.0 August 18, 2018*/
/*© American Software Testing Qualifications Board*/

/*
 * Title: ISS Flashcards Rough Data
 * Author: Marc Funston
 * Purpose: ISS Flashcards Index page.
 * Bugs: None known at this time
 * Edit: 4/17/2021 -- Converted entire Bolgowiz project to ISS Flashcards project
 * Edit: 4/18/2021 -- Rough import of data from ASTQB for sample tests 1 and 2
 *
 * To Do -- go through each and every question and and compare to downloaded pdfs
 */

DROP DATABASE IF EXISTS istqb2;

CREATE DATABASE istqb2;

USE istqb2;

CREATE TABLE users (
user_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
first_name VARCHAR(20),
last_name VARCHAR(40),
admin BOOL,
user_name VARCHAR(40) NOT NULL,
email VARCHAR(60) NOT NULL,
password VARCHAR(40) NOT NULL,
registration_date DATETIME NOT NULL,
PRIMARY KEY (user_id)
);


CREATE TABLE cards (
card_number INT UNSIGNED NOT NULL AUTO_INCREMENT,
user_id TINYINT UNSIGNED,
card_title VARCHAR(40) NOT NULL,
question VARCHAR(1024),
answer VARCHAR(1024),
image_name VARCHAR(60),
views INT UNSIGNED,
card_date DATETIME NOT NULL,
PRIMARY KEY (card_number),
INDEX (user_id),
INDEX (card_date)
);

CREATE TABLE messages (
user_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
email TINYINT UNSIGNED NOT NULL,
message VARCHAR(255) NOT NULL,
contact_date DATETIME NOT NULL,
PRIMARY KEY (user_id)
);

CREATE TABLE pictures(
picture_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
user_id TINYINT UNSIGNED NOT NULL,
title VARCHAR(20),
description VARCHAR(20),
link VARCHAR(128),
PRIMARY KEY(picture_id)
);

CREATE TABLE map_users_to_posts(
user_id TINYINT UNSIGNED NOT NULL, #fk
card_number INT UNSIGNED NOT NULL, #fk
PRIMARY KEY(user_id,card_number)
);

CREATE TABLE comments(
comment_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
comment VARCHAR(144),
user_id TINYINT UNSIGNED,
card_number INT UNSIGNED NOT NULL,
card_date DATETIME NOT NULL,
PRIMARY KEY(comment_id)
);

CREATE TABLE views(
card_number INT UNSIGNED NOT NULL AUTO_INCREMENT,
total INT UNSIGNED NOT NULL,
PRIMARY KEY(card_number)
);

alter table views
add foreign key(card_number)
references cards(card_number)
on delete cascade;

alter table comments
add foreign key(card_number)
references cards(card_number)
on delete cascade;

alter table comments
add foreign key(user_id)
references users(user_id)
on delete cascade;

alter table map_users_to_posts
add foreign key(user_id)
references users(user_id)
on delete cascade;

alter table map_users_to_posts
add foreign key(card_number)
references cards(card_number)
on delete cascade;

alter table messages
add foreign key(user_id)
references users(user_id)
on delete cascade;

alter table pictures
add foreign key(user_id)
references users(user_id)
on delete cascade;

/* this data is sanitized for upload to git*/

INSERT INTO users (first_name, last_name, admin, user_name, email, password, registration_date) VALUES
('Marc', 'Funston', true, 'admin', 'admin@something.com', SHA1('pass'), now()),
('Marc', 'Funston', false, 'marc', 'marc@something.com', SHA1('pass'), now());	

INSERT INTO `cards` (`card_number`, `user_id`, `card_title`, `question`, `answer`, `image_name`, `views`, `card_date`) VALUES
(1, NULL, 'Question #1', 'Which of the following is the activity that removes the cause of a failure?<br><br>a. Testing<br>b. Dynamic testing<br>c. Debugging<br>d. Reverse engineering', 'C is correct.', 'ISS.jpg', 0, '2021-05-10 13:20:00'),
(2, NULL, 'Question #2', 'As a tester, which of the following is a key to effectively communicating and maintaining positive<br>relationships with developers when there is disagreement over the prioritization of a defect?<br><br>a. Escalate the issue to human resources and stress the importance of mutual respect<br>b. Communicate in a setting with senior management to ensure everyone understands<br>c. Convince the developer to accept the blame for the mistake<br>d. Remind them of the common goal of creating quality systems', 'D is correct, per syllabus. Start with collaboration<br>rather than battles and remind everyone that it is<br>a common goal to build better quality systems.', 'ISS.jpg', 0, '2021-05-10 13:20:58'),
(3, NULL, 'Question #3', 'Why is software testing sometimes required for legal reasons?<br><br>a. It prevents developers from suing testers<br>b. Contracts may specify testing requirements that must be fulfilled<br>c. International laws require software testing for exported products<br>d. Testing across systems must be accompanied by legal documentation', 'B is correct. Software testing may be required to meet contractual requirements and commitments and penalties are sometimes assessed when quality goals are not met.', 'ISS.jpg', 0, '2021-05-10 13:21:45'),
(4, NULL, 'Question #4', 'In what way does root cause analysis contribute to process improvement?<br><br>a. Helps to better identify and correct the root cause of defects<br>b. Outlines how development teams can code faster<br>c. Specifies the desired root causes to be achieved by other teams<br>d. Contributes to the justification of future project funding', 'A is correct. Root cause analysis can determine common causes of issues. Addressing these common causes by process improvement can increase quality.', 'ISS.jpg', 0, '2021-05-10 13:22:31'),
(5, NULL, 'Question #5', 'Why is it important to avoid the pesticide paradox?<br><br>a. Dynamic testing is less reliable in finding bugs<br>b. Pesticides mixed with static testing can allow bugs to escape detection<br>c. Tests should not be context dependent<br>d. Running the same tests over and over will reduce the chance of finding new defects', 'D is correct. As tests are run repeatedly, the pesticide (the tests) become less effective.', 'ISS.jpg', 0, '2021-05-10 13:23:37'),
(6, NULL, 'Question #6', 'Which of the following is the activity that compares the planned test progress to the actual test progress?<br><br>a. Test monitoring<br>b. Test planning<br>c. Test closure<br>d. Test control', 'A is correct. Test monitoring involves the ongoing comparison of actual progress against the test plan.', 'ISS.jpg', 0, '2021-05-10 13:24:19'),
(7, NULL, 'Question #7', 'Which of the following is the correct statement?<br><br>a. An error causes a failure which results in a defect<br>b. A defect causes a failure which results in an error<br>c. A failure is observed as an error and the root cause is the defect<br>d. An error causes a defect which is observed as a failure', 'D is correct. The error or the mistake made by the developer causes a defect in the code. When that code is executed, a failure can be observed.', 'ISS.jpg', 0, '2021-05-10 13:24:53'),
(8, NULL, 'Question #8', 'What type of activity is normally used to find and fix a defect in the code?<br><br>a. Regression testing<br>b. Debugging<br>c. Dynamic analysis<br>d. Static analysis', 'B is correct. This normally occurs during<br>debugging.', 'ISS.jpg', 0, '2021-05-10 13:25:19'),
(9, NULL, 'Question #9', 'During which level of testing should non-functional tests be executed?<br><br>a. Unit and integration only<br>b. System testing only<br>c. Integration, system and acceptance only<br>d. Unit, integration, system and acceptance only', 'D is correct. Non-functional tests can and should be executed at all levels of testing.', 'ISS.jpg', 0, '2021-05-10 13:25:56'),
(10, NULL, 'Question #10', 'When a system is targeted for decommissioning, what type of maintenance testing may be required?<br><br>a. Retirement testing<br>b. Regression testing<br>c. Data migration testing<br>d. Patch testing', 'C is correct, per syllabus. Data migration to another system or data migration to an archival system may be needed.', 'ISS.jpg', 0, '2021-05-10 13:26:39'),
(11, NULL, 'Question #11', 'If impact analysis indicates that the overall system could be significantly affected by system<br>maintenance activities, why should regression testing be executed after the changes?<br><br>a. To ensure the system still functions as expected with no introduced issues<br>b. To ensure no unauthorized changes have been applied to the system<br>c. To assess the scope of maintenance performed on the system<br>d. To identify any maintainability issues with the code', 'A is correct, per syllabus. By definition, regression testing is looking for areas in which the system may have regressed (gone backwards).', 'ISS.jpg', 0, '2021-05-10 13:27:43'),
(12, NULL, 'Question #12', 'In an iterative lifecycle model, which of the following is an accurate statement about testing activities?<br><br>a. For every development activity, there should be a corresponding testing activity<br>b. For every testing activity, appropriate documentation should be produced, versioned and stored<br>c. For every development activity resulting in code, there should be a testing activity to document test cases<br>d. For every testing activity, metrics should be recorded and posted to a metrics dashboard for all stakeholders', 'A is correct. For any lifecycle model, this is a correct statement.', 'ISS.jpg', 0, '2021-05-10 13:28:26'),
(13, NULL, 'Question #13', 'Use cases are a test basis for which level of testing?<br><br>a. Unit<br>b. System<br>c. Load and performance<br>d. Usability', 'B is correct. Use cases are a good test basis for system testing because they include end-to-end transaction scenarios.', 'ISS.jpg', 0, '2021-05-10 13:29:14'),
(14, NULL, 'Question #14', 'Which of the following techniques is a form of static testing?<br><br>a. Error guessing<br>b. Automated regression testing<br>c. Providing inputs and examining the resulting outputs<br>d. Code review', 'D is correct,', 'ISS.jpg', 0, '2021-05-10 13:29:50'),
(15, NULL, 'Question #15', 'Which of the following is a benefit of static analysis?<br><br>a. Defects can be identified that might not be caught by dynamic testing<br>b. Early defect identification requires less documentation<br>c. Early execution of the code provides a gauge of code quality<br>d. Tools are not needed because reviews are used instead of executing code', 'A is correct, per syllabus. Static analysis with a static analyzer can be used to find defects such as uninitialized variables that could be difficult to catch with dynamic testing.', 'ISS.jpg', 0, '2021-05-10 13:30:31'),
(16, NULL, 'Question #16', 'What is the main difference between static and dynamic testing?<br><br>a. Static testing is performed by developers; dynamic testing is performed by testers<br>b. Manual test cases are used for dynamic testing; automated tests are used for static testing<br>c. Static testing must be executed before dynamic testing<br>d. Dynamic testing requires executing the software; the software is not executed during static<br>testing', 'D is correct. Dynamic testing is done while the software is actually running whereas static testing depends on examining the software while it is not running.', 'ISS.jpg', 0, '2021-05-10 13:51:17'),
(17, NULL, 'Question #17', 'If a review session is led by the author of the work product, what type of review is it?<br><br>a. Ad hoc<br>b. Walkthrough<br>c. Inspection<br>d. Audit', 'B is correct. In a walkthrough, the author normally leads the review session.', 'ISS.jpg', 0, '2021-05-10 13:51:54'),
(18, NULL, 'Question #18', 'You are preparing for a review of a mobile application that will allow users to transfer money between bank accounts from different banks. Security is a concern with this application and the previous version of this application had numerous security vulnerabilities (some of which were found by hackers). It is very important that this doesn’t happen again.<br><br>Given this information, what type of review technique would be most appropriate?<br><br>a. Ad hoc<br>b. Role-based<br>c. Checklist-based<br>d. Scenario', 'C is correct. This review should be conducted with checklist guidance with the checklist including security vulnerabilities.', 'ISS.jpg', 0, '2021-05-10 13:52:59'),
(19, NULL, 'Question #19', 'Which of the following is an experience-based testing technique?<br><br>a. Error guessing<br>b. Intuitive testing<br>c. Oracle-based testing<br>d. Exhaustive testing', 'A is correct,', 'ISS.jpg', 0, '2021-05-10 13:53:33'),
(20, NULL, 'Question #20', 'Which of the following test techniques uses the requirements specifications as a test basis?<br><br>a. Structure-based<br>b. Black-box<br>c. White-box<br>d. Exploratory', 'B is correct, per syllabus. Black-box testing is based off the requirements documents.', 'ISS.jpg', 0, '2021-05-10 13:54:53'),
(21, NULL, 'Question #21', 'How is statement coverage determined?<br><br>a. Number of test decision points divided by the number of test cases<br>b. Number of decision outcomes tested divided by the total number of executable statements<br>c. Number of possible test case outcomes divided by the total number of function points<br>d. Number of executable statements tested divided by the total number of executable statements', 'D is correct,', 'ISS.jpg', 0, '2021-05-10 13:55:48'),
(22, NULL, 'Question #22', 'If you have a section of code that has one simple IF statement, how many tests will be needed to<br>achieve 100% decision coverage?<br><br>a. 1<br>b. 2<br>c. 5<br>d. Unknown with this information', 'B is correct. A simple IF statement will be<br>composed of If ... then ... else.... end if. There<br>are two decision outcomes, one for the result of<br>the If being true and one for it being false. Since 100% decision coverage requires at least one test case for each decision outcome, two tests are needed.', 'ISS.jpg', 0, '2021-05-10 13:56:38'),
(23, NULL, 'Question #23', 'What is error guessing?<br><br>a. A testing technique used to guess where a developer is likely to have made a mistake<br>b. A technique used for assessing defect metrics<br>c. A development technique to verify that all error paths have been coded<br>d. A planning technique used to anticipate likely schedule variances due to faults', 'A is correct. Error guessing is a technique used<br>to anticipate where developers are likely to make<br>errors and to create tests to cover those areas.', 'ISS.jpg', 0, '2021-05-10 13:57:17'),
(24, NULL, 'Question #24', 'When exploratory testing is conducted using time-boxing and test charters, what is it called?<br><br>a. Schedule-based testing<br>b. Session-based testing<br>c. Risk-based testing<br>d. Formal chartering', 'B is correct. This is often called session-based<br>testing and may use session sheets.', 'ISS.jpg', 0, '2021-05-10 13:58:14'),
(25, NULL, 'Question #25', 'You are testing a scale system that determines shipping rates for a regional web-based auto parts distributor. You want to group your test conditions to minimize the testing.<br>Identify how many equivalence classes are necessary for the following range. Weights are rounded to the nearest pound. <br><br><style> table, th, td {  border: 1px solid black;  }</style><table><tr><th>Weight</th><th>Shipping Cost</th>  </tr><tr><td>1 to 10 lbs.</td><td>$5.00</td></tr><tr><td>11 to 25 lbs.</td><td>$7.50</td></tr><tr><td>26 to 50 lbs.</td><td>$12.00</td></tr><tr><td>51 lbs. and up</td><td>$17.00</td></tr></table><br><br>  a. 8<br>b. 6<br>c. 5<br>d. 4', 'C is correct. You need a partition for each of the 4 classes and one for a zero or negative weight.', 'ISS.jpg', 0, '2021-05-10 13:59:19'),
(26, NULL, 'Question #26', 'You are testing a scale system that determines shipping rates for a regional web-based auto parts<br>distributor. Due to regulations, shipments cannot exceed 100 lbs. You want to include boundary value<br>analysis as part of your black-box test design.<br>How many tests will you need to execute to achieve 100% two-value boundary value analysis? <br><br><style> table, th, td {  border: 1px solid black;  }</style><table><tr><th>Weight</th><th>Shipping Cost</th>  </tr><tr><td>1 to 10 lbs.</td><td>$5.00</td></tr><tr><td>11 to 25 lbs.</td><td>$7.50</td></tr><tr><td>26 to 50 lbs.</td><td>$12.00</td></tr><tr><td>51 lbs. to 100</td><td>$17.00</td></tr></table><br><br>a. 4<br>b. 8<br>c. 10<br>d. 12', 'C is correct. 2 per valid weight range plus one for a negative weight and one for a weight exceeding 100 lbs (-1, 0, 10, 11, 25, 26, 50, 51, 100, 101).', 'ISS.jpg', 0, '2021-05-10 14:00:21'),
(27, NULL, 'Question #27', 'Skip for now!!!! <!--Which of the following is the correct decision table for the following pseudocode for ordering a<br>hamburger? Note: if you add or delete items from the basic burger, you no longer get the basic burger.<br>Start<br>Select basic burger<br>If customer adds items<br>While items to be added Ask customer which item<br>Add item<br>End while<br>Endif<br>If customer deletes items<br>While items to be deleted<br>Ask customer which item<br>Delete item<br>End while<br>Endif<br>If customer wants fries<br>Add fries to order<br>Endif<br>Complete order<br>End-->', 'B is correct.', 'ISS.jpg', 0, '2021-05-10 14:01:36'),
(28, NULL, 'Question #28', 'You are testing an e-commerce transaction that has the following states and transitions:<br><br>1. Login (invalid) > Login<br>2. Login > Search<br>3. Search > Search<br>4. Search > Shopping Cart<br>5. Shopping Cart > Search<br>6. Shopping Cart > Checkout<br>7. Checkout > Search<br>8. Checkout > Logout<br><br>For a state transition diagram, how many transitions should be shown?<br><br>a. 4<br>b. 6<br>c. 8<br>d. 16', 'C is correct. There are 8 transitions that should<br>be shown in the state transition diagram as<br>explained in the question.', 'ISS.jpg', 0, '2021-05-10 14:02:12'),
(29, NULL, 'Question #29', 'You are testing a banking application that allows a customer to withdraw 20, 100 or 500 dollars in a<br>single transaction. The values are chosen from a drop-down list and no other values may be entered.<br><br>How many equivalence partitions need to be tested to achieve 100% equivalence partition coverage?<br><br>a. 1<br>b. 2<br>c. 3<br>d. 4', 'D is correct. The values to be tested are 20, 100, 500 and no selection.', 'ISS.jpg', 0, '2021-05-10 14:02:55'),
(30, NULL, 'Question #30', 'Level of risk is determined by which of the following?<br><br>a. Likelihood and impact<br>b. Priority and risk rating<br>c. Probability and practicality<br>d. Risk identification and mitigation', 'A is correct. The combination of likelihood and impact is normally used to determine the overall risk level (sometimes called the risk priority number).', 'ISS.jpg', 0, '2021-05-10 14:03:40'),
(31, NULL, 'Question #31', 'Who normally writes the test plan for a project?<br><br>a. The project manager<br>b. The product owner<br>c. The test manager<br>d. The tester', 'C is correct. Writing and updating the test plan is normally the responsibility of the test manager.', 'ISS.jpg', 0, '2021-05-10 14:04:21'),
(32, NULL, 'Question #32', 'What is the biggest problem with a developer testing his own code?<br><br>a. Developers are not good testers<br>b. Developers are not quality focused<br>c. Developers are not objective about their own code<br>d. Developers do not have time to test their own code', 'C is correct. This is the biggest problem. A and B are not necessarily true – some developers are good testers and have a good quality focus. D is not correct because unit testing is part of their job and time should be made in the schedule for at least unit testing.', 'ISS.jpg', 0, '2021-05-10 14:05:23'),
(33, NULL, 'Question #33', 'Which of the following is a project risk?<br><br>a. A defect that is causing a performance issue<br>b. A duplicate requirement<br>c. An issue with a data conversion procedure<br>d. A schedule that requires work during Christmas shutdown', 'D is correct, this is a risk to the entire project. A,<br>B and C are product risks.', 'ISS.jpg', 0, '2021-05-10 14:05:56'),
(34, NULL, 'Question #34', 'If your test strategy is based off the list of the ISO 25010 quality characteristics, what type of strategy is it? <br><br>a. Regulatory<br>b. Analytical<br>c. Methodical<br>d. Reactive', 'C is correct. When tests are derived from a systematic use of a preset list of quality<br>characteristics, this is a methodical strategy.', 'ISS.jpg', 0, '2021-05-10 14:06:42'),
(35, NULL, 'Question #35', 'If the developers are releasing code for testing that is not version controlled, what process is missing?<br><br>a. Configuration management<br>b. Debugging<br>c. Test and defect management<br>d. Risk analysis', 'A is correct. Configuration management is missing if the code is not being properly versioned and tracked.', 'ISS.jpg', 0, '2021-05-10 14:07:21'),
(36, NULL, 'Question #36', 'You are getting ready to test another upgrade of an ERP system. The previous upgrade was tested by your team and has been in production for several years. For this situation, which of the following is the most appropriate test effort estimation technique?<br><br>a. Effort-based<br>b. Expert-based<br>c. Metric-based<br>d. Schedule-based', 'C is correct. In this case, you should have access to the effort that was required on the previous version of the ERP system and you should be able to use that information to predict the effort for this release.', 'ISS.jpg', 0, '2021-05-10 14:08:22'),
(37, NULL, 'Question #37', 'You have been testing software that will be used to track credit card purchases. You have found a defect that causes the system to crash, but only if a person has made and voided 10 purchases in a row. What is the proper priority and severity rating for this defect?<br><br>a. Priority high, severity high<br>b. Priority high, severity low<br>c. Priority low, severity low<br>d. Priority low, severity high', 'D is correct. This is not likely to happen, so the urgency to fix it is low but it does crash the system so the impact to the system is high so the severity should be high.', 'ISS.jpg', 0, '2021-05-10 14:09:12'),
(38, NULL, 'Question #38', 'Consider the following test cases that are used to test an accounting system:  <br><br> <style> table, th, td { border: 1px solid black; } </style> <table> <tr> <th>Test ID</th> <th>Name</th> <th>Dependency</th> <th>Priority</th> </tr> <tr> <td>1</td> <td>Purchase Item</td> <td>none</td> <td>2</td> </tr> <tr> <td>2</td> <td>Receive Invoice</td> <td>Test 1</td> <td>3</td> </tr> <tr> <td>3</td> <td>Receive Goods</td> <td>Test 1</td> <td>2</td> </tr> <tr> <td>4</td> <td>Send payment</td> <td>Test 2</td> <td>3</td> </tr> <tr> <td>5</td> <td>Report Payments</td> <td>Test 4</td> <td>1</td> </tr> </table> <br><br> Given this information, what is the proper order in which to execute these test cases?<br><br>a. 5, 1, 3, 2, 4<br>b. 1, 2, 4, 5, 3<br>c. 1, 3, 2, 4, 5<br>d. 3, 4, 5, 1, 2', 'B is correct. The goal is to run the highest priority tests as soon as possible. Dependency has to be considered in order for the tests to actually be<br>executed. In order to get the highest priority test run as soon as possible, the correct order is as follows: test 1 has to go first since everything else is dependent on it. Then we need to do 2 so we can do 4 and 5 (the highest priority test) and<br>then 3 is last because 5 is not dependent on it.', 'ISS.jpg', 0, '2021-05-10 14:10:35'),
(39, NULL, 'Question #39', 'Which of the following are major objectives of a pilot project for a tool introduction?<br><br>a. Roll out, adapt, train, implement<br>b. Monitor, support, revise, implement<br>c. Learn, evaluate, decide, assess<br>d. Evaluate, adapt, monitor, support', 'C is correct. Learn more about the tool, evaluate the fit in the organization, decide on standard usage and assess benefits to be achieved are all objectives for a pilot project.', 'ISS.jpg', 0, '2021-05-10 14:11:20'),
(40, NULL, 'Question #40', 'What is the primary purpose of a test execution tool?<br><br>a. It runs automated test scripts to test the test object<br>b. It automatically records defects in the defect tracking system<br>c. It analyzes code to determine if there are any coding standard violations<br>d. It tracks test cases, defects and requirements traceability', 'A is correct. This is the primary purpose of the test execution tools.', 'ISS.jpg', 0, '2021-05-10 14:12:22');

