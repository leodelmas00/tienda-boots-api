import { Router } from "express";
import { ProductoRepository } from "../repository/producto-repository.js";

const router = Router();

// GET /api/productos?busqueda=&color=&talla=&precioMin=&precioMax=
router.get("/", async (req, res, next) => {
  try {
    const productos = await ProductoRepository.getAll(req.query);
    res.json({ ok: true, data: productos });
  } catch (err) {
    next(err);
  }
});

// GET /api/productos/:id
router.get("/:id", async (req, res, next) => {
  try {
    const producto = await ProductoRepository.getById(req.params.id);
    res.json({ ok: true, data: producto });
  } catch (err) {
    next(err);
  }
});

// POST /api/productos  (protegido — solo admin en el futuro)
router.post("/", async (req, res, next) => {
  try {
    const id = await ProductoRepository.create(req.body);
    res.status(201).json({ ok: true, id });
  } catch (err) {
    next(err);
  }
});

// PUT /api/productos/:id
router.put("/:id", async (req, res, next) => {
  try {
    const producto = await ProductoRepository.update(req.params.id, req.body);
    res.json({ ok: true, data: producto });
  } catch (err) {
    next(err);
  }
});

// DELETE /api/productos/:id
router.delete("/:id", async (req, res, next) => {
  try {
    await ProductoRepository.delete(req.params.id);
    res.json({ ok: true, message: "Producto eliminado" });
  } catch (err) {
    next(err);
  }
});

export default router;