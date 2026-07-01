import express from "express";
import cors from "cors";
import clienteRoutes from "./routes/cliente.routes.js";

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/health", (req, res) => {
  res.status(200).json({ ok: true, message: "API running" });
});

app.use("/api/clientes", clienteRoutes);

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