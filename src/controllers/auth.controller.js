import jwt from "jsonwebtoken";
import { UserRepository } from "../repository/user-repository.js";

export async function login(req, res) {
    const { username, password } = req.body;

    try {
        const user = await UserRepository.login({ username, password });

        const token = jwt.sign(
            {
                id: user.id,
                username: user.username,
            },
            process.env.SECRET_JWT_KEY,
            { expiresIn: "1h" }
        );

        res.cookie("access_token", token, {
            httpOnly: true,
            secure: process.env.NODE_ENV === "production",
            sameSite: "strict",
        });

        res.json({ user });

    } catch (err) {
        res.status(401).json({
            message: err.message,
        });
    }
}

export async function register(req, res) {
    const {
        username,
        nombre,
        apellido,
        email,
        password,
        dni,
        direccion,
        telefono,
    } = req.body;

    try {
        const id = await UserRepository.create({
            username,
            nombre,
            apellido,
            email,
            password,
            dni,
            direccion,
            telefono,
        });

        res.json({ id });

    } catch (err) {
        console.error(err);

        res.status(400).json({
            message: err.message,
        });
    }
}

export function logout(req, res) {
    res.clearCookie("access_token");
    res.sendStatus(200);
}

export async function me(req, res) {
    if (!req.session.user) {
        return res.status(401).json({
            message: "No autenticado",
        });
    }

    try {
        const user = await UserRepository.getById(req.session.user.id);

        res.json({ user });

    } catch (err) {
        res.status(404).json({
            message: err.message,
        });
    }
}

export async function updateProfile(req, res) {

    if (!req.session.user) {
        return res.status(401).json({
            message: "No autenticado"
        });
    }

    try {

        const data = {
            ...req.body
        };

        if (req.file) {
            data.foto_perfil = req.file.path;
        }

        const user = await UserRepository.update(
            req.session.user.id,
            data
        );

        res.json({
            user
        });

    } catch(err) {

        res.status(400).json({
            message: err.message
        });

    }
}