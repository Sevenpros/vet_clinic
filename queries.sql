/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
select name from animals where neutered = 't' and escape_attempts < 3;
select date_of_birth from animals where name ='Agumon' or name = 'Pikachu';
select name, escape_attempts from animals where weight_kg > 10.5;
select * from animals where neutered = 't';
select * from animals where name != 'Gabumon';
select * from animals where weight_kg <= 10.4 or weight_kg >= 17.3;

