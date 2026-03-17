import express from "express";
import connection from "../../config/db.js";

const router = express.Router();

/**
 * GET /api/log-wa
 * Ambil semua log WhatsApp (latest first)
 */
router.get("/", (req, res) => {
  const sql = `
    SELECT 
      id_wa_log,
      id_pendaftaran,
      no_wa,
      nama_penerima,
      jenis_wa,
      pesan,
      status,
      error_message,
      sent_at
    FROM log_wa
    ORDER BY sent_at DESC
  `;

  connection.query(sql, (err, rows) => {
    if (err) {
      console.error("❌ Gagal ambil log WhatsApp:", err);
      return res.status(500).json({
        message: "Gagal mengambil log WhatsApp",
      });
    }

    res.status(200).json(rows);
  });
});

export default router;
