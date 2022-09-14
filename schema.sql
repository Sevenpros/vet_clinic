/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
   id SERIAL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name text,
   date_of_birth date,
   escape_attempts INT,
   neutered BOOLEAN,
   weight_kg decimal
);

ALTER TABLE animals ADD species VARCHAR(300);

CREATE TABLE owners ( id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, full_name text, age INT);

CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name text);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD owners_id INT, ADD CONSTRAINT fk FOREIGN KEY(owners_id) REFERENCES owners(id) ON DELETE CASCADE;

ALTER TABLE animals ADD species_id INT, ADD CONSTRAINT fk2 FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE;
