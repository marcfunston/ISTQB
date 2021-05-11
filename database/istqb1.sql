/*ASTQB -- American Software Testing Qualification Board*/
/*Version 1.0 August 18, 2018*/
/*© American Software Testing Qualifications Board*/

/*
 * Title: ISTQB Flashcards program
 * Author: Marc Funston
 * Purpose: ISTQB 1 Practice Test Study programe.
 * Bugs: None known at this time
 * Edit: 5/11/2021 -- Updated data abd cleaned up description
 * 
 */

DROP DATABASE IF EXISTS istqb1;

CREATE DATABASE istqb1;

USE istqb1;

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

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #1', 'What is the test basis?<br>a. The point during software development when testing should start<br>
b. The body of knowledge used for test analysis and design<br>
c. The source to determine the actual results from a set of tests<br>
d. The method used to systematically devise test conditions<br>',
'<b>B is correct.</b> Per the glossary, the test basis is “a
source to determine expected results to compare
with the actual result of the system under test”. A
is not correct because this is usually defined as
the moment of involvement for testing. C is not
correct because this is the test oracle. D is not
correct because the test basis is not a method.
Keyword 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #2', 'When the tester verifies the test basis while designing tests early in the lifecycle, which common test
objective is being achieved?<br>a. Gaining confidence<br>b. Finding defects<br>c. Preventing defects<br>
d. Providing information for decision making<br>','<b>C is correct per the syllabus.</b> The other three are
achieved primarily by doing dynamic testing. This is a bit tricky because you are very likely to find
defects while doing this analysis and this may lead to either gaining or destroying confidence
and needing to supply information to the decision makers. However\, the wording of the question
matches the wording in the syllabus that defines preventing defects.
FL-1.1.1 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #3', 'When following the fundamental test process, when should the test control activity take place?<br><br>
a. During the planning activities<br>b. During the implementation and execution activities<br>
c. During the monitoring activities<br>d. During all the activities<br>', '<b>D is correct.</b> Control occurs throughout the
project to ensure that it is staying on track based on the plan and to take any corrective steps that 
may be necessary. The monitoring information is used to determine if control actions are needed. 
FL-1.4.2 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #4', 'Which of the following is a correct statement?<br><br>
a. A developer makes a mistake which causes a defect that may be seen as a failure during dynamic testing<br>
b. A developer makes an error which results in a failure that may be seen as a fault when the software is executed<br>
c. A developer has introduced a failure which results in a defect that may be seen as a mistake during dynamic testing<br>
d. A developer makes a mistake which causes a bug that may be seen as a defect when the
software is executed<br>','<b>A is correct.</b> The developer makes a
mistake/error which causes a defect/fault/bug which may cause a failure when the code is
dynamically tested or executed. B is incorrect because fault and failure are reversed. C is
incorrect because failure and mistake are reversed. D is incorrect because it’s a failure
that’s seen during execution, not the defect itself. The failure is a symptom of the defect.
FL-1.2.3 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #5', 'Which of the following is an example of debugging?<br><br>
a. A tester finds a defect and reports it<br>
b. A tester retests a fix from the developer and finds a regression<br>
c. A developer finds and fixes a defect<br>
d. A developer performs unit testing<br>','<b>C is correct.</b> Debugging is what the developer does to identify the cause of the defect, analyze
it and fix it. D may involve debugging, if the developer finds a defect, but the act of unit
testing is not the same as debugging. FL-1.1.2 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #6', 'Which of the following is a true statement about exhaustive testing?<br><br>
a. It is a form of stress testing<br>
b. It is not feasible except in the case of trivial software<br>
c. It is commonly done with test automation <br>
d. It is normally the responsibility of the developer during unit testing','<b>B is correct.</b> Exhaustive testing, all combinationsof inputs and preconditions, is not feasible unless
the software is trivially simple.Otherwise it would take too long and might not even be possible.
FL-131 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #7', 'A new retail product was released to production by your company. Shortly after the release it was
apparent that there were numerous problems with the point of sale application. This resulted in a
number of customer complaints and negative postings on social media encouraging people to take their
business to your competitor. You have investigated the problems and have discovered that the
production point of sale equipment is a later model than the model used in testing. The software
functions correctly on the old version, but fails on the later model.<br><br>
Given this scenario, what is the root cause and what is the effect?<br><br>
a. The root cause is the old equipment and the effect is the new equipment<br>
b. The root cause is the customer complaints and the effect is the social media postings<br>
c. The root cause is conducting the testing on the wrong version of the equipment and the effect<br>
is the customer complaints and postings<br>
d. The root cause is the software failing on the later model and the effect is the customer complaints<br>','<b>C is correct.</b> The root cause is that the testing,
and maybe the development, were conducted on
the wrong version of the POS equipment. The
effect of the problem is the customer complaints
and the social media postings.
FL-1.2.4 1
', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #8', 'If you need to provide a report showing test case execution coverage of the requirements, what do you
need to track?<br><br>
a. Traceability between the test cases and the requirements<br>
b. Coverage of the risk items by test case<br>
c. Traceability between the requirements and the risk items<br>
d. Coverage of the requirements by the test cases that have been designed<br>',
'<b>A is correct.</b> In order to show the test execution
coverage of the requirements you will need traceability between the requirements and the
test cases. As the test cases are executed this traceability can be used to record tests executed
against the requirements. <br>
B is not correct because it’s looking for requirements coverage, not risk coverage. <br>
C is not correct because it’s looking for test execution, not risk items. <br>
D is not correct because it’s looking for test cases that have been executed, not just designed.<br>
FL-1.4.4 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #9', 'Which of the following is most correct regarding the test level at which functional tests may be
executed?<br><br>
a. Unit and integration<br>
b. Integration and system<br>
c. System and acceptance<br>
d. All levels<br>', ' <b>D is correct.</b> Functional testing should be
conducted at all levels.
FL-2.3.2 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #10', 'Which of the following is a true statement regarding the V-model lifecycle?<br><br>
a. Testing involvement starts when the code is complete<br>
b. The test process is integrated with the development process<br>
c. The software is built in increments and each increment has activities for requirements, design,
build and test<br>
d. All activities for development and test are completed sequentially<br>','
<b>B is correct.</b> In the V-Model, testing activities are paired with each development activity.<br> 
A and D are not correct. These behaviors are typical of a waterfall model.<br> 
C is not correct. This is typical of an incremental model. FL-2.1.1 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #11', 'Usability testing is an example of which type of testing?<br><br>
a. Functional<br>
b. Non-functional<br>
c. Structural<br>
d. Change-related<br>','<b>B is correct.</b> Usability is one of the non-functional test types according to ISO 25010.
FL-2.3.1 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #12', 'What type of testing is normally conducted to verify that a product meets a particular regulatory
requirement?<br><br>
a. Unit testing<br>
b. Integration testing<br>
c. System testing<br>
d. Acceptance testing<br>','<b>D is correct per the syllabus.</b> Regulatory
acceptance is a form of acceptance testing. The other types of testing should be conducted as 
well, but the focus on the compliance with the regulatory requirements should occur during 
acceptance testing. It is a good practice to conduct this testing as early as possible, but 
formal acceptance by a regulatory agency is normally done during acceptance testing. 
FL-2.2.1 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #13', 'You have been receiving daily builds from the developers. Even though they are documenting the fixes
they are including in each build, you are finding that the fixes either aren’t in the build or are not
working. What type of testing is best suited for finding these issues?<br><br>
a. Unit testing<br>
b. System testing<br>
c. Confirmation testing<br>
d. Regression testing<br>','<b>C is correct.</b> Confirmation testing will determine if
a fix is present in a build and if it actually fixes the defect it is supposed to fix. <br>
A is not correct because this would be conducted by the developer as they fix the issues. While it might 
catch a fix that doesnt work, it’s not likely to catch the check-in/build process that is excluding 
the fix from the build.<br> 
B is not correct because system testing will take longer to pinpoint this 
problem and may result in more troubleshooting time when the problem is discovered again. <br>
D is not correct because this is the testing that is done to see if there have been any unintended 
changes in the software’s behavior. FL-2.3.3 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #14', 'In a formal review, which role is normally responsible for documenting all the open issues?<br><br>
a. The facilitator<br>b. The author<br>c. The scribe<br>
d. The manager<br>','<b>C is correct.</b> The scribe is normally responsible for documenting all issues, problems and open
FL-3.2.2 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #15', 'Which testing technique would be most effective in determining and improving the maintainability of the
code (assuming developers fix what is found)?<br><br>
a. Peer reviews<br>
b. Static analysis<br>
c. Dynamic testing<br>
d. Unit testing<br>', '<b>B is correct.</b> Static analysis with tools will give
the best results for improving maintainability and ensuring adherence to good coding practices. <br>
A may help, but depending on the peer, it may just reinforce bad habits.<br> 
C is unlikely to help because only failures will be observed, not the underlying code. <br>
D may help, but since it’s usually done by the developer who wrote the code, it’s unlikely to highlight maintenance
issues. FL-3.1.3 1', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #16', 'For a formal review, at what point in the process are the card and exit criteria defined?<br><br>
a. Planning<br>
b. Review initiation<br>
c. Individual review<br>
d. Fixing and reporting<br>', '<b>A is correct.</b> The card and exit criteria should be
defined during the planning step in the review process. These should be evaluated at each step 
to ensure the product is ready for the next step in the process. B, C and D are not correct because 
the criteria should already be defined by this point. FL-3.2.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #17', '
If the author of the code is leading a code review for other developers and testers, what type of review is it?<br><br>
a. An informal development review<br>
b. A walkthrough<br>
c. An inspection<br>
d. An audit<br>', '<b>B is correct.</b> When the author of the document being reviewed is leading the review, this is a 
typically a walkthrough. <br>
A is not correct because there is a group of people conversing in the review rather than a more formal review meeting. <br>
C is a formal review type and the facilitator (moderator) would lead the review.<br> 
D is not correct because an audit is normally conducted by a third party external to the team. FL-3.2.3 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #18', 'You are participating in a role-based review session. Your assigned role is that of a senior citizen. The
product is an online banking application that is targeted for use on smart phones. You are currently
reviewing the user interface of the product with a prototype that works on iPhones. Which of the
following is an area that you should review?<br><br>
a. The speed of response from the banking backend<br>
b. The attractiveness of the application<br>
c. The size and clarity of the instruction text<br>
d. The reliability of the application when the connection is dropped<br>', '<b>C is correct.</b> As a senior citizen, you should be
checking that the size of the instruction text is clearly readable and you should verify that the 
instructions will make sense to a senior citizen. A is not correct because this is not particular to 
your role as senior citizens are generally not as time compressed as younger users. B is not 
correct. Although it is nice, attractiveness tends to be very subjective and is difficult to evaluate at 
a role level. D is not correct because the reliability will be assumed by the senior citizen. 
This should be reviewed by the technical users and people on the go who are likely to move 
between covered and not covered zones. FL-3.2.4 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #19', 'Which of the following is an extension of equivalence partitioning?<br><br>
a. Decision tables<br>
b. Decision testing<br>
c. Boundary value analysis<br>
d. State transition testing<br>', '<b>C is correct.</b> BVA is an extension of EP, looking at the boundaries on the edges of the partitions
(or classes) of values. Keyword 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #20', 'If test cases are derived from looking at the code, what type of test design technique is being used?<br><br>
a. Black-box<br>
b. White-box<br>
c. Specification-based<br>
d. Behavior-based<br>', '20 B <b>B is correct.</b> A, C and D are all black-box and
use the specifications or requirements for the test design. FL-4.1.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #21', 'Which of the following is a good reason to use experience-based testing?<br><br>
a. You can find defects that might be missed by more formal techniques<br>
b. You can test for defects that only experienced users would encounter<br>
c. You can target the developer’s efforts to the areas that users will be more likely to use<br>
d. It is supported by strong tools and can be automated<br>', '<b>A is correct.</b> Experience-based testing is often
used to fill in the gaps left by the more formal testing techniques. B is not correct because it is
FL-4.4.1 14
Question Answer Rationale Learning 
Objective (LO) Number of Points used by experienced testers and has nothing to do with the experience level of the users. <br>
C is not correct because it is a test technique, not a development technique. <br>
D is not correct. There is not much tool support for these techniques and automation is not usually a goal because the effectiveness depends on the experience of the tester.
', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #22', 'If you are using error guessing to target your testing, which type of testing are you doing?<br><br>
a. Specification-based<br>
b. Structure-based<br>
c. Experience-based<br>
d. Reference-based<br>', '<b>C is correct.</b> This is an experience-based technique. FL-4.4.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #23', 'If you are testing a module of code, how do you determine the level of decision coverage you have
achieved?<br><br>
a. By taking the number of decisions you have tested and dividing that by the total number of executable statements in the module<br>
b. By taking the number of decisions you have tested and dividing that by the total number of decisions in the module<br>
c. By taking the number of decisions you have tested and dividing that by the total lines of code in the module<br>
d. By taking the number of decision outcomes you have tested and dividing that by the total number of decision outcomes in the module<br>', '<b>D is correct.</b> Decision coverage looks at the number of decision outcomes, not just the
decision statements.FL-4.3.2 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #24', 'Which of the following best describes the behaviors defined in a use case that should be covered by
tests?<br><br>
a. Positive path and negative path<br>
b. Basic, exception and error<br>
c. Normal, error, data, and integration<br>
d. Control flow, data flow and decision paths<br>', '<b>B is correct.</b> The basic, exception and error
behaviors should be covered with tests for a use case. A good use case should define all of these. <br>
A is not correct. Positive path equals the basic behavior and negative path equals the error 
behavior but neither handles the exception paths. <br>C and D are not correct as they are 
investigating areas that would not be covered in a use case. FL-4.2.5 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #25', 'You are testing a machine that scores exam papers and assigns grades. Based on the score achieved
the grades are as follows: <br>1-49 = F, <br>50-59 = D-, <br>60-69 = D, <br>70-79 = C, <br>80-89 = B, <br>90-100=A<br><br>
If you apply equivalence partitioning, how many test cases will you need to achieve minimum test coverage?<br><br>
a. 6<br>
b. 8<br>
c. 10<br>
d. 12<br>', '<b>B is correct.</b> You need a test for the invalid too low (0 or less), one for each valid partition, and 
one for invalid too high (>100). It may not allow you to enter a value > 100, but it should be 
tested to make sure it provides a proper error. FL-4.2.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #26', 'You are testing a machine that scores exam papers and assigns grades. Based on the score achieved
the grades are as follows:<br> 1-49 = F,<br> 50-59 = D-,<br> 60-69 = D,<br> 70-79 = C,<br> 80-89 = B,<br> 90-100=A<br>
If you apply two-value boundary value analysis, how many test cases will you need to achieve minimum test coverage?<br><br>
a. 8<br>
b. 10<br>
c. 12<br>
d. 14<br>', '<b>D is correct.</b> You need the following test cases:
0, 1, 49, 50, 59, 60, 69, 70, 79, 80, 89, 90, 100,101 FL-4.2.2 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #27', 'You have been given the following conditions and results from those condition combinations. Given this
information, using the decision table technique, what is the minimum number of test cases you would need to test these conditions?<br><br>
Conditions:<br>
Valid cash<br>
Valid credit card<br>
Valid debit card<br>
Valid pin<br>
Bank accepts<br>
Valid Selection<br>
Item in Stock<br>
Results:<br>
Reject Cash<br>
Reject Card<br>
Error Message<br>
Return Cash<br>
Refund Card<br>
Sell Item<br>
a. 7<br>
b. 13<br>
c. 15<br>
d. 18<br>', '<b>C is correct.</b> See table below FL-4.2.3 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #28', 'You have been given the following requirement:<br>
A user must log in to the system with a valid username and password. If they fail to enter the correct
combination three times, they will receive an error and will have to wait 10 minutes before trying again.
The test terminates when the user successfully logs in.
How many test cases are needed to provide 100% state transition coverage?<br><br>
a. 1<br>
b. 2<br>
c. 4<br>
d. 5<br>', '<b>B is correct.</b> Per the diagram below, only two
tests are needed: Login, Fail, Login, Success,
Home and Login, Fail, Fail, Fail = 3, Wait, Login,
Home 1. FL-4.2.4 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #29', 'You are testing a thermostat for a heating/air conditioning system. You have been given the following
requirements:<br><br>
- When the temperature is below 70 degrees, turn on the heating system<br>
- When the temperature is above 75 degrees, turn on the air conditioning system<br>
- When the temperature is between 70 and 75 degrees, inclusive, turn on fan only<br>
Which of the following is the minimum set of test temperature values to achieve 100% two-value
boundary value analysis coverage?<br><br>
a. 70, 75<br>
b. 65, 72, 80<br>
c. 69, 70, 75, 76<br>
d. 70, 71, 74, 75, 76<br>', '<b>C is correct.</b><br>
For the heating system, the values to test are 69,70 FL-4.2.2 1 5<br>
Question Answer Rationale Learning Objective (LO) Number of Points<br>
For the air conditioning system, the values are 75, 76<br>
For the fan only, the values are 69, 70, 75, 76 <-- 69 | 70 – 75 | 76 à<br>
The proper test set combines all these values, 69, 70, 75, 76<br>', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #30', 'A metric that tracks the number of test cases executed is gathered during which activity in the test
process?<br><br>
a. Planning<br>
b. Implementation<br>
c. Execution<br>
d. Reporting<br>', '<b>C is correct.</b> Test execution metrics are gathered during the Test Execution activity. These metrics
are used in reporting. FL-5.3.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #31', 'Who is normally responsible for the creation and update of a test plan for a project?<br><br>
a. The project manager<br>
b. The test manager<br>
c. The tester<br>
d. The product owner<br>', '<b>B is correct per the syllabus.</b> <br>A is not correct. The
PM is usually responsible for the overall project plan. <br>C is not correct. The tester may contribute
to the plan but is generally not responsible for writing it. D is not correct. The PO may contribute
to the plan and review the plan, but they do not normally write the plan. FL-5.1.2 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #32', 'Which of the following variances should be explained in the Test Summary Report?<br><br>
a. The variances between the weekly status reports and the test exit criteria<br>
b. The variances between the defects found and the defects fixed<br>
c. The variances between what was planned for testing and what was actually tested<br>
d. The variances between the test cases executed and the total number of test cases<br>',
'<b>C is correct.</b> The variances or deviations between the test plan and the testing that was 
actually done must be explained in the test summary report. A is not correct because if the 
weekly status reports have been tracking incorrectly to the test exit criteria, something is 
wrong and should have been caught a lot earlier. B is not correct because this information should 
be included in the test summary report, but a variance is expected. D is not correct because 
this should be tracked in the metrics section of the report rather than as a variance. FL-5.3.2 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #33', 'Which of the following is a project risk?<br><br>
a. A module that performs incorrect calculations due to a defect in a formula<br>
b. A failed performance test<br>
c. An issue with the interface between the system under test and a peripheral device<br>
d. A problem with the development manager which is resulting in his rejecting all defect reports<br>', 
'<b>D is a project risk.</b> The other three are product risks. FL-5.5.2 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #34', 'Which of the following is a benefit of test independence?<br><br>
a. Testers have different biases than developers<br>
b. Testers are isolated from the development team<br>
c. Testers lack information about the test object<br>
d. Testers will accept responsibility for quality<br>',
'<b>A is correct.</b> Testers bring different biases than the developers have, so they may be able to see 
different types of failures and check for assumptions the developers may have made. <br>B 
and C are disadvantages. <br>D is definitely a disadvantage and is sometimes seen in the 
developers losing their sense of responsibility for quality. FL-5.1.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #35', 'You are working in a team of testers who are all writing test cases. You have noticed that there is a 
significant inconsistency with the length and amount of detail in the different test cases. Where should
the test case guidelines have been documented?<br><br>
a. The test plan<br>
b. The test approach<br>
c. The test case template<br>
d. The project plan<br>', '<b>A is correct.</b> The level of detail and structure for the test documentation should be included in the
test plan. FL-5.2.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #36', 'Which of the following is an example of a good exit criterion from system testing?<br><br>
a. All tests should be completed<br>
b. The project budget should be spent<br>
c. All defects should be fixed<br>
d. All severity 1 defects must be resolved<br>', '<b>D is correct.</b> This is measurable and clear. <br>A is
not correct because completed is not a clear term and this might not be a reasonable goal. B 
is not correct because spending the budget is generally not the goal and you wouldn’t expect 
the budget to be spent when system testing is done because that leaves no money for 
acceptance testing or roll out. C is not correct FL-5.2.3 1 
6 Question Answer Rationale Learning Objective (LO) Number of Points because this is a “should” and also probably is
not realistic.', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #37', 'You have received the following description section in a defect report:
The report executed per the attached steps, but the data was incorrect. For example, the information in
column 1 was wrong. See the attached screenshot. This report is critical to the users and they will be
unable to do their jobs without this information.<br><br>
What is the biggest problem with this defect report?<br><br>
a. The developer won’t know how important the problem is<br>
b. The developer won’t know how to repeat the test<br>
c. The developer won’t be able to see what the tester is saying is wrong<br>
d. The developer won’t know what the tester expected to see<br>', '<b>D is correct.</b> From this information, the developer
only knows the tester thinks the information is wrong, but it’s not clear what was expected. A is 
incorrect because, although vague, the incident report seems to indicate this is an important 
problem. B is incorrect because the steps are attached (or so it says). C is incorrect because 
the screen shot should indicate column 1 that is wrong. FL-5.6.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #38', 'You have been given the following set of test cases to run. You have been instructed to run them in
order by risk and to accomplish the testing as quickly as possible to provide feedback to the developers
as soon as possible. Given this information, what is the best order in which to run these tests?<br>
Test Case ID Duration Risk Priority Dependency<br><br>
1 30 mins Low 6<br>
2 10 mins Medium none<br>
3 45 mins High 1<br>
4 30 mins High 2<br>
5 10 mins Medium 4<br>
6 15 mins Low 2<br>
a. 2, 4, 5, 6, 1, 3<br>
b. 4, 3, 2, 5, 6, 1<br>
c. 2, 5, 6, 4, 1, 3<br>
d. 6, 1, 3, 2, 4, 5<br>', '<b>A is correct</b> because it addresses the highest risk
and fastest tests first. It runs a fast medium test before a slow and more dependent high risk test 
because this will give feedback to the developers more quickly. FL-5.2.4 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #39', 'Why is it important to define usage guidelines for a new tool?<br><br>
a. Because this is a proven success factor in tool deployment<br>
b. Because this will ensure the licensing restrictions are enforced<br>
c. Because management needs to understand the details of the tool usage<br>
d. Because this will provide the information needed for the cost/benefit analysis<br>','<b>A is correct.</b> This is one of the success factors in
tool deployment. B is not correct because the usage guidelines are for the actual users, not the 
overall organization which is where the licensing requirements might be a concern. C is not 
correct because management is not focusing on the details. D is not correct because the 
cost/benefit information needs to be gathered long before the tool is procured. FL-6.2.3 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #40', 'Which of the following is an example of a tool that supports static testing?<br><br>
a. A tool that assists with tracking the results of reviews<br>b. A defect tracking tool<br>c. A test automation tool<br>
d. A tool that helps design test cases for security testing<br>', '<b>A is correct.</b> Reviews are a form of static testing
and a tool that supports reviews is an example of a tool that supports static testing. B is an 
example of a management tool used for defect management. C is an example of a test 
execution tool. D is an example of a test design tool. FL-6.1.1 1<br>
Conditions: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15<br>
Valid cash Y Y Y N<br>
Valid credit card Y Y Y Y N<br>
Valid debit card Y Y Y Y Y N<br>
Valid pin Y N Y Y Y<br>
Bank accepts Y N Y Y Y N Y Y<br>
Valid Selection Y N Y Y N Y Y N Y<br>
Item in Stock Y N Y N Y N<br>
Results:<br>
Reject Cash Y<br>
Reject Card Y Y Y Y N<br>
Error Message Y Y Y Y Y Y Y<br>
Return Cash Y Y<br>
Refund Card Y Y Y Y<br>
Sell Item Y Y Y<br>', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #1', 'Which of the following is the activity that removes the cause of a failure?<br>
a. Testing<br>b. Dynamic testing<br>c. Debugging<br>
d. Reverse engineering<br>','<b>C is correct.</b> Debugging is the process of finding, analyzing and removing the causes of failures in
software. A and B are incorrect because they will find the failure caused by a defect. D is incorrect. 
Reverse engineering is a process for determining the source code from the object code. Keyword 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #2', 'As a tester, which of the following is a key to effectively communicating and maintaining positive
relationships with developers when there is disagreement over the prioritization of a defect?<br>
a. Escalate the issue to human resources and stress the importance of mutual respect<br>
b. Communicate in a setting with senior management to ensure everyone understands<br>
c. Convince the developer to accept the blame for the mistake<br>
d. Remind them of the common goal of creating quality systems<br>', '<b>D is correct</b>, per syllabus. Start with collaboration
rather than battles and remind everyone that it is a common goal to build better quality systems. A 
and B are incorrect because this type of escalation is inappropriate. C is incorrect as it is 
the opposite approach to take because blame placing is not going to build a better team or 
product.FL-1.5.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #3', 'Why is software testing sometimes required for legal reasons?<br>
a. It prevents developers from suing testers<br>
b. Contracts may specify testing requirements that must be fulfilled<br>
c. International laws require software testing for exported products<br>
d. Testing across systems must be accompanied by legal documentation<br>', '<b>B is correct.</b> Software testing may be required to
meet contractual requirements and commitments and penalties are sometimes assessed when 
quality goals are not met. A is not correct because lawsuits, unfortunately, are not limited. 
C is not correct because there are not international laws covering all exported products. 
D is not correct because cross system testing may occur within an organization and require no legal documentation. 
FL-1.2.1 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #4', 'In what way does root cause analysis contribute to process improvement?
a. Helps to better identify and correct the root cause of defects b. Outlines how development teams can code faster 
c. Specifies the desired root causes to be achieved by other teams d. Contributes to the justification of future project funding',
'<b>A is correct.</b> Root cause analysis can determine common causes of issues. Addressing these 
common causes by process improvement can increase quality. B is incorrect because root 
cause analysis will not make the developers code faster, better maybe, not faster. C is 
incorrect because root causes generally are not good things that should be transferred between 
teams. D is not correct because it will not improve funding. FL-1.2.2 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #5', 'Why is it important to avoid the pesticide paradox?<br>
a. Dynamic testing is less reliable in finding bugs<br>
b. Pesticides mixed with static testing can allow bugs to escape detection<br>
c. Tests should not be context dependent<br>
d. Running the same tests over and over will reduce the chance of finding new defects<br>',
'<b>D is correct.</b> As tests are run repeatedly, the pesticide (the tests) become less effective. <br>A is 
not correct because dynamic testing should be used and helps to alleviate the pesticide 
paradox. <br>B doesn’t actually make sense. <br>C is not FL-1.3.1 1 2<br>
Question Answer Rationale Learning Objective (LO) Number of Points 
correct because testing should be context dependent.', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #6', 'Which of the following is the activity that compares the planned test progress to the actual test
progress?<br>
a. Test monitoring<br>
b. Test planning<br>
c. Test closure<br>
d. Test control<br>', '<b>A is correct.</b> Test monitoring involves the ongoing comparison of actual progress against the
test plan. B is incorrect because it defines testing objectives. C is incorrect because the activities 
have already completed and the project is closing down. D is incorrect because test control 
is when you take actions to correct any issues observed during monitoring. FL-1.4.2 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #7', 'Which of the following is the correct statement?<br>
a. An error causes a failure which results in a defect<br>
b. A defect causes a failure which results in an error<br>
c. A failure is observed as an error and the root cause is the defect<br>
d. An error causes a defect which is observed as a failure<br>', '<b>D is correct.</b> The error or the mistake made by the developer causes a defect in the code. When 
that code is executed, a failure can be observed. FL-1.2.3 1 ', 'ISS.png', 0, now());
 INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #8', 'What type of activity is normally used to find and fix a defect in the code?<br>
a. Regression testing<br>
b. Debugging<br>
c. Dynamic analysis<br>
d. Static analysis<br>', '<b>B is correct.</b> This normally occurs during debugging. FL-1.1.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #9', 'During which level of testing should non-functional tests be executed?<br>
a. Unit and integration only<br>
b. System testing only<br>
c. Integration, system and acceptance only<br>
d. Unit, integration, system and acceptance only<br>','9 D <b>D is correct.</b> Non-functional tests can and should be executed at all levels of testing. FL-2.3.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #10', 'When a system is targeted for decommissioning, what type of maintenance testing may be required?<br>
a. Retirement testing<br>
b. Regression testing<br>
c. Data migration testing<br>
d. Patch testing<br>', '<b>C is correct</b>, per syllabus. Data migration to another system or data migration to an archival 
system may be needed. A is incorrect, there is no such testing type. B is incorrect because this 
is more appropriate for current systems, not the system being retired. D is incorrect because this 
is of no use for a system being retired. FL-2.4.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #11', 'If impact analysis indicates that the overall system could be significantly affected by system
maintenance activities, why should regression testing be executed after the changes?<br>
a. To ensure the system still functions as expected with no introduced issues<br>
b. To ensure no unauthorized changes have been applied to the system<br>
c. To assess the scope of maintenance performed on the system<br>
d. To identify any maintainability issues with the code<br>', '<b>A is correct</b>, per syllabus. By definition,
regression testing is looking for areas in which the system may have regressed (gone 
backwards). B is incorrect as the purpose of regression is not to monitor malicious or 
erroneous activities by the developers. C is incorrect as it is not in scope of regression 
testing but would be a consideration for the impact analysis. D is incorrect because 
regression testing will not identify maintainability issues – that will have to be done via static 
analysis or specific maintainability tests. FL-2.4.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #12', 'In an iterative lifecycle model, which of the following is an accurate statement about testing activities?
a. For every development activity, there should be a corresponding testing activity<br>
b. For every testing activity, appropriate documentation should be produced, versioned and stored<br>
c. For every development activity resulting in code, there should be a testing activity to document test cases<br>
d. For every testing activity, metrics should be recorded and posted to a metrics dashboard for all stakeholders<br>',
'<b>A is correct.</b> For any lifecycle model, this is a correct statement. B is not correct because some 
testing activities may not produce documentation, such as reviews. C is not correct 
because test cases are not always written, particularly in an Agile lifecycle (which is an 
iterative lifecycle) where only exploratory testing might be used. D is not correct because not all 
testing activities produce metrics (such as test case creation, reviews, etc.) and, even if they 
did, not all stakeholders would be interested in those metrics. FL-2.1.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #13', 'Use cases are a test basis for which level of testing?<br>
a. Unit<br>
b. System<br>
c. Load and performance<br>
d. Usability<br>', '<b>B is correct.</b> Use cases are a good test basis for system testing because they include end-to-end
FL 2.2.1 1<br>
3 Question Answer Rationale Learning Objective (LO) Number of Points  transaction scenarios. <br>A is not correct because 
unit testing concentrates on individual components, not transactions. <br>C and D are not testing levels. ', 'ISS.png', 0, now());
 INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #14', 'Which of the following techniques is a form of static testing?<br>
a. Error guessing<br>
b. Automated regression testing<br>
c. Providing inputs and examining the resulting outputs<br>
d. Code review<br>', '<b>D is correct</b>, per syllabus. A, B and C are all forms of dynamic testing.
FL-3.1.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #15', 'Which of the following is a benefit of static analysis?<br>
a. Defects can be identified that might not be caught by dynamic testing<br>
b. Early defect identification requires less documentation<br>
c. Early execution of the code provides a gauge of code quality<br>
d. Tools are not needed because reviews are used instead of executing code<br>',
'<b>A is correct</b>, per syllabus. Static analysis with a static analyzer can be used to find defects such
as uninitialized variables that could be difficult to catch with dynamic testing. <br>B is incorrect 
because defects will still need to be documented regardless of how early they are found. <br>C is 
incorrect because this is dynamic analysis. <br>D is incorrect because static analysis usually requires 
the use of tools. FL-3.1.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #16', 'What is the main difference between static and dynamic testing?<br>
a. Static testing is performed by developers; dynamic testing is performed by testers<br>
b. Manual test cases are used for dynamic testing; automated tests are used for static testing<br>
c. Static testing must be executed before dynamic testing<br>
d. Dynamic testing requires executing the software; the software is not executed during static testing<br>',
'<b>D is correct.</b> Dynamic testing is done while the software is actually running whereas static 
testing depends on examining the software while it is not running. A is not correct because both 
types of testing can be done by both developers and testers. B is not correct because manual and 
automated tests can be used for dynamic testing. C is not correct because static testing can occur 
at any time although it is usually done before dynamic testing. FL-3.1.3 1 ', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #17', 'If a review session is led by the author of the work product, what type of review is it?<br>
a. Ad hoc<br>b. Walkthrough<br>c. Inspection<br>d. Audit<br>', '<b>B is correct.</b> In a walkthrough, the author
normally leads the review session. <br>A is not correct as this is not normally an organized 
session. <br>C is not correct because an inspection is normally led by the facilitator (moderator). <br>D is 
not correct because an audit is usually led by a third party. FL-3.2.3 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #18', 'You are preparing for a review of a mobile application that will allow users to transfer money between
bank accounts from different banks. Security is a concern with this application and the previous version
of this application had numerous security vulnerabilities (some of which were found by hackers). It is
very important that this doesn’t happen again.
Given this information, what type of review technique would be most appropriate?<br>
a. Ad hoc<br>b. Role-based<br>c. Checklist-based<br>d. Scenario<br>', '<b>C is correct.</b> This review should be conducted
with checklist guidance with the checklist including security vulnerabilities. A is not correct 
because this will not provide the needed guidance. B is not correct because the roles are 
not a concern – even the hacker role – compared to checking the vulnerabilities. D is not correct 
because the concern is about the security vulnerabilities, not the functionality of the product. 
FL-3.2.4 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #19', 'Which of the following is an experience-based testing technique?<br>
a. Error guessing<br>b. Intuitive testing<br>c. Oracle-based testing<br>
d. Exhaustive testing<br>', '<b>A is correct</b>, per syllabus. <br>B and C are not testingtechniques. 
<br>D is not possible unless the code is trivial and is not an experience-based technique. Keyword 1', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #20', 'Which of the following test techniques uses the requirements specifications as a test basis?<br>
a. Structure-based<br>b. Black-box<br>c. White-box<br>d. Exploratory<br>','

20 B B is correct, per syllabus. Black-box testing is based off the requirements documents. A and C 
are incorrect because these use the structure of the software as the test basis. D is incorrect 
because exploratory testing is often done when FL-4.1.1 1 4 
Question Answer Rationale Learning Objective (LO) Number of Points  
there is no specification, thus giving the tester the opportunity to learn about the software while testing. ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #21', 'How is statement coverage determined?<br>
a. Number of test decision points divided by the number of test cases<br>
b. Number of decision outcomes tested divided by the total number of executable statements<br>
c. Number of possible test case outcomes divided by the total number of function points<br>
d. Number of executable statements tested divided by the total number of executable statements<br>',
'<b>D is correct</b>, per syllabus. <br>A, B and C are not valid measures. FL-4.3.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #22', 'If you have a section of code that has one simple IF statement, how many tests will be needed to
achieve 100% decision coverage?<br>a. 1<br>b. 2<br>c. 5<br>d. Unknown with this information<br>', 
'<b>B is correct.</b> A simple IF statement will be composed of If ... then ... else.... end if. There 
are two decision outcomes, one for the result of the If being true and one for it being false. Since 
100% decision coverage requires at least one test case for each decision outcome, two tests 
are needed. A and C are incorrect because these are the wrong numbers of tests. D would 
be correct if this weren’t defined as a simple if statement because a complex if statement could 
include more than two outcomes. FL-4.3.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #23', 'What is error guessing?<br>
a. A testing technique used to guess where a developer is likely to have made a mistake<br>
b. A technique used for assessing defect metrics<br>
c. A development technique to verify that all error paths have been coded<br>
d. A planning technique used to anticipate likely schedule variances due to faults<br>',
'<b>A is correct.</b> Error guessing is a technique used to anticipate where developers are likely to make 
errors and to create tests to cover those areas. B, C and D are not correct. FL-4.4.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #24', 'When exploratory testing is conducted using time-boxing and test charters, what is it called?
a. Schedule-based testing<br>b. Session-based testing<br>c. Risk-based testing<br>d. Formal chartering<br>',
'<b>B is correct.</b> This is often called session-based testing and may use session sheets. A is not 
correct. Exploratory doesn’t usually comply to schedules but rather allows the tester to explore 
and learn about the software. Coverage is difficult to assess which is one of the reasons it is 
difficult to match the time spent to the amount accomplished. C is not correct. This may be one 
of the forms of risk-based testing, but it is not entirely RBT. D is not correct as this is not 
actually a testing term. FL-4.4.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #25', 'You are testing a scale system that determines shipping rates for a regional web-based auto parts
distributor. You want to group your test conditions to minimize the testing.
Identify how many equivalence classes are necessary for the following range. Weights are rounded to
the nearest pound.<br>
Weight&nbsp&nbsp&nbsp&nbspShipping Cost<br>&nbsp1 to 10 lbs.&nbsp&nbsp $5.00<br>11 to 25 lbs.&nbsp&nbsp $7.50<br>
26 to 50 lbs.&nbsp&nbsp$12.00<br>51 lbs. and up&nbsp&nbsp$17.00<br>a. 8<br>b. 6<br>c. 5<br>d. 4<br>',
'<b>C is correct.</b> You need a partition for each of the 4 classes and one for a zero or negative weight.
FL-4.2.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #26', 'You are testing a scale system that determines shipping rates for a regional web-based auto parts
distributor. Due to regulations, shipments cannot exceed 100 lbs. You want to include boundary value
analysis as part of your black-box test design.<br>
How many tests will you need to execute to achieve 100% two-value boundary value analysis?
Weight Shipping Cost<br>0 to 10 lbs. $5.00 <br>11 to 25 lbs. $7.50 <br>26 to 50 lbs. $12.00 <br>
51 lbs. to 100 $17.00<br>a. 4<br>b. 8<br>c. 10<br>d. 12<br>', '<b>C is correct.</b> 2 per valid weight range plus one for
a negative weight and one for a weight exceeding 100 lbs (-1, 0, 10, 11, 25, 26, 50, 51, 100, 101). FL-4.2.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #27', 'Which of the following is the correct decision table for the following pseudocode for ordering a
hamburger? Note: if you add or delete items from the basic burger, you no longer get the basic burger.<br>
Start<br>Select basic burger<br>If customer adds items<br>While items to be added<br>
Ask customer which item<br>Add item<br>End while<br>Endif<br>If customer deletes items<br>While items to be deleted<br>
Ask customer which item<br>Delete item<br>End while<br>Endif<br>If customer wants fries<br>Add fries to order<br>
Endif<br>Complete order<br>End<br>a.<br>Test # 1 2 3 4 5 6<br>Conditions<br>Add items Y Y N N N N<br>Delete items N N Y Y N N<br>
Add fries Y N Y N Y N<br>Results<br>Basic burger Y Y N N Y Y<br>Burger –<br>items<br>N N Y Y N N<br>Added items Y Y N N N N<br>
Fries N N Y N Y N<br>b.<br>Test # 1 2 3 4 5 6 7 8<br>Conditions<br>Add items Y Y Y Y N N N N<br>Delete items Y Y N N Y Y N N<br>
Add fries Y N Y N Y N Y N<br>Results<br>Basic burger N N N N N N Y Y<br>Deleted items Y Y N N Y Y N N<br>Added items Y Y Y Y N N N N<br>
Fries Y N Y N Y N Y N<br>c.<br>Test # 1 2 3 4 5 6 7 8<br>Conditions<br>Add items Y Y Y Y N N N N<br>Delete items N N N N Y Y Y Y<br>
Add fries Y N Y N Y N Y N<br>Results<br>Basic burger Y Y Y Y N N N N<br>Burger –<br>items<br>N N N N Y Y Y Y<br>
Added items Y Y Y Y N N N N<br>Fries Y N Y N Y N Y N<br>d.<br>Test # 1 2 3 4 5 6 7 8<br>Conditions<br>
Add items Y Y Y Y N N N N<br>Delete items Y Y N N Y Y N N<br>Add fries Y N Y N Y N Y N<br>Results<br>
Basic burger Y Y Y Y N N Y Y<br>Burger –<br>items<br>N N N N Y Y N N<br>Added items Y Y Y Y N N N N<br>
Fries Y N Y N Y N Y N<br>', '<b>B is correct.</b> <br>A is not correct because it assumes
you can’t add and delete items from a burger. <br>C is not correct because it makes the same
assumption as A and has duplicate tests. <br>D is not correct because the Results are wrong for
the first four tests. FL-4.2.3 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #28', 'You are testing an e-commerce transaction that has the following states and transitions:<br>
1. Login (invalid) > Login<br>2. Login > Search<br>3. Search > Search<br>4. Search > Shopping Cart<br>
5. Shopping Cart > Search<br>6. Shopping Cart > Checkout<br>7. Checkout > Search<br>8. Checkout > Logout<br>
For a state transition diagram, how many transitions should be shown?<br>a. 4<br>b. 6<br>c. 8<br>d. 16<br>',
'<b>C is correct.</b> There are 8 transitions that should be shown in the state transition diagram as 
explained in the question. A is not correct as this is only checking one transition from each state. B 
is not correct because this is probably excluding login > login and search > search. D is not 
correct because it is checking the invalid FL-4.2.4 1 5 <br>
Question Answer Rationale Learning Objective (LO) Number of Points <br>
transitions as well and those would be included in a state table, not a state transition diagram. <br>
These are:<br>1. Login (invalid) > Login<br>2. Login > Search<br>3. Login > Shopping Cart (invalid transition)<br>
4. Login > Checkout (invalid transition)<br>5. Search > Login (invalid transition)<br>6. Search > Search<br>
7. Search > Shopping Cart<br>8. Search > Checkout (invalid transition)<br>9. Shopping Cart > Login (invalid transition)<br>
10.Shopping Cart > Search<br>11.Shopping Cart > Shopping Cart (invalid transition)<br>12.Shopping Cart > Checkout<br>
13.Checkout > Login (invalid transition)<br>14.Checkout > Search<br>15.Checkout > Shopping Cart (invalid transition)<br>
16.Checkout > Logout', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #29', 'You are testing a banking application that allows a customer to withdraw 20, 100 or 500 dollars in a
single transaction. The values are chosen from a drop-down list and no other values may be entered.
How many equivalence partitions need to be tested to achieve 100% equivalence partition coverage?<br>
a. 1<br>b. 2<br>c. 3<br>d. 4<br>', '<b>D is correct.</b> The values to be tested are 20, 100, 500 and no selection. FL-4.2.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #30', 'Level of risk is determined by which of the following?<br>
a. Likelihood and impact<br>b. Priority and risk rating<br>c. Probability and practicality<br>d. Risk identification and mitigation<br>
','<b>A is correct.</b> The combination of likelihood and impact is normally used to determine the overall
risk level (sometimes called the risk priority number). FL-5.5.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #31', 'Who normally writes the test plan for a project?<br>a. The project manager<br>b. The product owner<br>
c. The test manager<br>d. The tester<br>', '<b>C is correct.</b> Writing and updating the test plan is normally the responsibility of the test manager.
A, B and D may contribute to the test plan, but the overall responsibility belongs to the test manager.
FL-5.1.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #32', 'What is the biggest problem with a developer testing his own code?<br>
a. Developers are not good testers<br>b. Developers are not quality focused<br>c. Developers are not objective about their own code<br>
d. Developers do not have time to test their own code<br>','<b>C is correct.</b> This is the biggest problem. A and B
are not necessarily true – some developers are good testers and have a good quality focus. D is 
not correct because unit testing is part of their job and time should be made in the schedule for 
at least unit testing. FL-5.1.1 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #33', 'Which of the following is a project risk?<br>
a. A defect that is causing a performance issue<br>b. A duplicate requirement<br>
c. An issue with a data conversion procedure<br>d. A schedule that requires work during Christmas shutdown<br>',
'<b>D is correct</b>, this is a risk to the entire project. <br>A, B and C are product risks. FL-5.5.2 1 ', 'ISS.png', 0, now());
INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #34', 'If your test strategy is based off the list of the ISO 25010 quality characteristics, what type of strategy is
it?<br>a. Regulatory<br>b. Analytical<br>c. Methodical<br>
d. Reactive<br>','Missing Answer', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #35', 'If the developers are releasing code for testing that is not version controlled, what process is missing?<br>
a. Configuration management<br>b. Debugging<br>c. Test and defect management<br>d. Risk analysis<br>', 'Missing Answer', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #36', 'You are getting ready to test another upgrade of an ERP system. The previous upgrade was tested by
your team and has been in production for several years. For this situation, which of the following is the
most appropriate test effort estimation technique?<br>
a. Effort-based<br>b. Expert-based<br>c. Metric-based<br>d. Schedule-based<br>', '<b>C is correct.</b> In this case, you should have
access to the effort that was required on the previous version of the ERP system and you 
should be able to use that information to predict the effort for this release. A and D are not correct 
because these are not estimation techniques. B is not correct because it’s better to use internal 
metrics. FL-5.2.6 1 ', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #37', 'You have been testing software that will be used to track credit card purchases. You have found a
defect that causes the system to crash, but only if a person has made and voided 10 purchases in a
row. What is the proper priority and severity rating for this defect?<br>
a. Priority high, severity high<br>b. Priority high, severity low<br>
c. Priority low, severity low<br>d. Priority low, severity high<br>', 
'<b>D is correct.</b> This is not likely to happen, so the urgency to fix it is low but it does crash the 
system so the impact to the system is high so the severity should be high. FL-5.6.1 1 ', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #38', 'Consider the following test cases that are used to test an accounting system:<br>
Test ID Name Dependency Priority<br>1 Purchase Item none 2<br>2 Receive Invoice Test 1 3<br>3 Receive Goods Test 1 2<br>
4 Send Payment Test 2 3<br>5 Report Payments Test 4 1<br>
Given this information, what is the proper order in which to execute these test cases?<br>
a. 5, 1, 3, 2, 4<br>b. 1, 2, 4, 5, 3<br>c. 1, 3, 2, 4, 5<br>d. 3, 4, 5, 1, 2<br>', 
'<b>B is correct.</b> The goal is to run the highest priority tests as soon as possible. Dependency has to be 
considered in order for the tests to actually be executed. In order to get the highest priority test 
run as soon as possible, the correct order is as follows: test 1 has to go first since everything 
else is dependent on it. Then we need to do 2 so we can do 4 and 5 (the highest priority test) and 
then 3 is last because 5 is not dependent on it. <br>A is not correct because 5 cannot be run first. <br>C is 
not correct because it does not run 5 as soon as possible; it defers it until after 3 is run. <br>D is not 
correct because 3 can’t be run first as it requires 1 and 2. FL-5.2.4 1 ', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #39', 'Which of the following are major objectives of a pilot project for a tool introduction?<br>
a. Roll out, adapt, train, implement<br>b. Monitor, support, revise, implement<br>c. Learn, evaluate, decide, assess<br>
d. Evaluate, adapt, monitor, support<br>', '<b>C is correct.</b> Learn more about the tool, evaluate
the fit in the organization, decide on standard usage and assess benefits to be achieved are all
objectives for a pilot project. FL-6.2.2 1 ', 'ISS.png', 0, now());

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #40', 'What is the primary purpose of a test execution tool?<br>
a. It runs automated test scripts to test the test object<br>b. It automatically records defects in the defect tracking system<br>
c. It analyzes code to determine if there are any coding standard violations<br>d. It tracks test cases, defects and requirements traceability<br>',
'<b>A is correct.</b> This is the primary purpose of the test execution tools. B may be something the tool 
can do, but this is not the primary purpose. C is a static analysis tool and D is a test management tool. 
FL-6.1.3 1 ', 'ISS.png', 0, now());











