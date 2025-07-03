-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema actividad-2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema actividad-2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `actividad-2` DEFAULT CHARACTER SET utf8 ;
USE `actividad-2` ;

-- -----------------------------------------------------
-- Tables `actividad-2`.`country, city`, `country_city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad-2`.`country` (
  `id` INT UNSIGNED NOT NULL UNIQUE,
  `name` VARCHAR(45) NOT NULL UNIQUE,
  `capital` VARCHAR(45) NOT NULL UNIQUE,
  `language` VARCHAR(45) NOT NULL,
  `area` DOUBLE UNSIGNED NOT NULL,
  `population` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad-2`.`city` (
  `id` INT UNSIGNED NOT NULL UNIQUE,
  `name` VARCHAR(45) NOT NULL,
  `population` INT UNSIGNED NOT NULL,
  `area` DOUBLE UNSIGNED NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `costal_city` BOOL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad-2`. `country_city`(
  `id_country` INT UNSIGNED NOT NULL,
  `id_city` INT UNSIGNED NOT NULL UNIQUE,
  FOREIGN KEY (`id_country`) REFERENCES `country` (`id`),
  FOREIGN KEY (`id_city`) REFERENCES `city` (`id`))
ENGINE = InnoDB;
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Procedimientos Almacenados de ABM de country
-- -----------------------------------------------------


DELIMITER //

CREATE PROCEDURE insert_country(
  IN p_id INT,
  IN p_name VARCHAR(45),
  IN p_capital VARCHAR(45),
  IN p_language VARCHAR(45),
  IN p_area DOUBLE,
  IN p_population INT
)

BEGIN
  INSERT INTO country (id, name, capital, language, area, population)
  VALUES (p_id, p_name, p_capital, p_language, p_area, p_population);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delete_country(
  IN p_id INT
)

BEGIN
  DELETE FROM `country` WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modify_country(
  IN p_id INT,
  IN p_name VARCHAR(45),
  IN p_capital VARCHAR(45),
  IN p_language VARCHAR(45),
  IN p_area DOUBLE,
  IN p_population INT
)

BEGIN
  UPDATE `country` 
  SET name = p_name,
      capital = p_capital,
      language = p_language,
      area = p_area,
      population = p_population
      WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_country(
  IN p_id INT
)

BEGIN
  SELECT name, capital, language, area, population 
  FROM country 
  WHERE id = p_id;
END //

DELIMITER ;

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Procedimientos Almacenados de ABM de city
-- -----------------------------------------------------


DELIMITER //

CREATE PROCEDURE insert_city(
  IN p_id INT,
  IN p_name VARCHAR(45),
  IN p_population INT,
  IN p_area DOUBLE,
  IN p_zip_code VARCHAR(45),
  IN p_coastal_city BOOL
)

BEGIN
  INSERT INTO city (id, name, population, area, zip_code, costal_city)
  VALUES (p_id, p_name, p_population, p_area, p_zip_code, p_coastal_city);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delete_city(
  IN p_id INT
)

BEGIN
  DELETE FROM `city` WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modify_city(
  IN p_id INT,
  IN p_name VARCHAR(45),
  IN p_population INT,
  IN p_area DOUBLE,
  IN p_zip_code VARCHAR(45),
  IN p_coastal_city BOOL  
)

BEGIN
  UPDATE `city` 
  SET name = p_name,
      population = p_population,
      area = p_area,
      zip_code = p_zip_code,
      costal_city = p_coastal_city
      WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_city(
  IN p_id INT
)

BEGIN
  SELECT name, population, area, zip_code, costal_city
  FROM city 
  WHERE id = p_id;
END //

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Procedimientos Almacenados para tabla intermedia country_city
-- -----------------------------------------------------


DELIMITER //

CREATE PROCEDURE insert_country_city_relationship(
  IN p_id_country INT,
  IN p_id_city INT
)

BEGIN
  INSERT INTO country_city (id_country, id_city)
  VALUES (p_id_country, p_id_city);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delete_country_city_relationship(
  IN p_id_city INT
)

BEGIN
  DELETE FROM `country_city` WHERE id_city = p_id_city;
END //

DELIMITER ;

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Procedimientos Almacenados para la actividad
-- -----------------------------------------------------

-- A 

DELIMITER //

CREATE PROCEDURE select_country_largest_populated_city()

BEGIN
SELECT country.name FROM country
JOIN country_city ON country.id_country = country_city.id_country
JOIN city ON city.id_city = country_city.id_city
ORDER BY city.population DESC 
LIMIT 1;
END //

DELIMITER ;

-- B

DELIMITER //

CREATE PROCEDURE select_countrys_coastal_city_population_over_1M()

BEGIN
SELECT DISTINCT country.name, country.id_country FROM country
JOIN country_city ON country.id_country = country_city.id_country
JOIN city ON city.id_city = country_city.id_city
WHERE city.costal_city = TRUE AND city.population > 1000000;
END //

DELIMITER ;

-- C

DELIMITER //

CREATE PROCEDURE select_country_city_highest_density()

BEGIN
SELECT country.name, city.name FROM country
JOIN country_city ON country.id_country = country_city.id_country
JOIN city ON city.id_city = country_city.id_city
ORDER BY city.population / city.area DESC 
LIMIT 1;
END //

-- -----------------------------------------------------

-- CALL contry

-- -----------------------------------------------------
-- Insert 
-- -----------------------------------------------------

CALL insert_country(1, 'Argentina', 'Buenos Aires', 'Español', 2780400.00, 45000000);
CALL insert_country(2, 'Uruguay', 'Montevideo', 'Español', 176215.00, 3500000);
CALL insert_country(3, 'Brasil', 'Brasilia', 'Portugués', 8515767.0, 212000000);
CALL insert_country(4, 'Chile', 'Santiago', 'Español', 756102.0, 19100000);
CALL insert_country(5, 'Paraguay', 'Asunción', 'Español', 406752.0, 7150000);
CALL insert_country(6, 'Bolivia', 'La Paz', 'Español', 1098581.0, 11600000);
CALL insert_country(7, 'Perú', 'Lima', 'Español', 1285216.0, 33000000);
CALL insert_country(8, 'Colombia', 'Bogotá', 'Español', 1141748.0, 50300000);
CALL insert_country(9, 'Venezuela', 'Caracas', 'Español', 916445.0, 28000000);
CALL insert_country(10, 'Ecuador', 'Quito', 'Español', 256370.0, 17600000);
CALL insert_country(11, 'México', 'Ciudad de México', 'Español', 1964375.0, 126000000);
CALL insert_country(12, 'Estados Unidos', 'Washington D.C.', 'Inglés', 9833520.0, 331000000);
CALL insert_country(13, 'Canadá', 'Ottawa', 'Inglés y Francés', 9984670.0, 38000000);
CALL insert_country(14, 'España', 'Madrid', 'Español', 505990.0, 47000000);
CALL insert_country(15, 'Francia', 'París', 'Francés', 551695.0, 67000000);
CALL insert_country(16, 'Alemania', 'Berlín', 'Alemán', 357386.0, 83000000);
CALL insert_country(17, 'Italia', 'Roma', 'Italiano', 301340.0, 59000000);
CALL insert_country(18, 'Reino Unido', 'Londres', 'Inglés', 243610.0, 67000000);
CALL insert_country(19, 'China', 'Pekín', 'Chino', 9596961.0, 1440000000);
CALL insert_country(20, 'Japón', 'Tokio', 'Japonés', 377975.0, 125000000);
CALL insert_country(21, 'Australia', 'Canberra', 'Inglés', 7692024.0, 25600000);

-- -----------------------------------------------------
-- SELECT 
-- -----------------------------------------------------

CALL search_country(1);
CALL search_country(3);

-- -----------------------------------------------------
-- UPDATE  
-- -----------------------------------------------------

CALL modify_country(1, 'Argentina', 'Buenos Aires', 'Español', 2780400.00, 47000000);
CALL modify_country(2, 'Uruguay', 'Montevideo', 'Español', 176215.00, 3800000);

-- -----------------------------------------------------
-- DELETE 
-- -----------------------------------------------------

CALL delete_country(2);
CALL delete_country(4);

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Prueba tabla city 
-- -----------------------------------------------------

INSERT INTO `actividad-2`.`city` (id_city, name, population, area, zip_code, costal_city) VALUES
(1, 'Buenos Aires', 3050000, 203.3, 'C1000', TRUE),
(2, 'Córdoba', 1390000, 576.0, 'X5000', FALSE),
(3, 'Mar del Plata', 600000, 79.5, 'B7600', TRUE),
(4, 'Rosario', 1200000, 178.7, 'S2000', FALSE);

SELECT * FROM `actividad-2`.`city`
WHERE costal_city = TRUE;

UPDATE `actividad-2`.`city`
SET population = 1410000, area = 580.2
WHERE id_city = 3;

DELETE FROM `actividad-2`.`city`
WHERE id_city = 3;

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Prueba de CALL de tabla city 
-- -----------------------------------------------------

CALL insert_city(
  5,
  'La Plata',
  800000,
  95.2,
  'B1900',
  TRUE
);

CALL delete_city(5);

CALL modify_city(
  2,
  'Córdoba Capital',
  1420000,
  600.5,
  'X5000',
  FALSE
);

CALL search_city(2);

-- -----------------------------------------------------

-- -----------------------------------------------------
-- CALL insert de tabla city para la actividad
-- -----------------------------------------------------

-- Argentina

CALL insert_city(1, 'Buenos Aires', 3050000, 203.3, 'C1000', TRUE);
CALL insert_city(2, 'Córdoba Capital', 1390000, 576.0, 'X5000', FALSE);
CALL insert_city(3, 'Mar del Plata', 600000, 79.5, 'B7600', TRUE);
CALL insert_city(4, 'Rosario', 1200000, 178.7, 'S2000', FALSE);
CALL insert_city(5, 'Mendoza', 1150000, 54.0, 'M5500', FALSE);

-- Uruguay

CALL insert_city(6, 'Montevideo', 1300000, 200.0, '11000', TRUE);
CALL insert_city(7, 'Salto', 100000, 50.2, '50000', FALSE);
CALL insert_city(8, 'Paysandú', 76000, 45.3, '60000', FALSE);
CALL insert_city(9, 'Maldonado', 62000, 35.1, '20000', TRUE);
CALL insert_city(10, 'Rivera', 64000, 33.0, '40000', FALSE);

-- Brasil

CALL insert_city(11, 'São Paulo', 12300000, 1521.0, '01000-000', FALSE);
CALL insert_city(12, 'Rio de Janeiro', 6700000, 1182.3, '20000-000', TRUE);
CALL insert_city(13, 'Brasilia', 3100000, 5779.9, '70000-000', FALSE);
CALL insert_city(14, 'Salvador', 2900000, 693.8, '40000-000', TRUE);
CALL insert_city(15, 'Fortaleza', 2700000, 314.9, '60000-000', TRUE);

-- Chile 

CALL insert_city(16, 'Santiago', 6200000, 641.4, '8320000', FALSE);
CALL insert_city(17, 'Valparaíso', 300000, 401.6, '2340000', TRUE);
CALL insert_city(18, 'Concepción', 1000000, 222.4, '4030000', TRUE);
CALL insert_city(19, 'Antofagasta', 400000, 303.2, '1240000', TRUE);
CALL insert_city(20, 'Temuco', 280000, 294.0, '4780000', FALSE);

-- Paraguay

CALL insert_city(21, 'Asunción', 525000, 117.0, '1209', FALSE);
CALL insert_city(22, 'Ciudad del Este', 320000, 104.0, '7000', FALSE);
CALL insert_city(23, 'San Lorenzo', 250000, 57.5, '1115', FALSE);
CALL insert_city(24, 'Luque', 270000, 45.0, '1215', FALSE);
CALL insert_city(25, 'Encarnación', 130000, 67.2, '6000', TRUE);

-- -----------------------------------------------------

-- -----------------------------------------------------
-- CALL insert de tabla country_city para la actividad
-- -----------------------------------------------------

-- Argentina

CALL insert_country_city_relationship(1, 1); -- Buenos Aires
CALL insert_country_city_relationship(1, 2); -- Córdoba
CALL insert_country_city_relationship(1, 3); -- Mar del Plata
CALL insert_country_city_relationship(1, 4); -- Rosario
CALL insert_country_city_relationship(1, 5); -- Mendoza

-- Uruguay

CALL insert_country_city_relationship(2, 6); -- Montevideo
CALL insert_country_city_relationship(2, 7); -- Salto
CALL insert_country_city_relationship(2, 8); -- Paysandú
CALL insert_country_city_relationship(2, 9); -- Maldonado
CALL insert_country_city_relationship(2, 10); -- Rivera

-- Brasil

CALL insert_country_city_relationship(3, 11); -- São Paulo
CALL insert_country_city_relationship(3, 12); -- Rio de Janeiro
CALL insert_country_city_relationship(3, 13); -- Brasilia
CALL insert_country_city_relationship(3, 14); -- Salvador
CALL insert_country_city_relationship(3, 15); -- Fortaleza

-- Chile 

CALL insert_country_city_relationship(4, 16); -- Santiago
CALL insert_country_city_relationship(4, 17); -- Valparaíso
CALL insert_country_city_relationship(4, 18); -- Concepción
CALL insert_country_city_relationship(4, 19); -- Antofagasta
CALL insert_country_city_relationship(4, 20); -- Temuco

-- Paraguay

CALL insert_country_city_relationship(5, 21); -- Asunción
CALL insert_country_city_relationship(5, 22); -- Ciudad del Este
CALL insert_country_city_relationship(5, 23); -- San Lorenzo
CALL insert_country_city_relationship(5, 24); -- Luque
CALL insert_country_city_relationship(5, 25); -- Encarnación

-- -----------------------------------------------------

-- CALL de prueba para la actividad 

CALL select_country_largest_populated_city()
CALL select_countrys_coastal_city_population_over_1M()
CALL select_country_city_highest_density()