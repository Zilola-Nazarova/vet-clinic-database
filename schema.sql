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
