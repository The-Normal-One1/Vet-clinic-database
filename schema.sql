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
