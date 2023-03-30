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

-- Write queries to get the answer

-- 1. Who was the last animal seen by William Tatcher?

SELECT v.name, a.name, vi.date_of_visits
FROM vets v 
JOIN visits vi ON vi.vets_id = v.id
JOIN animals a ON a.id = vi.animals_id
WHERE vets_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY vi.date_of_visits DESC LIMIT 1;

-- 2. How many different animals did Stephanie Mendez see?
SELECT v.name, COUNT(vi.animals_id)
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
WHERE v.id =  (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
GROUP BY v.name;

-- 3. List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.species_id
FROM vets v
LEFT JOIN specializations s ON v.id = s.vets_id
GROUP BY v.name,s.species_id;

-- 4. List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name, v.name, vi.date_of_visits
FROM visits vi 
JOIN vets v ON vi.vets_id = v.id
JOIN animals a ON vi.animals_id = a.id
WHERE v.id= (SELECT id FROM vets WHERE name = 'Stephanie Mendez') AND vi.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30'
GROUP BY a.name, v.name, vi.date_of_visits;

-- 5. What animal has the most visits to vets?

SELECT a.name, COUNT(vi.animals_id)
FROM visits vi
JOIN animals a ON vi.animals_id = a.id
GROUP BY a.name
ORDER BY COUNT(vi.animals_id) DESC LIMIT 1;

-- 6. Who was Maisy Smith's first visit?

SELECT a.name, vi.date_of_visits, v.name
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
JOIN animals a ON a.id = vi.animals_id
WHERE vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY vi.date_of_visits LIMIT 1;

-- 7. Details for most recent visit: animal information, vet information, and date of visit.

SELECT a.name, a.date_of_birth, a.escape_attempts, a.neutered, a.weight_kg,
o.full_name, o.age,
s.name,
v.name, v.age, v.date_of_graduation,
vi.date_of_visits
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
JOIN animals a ON a.id = vi.animals_id
JOIN owners o ON  o.id = a.owner_id
JOIN species s ON s.id = a.species_id
ORDER BY vi.date_of_visits DESC LIMIT 1;

-- 8. How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(vi.vets_id)
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
JOIN animals a ON vi.animals_id = a.id
JOIN specializations s ON vi.vets_id = s.species_id
JOIN species spe ON spe.id = a.species_id
WHERE a.species_id != s.species_id;

-- 9. What specialty should Maisy Smith consider getting? Look for the species she gets the most

SELECT a.name, COUNT(vi.animals_id), spe.name, v.name
FROM vets v
JOIN visits vi ON v.id = vi.vets_id
join animals a ON vi.animals_id = a.id
JOIN species spe ON a.species_id = spe.id
WHERE vi.vets_id =(SELECT id FROM vets WHERE name ='Maisy Smith')
GROUP BY vi.animals_id, a.name, spe.name, v.name
ORDER BY COUNT(vi.animals_id) DESC LIMIT 1;
