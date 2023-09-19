/*Queries that provide answers to the questions from all projects.*/

/* PROJECT 1 */
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE (neutered = true) AND (escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


/* PROJECT 2 */
-- begin the transaction
BEGIN;
-- set the species column to unspecified
UPDATE animals 
SET species = 'unspecified';
-- verify
SELECT name, species
FROM animals;
-- roll back the transaction
ROLLBACK;
-- verify
SELECT name, species
FROM animals;


-- begin the transaction
BEGIN;
-- set the species column
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals 
SET species = 'pokemon'
WHERE species IS NULL;
-- verify that changes were made
SELECT name, species
FROM animals;
-- commit transaction
COMMIT;
-- verify that changes persist
SELECT name, species
FROM animals;


-- begin the transaction
BEGIN;
-- set the species column
DELETE FROM animals;
-- or
TRUNCATE TABLE animals;
-- verify that rows were deleted
SELECT * FROM animals;
--or
SELECT COUNT(*) FROM animals;
-- roll back the transaction
ROLLBACK;
-- verify that all records exist
SELECT * FROM animals;


-- begin the transaction
BEGIN;
-- delete rows
DELETE FROM animals 
WHERE date_of_birth > '2022-01-01';
-- set savepoint
SAVEPOINT SP1;
-- update weights (attempt #1)
UPDATE animals 
SET weight_kg = weight_kg * (-1);
-- roll back the SP1
ROLLBACK TO SP1;
-- update weights (attempt #2)
UPDATE animals 
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
-- verify that changes were made
SELECT name, weight_kg
FROM animals;
-- commit transaction
COMMIT;
-- verify that changes persist
SELECT name, weight_kg
FROM animals;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts)
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


/* PROJECT 3 */
-- What animals belong to Melody Pond?
SELECT owners.full_name AS owner, animals.name AS "animal name"
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT species.name AS species, animals.name AS "animal name"
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal
SELECT owners.full_name AS owner, animals.name AS "animal name"
FROM animals
RIGHT JOIN owners
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species, COUNT(*) FROM
  (SELECT species.name AS species, animals.name
  FROM animals
  INNER JOIN species
  ON animals.species_id = species.id)
GROUP BY species;

-- List all Digimon owned by Jennifer Orwell
SELECT owners.full_name AS owner, animals.name AS "animal name", species.name AS species
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
INNER JOIN species
ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT owners.full_name AS owner, animals.name AS "animal name", animals.escape_attempts
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name, count FROM (
  SELECT full_name, COUNT(*)
  FROM animals
  INNER JOIN owners
  ON animals.owner_id = owners.id
  GROUP BY full_name
)
WHERE count = (SELECT MAX(count) FROM (
  SELECT full_name, COUNT(*)
  FROM animals
  INNER JOIN owners
  ON animals.owner_id = owners.id
  GROUP BY full_name
));
--or
SELECT full_name, count FROM (
  SELECT full_name, COUNT(*)
  FROM animals
  INNER JOIN owners
  ON animals.owner_id = owners.id
  GROUP BY full_name
)
ORDER BY count DESC;
