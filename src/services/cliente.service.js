import pool from "../config/db.js";

export const getAllClientes = async () => {
  const [rows] = await pool.execute("SELECT * FROM Cliente");
  return rows;
};