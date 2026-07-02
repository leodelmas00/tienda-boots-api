# tienda-boots-api

## Instalación y ejecución

1. Clonar el repositorio:

```bash
git clone https://github.com/leodelmas00/tienda-boots-api.git
```

2. Instalar las dependencias:

```bash
pnpm install
```

3. Crear un archivo `.env` en la raíz del proyecto con el siguiente contenido (adaptando los datos a tu instalación de MySQL):

```env
PORT=3000
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=tu_usuario
DB_PASSWORD=tu_password
DB_NAME=tienda_boots_db
```

4. Importar la base de datos (ver opciones más abajo).

5. Iniciar el servidor:

```bash
pnpm start
```

---

## Base de datos

El proyecto incluye un respaldo de la base de datos en:

```
database/tienda_boots_db.sql
```

### Opción 1: Importar desde la consola

Crear la base de datos:

```bash
mysql -u root -p
```

```sql
CREATE DATABASE tienda_boots_db;
EXIT;
```

Importar el respaldo:

```bash
mysql -u root -p tienda_boots_db < database/tienda_boots_db.sql
```

---

### Opción 2: Importar desde MySQL Workbench

1. Abrir **MySQL Workbench**.
2. Conectarse al servidor MySQL.
3. Crear una base de datos llamada **tienda_boots_db**.
4. Ir a **Server → Data Import**.
5. Seleccionar **Import from Self-Contained File**.
6. Elegir el archivo:

```
database/tienda_boots_db.sql
```

7. Seleccionar la base de datos **tienda_boots_db** como destino.
8. Hacer clic en **Start Import**.

---

## Estructura del proyecto

```
/src
├── config         # Conexión a la base de datos y variables de entorno
├── models         # Definición de entidades / modelos
├── controllers    # Lógica de los endpoints
├── services       # Lógica de negocio
├── routes         # Definición de rutas
├── middleware     # Middleware (auth, validaciones, manejo de errores)
└── utils          # Funciones auxiliares
```