import jwt from "jsonwebtoken";

export function authMiddleware(req, res, next) {

    const token = req.cookies.access_token;

    req.session = {
        user: null,
    };

    try {
        if (token) {
            req.session.user = jwt.verify(
                token,
                process.env.SECRET_JWT_KEY
            );
        }
    } catch {
        req.session.user = null;
    }

    next();
}