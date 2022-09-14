/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Agumon', 'Feb 3, 2020', 0, false, 10.23),
('Gabumon', 'Nov 15, 2018', 2, true, 8),
('Pikachu', 'Jan 7, 2021', 1, false, 14.04),
('Devimon', 'May 12, 2017', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Charmander', 'Feb 8, 2020', 0, false, -11),
    ('Plantmon','Nov 15, 2021', 2, true, -5.7),
    ('Squirtle',' Apr 2, 1993', 3, false, -12.13),
    ('Angemon',' Jun 12, 2005', 1, true, -45),
    ('Boarmon',' Jun 7, 2005', 7, true, 20.4),
    ('Blossom',' Oct 13, 1998', 3, true, 17),
    ('Ditto',' May 14, 2022', 4, true, 22);

INSERT INTO owners (full_name, age)
VALUES('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES('Pokemon'),('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

SELECT name FROM animals WHERE species_id IS NULL;

UPDATE animals SET owners_id = 1 WHERE name = 'Agumon';

UPDATE animals SET owners_id = 2 WHERE name = 'Pikachu' OR name = 'Gabumon';

UPDATE animals SET owners_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals SET owners_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

 UPDATE animals SET owners_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';