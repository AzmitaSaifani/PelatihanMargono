import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "./adminLogger.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

/* =========================================
   KONFIGURASI UPLOAD SERTIFIKAT
   ========================================= */
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/sertifikat";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage });

/* =========================================
   CREATE / UPLOAD SERTIFIKAT AKREDITASI
   ========================================= */
router.post("/:id/upload", upload.single("file"), (req, res) => {
  const historiAkreditasiId = req.params.id;
  const { keterangan } = req.body;
  const file = req.file ? req.file.filename : null;

  if (!file) {
    return res.status(400).json({ message: "❌ File sertifikat wajib diupload." });
  }

  const sql = `
    INSERT INTO sertifikat_akreditasi
    (histori_akreditasi_id, file_name, file_path, keterangan)
    VALUES (?, ?, ?, ?)
  `;

  const values = [
    historiAkreditasiId,
    file,
    `uploads/sertifikat/${file}`,
    keterangan,
  ];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal upload sertifikat:", err);
      return res.status(500).json({
        message: "❌ Gagal upload sertifikat",
        error: err.message,
      });
    }

    // ✅ LOG ADMIN
    logAdmin({
      id_user: req.user.id,
      email: req.user.email,
      nama_lengkap: req.user.nama_lengkap,
      aktivitas: "UPLOAD SERTIFIKAT",
      keterangan: `Upload sertifikat histori akreditasi ID ${historiAkreditasiId}`,
      req,
    });

    res.status(201).json({
      message: "✅ Sertifikat berhasil diupload!",
      id_sertifikat: result.insertId,
    });
  });
});

/* =========================================
   READ: LIST SERTIFIKAT PER HISTORI
   ========================================= */
router.get("/:histori_id", (req, res) => {
  const { histori_id } = req.params;

  const sql = `
    SELECT * FROM sertifikat_akreditasi
    WHERE histori_akreditasi_id = ?
    ORDER BY uploaded_at DESC
  `;

  connection.query(sql, [histori_id], (err, results) => {
    if (err) {
      return res.status(500).json({
        message: "❌ Gagal mengambil sertifikat",
        error: err.message,
      });
    }
    res.status(200).json(results);
  });
});

/* =========================================
   DELETE: HAPUS SERTIFIKAT
   ========================================= */
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  const getFile = "SELECT file_path FROM sertifikat_akreditasi WHERE id = ?";
  connection.query(getFile, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Sertifikat tidak ditemukan." });
    }

    const filePath = results[0].file_path;
    if (filePath && fs.existsSync(filePath)) {
      fs.unlinkSync(filePath);
    }

    const deleteSql = "DELETE FROM sertifikat_akreditasi WHERE id = ?";
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        return res.status(500).json({ message: "❌ Gagal menghapus sertifikat" });
      }

      // ✅ LOG ADMIN
      logAdmin({
        id_user: req.user.id,
        email: req.user.email,
        nama_lengkap: req.user.nama_lengkap,
        aktivitas: "DELETE SERTIFIKAT",
        keterangan: `Menghapus sertifikat ID ${id}`,
        req,
      });

      res.status(200).json({ message: "✅ Sertifikat berhasil dihapus!" });
    });
  });
});

export default router;
