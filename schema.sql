/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
   id INT GENERATED ALWAYS AS IDENTITY,
   name text,
   date_of_birth date,
   escape_attempts INT,
   neutered BIT,
   weight_kg decimal
);

ALTER TABLE animals ADD species VARCHAR(300);