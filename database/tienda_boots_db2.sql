CREATE DATABASE IF NOT EXISTS TiendaBoots;
USE TiendaBoots;

CREATE TABLE Cliente (
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
usuario varchar(50) NOT null,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
password VARCHAR(100) NOT NULL,
telefono VARCHAR(20),
direccion VARCHAR(150)
);

CREATE TABLE Producto (
id_producto INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(255),
precio DECIMAL(10,2) NOT NULL,
color VARCHAR(30),
marca VARCHAR(50)
);

CREATE TABLE Pedido (
id_pedido INT PRIMARY KEY AUTO_INCREMENT,
id_cliente INT NOT NULL,
fecha_pedido DATE NOT NULL,
estado ENUM('pendiente','pagado','enviado','cancelado'),
total DECIMAL(10,2),
FOREIGN KEY (id_cliente)
REFERENCES Cliente(id_cliente)
);

CREATE TABLE Detalle (
id_detalle INT PRIMARY KEY AUTO_INCREMENT,
id_pedido INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
subtotal DECIMAL(10,2),
FOREIGN KEY (id_pedido)
REFERENCES Pedido(id_pedido),
FOREIGN KEY (id_producto)
REFERENCES Producto(id_producto)
);

INSERT INTO Cliente
(usuario, nombre, apellido, email, password, telefono, direccion)
VALUES
('gianm8','Gian', 'March', 'gm@gmail.com', '12345678', '', '');

INSERT INTO Producto
(nombre, descripcion, precio, color, marca)
VALUES
('Botas Timberland', 'Botas Timberland Earthkeepers para hombre', 389.999, 'Marron', 'Timberland');

SELECT * FROM Cliente;
SELECT Apellido,Direccion FROM Cliente;

SELECT * FROM Producto;
SELECT Color FROM Producto;

SELECT
p.id_pedido,
c.nombre,
c.apellido,
p.fecha_pedido,
p.total
FROM Pedido p
INNER JOIN Cliente c
ON p.id_cliente = c.id_cliente;

UPDATE Cliente
SET telefono = '2664555555'
WHERE id_cliente = 1;

UPDATE Producto
SET precio = 18000
WHERE id_producto = 1;

DELETE FROM Producto
WHERE id_producto = 1;
