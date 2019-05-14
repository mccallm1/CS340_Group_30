-- Drop tables with Foreign key restraints first
DROP TABLE IF EXISTS observation;
DROP TABLE IF EXISTS interaction;
DROP TABLE IF EXISTS animal;
DROP TABLE IF EXISTS researcher;
-- Then remaining tables
DROP TABLE IF EXISTS species;


-- Data Definitions

CREATE TABLE species (
  id INT AUTO_INCREMENT,
  scientific_name VARCHAR(255) NOT NULL,
  common_name VARCHAR(255),
  feeding_type VARCHAR(255),
  notes TEXT,
  PRIMARY KEY (id)
);

CREATE TABLE animal (
  id INT AUTO_INCREMENT,
  species_id INT NOT NULL,
  sex VARCHAR(255),
  birthdate DATE,
  PRIMARY KEY (id),
  FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE researcher (
  id INT AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL,
  specialty_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (specialty_id) REFERENCES species(id)
);

CREATE TABLE observation (
  id INT AUTO_INCREMENT,
  researcher_id INT NOT NULL,
  animal_id INT NOT NULL,
  obs_date DATE NOT NULL,
  latitude FLOAT(10),
  longitude FLOAT(10),
  weight FLOAT,
  notes TEXT,
  PRIMARY KEY (id),
  FOREIGN KEY (researcher_id) REFERENCES researcher(id),
  FOREIGN KEY (animal_id) REFERENCES animal(id)
);

CREATE TABLE interaction (
  species_1_id INT NOT NULL,
  species_2_id INT NOT NULL,
  behavior TEXT,
  PRIMARY KEY (species_1_id, species_2_id),
  FOREIGN KEY (species_1_id) REFERENCES species(id),
  FOREIGN KEY (species_2_id) REFERENCES species(id)
);



-- Data manipulation

INSERT INTO species (scientific_name, common_name, feeding_type)
VALUES ('Sciuridae', 'Squirrel', 'omnivore'),
  ('Canis latrans', 'Coyote', 'omnivore'),
  ('Tyto alba', 'Barn Owl', 'carnivore'),
  ('Myocastor coypus', 'Nutria', 'omnivore');

INSERT INTO animal (species_id, sex, birthdate)
VALUES (1, 'female', 2017-03-09),
  (1, 'female', 2018-04-12),
  (2, 'male', 2015-05-03),
  (3, 'male', NULL),
  (4, 'female', NULL),
  (4, 'male', 2019-07-28);

INSERT INTO researcher (first_name, last_name, role, specialty_id)
VALUES ('Tasha', 'Henderson', 'Lab Assistant',NULL),
  ('Wallace', 'Smith', 'Field Collector',NULL),
  ('Natalie', 'Wells', 'Graduate Researcher',1),
  ('Jackie', 'Rodriguez', 'Doctorate Researcher',4),
  ('Brent', 'Charles', 'Field Collector',1);

INSERT INTO observation (researcher_id, animal_id, obs_date, latitude, longitude, weight, notes)
VALUES (2, 3, 2017-06-08, 33.0345, -101.2301, 34.07, "caught in spring trap"),
  (2, 3, 2019-03-18, 45.0089, -118.2056, NULL, NULL),
  (2, 6, 2019-03-19, 47.0134, -119.0321, NULL, "found trapped in brush"),
  (2, 1, 2017-08-12, 30.004, -105.8921, 0.89, NULL),
  (5, 1, 2018-09-03, 30.0102, -105.0012, 1.23, "fully grown now"),
  (5, 1, 2019-09-07, 29.0811, -105.7642, 1.01, "damage to left rear leg");

INSERT INTO interaction (species_1_id, species_2_id, behavior)
VALUES (2, 1, "Coyotes hunt squirrels"),
  (2, 4, "Coyotes hunt nutria"),
  (3, 1, "Barn owls hunt squirrels"),
  (2, 3, "Coyotes and Barn owls compete for smaller prey");
