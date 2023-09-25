/* Database schema to keep the structure of entire database. */

/* PROJECT 1 */
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

/* PROJECT 2 */
ALTER TABLE animals
ADD species varchar(250);


/* PROJECT 3 */
-- create owners table
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250),
    age INT,
    PRIMARY KEY(id)
);
-- create species table
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY(id)
);
-- verify
\d
SELECT * FROM owners;
SELECT * FROM species;


-- relate animals table to owners and species tables
-- start transaction
SELECT id, name, species FROM animals;
BEGIN;
-- delete species column
ALTER TABLE animals
DROP COLUMN species;
-- add new columns
ALTER TABLE animals
ADD COLUMN species_id INT,
ADD COLUMN owner_id INT;
-- add fk_species constraint
ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id) 
REFERENCES species(id);
-- add fk_owner constraint
ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY(owner_id) 
REFERENCES owners(id);
-- verify
\d animals
SELECT id, name, species_id, owner_id FROM animals;
-- commit transaction
COMMIT;
-- verify
SELECT id, name, species_id, owner_id FROM animals;





/* PROJECT 4 */
-- create vets table
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);
-- create specializations join table
CREATE TABLE specializations(
    vet_id INT,
    species_id INT
);
-- create visits join table
CREATE TABLE visits(
    animal_id INT,
    vet_id INT,
    date_of_visit DATE
);

/* PROJECT 5 */
-- add column to owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- create indices to visits and owners tables on specific columns
CREATE INDEX visits_animal_id_asc ON visits(animal_id ASC);
CREATE INDEX visits_vet_id_asc ON visits(vet_id ASC);
CREATE INDEX owners_email_asc ON owners(email ASC);
