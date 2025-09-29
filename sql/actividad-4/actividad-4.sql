CREATE SCHEMA IF NOT EXISTS `actividad-4` DEFAULT CHARACTER SET utf8 ;
USE `actividad-4` ;

-- -----------------------------------------------------
-- Tablas `actividad-4`.`folder`, `file`, `folder_container_folders` y `folder_files`
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Tabla: Folder
-- -----------------------------------------------------
CREATE TABLE Folder (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  creation_date DATE NOT NULL
);

-- -----------------------------------------------------
-- Tabla: File
-- -----------------------------------------------------
CREATE TABLE File (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  extension VARCHAR(10) NOT NULL,
  creation_date DATE NOT NULL
);

-- -----------------------------------------------------
-- Tabla "intermedia": folder_container_folders
-- Relación: una carpeta puede contener varias subcarpetas,
-- pero una subcarpeta solo puede tener una carpeta padre.
-- -----------------------------------------------------
CREATE TABLE folder_container_folders (
    id_folder_container INT,
    id_folder INT,
    PRIMARY KEY (id_folder_container, id_folder),
    FOREIGN KEY (id_folder_container) REFERENCES Folder(id) ON DELETE CASCADE,
    FOREIGN KEY (id_folder) REFERENCES Folder(id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabla intermedia: folder_files
-- -----------------------------------------------------
CREATE TABLE folder_files (
    id_folder INT,
    id_file INT,
    PRIMARY KEY (id_folder, id_file),
    FOREIGN KEY (id_folder) REFERENCES Folder(id) ON DELETE CASCADE,
    FOREIGN KEY (id_file) REFERENCES File(id) ON DELETE CASCADE
);


-- -----------------------------------------------------
-- ADM de las tablas
-- -----------------------------------------------------

-- Procedimientos almacenados para la tabla Folder

DELIMITER //

-- Insertar carpeta
CREATE PROCEDURE insert_folder(
  IN p_name VARCHAR(100),
  IN p_creation_date DATE
)

BEGIN
  INSERT INTO Folder (name, creation_date)
  VALUES (p_name, p_creation_date);
END //

DELIMITER ;

-- Eliminar carpeta

DELIMITER //

DELIMITER //

CREATE PROCEDURE delete_folder(
  IN p_id_folder INT
)
BEGIN
  DELETE FROM Folder WHERE id = p_id_folder;
END //

DELIMITER ;

DELIMITER //

-- Modificar carpeta
CREATE PROCEDURE modify_folder(
  IN p_id INT,
  IN p_name VARCHAR(100),
  IN p_creation_date DATE
)

BEGIN
  UPDATE Folder
  SET name = p_name,
      creation_date = p_creation_date
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

-- Buscar carpeta por ID
CREATE PROCEDURE search_folder_by_id(
  IN p_id INT
)

BEGIN
  SELECT id, name, creation_date
  FROM Folder
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

-- Buscar carpeta por nombre
CREATE PROCEDURE search_folder_by_name(
  IN p_name VARCHAR(100)
)

BEGIN
  SELECT id, name, creation_date
  FROM Folder
  WHERE name = p_name;
END //

DELIMITER ;

-- -----------------------------------------------------


-- Procedimientos almacenados para la tabla File

DELIMITER //

-- Insertar archivo
CREATE PROCEDURE insert_file(
  IN p_name VARCHAR(100),
  IN p_extension VARCHAR(10),
  IN p_creation_date DATE
)

BEGIN
  INSERT INTO File (name, extension, creation_date)
  VALUES (p_name, p_extension, p_creation_date);
END //

DELIMITER ;

-- Eliminar archivo

DELIMITER //

CREATE PROCEDURE delete_file(
  IN p_id_file INT
)
BEGIN
  -- Primero borro la relación con carpetas
  DELETE FROM folder_files
  WHERE id_file = p_id_file;

  -- Después borro el archivo en sí
  DELETE FROM File
  WHERE id = p_id_file;
END //

DELIMITER ;


DELIMITER //

-- Modificar archivo
CREATE PROCEDURE modify_file(
  IN p_id INT,
  IN p_name VARCHAR(100),
  IN p_extension VARCHAR(10),
  IN p_creation_date DATE
)

BEGIN
  UPDATE File
  SET name = p_name,
      extension = p_extension,
      creation_date = p_creation_date
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

-- Buscar archivo por ID
CREATE PROCEDURE search_file_by_id(
  IN p_id INT
)

BEGIN
  SELECT id, name, extension, creation_date
  FROM File
  WHERE id = p_id;
END //

DELIMITER ;

DELIMITER //

-- Buscar archivo por nombre
CREATE PROCEDURE search_file_by_name(
  IN p_name VARCHAR(100)
)

BEGIN
  SELECT id, name, extension, creation_date
  FROM File
  WHERE name = p_name;
END //

DELIMITER ;

-- -----------------------------------------------------


-- Procedimientos almacenados para la tabla folder_container_folders

DELIMITER //

-- Insertar relación (carpeta contenedora - subcarpeta)
CREATE PROCEDURE insert_folder_container_relationship(
  IN p_id_folder_container INT,
  IN p_id_folder INT
)
BEGIN
  INSERT INTO folder_container_folders (id_folder_container, id_folder)
  VALUES (p_id_folder_container, p_id_folder);
END //

DELIMITER ;

DELIMITER //

-- Eliminar relación (carpeta contenedora - subcarpeta)
CREATE PROCEDURE delete_folder_container_relationship(
  IN p_id_folder_container INT,
  IN p_id_folder INT
)

BEGIN
  DELETE FROM folder_container_folders
  WHERE id_folder_container = p_id_folder_container
    AND id_folder = p_id_folder;
END //

DELIMITER ;

DELIMITER //

-- Buscar subcarpetas de una carpeta dada
CREATE PROCEDURE search_subfolders(
  IN p_id_folder_container INT
)

BEGIN
  SELECT f.id, f.name, f.creation_date
  FROM Folder f
  JOIN folder_container_folders fc
    ON f.id = fc.id_folder
  WHERE fc.id_folder_container = p_id_folder_container;
END //

DELIMITER ;

-- -----------------------------------------------------


-- Procedimientos almacenados para la tabla folder_files

DELIMITER //

-- Insertar relación (carpeta - archivo)
CREATE PROCEDURE insert_folder_file_relationship(
  IN p_id_folder INT,
  IN p_id_file INT
)

BEGIN
  INSERT INTO folder_files (id_folder, id_file)
  VALUES (p_id_folder, p_id_file);
END //

DELIMITER ;

DELIMITER //

-- Eliminar relación (carpeta - archivo)
CREATE PROCEDURE delete_folder_file_relationship(
  IN p_id_folder INT,
  IN p_id_file INT
)

BEGIN
  DELETE FROM folder_files
  WHERE id_folder = p_id_folder
    AND id_file = p_id_file;
END //

DELIMITER ;

DELIMITER //

-- Buscar archivos dentro de una carpeta
CREATE PROCEDURE search_files_in_folder(
  IN p_id_folder INT
)
BEGIN
  SELECT f.id, f.name, f.extension, f.creation_date
  FROM File f
  JOIN folder_files ff
    ON f.id = ff.id_file
  WHERE ff.id_folder = p_id_folder;
END //

DELIMITER ;

-- -----------------------------------------------------

-- Procedimiento para la actividad

DELIMITER //

CREATE PROCEDURE search_files_by_extension_and_date(
  IN p_extension VARCHAR(10),
  IN p_creation_date DATE
)
BEGIN
  SELECT 
    f.id AS file_id,
    f.name AS file_name,
    f.extension,
    f.creation_date,
    fo.id AS folder_id,
    fo.name AS folder_name
  FROM File f
  JOIN folder_files ff ON f.id = ff.id_file
  JOIN Folder fo ON ff.id_folder = fo.id
  WHERE f.extension = p_extension
    AND f.creation_date = p_creation_date
  ORDER BY f.name;
END //

DELIMITER ;

-- -----------------------------------------------------


-- -----------------------------------------------------
-- Insertar datos de prueba en las tablas
-- -----------------------------------------------------

-- Insertar carpetas
CALL insert_folder('Carpeta Raíz', '2025-09-01');
CALL insert_folder('Subcarpeta A', '2025-09-05');
CALL insert_folder('Subcarpeta B', '2025-09-10');

-- Modificar carpeta
CALL modify_folder(2, 'Subcarpeta A Modificada', '2025-09-06');

-- Buscar carpeta por ID
CALL search_folder_by_id(1);

-- Buscar carpeta por nombre
CALL search_folder_by_name('Subcarpeta B');
-- Buscar carpeta por nombre (no existente)
CALL search_folder_by_name('Carpeta Inexistente');

-- -----------------------------------------------------

-- Insertar archivos
CALL insert_file('Documento1', 'txt', '2025-09-20');
CALL insert_file('Foto1', 'jpg', '2025-09-21');
CALL insert_file('Codigo1', 'cpp', '2025-09-22');

-- Modificar archivo
CALL modify_file(1, 'Documento1_editado', 'txt', '2025-09-23');

-- Buscar archivo por ID
CALL search_file_by_id(2);

-- Buscar archivo por nombre
CALL search_file_by_name('Codigo1');

-- Buscar archivo por nombre (no existente)
CALL search_file_by_name('Archivo Inexistente');

-- -----------------------------------------------------

-- Relacionar carpetas (raíz contiene subcarpeta A y B)
CALL insert_folder_container_relationship(1, 2);
CALL insert_folder_container_relationship(1, 3);

-- Relacionar archivos a carpetas
CALL insert_folder_file_relationship(2, 1); -- Documento1 en Subcarpeta A
CALL insert_folder_file_relationship(2, 2); -- Foto1 en Subcarpeta A
CALL insert_folder_file_relationship(3, 3); -- Codigo1 en Subcarpeta B

-- Buscar subcarpetas dentro de la carpeta raíz
CALL search_subfolders(1);

-- Buscar archivos dentro de Subcarpeta A
CALL search_files_in_folder(2);

-- Eliminar relación carpeta-archivo
CALL delete_folder_file_relationship(2, 1);

-- Eliminar relación carpeta-contenedora
CALL delete_folder_container_relationship(1, 3);

-- -----------------------------------------------------

-- Borrar un archivo (Foto1)
CALL delete_file(2);

-- Borrar una carpeta (simulación en cascada)
CALL delete_folder(1);

-- Verificar que todo se borró correctamente
CALL search_folder_by_id(1); -- Carpeta Raíz (debería no existir)

-- -----------------------------------------------------

-- Buscar archivos .cpp creados el 2025-09-22
CALL search_files_by_extension_and_date('cpp', '2025-09-22');


