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

/* WORKING WITH JOINS TABLE */ 

SELECT animals.name FROM visits
JOIN animals ON visits.animal_id = animals.id
WHERE date_of_visit = (SELECT max(date_of_visit) FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Willian Tatcher');

SELECT SUM(count) FROM (SELECT COUNT(animals.name) FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez'
GROUP BY animals.name) AS count;

SELECT vets.name AS vets, species.name AS species
FROM specializations FULL JOIN vets ON vet_id = vets.id
FULL JOIN species ON species_id = species.id;

SELECT animals.name as animals, vets.name as vets, date_of_visit
FROM visits JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez'
AND date_of_visit BETWEEN '2020-04-1' AND '2020-08-30';

SELECT animals.name, COUNT(animals.name) FROM visits
JOIN animals ON animal_id = animals.id GROUP BY animals.name
HAVING COUNT (animals.name)=(SELECT MAX(mycount)
FROM (SELECT animals.name, COUNT(animals.name) mycount
FROM visits JOIN animals ON animal_id = animals.id GROUP BY animals.name)as m);


SELECT animals.name FROM visits
JOIN animals ON visits.animal_id = animals.id
WHERE date_of_visit = (SELECT MIN(date_of_visit) FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith');

 SELECT animals.name, date_of_birth, species.name AS species,
 vets.name AS vets, vets.age, date_of_visit FROM visits JOIN animals
 ON animal_id = animals.id JOIN vets ON vet_id = vets.id JOIN species
 ON species_id = species.id JOIN owners ON owners_id = owners.id
 WHERE date_of_visit = (SELECT MAX(date_of_visit) FROM visits);

 SELECT species.name, COUNT(animal_id) FROM visits 
JOIN vets ON vet_id = vets.id JOIN animals ON animal_id = animals.id 
JOIN species ON species_id = species.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name
HAVING COUNT (animal_id) = (SELECT MAX(myc)
FROM (SELECT species.name, COUNT(animal_id) myc FROM visits 
JOIN vets ON vet_id = vets.id JOIN animals ON animal_id = animals.id 
JOIN species ON species_id = species.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name)
AS m);

SELECT COUNT(*) FROM visits JOIN vets ON vets.id = visits.vet_id 
JOIN animals ON animals.id = visits.animal_id JOIN species ON 
species.id = animals.species_id LEFT JOIN specializations ON 
specializations.vet_id = vets.id WHERE specializations.species_id 
IS NULL OR NOT EXISTS (SELECT * FROM specializations WHERE 
specializations.vet_id = vets.id AND specializations.species_id = animals.species_id);