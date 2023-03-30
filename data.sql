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