import express from "express";
import cors from "cors";
import path from "path";
import authRoutes from "./routes/index.js";
import { fileURLToPath } from "url";

const app = express();

// ===========================
// FIX __dirname (ESM)
// ===========================
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// ===========================
// STATIC FILE: Uploads
// ===========================
app.use("/uploads", express.static(path.join(process.cwd(), "uploads")));


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

app.use("/api", authRoutes);

// ===========================
const PORT = 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server berjalan di http://localhost:${PORT}`);
});
