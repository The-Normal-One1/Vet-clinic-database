/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
 id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(100) NOT NULL,
date_of_birth DATE NULL,
escape_attempts INT NOT NULL,
neutered BOOLEAN NOT NULL,
weight_kg DECIMAL NOT NULL,
PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species TEXT;

--  ADDING OWNERS AND SPECIES TABELS

CREATE TABLE owners(
id INT GENERATED ALWAYS AS IDENTITY,
	full_name  VARCHAR(30),
	age INT,
	PRIMARY KEY(id)
);

SELECT * FROM owners

CREATE TABLE species(
id INT GENERATED ALWAYS AS IDENTITY,
	name  VARCHAR(30),
	PRIMARY KEY(id)
);

SELECT * FROM species

ALTER TABLE animals
DROP species;

SELECT * FROM animals

ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals
ADD FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

SELECT * FROM animals

ALTER TABLE animals
ADD owner_id INT;

SELECT * FROM animals

ALTER TABLE animals
ADD FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;

-- Create a table named vets 

CREATE TABLE vets(
id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	date_of_graduation DATE NOT NULL,
	PRIMARY KEY(id)
	
);

--  Create a "join table" called specializations

CREATE TABLE specializations(
species_id INT,
	vets_id INT
);

SELECT * FROM specializations

ALTER TABLE specializations
ADD FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE specializations
ADD FOREIGN KEY (vets_id)
REFERENCES vets(id)
ON DELETE CASCADE;

-- Create a "join table" called visits

CREATE TABLE visits(
animals_id INT,
	vets_id INT
);

ALTER TABLE visits
ADD FOREIGN KEY (animals_id)
REFERENCES animals(id)
ON DELETE CASCADE;

ALTER TABLE visits
ADD FOREIGN KEY (vets_id)
REFERENCES vets(id)
ON DELETE CASCADE;

ALTER TABLE visits
ADD date_of_visits DATE;


-- Add an email column to our owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- CREATE INDEXES TO IMPROVE THE PERFORMANCE
CREATE INDEX index_animals_id ON visits(animals_id);
CREATE INDEX index_vets_id ON visits(vets_id);
CREATE INDEX index_owners ON owners(email);