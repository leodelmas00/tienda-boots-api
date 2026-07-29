import pool from "../config/db.js";

export class ProductoRepository {

  // Mapea snake_case de MySQL → camelCase para el frontend
  static #toClient(row) {
    return {
      id:          row.id_producto,
      nombre:      row.nombre,
      descripcion: row.descripcion,
      precio:      `$${Number(row.precio).toLocaleString("es-AR")}`,
      precioNum:   Number(row.precio),
      color:       row.color,
      marca:       row.marca,
      imagen:      row.imagen,
      stock:       row.stock,
      stockClass:  row.stock_class,
      stars:       parseFloat(row.stars),
      envio:       row.envio,
      talla:       row.talla,
      genero:      row.genero,
      material:    row.material,
    };
  }

  static async getAll({ busqueda, color, talla, precioMin, precioMax } = {}) {
    let sql    = "SELECT * FROM Producto WHERE 1=1";
    const vals = [];

    if (busqueda) { sql += " AND nombre LIKE ?";          vals.push(`%${busqueda}%`); }
    if (color)    { sql += " AND color = ?";              vals.push(color); }
    if (talla)    { sql += " AND talla = ?";              vals.push(talla); }
    if (precioMin){ sql += " AND precio >= ?";            vals.push(Number(precioMin)); }
    if (precioMax){ sql += " AND precio <= ?";            vals.push(Number(precioMax)); }

    sql += " ORDER BY id_producto ASC";

    const [rows] = await pool.query(sql, vals);
    return rows.map(ProductoRepository.#toClient);
  }

  static async getById(id) {
    const [rows] = await pool.query(
      "SELECT * FROM Producto WHERE id_producto = ? LIMIT 1",
      [id]
    );
    if (!rows.length) throw new Error("Producto no encontrado");
    return ProductoRepository.#toClient(rows[0]);
  }

  static async create({ nombre, descripcion, precio, color, marca, imagen, stock, stockClass, stars, talla, genero, material }) {
    const [result] = await pool.query(
      `INSERT INTO Producto
        (nombre, descripcion, precio, color, marca, imagen, stock, stock_class, stars, talla, genero, material)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [nombre, descripcion, precio, color, marca, imagen,
       stock ?? "En stock", stockClass ?? "success", stars ?? 0,
       talla, genero, material]
    );
    return result.insertId;
  }

  static async update(id, fields) {
    const allowed = ["nombre","descripcion","precio","color","marca","imagen","stock","stock_class","stars","talla","genero","material"];
    const cols  = [];
    const vals  = [];

    // Permite pasar stockClass (camelCase) y lo convierte
    const mapped = { ...fields, ...(fields.stockClass ? { stock_class: fields.stockClass } : {}) };
    delete mapped.stockClass;

    for (const [key, val] of Object.entries(mapped)) {
      if (allowed.includes(key) && val !== undefined) {
        cols.push(`${key} = ?`);
        vals.push(val);
      }
    }
    if (!cols.length) throw new Error("No hay campos para actualizar");
    vals.push(id);
    await pool.query(`UPDATE Producto SET ${cols.join(", ")} WHERE id_producto = ?`, vals);
    return ProductoRepository.getById(id);
  }

  static async delete(id) {
    const [result] = await pool.query("DELETE FROM Producto WHERE id_producto = ?", [id]);
    if (!result.affectedRows) throw new Error("Producto no encontrado");
    return true;
  }
}