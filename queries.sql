/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
select name from animals where neutered = 't' and escape_attempts < 3;
select date_of_birth from animals where name ='Agumon' or name = 'Pikachu';
select name, escape_attempts from animals where weight_kg > 10.5;
select * from animals where neutered = 't';
select * from animals where name != 'Gabumon';
select * from animals where weight_kg <= 10.4 or weight_kg >= 17.3;

/*working with TRANSACTIONS. */
BEGIN;
update animals set species = 'digimon' where name like '%mon';
update animals set species = 'pokemon' where species ='';
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals where date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg <0;
COMMIT;

/*Working with aggregate functions*/

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name AS ANIMALS, full_name AS OWNERS FROM animals JOIN owners ON owners_id = owners.id WHERE full_name ='Melody Pond';
SELECT animals.name, species.name FROM animals JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
SELECT full_name AS OWNERS, name as animals FROM animals FULL JOIN owners ON owners_id = owners.id;
SELECT species.name as species, COUNT(animals.name) FROM animals JOIN species ON species_id = species.id GROUP BY species.name;

SELECT full_name, animals.name, species.name FROM animals
JOIN owners ON owners_id = owners.id
JOIN species ON species_id = species.id
WHERE full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT name, full_name FROM animals JOIN owners ON owners_id = owners.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT full_name, COUNT(animals.name) FROM animals
JOIN owners ON owners_id = owners.id GROUP BY full_name 
HAVING COUNT (animals.name)=(SELECT MAX(mycount) 
FROM (SELECT full_name, COUNT(animals.name) mycount 
FROM animals JOIN owners ON owners_id = owners.id GROUP BY full_name)as m);