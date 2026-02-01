import express from "express";
import { logAdminLogout } from "./adminLogger.js";

const router = express.Router();

router.post("/", (req, res) => {
  const admin = req.session?.admin; 

  // 🔍 DEBUG (boleh hapus setelah yakin)
  console.log("SESSION LOGOUT:", req.session);

  if (admin) {
    logAdminLogout({
      id_user: admin.id_user,
      email: admin.email,
      nama_lengkap: admin.nama_lengkap,
      req,
    });
  }

  // hancurkan session
  req.session?.destroy?.((err) => {
    if (err) {
      return res.status(500).json({ message: "Gagal logout" });
    }

    res.json({ message: "Logout berhasil" });
  });
});

export default router;
