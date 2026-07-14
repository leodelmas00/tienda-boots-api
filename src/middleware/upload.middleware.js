import multer from "multer";
import path from "path";

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, "uploads/");
    },

    filename: function (req, file, cb) {
        const extension = path.extname(file.originalname);

        cb(
            null,
            `perfil-${Date.now()}${extension}`
        );
    }
});


export const upload = multer({
    storage,
    limits: {
        fileSize: 2 * 1024 * 1024 // 2MB
    },
    fileFilter: (req, file, cb) => {

        if (file.mimetype.startsWith("image/")) {
            cb(null, true);
        } else {
            cb(new Error("El archivo debe ser una imagen"));
        }

    }
});