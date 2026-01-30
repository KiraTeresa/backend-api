DROP DATABASE IF EXISTS books;
CREATE DATABASE books;
use books;

DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS translators;
DROP TABLE IF EXISTS publishers;

CREATE TABLE publishers
(
	id             int          not null auto_increment,
	publisher_name varchar(128) not null,
	city           varchar(128) not null,
	country        varchar(128) not null,
	primary key (id)
);

CREATE TABLE authors
(
	id         int          not null auto_increment,
	first_name varchar(128) not null,
	last_name  varchar(128) not null,
	country    varchar(128) not null,
	primary key (id)
);

CREATE TABLE translators
(
	id         int          not null auto_increment,
	first_name varchar(128) not null,
	last_name  varchar(128) not null,
	primary key (id)
);

CREATE TABLE books
(
	id              int          not null auto_increment,
	title           varchar(255) not null,
	subTitle        varchar(255),
	author_id       int, -- for now only one author per book
	translator_id   int, -- for now only one translator per book
	publisher_id    int,
	first_published date,
	pages           int          not null,
	genre           varchar(128) not null,
	language        varchar(128) not null,
	isbn            varchar(20)  not null,
	primary key (id),
	foreign key (publisher_id) references publishers (id),
	foreign key (author_id) references authors (id),
	foreign key (translator_id) references translators (id)
);


INSERT INTO publishers (publisher_name, city, country)
VALUES ('Insel Verlag', 'Berlin', 'Germany'),
	   ('Suhrkamp Verlag GmbH', 'Berlin', 'Germany'),
	   ('DuMont Buchverlag GmbH', 'Köln', 'Germany'),
	   ('C.H.Beck GmbH & Co. KG', 'München', 'Germany'),
	   ('Piper Verlag', 'München', 'Germany'),
	   ('Hanser Berlin', 'Berlin', 'Germany'),
	   ('Kiepenheuer & Witsch', 'Köln', 'Germany'),
	   ('Zsolnay', 'Wien', 'Austria');

INSERT INTO authors(first_name, last_name, country)
VALUES ('Jocelyne', 'Saucier', 'Canada'),
	   ('Benjamin', 'Myers', 'United Kingdom'),
	   ('Timon Karl', 'Kaleyta', 'Germany'),
	   ('Tijan', 'Sila', 'Germany'),
	   ('Laurie', 'Forest', 'United States'),
	   ('Gaea', 'Schoeters', 'Belgium'),
	   ('Liz', 'Moore', 'United States');

INSERT INTO translators(first_name, last_name)
VALUES ('Sonja', 'Finck'),
	   ('Frank', 'Weigand'),
	   ('Ulrike', 'Wasel'),
	   ('Klaus', 'Timmermann'),
	   ('Cornelius', 'Hartz'),
	   ('Freya', 'Rall'),
	   ('Lisa', 'Mensing');

INSERT INTO books
(title,
 subTitle,
 author_id,
 translator_id,
 publisher_id,
 first_published,
 pages,
 genre,
 language,
 isbn)
VALUES

-- Jocelyne Saucier
('Ein Leben mehr',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Jocelyne' AND last_name = 'Saucier'),
 (SELECT id FROM translators WHERE first_name = 'Sonja' AND last_name = 'Finck'),
 (SELECT id FROM publishers WHERE publisher_name = 'Insel Verlag'),
 '2017-03-06',
 192,
 'Roman',
 'Deutsch',
 '9783458361893'),

('Niemals ohne sie',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Jocelyne' AND last_name = 'Saucier'),
 (SELECT id FROM translators WHERE first_name = 'Sonja' AND last_name = 'Finck'),
 (SELECT id FROM publishers WHERE publisher_name = 'Insel Verlag'),
 '2020-05-17',
 255,
 'Roman',
 'Deutsch',
 '9783458364801'),

('Was dir bleibt',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Jocelyne' AND last_name = 'Saucier'),
 (SELECT id FROM translators WHERE first_name = 'Sonja' AND last_name = 'Finck'),
 (SELECT id FROM publishers WHERE publisher_name = 'Insel Verlag'),
 '2021-10-10',
 255,
 'Roman',
 'Deutsch',
 '9783458681762'),

-- Benjamin Myers
('Offene See',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Benjamin' AND last_name = 'Myers'),
 (SELECT id FROM translators WHERE first_name = 'Ulrike' AND last_name = 'Wasel'),
 (SELECT id FROM publishers WHERE publisher_name = 'DuMont Buchverlag GmbH'),
 '2020-03-20',
 270,
 'Roman',
 'Deutsch',
 '9783832181192'),

('Der längste, strahlendste Tag',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Benjamin' AND last_name = 'Myers'),
 (SELECT id FROM translators WHERE first_name = 'Ulrike' AND last_name = 'Wasel'),
 (SELECT id FROM publishers WHERE publisher_name = 'DuMont Buchverlag GmbH'),
 '2023-10-12',
 272,
 'Erzählungen',
 'Deutsch',
 '9783832181765'),

-- Timon Karl Kaleyta
('Die Geschichte eines einfachen Mannes',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Timon Karl' AND last_name = 'Kaleyta'),
 NULL,
 (SELECT id FROM publishers WHERE publisher_name = 'Piper Verlag'),
 '2021-04-01',
 320,
 'Roman',
 'Deutsch',
 '9783492070461'),

('Heilung',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Timon Karl' AND last_name = 'Kaleyta'),
 NULL,
 (SELECT id FROM publishers WHERE publisher_name = 'Piper Verlag'),
 '2021-04-01',
 207,
 'Roman',
 'Deutsch',
 '9783492071710'),

-- Tijan Sila
('Radio Sarajevo',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Tijan' AND last_name = 'Sila'),
 NULL,
 (SELECT id FROM publishers WHERE publisher_name = 'Hanser Berlin'),
 '2023-08-21',
 176,
 'Roman',
 'Deutsch',
 '9783446277267'),

('Krach',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Tijan' AND last_name = 'Sila'),
 NULL,
 (SELECT id FROM publishers WHERE publisher_name = 'Kiepenheuer & Witsch'),
 '2021-05-06',
 272,
 'Roman',
 'Deutsch',
 '9783462053753'),

-- Gaea Schoeters
('Trophäe',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Gaea' AND last_name = 'Schoeters'),
 (SELECT id FROM translators WHERE first_name = 'Lisa' AND last_name = 'Mensing'),
 (SELECT id FROM publishers WHERE publisher_name = 'Zsolnay'),
 '2024-02-19',
 256,
 'Roman',
 'Deutsch',
 '9783552073883'),

-- Liz Moore
('Der Gott des Waldes',
 NULL,
 (SELECT id FROM authors WHERE first_name = 'Liz' AND last_name = 'Moore'),
 (SELECT id FROM translators WHERE first_name = 'Cornelius' AND last_name = 'Hartz'),
 (SELECT id FROM publishers WHERE publisher_name = 'C.H.Beck GmbH & Co. KG'),
 '2023-01-01',
 590,
 'Roman',
 'Deutsch',
 '9783406829772'),

-- Laurie Forest
('Black Witch',
 'Prophezeiung',
 (SELECT id FROM authors WHERE first_name = 'Laurie' AND last_name = 'Forest'),
 (SELECT id FROM translators WHERE first_name = 'Freya' AND last_name = 'Rall'),
 (SELECT id FROM publishers WHERE publisher_name = 'Foliant Verlag'),
 '2024-03-26',
 600,
 'YA Fantasy',
 'Deutsch',
 '9783910522411'),

('Black Witch',
 'Erkenntnis',
 (SELECT id FROM authors WHERE first_name = 'Laurie' AND last_name = 'Forest'),
 (SELECT id FROM translators WHERE first_name = 'Freya' AND last_name = 'Rall'),
 (SELECT id FROM publishers WHERE publisher_name = 'Foliant Verlag'),
 '2024-04-30',
 607,
 'YA Fantasy',
 'Deutsch',
 '9783910522428'),

('Black Witch',
 'Rebellion',
 (SELECT id FROM authors WHERE first_name = 'Laurie' AND last_name = 'Forest'),
 (SELECT id FROM translators WHERE first_name = 'Freya' AND last_name = 'Rall'),
 (SELECT id FROM publishers WHERE publisher_name = 'Foliant Verlag'),
 '2024-10-15',
 640,
 'YA Fantasy',
 'Deutsch',
 '9783910522435'),

('Black Witch',
 'Enthüllung',
 (SELECT id FROM authors WHERE first_name = 'Laurie' AND last_name = 'Forest'),
 (SELECT id FROM translators WHERE first_name = 'Freya' AND last_name = 'Rall'),
 (SELECT id FROM publishers WHERE publisher_name = 'Foliant Verlag'),
 '2025-07-15',
 696,
 'YA Fantasy',
 'Deutsch',
 '9783910522442');
