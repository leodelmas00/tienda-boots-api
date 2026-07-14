import pool from "../config/db.js";
import bcrypt from "bcrypt";


export class UserRepository {

    static async create({
        username,
        nombre,
        apellido,
        email,
        password,
        dni,
        direccion,
        telefono
    }) {
        // Validaciones

        if( typeof username !== "string" || username.trim().length < 3 ){
            throw new Error( "El username debe tener al menos 3 caracteres" );
        }

        if( typeof nombre !== "string" || nombre.trim().length < 3 ){
            throw new Error( "El nombre debe tener al menos 3 caracteres" );
        }

        if( typeof apellido !== "string" || apellido.trim().length < 3 ){
            throw new Error( "El apellido debe tener al menos 3 caracteres" );
        }

        if( typeof email !== "string" ){
            throw new Error( "Email inválido" );
        }

        if( typeof password !== "string" || password.length < 8 ){
            throw new Error( "La contraseña debe tener al menos 8 caracteres" );
        }

        if( dni && !/^\d{7,8}$/.test(dni) ){
            throw new Error( "DNI inválido");
        }

        if( telefono && !/^[0-9+\-\s()]{6,20}$/.test(telefono) ){
            throw new Error( "Teléfono inválido" );
        }

        // Usuario existente

        const [rows] = await pool.query(
            "SELECT id_cliente FROM Cliente WHERE username = ? LIMIT 1",
            [username]
        );

        if(rows.length > 0){
            throw new Error( "El username ya está registrado" );
        }

        // Hash contraseña

        const hashPassword = await bcrypt.hash( password, 10);

        // Insert

        const [result] = await pool.query(
            `
            INSERT INTO Cliente
            (
                username,
                nombre,
                apellido,
                email,
                contrasenia,
                dni,
                direccion,
                telefono
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            `,
            [
                username,
                nombre,
                apellido,
                email,
                hashPassword,
                dni || null,
                direccion || null,
                telefono || null
            ]
        );
        return result.insertId;
    }

    static async login({
        username,
        password
    }) {
        const [rows] = await pool.query(

            `
            SELECT *
            FROM Cliente
            WHERE username = ?
            LIMIT 1
            `,

            [username]

        );

        if(rows.length === 0){
            throw new Error( "Usuario no encontrado" );
        }
        
        const user = rows[0];
        const isValid = await bcrypt.compare(password, user.contrasenia);

        if(!isValid){
            throw new Error( "Contraseña incorrecta" );
        }

        return {
            id:user.id_cliente,
            username:user.username,
            nombre:user.nombre,
            apellido:user.apellido,
            email:user.email,
            dni:user.dni,
            direccion:user.direccion,
            telefono:user.telefono
        };
    }
}