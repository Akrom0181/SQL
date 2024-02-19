
CREATE TABLE Country (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) UNIQUE
);

INSERT INTO Country (country_name) VALUES
    ('United States'),
    ('United Kingdom'),
    ('France'),
    ('Germany'),
    ('Japan');

CREATE TABLE City (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(50),
    country_id INTEGER REFERENCES Country(country_id),
    population INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_city_per_country UNIQUE (city_name, country_id)
);

INSERT INTO City (city_name, country_id, population) VALUES
    ('New York', 1, 8622698),
    ('Los Angeles', 1, 3990456),
    ('London', 2, 8982000),
    ('Manchester', 2, 547627),
    ('Paris', 3, 2140526),
    ('Marseille', 3, 861635),
    ('Berlin', 4, 3644826),
    ('Munich', 4, 1484226),
    ('Tokyo', 5, 13929286),
    ('Osaka', 5, 2691185);

SELECT Country.country_name, 
    (
        SELECT COUNT(*) 
        FROM City 
        WHERE City.country_id = Country.country_id
    ) AS total_cities
FROM Country;

SELECT country_name FROM Country 
WHERE (SELECT COUNT(*) FROM City WHERE City.country_id = Country.country_id) > 3;

SELECT city_name FROM city where city_name like 'A%';

SELECT 
    (SELECT city_name FROM city WHERE city_id = (SELECT MIN(city_id) FROM city)) AS oldest_city,
    (SELECT city_name FROM city WHERE city_id = (SELECT MAX(city_id) FROM city)) AS youngest_city;

-- ALTER TABLE CITY 
-- ADD column POPULATION integer;    

SELECT SUM(population) AS total_population
FROM City;

UPDATE City
SET population = 2000000
WHERE city_name = 'Paris';

DELETE FROM City
WHERE population < 100000;

UPDATE City
SET population = 1500000
WHERE city_name = 'Chicago';

ALTER TABLE City
ADD CONSTRAINT fk_country_id
FOREIGN KEY (country_id) REFERENCES Country(country_id);

ALTER TABLE City
ADD CONSTRAINT unique_city_per_country UNIQUE (city_name, country_id);

/*

Create two tables: Country and City.
Country table should have columns: country_id (primary key), country_name.
City table should have columns: city_id (primary key), city_name, country_id (foreign key referencing country_id in Country table).


Insert Data:
Insert at least 5 records into the Country table.
Insert at least 10 records into the City table, 
ensuring that each city is associated with a valid country using the country_id foreign key.

*/