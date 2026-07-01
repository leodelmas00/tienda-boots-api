# tienda-boots-api

## Instalación y ejecución
1. Clonar el repositorio:
`git clone https://github.com/leodelmas00/tienda-boots-api.git`
2. Instalar dependencias:
`pnpm install`
3. Ejecutar servidor
`node ./src/index.js`

## Estructura

```
/src
|- /config (conexión a BD, variables de entorno)
|- /models (definición de entidades / ORM)
|- /controllers (lógica de los endpoints)
|- /services (lógica de negocio/reutilizable)
|- /routes (definición de rutas y versionado, p. ej. v1)
|- /middleware (auth, error-handler, validators)
|- /utils (helpers, formatters)
```