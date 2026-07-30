-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: tienda_boots_db
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contrasenia` varchar(255) NOT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `rol` varchar(20) NOT NULL DEFAULT 'cliente',
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `uq_cliente_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (17,'Pepe00','Pepe','gomes','pepe@gmail.com','$2b$10$/n1x8Nx.p1BOEP6ML06uYOPIMdW0puAvMvUDns9rbtAgjvwRhCG1C',NULL,NULL,NULL,'uploads/perfil-1784071809011.png','admin'),(18,'raul00','raul','martines','raul@gmail.com','$2b$10$Mt8JVN2Rw0JtwbIaq9VdveADTUeYsrlDFR5cM4GpKoh2lCb.jRF/i',NULL,NULL,NULL,NULL,'cliente'),(19,'nuevoUsuario','Pepe','Delmas','nuevo@email.com','$2b$10$DHrdcdBBLHrwqVqAwzCMOeMH.g2FMgC9MW3IjFqTd5V4dVzlB7hQK','42295002','Nueva direccion','123456789',NULL,'cliente'),(20,'mati00','mati','pedro','mati@gmail.com','$2b$10$gwdVQG4UvamhyQukvULYP.TvJt5XSyUvC7XwN4.Yq7oYBIaCMWcmC',NULL,NULL,NULL,NULL,'cliente'),(21,'zorro','zzzzzz','sssssss','zorro@gmail.com','$2b$10$TVU5Eq4gWBG4zoegAl7R/OCY1LlRviptu0t./ddrqb6eWvjnQlB.m','42295000','pepe avenida 34','2233455666',NULL,'cliente'),(22,'caca00','caca','asddd','caca@gmail.com','$2b$10$2mmmkb1tx9YsP59zF9BHJ.T/w3OFWEE.qt3tchytrdb3xgT8RKlUW',NULL,NULL,NULL,'uploads/perfil-1785358970983.png','cliente'),(23,'admin','admin','admin','admin@gmail.com','$2b$10$M43JFMlTva.F/q4v8NBve.8Q.nNoy1JjFX3AkEUi4xI3dZ8qpag5i',NULL,NULL,NULL,NULL,'admin'),(24,'usuario','usuario','usuario','usuario@gmail.com','$2b$10$ZbbB/pxj7/EmevyLUtU1JuXB/Inra1OwwfzUxtErTQe2YQgrDL5JC',NULL,NULL,NULL,NULL,'cliente');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Detalle`
--

DROP TABLE IF EXISTS `Detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Detalle` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `Detalle_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Detalle_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `Producto` (`id_producto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Detalle`
--

LOCK TABLES `Detalle` WRITE;
/*!40000 ALTER TABLE `Detalle` DISABLE KEYS */;
INSERT INTO `Detalle` VALUES (1,1,2,1,289.99),(2,1,3,1,320.99);
/*!40000 ALTER TABLE `Detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedido`
--

DROP TABLE IF EXISTS `Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pedido` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha_pedido` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(50) DEFAULT 'pendiente',
  `total` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
INSERT INTO `Pedido` VALUES (1,18,'2026-07-29 17:59:52','pendiente',610.98);
/*!40000 ALTER TABLE `Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Producto`
--

DROP TABLE IF EXISTS `Producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) NOT NULL,
  `color` varchar(50) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `imagen` varchar(500) DEFAULT NULL,
  `stock` varchar(50) DEFAULT 'En stock',
  `stock_class` varchar(20) DEFAULT 'success',
  `stars` decimal(2,1) DEFAULT '0.0',
  `envio` varchar(255) DEFAULT 'Envíos sin cargo a todo el país',
  `talla` varchar(10) DEFAULT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `material` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Producto`
--

LOCK TABLES `Producto` WRITE;
/*!40000 ALTER TABLE `Producto` DISABLE KEYS */;
INSERT INTO `Producto` VALUES (1,'Botas Timberland Earthkeepers para hombre','Un mix entre la durabilidad de Timberland y la conciencia sustentable.',389.99,'Marrón','Timberland','https://images.unsplash.com/photo-1520639888713-7851133b1ed0?q=80&w=687&auto=format&fit=crop','En stock','success',4.5,'Envíos sin cargo a todo el país','42','Hombre','Cuero vacuno'),(2,'Botín de cuero para mujer','Botín al tobillo en cuero negro con acabado satinado y dos cremalleras metálicas laterales.',289.99,'Negro','Genérico','https://images.unsplash.com/photo-1605732440685-d0654d81aa30?q=80&w=1470&auto=format&fit=crop','En stock','success',4.0,'Envíos sin cargo a todo el país','38','Mujer','Cuero con acabado satinado'),(3,'Botas impermeables Timberland Premium','Diseñadas hace 40 años se mantienen como un ícono global hoy en día.',320.99,'Marrón','Timberland','https://images.unsplash.com/photo-1542838776-096d877b5aa2?w=600&auto=format&fit=crop&q=60','En stock','success',4.5,'Envíos sin cargo a todo el país','41','Hombre','Cuero impermeabilizado'),(4,'Botas brogue con puntera Barker Calder','Botas elegantes con perforaciones decorativas y puntera clásica.',159.99,'Marrón','Barker','https://images.unsplash.com/photo-1638609348722-aa2a3a67db26?q=80&w=1345&auto=format&fit=crop','Sin stock','danger',4.0,'Envíos sin cargo a todo el país','43','Hombre','Cuero liso'),(5,'Botas Dr. Martens Rojo Cereza','Entrá en el modo rebelde y expresivo con la clásica suela amarilla.',220.99,'Bordo','Dr. Martens','https://plus.unsplash.com/premium_photo-1728158949987-efc83ed54df4?q=80&w=687&auto=format&fit=crop','En stock','success',4.0,'Envíos sin cargo a todo el país','39','Unisex','Cuero liso'),(6,'Botín militar cuero negro al tobillo','Silueta clásica de inspiración militar con funcionalidad moderna.',159.99,'Negro','Genérico','https://images.unsplash.com/photo-1613673720017-56e42d90fee4?w=600&auto=format&fit=crop&q=60','En stock','success',3.5,'Envíos sin cargo a todo el país','40','Unisex','Cuero vacuno'),(7,'Botines Chelsea de cuero marrón claro','Estilo clásico y versátil para uso urbano o rural. Paneles elásticos laterales y suela de goma resistente.',89.99,'Marrón','Genérico/Artesanal','https://images.unsplash.com/photo-1773425975272-35f0900a9d8f?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D','En stock','success',4.5,'Envíos sin cargo a todo el país','42','Hombre','Cuero natural liso'),(8,'Bota vaquera cowboy Sendra negra','Bota campera de caña alta con punta fina y detalles bordados. Fabricada artesanalmente en España.',430.99,'Negro','Sendra','https://images.unsplash.com/photo-1726259794537-4771f549a931?q=80&w=1608&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D','En stock','success',5.0,'Envíos sin cargo a todo el país','42','Unisex','Cuero engrasado'),(9,'Botas de senderismo Salomon Outline Mid GTX','Calzado técnico y ligero que combina la flexibilidad de una zapatilla de running con la protección y tracción necesarias para el trekking y senderismo de media montaña.',159.99,'Gris','Salomon','https://images.unsplash.com/photo-1631287381310-925554130169?q=80&w=1450&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D','En stock','success',4.5,'Envíos sin cargo a todo el país','43','Unisex','Textil sintético anti-detritus + membrana Gore-Tex'),(10,'Botas de cuero marrón Coclico con taco de madera','Botín de cuero curtido con detalle de borde rústico, panel elástico cubierto y tacón bajo de madera natural',345.00,'Marrón','Coclico','https://plus.unsplash.com/premium_photo-1670983858132-c2f3c4dbf08c?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D','En stock','success',4.8,'Envíos sin cargo a todo el país','38','Mujer','Cuero natural + tacón de madera'),(11,'Borcego cuero nubuck todo terreno','Borcego de nubuck engrasado con cuello acolchado y suela cosida.',275.99,'Marrón','El Boyero','https://images.unsplash.com/photo-1608256246200-53e635b5b65f?q=80&w=687&auto=format&fit=crop','En stock','success',4.0,'Envíos sin cargo a todo el país','40','Hombre','Nubuck engrasado'),(12,'Botas Dr. Martens 1460 negras clásicas','El modelo que definió una generación. 8 ojales, suela amarilla icónica.',265.99,'Negro','Dr. Martens','https://images.unsplash.com/photo-1616610868156-fe7e276de965?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZG9jJTIwbWFydGVuc3xlbnwwfHwwfHx8MA%3D%3D','En stock','success',5.0,'Envíos sin cargo a todo el país','38','Unisex','Cuero liso suave');
/*!40000 ALTER TABLE `Producto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-30 15:24:04
