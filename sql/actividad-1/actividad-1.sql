-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema actividad-1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema actividad-1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `actividad-1` DEFAULT CHARACTER SET utf8 ;
USE `actividad-1` ;

-- -----------------------------------------------------
-- Table `actividad-1`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad-1`.`country` (
  `id` INT NOT NULL UNIQUE,
  `name` VARCHAR(45) NOT NULL UNIQUE,
  `capital` VARCHAR(45) NOT NULL UNIQUE,
  `language` VARCHAR(45) NOT NULL,
  `area` DOUBLE NOT NULL,
  `population` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

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
  SELECT NAME, CAPITAL, LANGUAGE, AREA, POPULATION FROM `country` WHERE id = p_id;
END //

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- CALL --------------------------------------------------------------------------------

-- Insert ---------------------------------------------------------------------------

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

-- SELECT ---------------------------------------------------------------------------

CALL search_country(1);
CALL search_country(3);

-- UPDATE ----------------------------------------------------------------------------- 

CALL modify_country(1, 'Argentina', 'Buenos Aires', 'Español', 2780400.00, 47000000);
CALL modify_country(2, 'Uruguay', 'Montevideo', 'Español', 176215.00, 3800000);

-- DELETE ----------------------------------------------------------------------------

CALL delete_country(2);
CALL delete_country(4);
