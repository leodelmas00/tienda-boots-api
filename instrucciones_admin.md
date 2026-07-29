#Correr migración de db: 
(database/migration_rol.sql) contra su MySQL local para agregar la columna rol. Sin ello el backend causará error porque user-repository.js referencia a rol.

#Promover user a admin via SQL:
UPDATE Cliente SET rol = 'admin' WHERE username = 'admin';
No hay flujo de registro para crear admin users, se realiza manual.

#Rol de cliente:
Cada nuevo usuario registrado obtiene el rol de "cliente" automáticamente.

#Corriendo en puerto 3001 para el back y 5173 para el front

.env en el FRONT
VITE_API_URL=/api

#Crear .env en BACKEND
.env en el BACK (así anduvo)
PORT=3001

DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=
DB_PASSWORD=
DB_NAME=tienda_boots_db

SECRET_JWT_KEY=
FRONTEND_URL=http://localhost:5173
 
#bcrypt native build
en el pnpm install puede requerir Python + build tools