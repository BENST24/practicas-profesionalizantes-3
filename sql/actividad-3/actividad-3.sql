CREATE SCHEMA IF NOT EXISTS `actividad-3` DEFAULT CHARACTER SET utf8 ;
USE `actividad-3` ;

-- -----------------------------------------------------
-- Tablas `actividad-3`.`user, city`, `user_city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `actividad-3`.`user` (
  `id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL UNIQUE,
  `password` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad-3`.`group` (
  `id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL UNIQUE,
  `description` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad-3`.`action` (
  `id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL UNIQUE,
  `description` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad-3`.`web_api` (
  `id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
  `id_action` INT UNSIGNED NOT NULL,
  `url` VARCHAR(256) NOT NULL UNIQUE,
  `http_method` VARCHAR(45) NOT NULL,
  FOREIGN KEY (`id_action`) REFERENCES `action` (`id`),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad-3`. `user_groups`(
  `id_user` INT UNSIGNED NOT NULL,
  `id_group` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_user`, `id_group`),
  CONSTRAINT `fk_user_groups_user`
    FOREIGN KEY (`id_user`)  REFERENCES `user`  (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_groups_group`
    FOREIGN KEY (`id_group`) REFERENCES `group` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `actividad-3`. `group_permissions`(
  `id_group` INT UNSIGNED NOT NULL,
  `id_action` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_group`, `id_action`),
  CONSTRAINT `fk_group_permissions_group`
    FOREIGN KEY (`id_group`)  REFERENCES `group`  (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_permissions_action`
    FOREIGN KEY (`id_action`) REFERENCES `action` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE)
ENGINE = InnoDB;
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Procedimientos Almacenados de ABM de user
-- -----------------------------------------------------


DELIMITER //

CREATE PROCEDURE insert_user(
  IN p_name VARCHAR(45),
  IN p_password VARCHAR(128)
)

BEGIN
  INSERT INTO user (name, password)
  VALUES (p_name, p_password);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delete_user(
  IN p_id INT
)

BEGIN
  DELETE FROM `user` WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modify_user(
  IN p_id INT,
  IN p_name VARCHAR(45),
  IN p_password VARCHAR(128)
)

BEGIN
  UPDATE `user` 
  SET name = p_name,
      password = p_password
      WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_user_by_id(
  IN p_id INT
)

BEGIN
  SELECT name, password
  FROM user 
  WHERE id = p_id;
END //

DELIMITER ; 

DELIMITER //

CREATE PROCEDURE search_user_by_name(
  IN p_name varchar(45)
)

BEGIN
  SELECT id, name, password
  FROM user 
  WHERE name = p_name;
END //

DELIMITER ;

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Procedimientos Almacenados de ABM de group
-- -----------------------------------------------------


DELIMITER //

CREATE PROCEDURE insert_group(
  IN p_name VARCHAR(45),
  IN p_description VARCHAR(128)
)

BEGIN
  INSERT INTO group (name, description)
  VALUES (p_name, p_description);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delete_group(
  IN p_id INT
)

BEGIN
  DELETE FROM `group` WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modify_group(
  IN p_id INT,
  IN p_name VARCHAR(45),
  IN p_description VARCHAR(128)
)

BEGIN
  UPDATE `group` 
  SET name = p_name,
      description = p_description
      WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_group_by_id(
  IN p_id INT
)

BEGIN
  SELECT name, description
  FROM group 
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_group_by_name(
  IN p_name varchar(45)
)

BEGIN
  SELECT id, name, description
  FROM group 
  WHERE name = p_name;
END //

DELIMITER ;

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Procedimientos Almacenados de ABM de action
-- -----------------------------------------------------


DELIMITER //

CREATE PROCEDURE insert_action(
  IN p_name VARCHAR(45),
  IN p_description VARCHAR(128)
)

BEGIN
  INSERT INTO action (name, description)
  VALUES (p_name, p_description);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delete_action(
  IN p_id INT
)

BEGIN
  DELETE FROM `action` WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modify_action(
  IN p_id INT,
  IN p_name VARCHAR(45),
  IN p_description VARCHAR(128)
)

BEGIN
  UPDATE `action` 
  SET name = p_name,
      description = p_description
      WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_action_by_id(
  IN p_id INT
)

BEGIN
  SELECT name, description
  FROM action 
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_action_by_name(
  IN p_name varchar(45)
)

BEGIN
  SELECT id, name, description
  FROM action 
  WHERE name = p_name;
END //

DELIMITER ;

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Procedimientos Almacenados para tabla intermedia web_api
-- -----------------------------------------------------


DELIMITER //

CREATE PROCEDURE insert_web_api(
  IN p_id_action INT,
  IN p_url VARCHAR(256),
  IN p_http_method VARCHAR(45)
)
BEGIN
  INSERT INTO web_api (id_action, url, http_method)
  VALUES (p_id_action, p_url, p_http_method);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE delete_web_api(
  IN p_id INT
)
BEGIN
  DELETE FROM web_api
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE modify_web_api(
  IN p_id INT,
  IN p_id_action INT,
  IN p_url VARCHAR(256),
  IN p_http_method VARCHAR(45)
)
BEGIN
  UPDATE web_api
  SET id_action = p_id_action,
      url = p_url,
      http_method = p_http_method
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_web_api_by_id(
  IN p_id INT
)
BEGIN
  SELECT web_api.id, action.name AS action_name, web_api.url, web_api.http_method
  FROM web_api
  JOIN action ON web_api.id_action = action.id
  WHERE web_api.id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE search_web_api_by_id_action(
  IN p_id_action INT
)
BEGIN
  SELECT web_api.id, action.name AS action_name, web_api.url, web_api.http_method
  FROM web_api
  JOIN action ON web_api.id_action = action.id
  WHERE web_api.id_action = p_id_action;
END //

DELIMITER ;


-- -----------------------------------------------------

-- -----------------------------------------------------
-- Procedimientos Almacenados para tabla intermedia user_groups
-- -----------------------------------------------------


DELIMITER //
CREATE PROCEDURE insert_user_groups_relationship(
  IN p_id_user INT,
  IN p_id_group INT
)
BEGIN
  INSERT INTO user_groups (id_user, id_group)
  VALUES (p_id_user, p_id_group);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE delete_user_groups_relationship(
  IN p_id_user INT,
  IN p_id_group INT
)
BEGIN
  DELETE FROM user_groups
  WHERE id_user = p_id_user AND id_group = p_id_group;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE search_user_groups(
  IN p_id_user INT
)
BEGIN
  SELECT `group`.id, `group`.name, `group`.description
  FROM `group`
  JOIN user_groups ON `group`.id = user_groups.id_group
  WHERE user_groups.id_user = p_id_user;
END //
DELIMITER ;

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Procedimientos Almacenados para tabla intermedia group_permissions
-- -----------------------------------------------------


DELIMITER //
CREATE PROCEDURE insert_group_permissions_relationship(
  IN p_id_group INT,
  IN p_id_action INT
)
BEGIN
  INSERT INTO group_permissions (id_group, id_action)
  VALUES (p_id_group, p_id_action);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE delete_group_permissions_relationship(
  IN p_id_group INT,
  IN p_id_action INT
)
BEGIN
  DELETE FROM group_permissions
  WHERE id_group = p_id_group AND id_action = p_id_action;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE search_group_permissions(
  IN p_id_group INT
)
BEGIN
  SELECT action.id, action.name, action.description
  FROM action
  JOIN group_permissions ON action.id = group_permissions.id_action
  WHERE group_permissions.id_group = p_id_group;
END //
DELIMITER ;

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Call para cargar datos de group de la actividad
-- -----------------------------------------------------


CALL insert_group('Administradores', 'Acceso a toda la WebAPI');
CALL insert_group('Regulares', 'Pueden likear, comentar, subir y consultar videos de usuarios');
CALL insert_group('Moderadores', 'Pueden suspender usuarios por infringir copyright');

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Call para cargar datos de action de la actividad
-- -----------------------------------------------------


CALL insert_action('uploadVideo', 'Sube un nuevo video');
CALL insert_action('getUserVideos', 'Obtiene los videos de un usuario');
CALL insert_action('likeVideo', 'Marca un video como me gusta');
CALL insert_action('commentOnVideo', 'Agrega un comentario a un video');
CALL insert_action('deleteVideo', 'Elimina un video por ID');
CALL insert_action('suspendUser', 'Suspende usuario por ID');

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Call para cargar la tabla intermedia de group_permissions de la actividad
-- -----------------------------------------------------


-- Administradores

CALL insert_group_permissions_relationship(1, 1); -- uploadVideo
CALL insert_group_permissions_relationship(1, 2); -- getUserVideos
CALL insert_group_permissions_relationship(1, 3); -- likeVideo
CALL insert_group_permissions_relationship(1, 4); -- commentOnVideo
CALL insert_group_permissions_relationship(1, 5); -- deleteVideo
CALL insert_group_permissions_relationship(1, 6); -- suspendUser

-- Regulares

CALL insert_group_permissions_relationship(2, 1); -- uploadVideo
CALL insert_group_permissions_relationship(2, 2); -- getUserVideos
CALL insert_group_permissions_relationship(2, 3); -- likeVideo
CALL insert_group_permissions_relationship(2, 4); -- commentOnVideo

-- Moderadores

CALL insert_group_permissions_relationship(3, 6); -- suspendUser

-- -----------------------------------------------------