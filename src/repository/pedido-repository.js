import pool from "../config/db.js";

export class PedidoRepository {

  // Crea un pedido con sus detalles en una sola transacción
  static async create(id_cliente, items) {
    // items = [{ id_producto, cantidad, precioUnitario }, ...]
    if (!items?.length) throw new Error("El carrito no puede estar vacío");

    const conn = await pool.getConnection();
    try {
      await conn.beginTransaction();

      // 1. Calcular total
      const total = items.reduce((acc, i) => acc + i.precioUnitario * i.cantidad, 0);

      // 2. Insertar Pedido
      const [pedidoResult] = await conn.query(
        `INSERT INTO Pedido (id_cliente, fecha_pedido, estado, total)
         VALUES (?, NOW(), 'pendiente', ?)`,
        [id_cliente, total]
      );
      const id_pedido = pedidoResult.insertId;

      // 3. Insertar Detalles
      for (const item of items) {
        const subtotal = item.precioUnitario * item.cantidad;
        await conn.query(
          `INSERT INTO Detalle (id_pedido, id_producto, cantidad, subtotal)
           VALUES (?, ?, ?, ?)`,
          [id_pedido, item.id_producto, item.cantidad, subtotal]
        );
      }

      await conn.commit();
      return { id_pedido, total };
    } catch (err) {
      await conn.rollback();
      throw err;
    } finally {
      conn.release();
    }
  }

  // Todos los pedidos de un cliente con su detalle
  static async getByCliente(id_cliente) {
    const [pedidos] = await pool.query(
      `SELECT id_pedido, fecha_pedido, estado, total
       FROM Pedido
       WHERE id_cliente = ?
       ORDER BY fecha_pedido DESC`,
      [id_cliente]
    );

    if (!pedidos.length) return [];

    // Para cada pedido, traer sus detalles con nombre de producto
    const result = await Promise.all(
      pedidos.map(async (p) => {
        const [detalles] = await pool.query(
          `SELECT d.id_detalle, d.cantidad, d.subtotal,
                  pr.id_producto, pr.nombre, pr.imagen, pr.color, pr.talla
           FROM Detalle d
           JOIN Producto pr ON d.id_producto = pr.id_producto
           WHERE d.id_pedido = ?`,
          [p.id_pedido]
        );
        return { ...p, detalles };
      })
    );

    return result;
  }

  // Todos los pedidos (admin) con nombre del cliente
  static async getAll() {
    const [pedidos] = await pool.query(
      `SELECT p.id_pedido, p.fecha_pedido, p.estado, p.total,
              c.nombre AS cliente_nombre, c.apellido AS cliente_apellido
       FROM Pedido p
       JOIN Cliente c ON p.id_cliente = c.id_cliente
       ORDER BY p.fecha_pedido DESC`
    );

    if (!pedidos.length) return [];

    const result = await Promise.all(
      pedidos.map(async (p) => {
        const [detalles] = await pool.query(
          `SELECT d.cantidad, d.subtotal,
                  pr.id_producto, pr.nombre, pr.imagen, pr.color, pr.talla
           FROM Detalle d
           JOIN Producto pr ON d.id_producto = pr.id_producto
           WHERE d.id_pedido = ?`,
          [p.id_pedido]
        );
        return { ...p, detalles };
      })
    );

    return result;
  }

  // Actualizar estado de un pedido (admin)
  static async updateEstado(id_pedido, estado) {
    const [result] = await pool.query(
      `UPDATE Pedido SET estado = ? WHERE id_pedido = ?`,
      [estado, id_pedido]
    );
    if (result.affectedRows === 0) throw new Error("Pedido no encontrado");
    return { id_pedido, estado };
  }

  static async getById(id_pedido) {
    const [[pedido]] = await pool.query(
      `SELECT p.id_pedido, p.fecha_pedido, p.estado, p.total,
              c.nombre AS cliente_nombre, c.apellido AS cliente_apellido
       FROM Pedido p
       JOIN Cliente c ON p.id_cliente = c.id_cliente
       WHERE p.id_pedido = ?`,
      [id_pedido]
    );
    if (!pedido) throw new Error("Pedido no encontrado");

    const [detalles] = await pool.query(
      `SELECT d.cantidad, d.subtotal,
              pr.id_producto, pr.nombre, pr.imagen, pr.color, pr.talla
       FROM Detalle d
       JOIN Producto pr ON d.id_producto = pr.id_producto
       WHERE d.id_pedido = ?`,
      [id_pedido]
    );

    return { ...pedido, detalles };
  }
}