/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE (neutered = true) AND (escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


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
