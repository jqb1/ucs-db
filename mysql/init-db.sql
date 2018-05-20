CREATE DATABASE 'used_cars_store';
USE used_cars_store;

CREATE TABLE car(id smallint not null auto_increment,
brand varchar(20) not null,
model varchar(30) not null,
mileage int unsigned not null,
year date not null,
price float not null,
img varchar(50) not null,
primary key(id));

CREATE TABLE person(id smallint not null auto_increment,
name varchar(30) not null,
surname varchar(30) not null,
email varchar(50) not null,
phone varchar(50) not null,
primary key(id));

CREATE TABLE card(id smallint not null auto_increment,
number varchar(50) not null unique,
balance float not null,
primary key(id));

CREATE TABLE account(id smallint not null auto_increment,
person_id smallint not null,
card_id smallint not null,
username varchar(30) not null unique,
password varchar(30) not null,
creation_date datetime not null,
last_visit datetime,
privilege enum('admin', 'user'),
check(password>=8),
primary key(id),
foreign key(person_id) references person(id),
foreign key(card_id) references card(id));

CREATE TABLE transaction(id smallint not null auto_increment,
account_id smallint,
car_id smallint not null,
execution_date date not null,
primary key(id),
foreign key(account_id) references account(id),
foreign key(car_id) references car(id));

INSERT INTO `card` (`id`, `number`, `balance`) VALUES (1, '4532360242456443', '2074');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (2, '342494545071061', '2233');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (3, '4024007145935', '2617');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (4, '4218664282117', '5512');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (5, '4539802219674', '9255');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (6, '5229082692414066', '4514');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (7, '4024007130398053', '4428');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (8, '4539384684546320', '3023');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (9, '4716906131456', '3964');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (10, '5279757380892500', '7593');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (11, '4556321002299', '4788');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (12, '4024007146420661', '8088');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (13, '4893733088927', '1709');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (14, '5559257888991478', '1274');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (15, '4532883732831', '3375');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (16, '5408152648315670', '9229');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (17, '4716595948582809', '7075');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (18, '4929817099854', '9863');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (19, '5335593475919417', '3415');
INSERT INTO `card` (`id`, `number`, `balance`) VALUES (20, '6011067501588633', '2313');

INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (1, 'Brandt', 'Macejkovic', 'dana.will@example.net', '(186)251-6194x86193');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (2, 'Bertrand', 'Zboncak', 'davon33@example.org', '01169213441');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (3, 'Elian', 'Spinka', 'carlie52@example.org', '+93(2)3473994714');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (4, 'Joana', 'Shields', 'madilyn.cartwright@example.com', '200-452-6566');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (5, 'Natalie', 'Stoltenberg', 'jewell34@example.com', '1-187-709-1517x265');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (6, 'Kristin', 'Quigley', 'schulist.cheyenne@example.org', '+69(2)4230567722');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (7, 'Leonor', 'Mitchell', 'ljacobi@example.org', '(356)046-3703');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (8, 'Brittany', 'Kihn', 'easter.lowe@example.net', '934-960-0600');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (9, 'Else', 'Kuhn', 'lysanne.ryan@example.net', '+38(8)6204579465');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (10, 'Hoyt', 'Schultz', 'norwood76@example.com', '1-972-929-7642');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (11, 'Darion', 'Sanford', 'vicente43@example.net', '+62(4)1011897053');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (12, 'Savion', 'Feeney', 'savion.huel@example.com', '03187765338');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (13, 'Joyce', 'Rosenbaum', 'kathlyn39@example.com', '443-048-6512x300');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (14, 'London', 'Waelchi', 'lowell70@example.com', '(347)088-2853x17018');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (15, 'Ashly', 'Greenholt', 'muriel.hane@example.com', '477-569-6312x5478');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (16, 'Brad', 'Olson', 'sigrid89@example.net', '541-327-4515x49085');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (17, 'Adalberto', 'Adams', 'burnice.sauer@example.com', '(265)717-7182x06701');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (18, 'Kari', 'Smith', 'hahn.yolanda@example.org', '+92(3)6004195909');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (19, 'Mafalda', 'Trantow', 'otho.rice@example.net', '227.008.6497x355');
INSERT INTO `person` (`id`, `name`, `surname`, `email`, `phone`) VALUES (20, 'Leta', 'Bechtelar', 'blanda.luciano@example.org', '(858)063-1604x0058');

INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (1, 3, 3, 'yhansen', 'sit', '1979-11-14 13:02:06', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (2, 5, 15, 'theodore83', 'porro', '1997-05-17 14:29:34', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (3, 2, 1, 'schroeder.sonia', 'mollitia', '2016-03-31 11:42:50', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (4, 7, 3, 'ignatius.wuckert', 'error', '2016-06-06 14:37:26', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (5, 13, 8, 'schinner.eddie', 'suscipit', '1975-02-11 15:09:10', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (6, 16, 11, 'liliana72', 'aliquam', '2013-03-09 18:39:34', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (7, 17, 11, 'zledner', 'eos', '1989-09-14 17:54:24', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (8, 6, 17, 'mcclure.derrick', 'aut', '2013-12-31 21:31:39', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (9, 13, 14, 'trevion.veum', 'qui', '2009-01-03 01:13:37', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (10, 20, 14, 'sawayn.tessie', 'aut', '2004-01-25 02:37:09', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (11, 16, 8, 'neha26', 'consequatur', '1996-01-06 23:52:10', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (12, 11, 5, 'wade82', 'error', '1970-03-28 01:45:17', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (13, 3, 7, 'eldred.walsh', 'minima', '1972-08-30 03:17:35', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (14, 12, 1, 'zkreiger', 'ea', '1972-11-17 20:44:10', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (15, 11, 19, 'uschumm', 'et', '2007-12-30 10:01:22', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (16, 13, 18, 'syble10', 'commodi', '1991-07-08 13:11:49', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (17, 20, 16, 'jennie.schneider', 'sit', '2006-05-10 00:20:37', NULL, 'user');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (18, 20, 7, 'smitham.rasheed', 'magni', '2000-10-11 21:49:21', NULL, 'admin');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (19, 3, 15, 'christiansen.tristian', 'porro', '2007-02-14 04:23:33', NULL, 'admin');
INSERT INTO `account` (`id`, `person_id`, `card_id`, `username`, `password`, `creation_date`, `last_visit`, `privilege`) VALUES (20, 4, 6, 'guiseppe.wuckert', 'temporibus', '2001-03-19 06:52:21', NULL, 'admin');

