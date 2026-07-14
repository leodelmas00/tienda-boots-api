import { Router } from "express";
import { upload } from "../middleware/upload.middleware.js";

import {
    login,
    register,
    logout,
    me,
    updateProfile
} from "../controllers/auth.controller.js";

const router = Router();

router.post("/login", login);

router.post("/register", register);

router.post("/logout", logout);

router.get("/me", me);

router.put( "/profile", upload.single("foto_perfil"), updateProfile);

export default router;