/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Agumon','2020-02-03','0','True','10.23'),
('Gabumon','2018-11-15','2','True','8.00'),
('Pikachu','2021-01-07','1','False','15.04'),
('Devimon','2017-05-12','5','True','11.00');

-- Insert extra data
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Charmander','2020-02-08','0','False','-11.00'),
('Plantmon','2021-11-15','2','True','-5.70'),
('Squirtle','1993-04-02','3','False','-12.13'),
('Angemon','2005-06-12','1','True','-45.00'),
('Boarmon','2005-06-07','7','True','20.40'),
('Blossom','1998-10-13','3','True','17.00'),
('Ditto','2022-05-14','4','True','22.00');

-- EXTRA INSERT IN OWNERS TABLE

INSERT INTO owners (full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob',45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

SELECT * FROM owners

-- INSERT DATE FOR SPECIES TABLE

SELECT * FROM species

INSERT INTO species(name) VALUES
('Pokemon'),
('Digimon');


--  To modify the animals with species_id

BEGIN;

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon%';

SELECT * FROM animals

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE name NOT LIKE '%mon%';

SELECT * FROM animals

COMMIT;

--  Modify animals table with owner_id

BEGIN;

SELECT * FROM animals

SELECT * FROM owners

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

SELECT * FROM owners

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

SELECT * FROM animals

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

SELECT * FROM owners

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon' OR name = 'Boarmon';

SELECT * FROM animals

COMMIT;

-- Insert the data for vets

INSERT INTO vets(name, age, date_of_graduation) VALUES
('William Tatcher', 45,'2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

SELECT * FROM vets

-- Insert data for specialties

INSERT INTO specializations VALUES
(1, 1),
(2, 3),
(1, 3),
(2, 4);

-- Insert data for visits

SELECT * FROM animals
SELECT * FROM vets

INSERT INTO visits VALUES
(1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),
(6, 1, '2020-08-10'),
(6, 2, '2021-04-07'),
(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-11-04'),
(9, 2, '2019-01-24'),
(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),
(9, 2, '2020-09-03'),
(10, 3, '2020-05-24'),
(10, 1, '2021-01-11');

SELECT * FROM visits



-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visits) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';