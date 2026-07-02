import express from "express";
import clienteRoutes from "./routes/cliente.routes.js";

const app = express();

app.use(express.json());

// Rutas

app.use("/api/clientes", clienteRoutes);


// Manejo de errores

app.use((req, res) => {
  res.status(404).json({
    ok: false,
    message: "Ruta no encontrada",
  });
});

app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).json({
    ok: false,
    message: err.message || "Error interno del servidor",
  });
});

export default app;