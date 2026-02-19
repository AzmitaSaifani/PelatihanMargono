import express from "express";
import connection from "../../config/db.js";

const router = express.Router();

/**
 * GET /api/email-log
 * Ambil semua log email (latest first)
 */
router.get("/", (req, res) => {
  const sql = `
    SELECT 
      id_email_log,
      id_pendaftaran,
      email,
      nama_penerima,
      jenis_email,
      subject,
      status,
      error_message,
      sent_at
    FROM email_log_tb
    ORDER BY sent_at DESC
  `;

  connection.query(sql, (err, rows) => {
    if (err) {
      console.error("❌ Gagal ambil email log:", err);
      return res.status(500).json({
        message: "Gagal mengambil email log",
      });
    }

    res.status(200).json(rows);
  });
});

export default router;
