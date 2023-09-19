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


/* PROJECT 4 */
-- Who was the last animal seen by William Tatcher?
SELECT animals.name AS last_animal, animal_id, vets.name AS vet_name,  vet_id, date_of_visit
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
WHERE date_of_visit = (
  SELECT MAX(date_of_visit)
  FROM visits
  WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
);

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) FROM (
  SELECT DISTINCT animal_id
  FROM visits
  WHERE vet_id = (
    SELECT id 
    FROM vets 
    WHERE name = 'Maisy Smith'
  )
);

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.id AS vet_id, vets.name AS vet_name, specializations.species_id, species.name AS species_name
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animal_id, animals.name AS animal_name, date_of_visit
FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
WHERE (vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')) AND (date_of_visit BETWEEN '2020-04-01' AND '2020-08-30');

-- What animal has the most visits to vets?
SELECT animals.name, animal_id, visits_count
FROM animals
INNER JOIN (
  SELECT animal_id, COUNT(animal_id) AS visits_count
  FROM visits
  GROUP BY animal_id
)
ON animals.id = animal_id
ORDER BY visits_count DESC;

--or
SELECT animals.name, animal_id, visits_count
FROM animals
INNER JOIN (
  SELECT animal_id, COUNT(animal_id) AS visits_count
  FROM visits
  GROUP BY animal_id
)
ON animals.id = animal_id
WHERE visits_count = (SELECT MAX(visits_count) FROM (
  SELECT animal_id, COUNT(animal_id) AS visits_count
  FROM visits
  GROUP BY animal_id
));

-- Who was Maisy Smith's first visit?
SELECT animal_id, animals.name AS animal_name, vet_id, vets.name AS vet_name, date_of_visit AS latest_visit
FROM visits
INNER JOIN animals
ON animals.id = animal_id
INNER JOIN vets
ON vets.id = vet_id
WHERE date_of_visit = (
  SELECT MIN(date_of_visit) AS latest_visit
  FROM visits
  WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
);

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animal_id, animals.name AS animal, animals.date_of_birth, animals.weight_kg, animals.escape_attempts, animals.neutered, species.name AS species, owners.full_name as owner, vet_id, vets.name AS vet_name, date_of_visit
FROM visits
INNER JOIN animals
ON animals.id = animal_id
INNER JOIN vets
ON vets.id = vet_id
INNER JOIN owners
ON owners.id = animals.owner_id
INNER JOIN species
ON species.id = animals.species_id
WHERE date_of_visit = (
  SELECT MAX(date_of_visit) AS latest_visit
  FROM visits
);

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT (*) FROM (
  SELECT animal_id, vet_id, animals.species_id AS species
  FROM visits
  INNER JOIN animals
  ON animals.id = visits.animal_id
  WHERE (animals.species_id != (
    SELECT specializations.species_id
    FROM vets
    LEFT JOIN specializations
    ON vets.id = specializations.vet_id
    WHERE specializations.vet_id = visits.vet_id AND specializations.vet_id != 3
  )) OR vet_id = 2
);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species_id, species_name, SUM(visits_count) AS sum
FROM (
  SELECT animals.species_id, species.name AS species_name, visits_count
  FROM animals
  INNER JOIN (
    SELECT animal_id, COUNT(animal_id) AS visits_count
    FROM visits
    WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
    GROUP BY animal_id
  )
  ON animals.id = animal_id
  INNER JOIN species
  ON species.id = species_id
)
GROUP BY species_id, species_name
ORDER BY sum DESC;
-- or
SELECT species_id, species.name AS species_name, sum AS species_visits_count
FROM species
INNER JOIN
(
  SELECT species_id, SUM(visits_count) AS sum
  FROM (
    SELECT animals.species_id, visits_count
    FROM animals
    INNER JOIN (
      SELECT animal_id, COUNT(animal_id) AS visits_count
      FROM visits
      WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
      GROUP BY animal_id
    )
    ON animals.id = animal_id
  )
  GROUP BY species_id
)
ON species.id = species_id
WHERE sum = (SELECT MAX(sum) FROM (
  SELECT species_id, SUM(visits_count) AS sum
  FROM (
    SELECT animals.species_id, visits_count
    FROM animals
    INNER JOIN (
      SELECT animal_id, COUNT(animal_id) AS visits_count
      FROM visits
      WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
      GROUP BY animal_id
    )
    ON animals.id = animal_id
  )
  GROUP BY species_id
));
