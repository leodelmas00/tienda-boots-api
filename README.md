# tienda-boots-api

## Resumen del proyecto

**tienda-boots-api** es la API REST de backend para una tienda online de calzado (botas, botines, borcegos). La aplicación permite a los usuarios registrarse, autenticarse, navegar productos, crear pedidos desde un carrito de compras y gestionar perfiles. Existe un rol de administrador para gestionar productos y pedidos.

El frontend es una aplicación separada (SPA con Vite, probablemente Vue o React) que se comunica con esta API.

---

## Objetivo y funcionalidad principal

- **Catálogo de productos**: Listado con filtros por búsqueda (nombre), color, talla, precio mínimo y máximo.
- **Autenticación de usuarios**: Login/logout con JWT emitido como cookie `httpOnly`. Registro con validaciones de campos.
- **Perfil de usuario**: Consulta (`/me`) y actualización de datos, incluyendo foto de perfil (upload con multer).
- **Pedidos**: Creación de pedidos desde el carrito, consulta de pedidos propios, y vista admin de todos los pedidos con cambio de estado.
- **Gestión de productos**: CRUD completo (Crear, Leer, Actualizar, Eliminar). La protección por rol admin para crear/editar/eliminar **no está implementada aún** — las rutas están abiertas.
- **Roles**: `cliente` (por defecto) y `admin`. No hay flujo de registro de admin; se promueve vía SQL directo.

---

## Arquitectura general

Arquitectura en capas (layers) sobre Express.js:

```
HTTP Request
    │
    ▼
┌──────────────┐
│   Routes     │  ← Definición de endpoints (Express Router)
├──────────────┤
│  Middleware  │  ← auth (JWT decode), upload (multer), CORS, cookies
├──────────────┤
│ Controllers  │  ← Lógica HTTP: parsea request, llama al service/repository, retorna response
├──────────────┤
│  Services    │  ← Lógica de negocio (solo cliente.service tiene implementación; el resto está vacío)
├──────────────┤
│ Repositories │  ← Acceso directo a MySQL (queries SQL, validaciones, transacciones)
├──────────────┤
│  DB Config   │  ← Pool de conexiones mysql2/promise
├──────────────┤
│   MySQL 8    │  ← Base de datos relacional
└──────────────┘
```

---

## Instrucciones para instalar y ejecutar
### Prerrequisitos
- **Node.js** (v18+ recomendado)
- **pnpm** (v11.9+)
- **MySQL 8.0** corriendo localmente
- **Python 3** + build tools (necesarios para compilar `bcrypt`)

### Instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/leodelmas00/tienda-boots-api.git
cd tienda-boots-api

# 2. Instalar dependencias
pnpm install
```

### Configurar base de datos

```bash
# 3. Crear la base de datos e importar el dump
mysql -u root -p
```

```sql
CREATE DATABASE tienda_boots_db;
EXIT;
```

```bash
# 4. Importar el esquema completo (recomendado: tienda_boots_final_db.sql)
mysql -u root -p tienda_boots_db < database/tienda_boots_final_db.sql
```

> **Importante**: Usar `database/tienda_boots_final_db.sql` ya que es el dump más actualizado con todas las columnas (incluyendo `rol`, `foto_perfil`, columnas extendidas de Producto) y datos de ejemplo (12 productos, usuarios de prueba).

> Si se usa `tienda_boots_db.sql` (versión anterior), se debe ejecutar `migration_rol.sql` y `migration_productos.sql` manualmente después.

### Configurar variables de entorno

```bash
# 5. Crear archivo .env en la raíz

PORT=3001
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=tu_usuario_mysql
DB_PASSWORD=tu_password_mysql
DB_NAME=tienda_boots_db
SECRET_JWT_KEY=tu_clave_secreta
FRONTEND_URL=http://localhost:5173
```

Nota: La SECRET_JWT_KEY esta adjunta en el final del archivo .pdf enviado por moodle. 

### Ejecutar

```bash
# 6. Iniciar el servidor
pnpm start
```

El servidor arranca en `http://localhost:3001`.

### Promover usuario a admin

No hay interfaz para crear admins. Se debe hacer por SQL:

```sql
USE tienda_boots_db;
UPDATE Cliente SET rol = 'admin' WHERE username = 'admin';
```

---

## Usuarios ya creados para usar

Si se quisiera usar esta pagina sin la necesidad de crear usuario se podrian usar estos usuarios ya cargados:

User con rol de admin:
username: admin
password: admin123

User sin privilegios de admin:
username: usuario
password: password
