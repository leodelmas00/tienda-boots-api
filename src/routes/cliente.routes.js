import { Router } from "express";
import * as clienteController from "../controllers/cliente.controller.js";

const router = Router();

router.get("/", clienteController.getAllClientes);

export default router;