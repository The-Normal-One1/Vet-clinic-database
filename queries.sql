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

BEGIN;
UPDATE animals 
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SAVEPOINT SP1;

SELECT * FROM animals
ROLLBACK TO SP1;
COMMIT;

-- Answer for the quary

SELECT * FROM animals

SELECT COUNT(*) FROM animals;

SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg),MAX(weight_kg) FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-30'
GROUP BY species;

-- What animals belong to Melody Pond?

SELECT name, full_name
FROM animals a
JOIN owners o ON o.id = a.owner_id 
WHERE full_name = 'Melody Pond'

-- List of all animals that are pokemon (their type is Pokemon).

SELECT * FROM species

SELECT a.name, s.name
FROM animals a
JOIN species s ON s.id = a.species_id 
WHERE s.name = 'Pokemon'

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT full_name, name
FROM owners o 
LEFT JOIN animals a ON o.id = a.owner_id 

-- How many animals are there per species?

SELECT COUNT(a.species_id), s.name
FROM animals a 
JOIN species s ON s.id = a.species_id 
GROUP BY s.name

-- List all Digimon owned by Jennifer Orwell.

SELECT a.name, s.name, full_name
FROM animals a 
JOIN species s ON s.id = a.species_id 
JOIN owners o ON o.id = a.owner_id
WHERE full_name =  'Jennifer Orwell' AND s.name = 'Digimon'

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT a.name, a.escape_attempts, full_name
FROM animals a 
JOIN owners o ON o.id = a.owner_id
WHERE full_name =  'Dean Winchester' AND escape_attempts = 0

-- Who owns the most animals?

SELECT COUNT(a.owner_id), full_name
FROM animals a 
JOIN owners o ON o.id = a.owner_id
GROUP BY full_name
ORDER BY COUNT(a.owner_id) DESC