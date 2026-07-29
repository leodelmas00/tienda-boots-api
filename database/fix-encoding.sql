USE tienda_boots_db;
SET NAMES utf8mb4;

-- Fix error de encoding
UPDATE Producto SET envio = 'Envíos sin cargo a todo el país';

-- Fix errores de encoding
UPDATE Producto SET
  nombre = REPLACE(REPLACE(nombre, 'Ã¡', 'á'), 'Ã©', 'é'),
  descripcion = REPLACE(REPLACE(descripcion, 'Ã¡', 'á'), 'Ã©', 'é');
