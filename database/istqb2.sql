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

INSERT INTO cards (user_id, card_title, question, answer, image_name, views, card_date)VALUES
(1, 'Question #1', 'What is the test basis?',
'<b>The body of knowledge used for test analysis and design</b> Per the glossary, the test basis is “a
source to determine expected results to compare with the actual result of the system under test”.', 'ISS.png', 0, now());











