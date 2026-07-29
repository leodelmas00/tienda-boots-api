import { Router } from "express";
import { PedidoRepository } from "../repository/pedido-repository.js";

const router = Router();

// POST /api/pedidos  — crear pedido desde el carrito
// Requiere sesión activa (authMiddleware ya carga req.session.user)
router.post("/", async (req, res, next) => {
  try {
    if (!req.session.user) {
      return res.status(401).json({ ok: false, message: "Debes iniciar sesión para comprar" });
    }

    const { items } = req.body;
    // items: [{ id_producto, cantidad, precioUnitario }]
    if (!Array.isArray(items) || !items.length) {
      return res.status(400).json({ ok: false, message: "El carrito está vacío" });
    }

    const pedido = await PedidoRepository.create(req.session.user.id, items);
    res.status(201).json({ ok: true, data: pedido });
  } catch (err) {
    next(err);
  }
});

// GET /api/pedidos/admin  — todos los pedidos (admin)
router.get("/admin", async (req, res, next) => {
  try {
    const pedidos = await PedidoRepository.getAll();
    res.json({ ok: true, data: pedidos });
  } catch (err) {
    next(err);
  }
});

// PUT /api/pedidos/:id/estado  — cambiar estado de un pedido (admin)
router.put("/:id/estado", async (req, res, next) => {
  try {
    const { estado } = req.body;
    if (!estado) {
      return res.status(400).json({ ok: false, message: "El estado es requerido" });
    }
    const result = await PedidoRepository.updateEstado(req.params.id, estado);
    res.json({ ok: true, data: result });
  } catch (err) {
    next(err);
  }
});

// GET /api/pedidos  — pedidos del cliente logueado
router.get("/", async (req, res, next) => {
  try {
    if (!req.session.user) {
      return res.status(401).json({ ok: false, message: "No autenticado" });
    }
    const pedidos = await PedidoRepository.getByCliente(req.session.user.id);
    res.json({ ok: true, data: pedidos });
  } catch (err) {
    next(err);
  }
});

// GET /api/pedidos/:id
router.get("/:id", async (req, res, next) => {
  try {
    if (!req.session.user) {
      return res.status(401).json({ ok: false, message: "No autenticado" });
    }
    const pedido = await PedidoRepository.getById(req.params.id);
    res.json({ ok: true, data: pedido });
  } catch (err) {
    next(err);
  }
});

export default router;