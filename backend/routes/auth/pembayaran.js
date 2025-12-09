// backend/routes/auth/pembayaran.js
import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

/* ===========================================
   MULTER KONFIGURASI
=========================================== */
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/bukti_transfer";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const unique = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, unique + path.extname(file.originalname));
  },
});

const upload = multer({
  storage,
});

/* ===========================================
   1️⃣ CREATE PEMBAYARAN TANPA PARAMETER ID
   FRONTEND KIRIM:
   - nama_peserta
   - no_wa
   - id_pelatihan
   - bukti_pembayaran
=========================================== */
router.post("/", upload.single("bukti_pembayaran"), (req, res) => {
  const { nama_peserta, no_wa, id_pelatihan } = req.body;

  if (!req.file) {
    return res
      .status(400)
      .json({ message: "Bukti pembayaran wajib diupload!" });
  }

  const bukti_transfer = req.file.filename;

  // Cari id_pendaftaran berdasarkan data peserta
  const sqlCari = `
      SELECT id_pendaftaran 
      FROM pendaftaran_tb
      WHERE nama_peserta=? 
      AND no_wa=? 
      AND id_pelatihan=?
      ORDER BY id_pendaftaran DESC
      LIMIT 1
  `;

  connection.query(
    sqlCari,
    [nama_peserta, no_wa, id_pelatihan],
    (err, hasil) => {
      if (err) {
        console.error("Error mencari id_pendaftaran:", err);
        return res
          .status(500)
          .json({ message: "Gagal mencari data pendaftaran" });
      }

      if (hasil.length === 0) {
        return res.status(404).json({
          message:
            "Data pendaftaran tidak ditemukan. Pastikan nama, nomor WA, dan pelatihan benar.",
        });
      }

      const id_pendaftaran = hasil[0].id_pendaftaran;

      // Insert pembayaran
      const sqlInsert = `
       INSERT INTO pembayaran_tb (id_pendaftaran, bukti_transfer, status)
       VALUES (?, ?, 'PENDING')
    `;

      connection.query(
        sqlInsert,
        [id_pendaftaran, bukti_transfer],
        (err2, result) => {
          if (err2) {
            console.error("Error insert pembayaran:", err2);
            return res
              .status(500)
              .json({ message: "Gagal menyimpan pembayaran" });
          }

          // Update status pendaftaran
          const sqlUpdatePendaftaran = `
          UPDATE pendaftaran_tb 
          SET status='menunggu'
          WHERE id_pendaftaran=?
      `;

          connection.query(sqlUpdatePendaftaran, [id_pendaftaran]);

          res.status(201).json({
            message:
              "Bukti pembayaran berhasil dikirim! Menunggu verifikasi admin.",
            id_pembayaran: result.insertId,
            id_pendaftaran,
            status: "PENDING",
          });
        }
      );
    }
  );
});

/* ===========================================
   EXPORT ROUTER
=========================================== */
export default router;
