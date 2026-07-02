import "dotenv/config";
import app from "./app.js";
import mysql from "mysql2"

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

