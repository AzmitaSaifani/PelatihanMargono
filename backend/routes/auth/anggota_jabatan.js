import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../auth/adminLogger.js";

const router = express.Router();

/* =========================
   SET / GANTI ANGGOTA JABATAN
========================= */
router.post("/", (req, res) => {
  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  const { id_anggota, id_jabatan, is_utama } = req.body;

  const sql = `
    INSERT INTO anggota_jabatan
    (id_anggota, id_jabatan, is_utama, mulai_menjabat)
    VALUES (?, ?, ?, CURDATE())
  `;

  connection.query(sql, [id_anggota, id_jabatan, is_utama ?? 1], (err) => {
    if (err) {
      return res.status(500).json({ message: "Gagal menempatkan anggota" });
    }

    logAdmin({
      id_user: adminId,
      email: adminEmail,
      nama_lengkap: adminNama,
      aktivitas: "AKSI",
      keterangan: `Menempatkan anggota ${id_anggota} ke jabatan ${id_jabatan}`,
      req,
    });

    res.json({ message: "Penempatan berhasil" });
  });
});

export default router;
