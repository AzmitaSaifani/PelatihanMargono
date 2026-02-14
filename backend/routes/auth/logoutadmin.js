import express from "express";
import { logAdmin } from "./adminLogger.js";

const router = express.Router();

router.post("/", (req, res) => {
  const admin = req.session?.admin;

  console.log("SESSION LOGOUT:", req.session); // hapus di production

  if (admin) {
    const adminId = admin.id_user;
    const adminEmail = admin.email;
    const adminNama = admin.nama_lengkap;

    logAdmin({
      id_user: adminId,
      email: adminEmail,
      nama_lengkap: adminNama,
      aktivitas: "LOGOUT",
      keterangan: `Admin [ID:${adminId}] ${adminNama} melakukan logout`,
      req,
    });
  }

  req.session.destroy((err) => {
    if (err) {
      console.error("SESSION DESTROY ERROR:", err);
      return res.status(500).json({ message: "Gagal logout" });
    }

    res.clearCookie("connect.sid");

    res.json({ message: "Logout berhasil" });
  });
});

export default router;
