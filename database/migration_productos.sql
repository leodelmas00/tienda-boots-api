USE tienda_boots_db;
SET NAMES utf8mb4;

-- 1. Agregar columnas faltantes a la tabla Producto existente
ALTER TABLE Producto
  ADD COLUMN imagen      VARCHAR(500)  DEFAULT NULL,
  ADD COLUMN stock       VARCHAR(50)   DEFAULT 'En stock',
  ADD COLUMN stock_class VARCHAR(20)   DEFAULT 'success',
  ADD COLUMN stars       DECIMAL(2,1)  DEFAULT 0,
  ADD COLUMN envio       VARCHAR(255)  DEFAULT 'Envíos sin cargo a todo el país',
  ADD COLUMN talla       VARCHAR(10)   DEFAULT NULL,
  ADD COLUMN genero      VARCHAR(50)   DEFAULT NULL,
  ADD COLUMN material    VARCHAR(150)  DEFAULT NULL;

-- 2. Insertar los 12 productos
INSERT INTO Producto (nombre, descripcion, precio, color, marca, imagen, stock, stock_class, stars, talla, genero, material) VALUES
(
  'Botas Timberland Earthkeepers para hombre',
  'Un mix entre la durabilidad de Timberland y la conciencia sustentable.',
  389.99, 'Marrón', 'Timberland',
  'https://images.unsplash.com/photo-1520639888713-7851133b1ed0?q=80&w=687&auto=format&fit=crop',
  'En stock', 'success', 4.5, '42', 'Hombre', 'Cuero vacuno'
),
(
  'Botín de cuero para mujer',
  'Botín al tobillo en cuero negro con acabado satinado y dos cremalleras metálicas laterales.',
  289.99, 'Negro', 'Genérico',
  'https://images.unsplash.com/photo-1605732440685-d0654d81aa30?q=80&w=1470&auto=format&fit=crop',
  'En stock', 'success', 4.0, '38', 'Mujer', 'Cuero con acabado satinado'
),
(
  'Botas impermeables Timberland Premium',
  'Diseñadas hace 40 años se mantienen como un ícono global hoy en día.',
  320.99, 'Marrón', 'Timberland',
  'https://images.unsplash.com/photo-1542838776-096d877b5aa2?w=600&auto=format&fit=crop&q=60',
  'En stock', 'success', 4.5, '41', 'Hombre', 'Cuero impermeabilizado'
),
(
  'Botas brogue con puntera Barker Calder',
  'Botas elegantes con perforaciones decorativas y puntera clásica.',
  159.99, 'Marrón', 'Barker',
  'https://images.unsplash.com/photo-1638609348722-aa2a3a67db26?q=80&w=1345&auto=format&fit=crop',
  'Sin stock', 'danger', 4.0, '43', 'Hombre', 'Cuero liso'
),
(
  'Botas Dr. Martens Rojo Cereza',
  'Entrá en el modo rebelde y expresivo con la clásica suela amarilla.',
  220.99, 'Bordo', 'Dr. Martens',
  'https://plus.unsplash.com/premium_photo-1728158949987-efc83ed54df4?q=80&w=687&auto=format&fit=crop',
  'En stock', 'success', 4.0, '39', 'Unisex', 'Cuero liso'
),
(
  'Botín militar cuero negro al tobillo',
  'Silueta clásica de inspiración militar con funcionalidad moderna.',
  159.99, 'Negro', 'Genérico',
  'https://images.unsplash.com/photo-1613673720017-56e42d90fee4?w=600&auto=format&fit=crop&q=60',
  'En stock', 'success', 3.5, '40', 'Unisex', 'Cuero vacuno'
),
(
  'Botines Chelsea de cuero marrón claro',
  'Estilo clásico y versátil para uso urbano o rural. Paneles elásticos laterales y suela de goma resistente.',
  89.99, 'Marrón', 'Genérico/Artesanal',
  'https://images.unsplash.com/photo-1773425975272-35f0900a9d8f?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'En stock', 'success', 4.5, '42', 'Hombre', 'Cuero natural liso'
),
(
  'Bota vaquera cowboy Sendra negra',
  'Bota campera de caña alta con punta fina y detalles bordados. Fabricada artesanalmente en España.',
  430.99, 'Negro', 'Sendra',
  'https://images.unsplash.com/photo-1726259794537-4771f549a931?q=80&w=1608&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'En stock', 'success', 5.0, '42', 'Unisex', 'Cuero engrasado'
),
(
  'Botas de senderismo Salomon Outline Mid GTX',
  'Calzado técnico y ligero que combina la flexibilidad de una zapatilla de running con la protección y tracción necesarias para el trekking y senderismo de media montaña.',
  159.99, 'Gris', 'Salomon',
  'https://images.unsplash.com/photo-1631287381310-925554130169?q=80&w=1450&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'En stock', 'success', 4.5, '43', 'Unisex', 'Textil sintético anti-detritus + membrana Gore-Tex'
),
( 
    'Botas de cuero marrón Coclico con taco de madera',
    'Botín de cuero curtido con detalle de borde rústico, panel elástico cubierto y tacón bajo de madera natural', 
    345.00, 'Marrón', 'Coclico', 
    'https://plus.unsplash.com/premium_photo-1670983858132-c2f3c4dbf08c?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'En stock', 'success', 4.8, '38', 'Mujer', 'Cuero natural + tacón de madera' 
),
(
  'Borcego cuero nubuck todo terreno',
  'Borcego de nubuck engrasado con cuello acolchado y suela cosida.',
  275.99, 'Marrón', 'El Boyero',
  'https://images.unsplash.com/photo-1608256246200-53e635b5b65f?q=80&w=687&auto=format&fit=crop',
  'En stock', 'success', 4.0, '40', 'Hombre', 'Nubuck engrasado'
),
(
  'Botas Dr. Martens 1460 negras clásicas',
  'El modelo que definió una generación. 8 ojales, suela amarilla icónica.',
  265.99, 'Negro', 'Dr. Martens',
  'https://images.unsplash.com/photo-1616610868156-fe7e276de965?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZG9jJTIwbWFydGVuc3xlbnwwfHwwfHx8MA%3D%3D',
  'En stock', 'success', 5.0, '38', 'Unisex', 'Cuero liso suave'
);