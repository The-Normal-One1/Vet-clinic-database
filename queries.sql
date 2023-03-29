/*Queries that provide answers to the questions from all projects.*/


SELECT * FROM animals

SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT (name) FROM animals WHERE name LIKE '%mon%';

SELECT (name), (date_of_birth) FROM animals WHERE date_of_birth BETWEEN '2016-01-01 00:00:00' AND '2019-12-31 12:00:00';

SELECT (name),(neutered),(escape_attempts) FROM animals WHERE neutered IS true AND escape_attempts < 3;

SELECT (date_of_birth) FROM animals WHERE name = 'Agumon' OR name ='Pikachu'; 

SELECT (name),(escape_attempts) FROM animals WHERE weight_kg < 10.5;

SELECT (name) FROM animals WHERE neutered IS true;

SELECT (name) FROM animals WHERE name NOT IN ('Gabumon');

SELECT (name) FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


