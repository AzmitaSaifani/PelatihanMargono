import "dotenv/config";
// dotenv.config();

import express from "express";
import session from "express-session";
import cors from "cors";
import path from "path";
import authRoutes from "./routes/index.js";
import { fileURLToPath } from "url";
import captchaRoute from "./routes/auth/captcha.js";
import helmet from "helmet";
import rateLimit from "express-rate-limit";

const app = express();

// ===========================
// FIX __dirname (ESM)
// ===========================
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(
  cors({
    origin: "http://localhost:8080",
    credentials: true,
    methods: ["GET", "POST", "PUT", "DELETE"],
  }),
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(
  helmet({
    crossOriginResourcePolicy: { policy: "cross-origin" },
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],

        scriptSrc: ["'self'", "https://cdn.jsdelivr.net"],

        styleSrc: ["'self'", "'unsafe-inline'", "https://cdn.jsdelivr.net"],

        imgSrc: ["'self'", "data:", "http://localhost:5000"],

        connectSrc: ["'self'", "http://localhost:5000"],

        frameSrc: ["'self'", "http://localhost:5000"],

        frameAncestors: ["'self'", "http://localhost:8080"],
      },
    },
  }),
);

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
});

app.use(limiter);

app.use("/uploads", (req, res, next) => {
  res.header("Access-Control-Allow-Origin", "http://localhost:8080");
  next();
});

// ===========================
// STATIC FILE: Uploads
// ===========================
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// ===========================
// STATIC FILE: admin_check.js
// (TANPA MEMINDAHKAN FILE!)
// ===========================

app.get("/static/admin_check.js", (req, res) => {
  res.sendFile(path.join(__dirname, "routes/auth/admin_check.js"));
});

// ===========================
// ROUTES API
// ===========================
app.get("/", (req, res) => {
  res.send("✅ Server API pelatihan jalan!");
});

// ✅ SESSION HARUS DI APP LEVEL
app.use(
  session({
    name: "admin-session",
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false,
    cookie: {
      httpOnly: true,
      secure: false, //nanti diubah kalo mau deploy, jadi true
      sameSite: "lax",
      maxAge: 1000 * 60 * 60 * 2,
    },
  }),
);

app.use("/api", authRoutes);
app.use("/captcha", captchaRoute);

// ===========================
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server berjalan di http://localhost:${PORT}`);
});
