/* Populate database with sample data. */

/* PROJECT 1 */
INSERT INTO animals
(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Agumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8.00),
('Pikachu', '2021-01-07', 1, false, 15.04),
('Devimon', '2017-05-12', 5, true, 11.00);


/* PROJECT 2 */
INSERT INTO
animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
('Charmander', '2020-02-08', 0, false, -11.00),
('Plantmon', '2021-11-15', 2, true, -5.70),
('Squirtle', '1993-04-02', 3, false, -12.13),
('Angemon', '2005-06-12', 1, true, -45.00),
('Boarmon', '2005-06-07', 7, true, 20.40),
('Blossom', '1998-10-13', 3, true, 17.00),
('Ditto', '2022-05-14', 4, true, 22.00);


/* PROJECT 3 */
-- add rows to species table
INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');
-- add rows to owners table
INSERT INTO owners (full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);
--verify
SELECT * FROM owners;
SELECT * FROM species;


-- add species_id to animals table
BEGIN;

UPDATE animals 
SET species_id = (SELECT id from species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id = (SELECT id from species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

SELECT id, name, species_id FROM animals;

COMMIT;

SELECT id, name, species_id FROM animals;


-- add owner_id to animals table
BEGIN;

UPDATE animals 
SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals 
SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals 
SET owner_id = (SELECT id from owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals 
SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals 
SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

SELECT id, name, owner_id FROM animals;

COMMIT;

SELECT id, name, owner_id FROM animals;


/* PROJECT 4 */
-- insert the data for vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- insert the data for specializations
INSERT INTO specializations (vet_id, species_id)
VALUES (
  (SELECT id FROM vets where name = 'William Tatcher'),
  (SELECT id FROM species where name = 'Pokemon')
),
(
  (SELECT id FROM vets where name = 'Stephanie Mendez'),
  (SELECT id FROM species where name = 'Digimon')
),
(
  (SELECT id FROM vets where name = 'Stephanie Mendez'),
  (SELECT id FROM species where name = 'Pokemon')
),
(
  (SELECT id FROM vets where name = 'Jack Harkness'),
  (SELECT id FROM species where name = 'Digimon')
);

-- insert the data for visits
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES (
  (SELECT id FROM animals where name = 'Agumon'),
  (SELECT id FROM vets where name = 'William Tatcher'),
  '2020-05-24'
),
(
  (SELECT id FROM animals where name = 'Agumon'),
  (SELECT id FROM vets where name = 'Stephanie Mendez'),
  '2020-07-22'
),
(
  (SELECT id FROM animals where name = 'Gabumon'),
  (SELECT id FROM vets where name = 'Jack Harkness'),
  '2021-02-02'
),
(
  (SELECT id FROM animals where name = 'Pikachu'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2020-01-05'
),
(
  (SELECT id FROM animals where name = 'Pikachu'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2020-03-08'
),
(
  (SELECT id FROM animals where name = 'Pikachu'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2020-05-14'
),
(
  (SELECT id FROM animals where name = 'Devimon'),
  (SELECT id FROM vets where name = 'Stephanie Mendez'),
  '2021-05-04'
),
(
  (SELECT id FROM animals where name = 'Charmander'),
  (SELECT id FROM vets where name = 'Jack Harkness'),
  '2021-02-24'
),
(
  (SELECT id FROM animals where name = 'Plantmon'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2019-12-21'
),
(
  (SELECT id FROM animals where name = 'Plantmon'),
  (SELECT id FROM vets where name = 'William Tatcher'),
  '2020-08-10'
),
(
  (SELECT id FROM animals where name = 'Plantmon'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2021-04-07'
),
(
  (SELECT id FROM animals where name = 'Squirtle'),
  (SELECT id FROM vets where name = 'Stephanie Mendez'),
  '2019-09-29'
),
(
  (SELECT id FROM animals where name = 'Angemon'),
  (SELECT id FROM vets where name = 'Jack Harkness'),
  '2020-10-03'
),
(
  (SELECT id FROM animals where name = 'Angemon'),
  (SELECT id FROM vets where name = 'Jack Harkness'),
  '2020-11-04'
),
(
  (SELECT id FROM animals where name = 'Boarmon'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2019-01-24'
),
(
  (SELECT id FROM animals where name = 'Boarmon'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2019-05-15'
),
(
  (SELECT id FROM animals where name = 'Boarmon'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2020-02-27'
),
(
  (SELECT id FROM animals where name = 'Boarmon'),
  (SELECT id FROM vets where name = 'Maisy Smith'),
  '2020-08-03'
),
(
  (SELECT id FROM animals where name = 'Blossom'),
  (SELECT id FROM vets where name = 'Stephanie Mendez'),
  '2020-05-24'
),
(
  (SELECT id FROM animals where name = 'Blossom'),
  (SELECT id FROM vets where name = 'William Tatcher'),
  '2021-01-11'
);
