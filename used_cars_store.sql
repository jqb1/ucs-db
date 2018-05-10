USE used_cars_store;
CREATE TABLE car(car_id smallint not null auto_increment,
brand varchar(20) not null,
model varchar(30) not null,
mileage int unsigned not null,
production_year date not null,
price float not null,
primary key(car_id));

CREATE TABLE person(person_id smallint not null auto_increment,
name varchar(30) not null,
surname varchar(30) not null,
email varchar(50) not null,
phone_number int(9) not null,
primary key(person_id));


CREATE TABLE card(card_id smallint not null auto_increment,
number int,
expenses int,
primary key(card_id));



CREATE TABLE account(account_id smallint not null auto_increment,
person_id smallint not null,
card_id smallint not null,
username varchar(30) not null unique,
password varchar(30) not null,
creation_date datetime not null,
last_visit datetime,
check(password>=8),
primary key(account_id),
foreign key(person_id) references person(person_id),
foreign key(card_id) references card(card_id)
);

CREATE TABLE transaction(id smallint not null auto_increment,
account_id smallint,
car_id smallint not null,
execution_date date not null,
primary key(id),
foreign key(account_id) references account(account_id),
foreign key(car_id) references car(car_id));
