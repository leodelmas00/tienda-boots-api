import * as clienteService from "../services/cliente.service.js";

export const getAllClientes = async (req, res, next) => {
  try {
    const clientes = await clienteService.getAllClientes();

    return res.status(200).json({
      ok: true,
      data: clientes,
    });
  } catch (error) {
    next(error);
  }
};