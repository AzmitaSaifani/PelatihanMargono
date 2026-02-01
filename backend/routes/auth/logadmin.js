import express from "express";
import connection from "../../config/db.js";

const router = express.Router();

/**
 * GET /api/log-admin
 * Ambil semua log admin (latest first)
 */
router.get("/", (req, res) => {
  const sql = `
    SELECT 
      id_log,
      id_user,
      email,
      nama_lengkap,
      ip_address,
      user_agent,
      aktivitas,
      keterangan,
      created_at
    FROM log_admin
    ORDER BY created_at DESC
  `;

  connection.query(sql, (err, rows) => {
    if (err) {
      console.error("❌ Gagal ambil log admin:", err);
      return res.status(500).json({
        message: "Gagal mengambil log admin",
      });
    }

    res.status(200).json(rows);
  });
});

export default router;
