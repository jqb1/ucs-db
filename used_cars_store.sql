USE used_cars_store;
CREATE TABLE car(id smallint not null auto_increment,
brand varchar(20) not null,
model varchar(30) not null,
mileage int unsigned not null,
production_year date not null,
price float not null,
primary key(id));

CREATE TABLE person(id smallint not null auto_increment,
name varchar(30) not null,
surname varchar(30) not null,
email varchar(50) not null,
phone_number int(9) not null,
primary key(id));


CREATE TABLE card(id smallint not null auto_increment,
number int,
expenses int,
primary key(id));



CREATE TABLE account(id smallint not null auto_increment,
person_id smallint not null,
card_id smallint not null,
username varchar(30) not null unique,
password varchar(30) not null,
creation_date datetime not null,
last_visit datetime,
check(password>=8),
primary key(id),
foreign key(id) references person(id),
foreign key(id) references card(id)
);

CREATE TABLE transaction(id smallint not null auto_increment,
account_id smallint,
car_id smallint not null,
execution_date date not null,
primary key(id),
foreign key(id) references account(id),
foreign key(id) references car(id));
