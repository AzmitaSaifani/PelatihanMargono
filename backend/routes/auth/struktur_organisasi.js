import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../../routes/auth/adminLogger.js";

const router = express.Router();

/**
 * GET struktur organisasi diklat (1 aktif)
 */
router.get("/", (req, res) => {
  const sql = `
    SELECT 
    j.*,
    ao.nama_lengkap,
    ao.foto
  FROM jabatan j
  JOIN anggota_jabatan aj 
    ON j.id_jabatan = aj.id_jabatan
  JOIN anggota_organisasi ao 
    ON aj.id_anggota = ao.id_anggota
    AND ao.status = 1
  ORDER BY j.level_jabatan ASC, j.urutan ASC
  `;

  connection.query(sql, (err, rows) => {
    if (err) {
      return res.status(500).json({ message: "Gagal ambil jabatan" });
    }
    res.json(rows);
  });
});

export default router;
