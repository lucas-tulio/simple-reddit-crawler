CREATE SCHEMA reddit DEAFULT CHARSET 'utf8' COLLATE 'utf8_general_ci';

CREATE TABLE subs (
id int primary key not null auto_increment,
name varchar(255) not null,
url varchar(255) not null
) engine=innodb;

INSERT INTO subs (name, url) values ('leagueoflegends', '/r/leagueoflegends');

CREATE TABLE threads (
id int primary key not null auto_increment,
id_thread varchar(16) not null unique key,
id_sub int not null,
title text not null,
url varchar(255) not null,
score int not null,
created int
) engine=innodb;

CREATE TABLE comments (
id int primary key not null auto_increment,
id_comment varchar(16) not null unique key,
id_thread int not null,
comment text not null,
url varchar(255) not null,
score int not null,
created int
) engine=innodb;

CREATE TABLE logs (
id int primary key not null auto_increment,
startingTime timestamp not null,
endingTime timestamp not null,
newThreads int not null,
ignoredThreads int not null,
newComments int not null,
ignoredComments int not null
) engine=innodb;
