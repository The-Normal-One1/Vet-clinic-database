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


-- Transaction

SELECT * FROM animals

BEGIN;

UPDATE animals
SET species = 'unspecified';

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';

UPDATE animals 
SET species = 'pokemon'
WHERE name NOT LIKE '%mon%'; 

COMMIT;

SELECT * FROM animals WHERE species = 'digimon';
SELECT * FROM animals

BEGIN;

DELETE FROM animals;

ROLLBACK;

DELETE FROM animals
WHERE date_of_birth >= '2022-01-01';

SAVEPOINT SP1;

BEGIN;
UPDATE animals 
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * FROM animals
ROLLBACK TO SP1;
COMMIT;

