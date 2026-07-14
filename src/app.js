import express from "express";
import cookieParser from "cookie-parser";
import cors from "cors";
import "dotenv/config";

import clienteRoutes from "./routes/cliente.routes.js";
import authRoutes from "./routes/auth.routes.js";

import { authMiddleware } from "./middleware/auth.middleware.js";

const app = express();

// Middlewares

app.use(express.json());

app.use(cookieParser());

app.use(cors({
    origin: "http://localhost:5173",
    credentials: true,
}));

app.use(authMiddleware);

app.use("/uploads", express.static("uploads"));

// Rutas

app.use("/api/clientes", clienteRoutes);

app.use("/", authRoutes);

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