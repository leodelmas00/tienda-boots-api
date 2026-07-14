import express from "express";
import clienteRoutes from "./routes/cliente.routes.js";
import { UserRepository } from "./repository/user-repository.js";
import jwt from "jsonwebtoken";
import "dotenv/config";
import cookieParser from "cookie-parser";
import cors from "cors";

const app = express();

// Middleware

app.use(cors({
    origin: "http://localhost:5173",
    credentials: true
}));

app.use(express.json());
app.use(cookieParser());

// Verificar sesión JWT

app.use((req, res, next) => {
    const token = req.cookies.access_token;

    req.session = {
        user: null
    };

    if (!token) {
        return next();
    }

    try {
        const data = jwt.verify( token, process.env.SECRET_JWT_KEY);
        req.session.user = data;
    } catch {}
    next();
});


// Rutas

app.use("/api/clientes", clienteRoutes);

// LOGIN

app.post("/login", async (req,res) => {

    const { username, password } = req.body;

    try {
        const user = await UserRepository.login({ username, password });
        const token = jwt.sign( { id: user.id, username: user.username}, process.env.SECRET_JWT_KEY,{expiresIn: "1h"});

        res.cookie( "access_token", token,
            {
                httpOnly: true,
                secure: process.env.NODE_ENV === "production",
                sameSite: "strict"
            }
        );
        res.json({ user });
    } catch(err) {

        console.error(err);
        res.status(401).json({
            message: err.message
        });
    }

});

// REGISTER

app.post("/register", async (req,res) => {

    const {
        username,
        nombre,
        apellido,
        email,
        password,
        dni,
        direccion,
        telefono
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
            telefono
        });

        res.json({ id });

    } catch(err) {

        console.error(err);
        res.status(400).json({
            message: err.message
        });
    }

});



// LOGOUT

app.post("/logout", (req,res)=>{
    res.clearCookie( "access_token" );
    res.sendStatus(200);
});



// PROTECTED

app.get("/protected",(req,res)=>{
    const {user} = req.session;
    if(!user){
        return res.status(403).json({ message:"Acceso no autorizado"});
    }
    res.json({
        message:"Contenido protegido",
        user
    });

});

// ME

app.get("/me",(req,res)=>{
    if(!req.session.user){
        return res.status(401).json({message:"No autenticado"});
    }
    res.json({
        user:req.session.user
    });
});

// Errores

app.use((req,res)=>{
    res.status(404).json({
        ok:false,
        message:"Ruta no encontrada"
    });
});

app.use((err,req,res,next)=>{
    console.error(err);
    res.status(err.status || 500).json({
        ok:false,
        message:err.message || "Error interno"
    });
});

export default app;