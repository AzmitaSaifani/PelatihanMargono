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
   GET ALL SERTIFIKAT
========================================= */
router.get("/", (req, res) => {
  const sql = `
    SELECT * FROM sertifikat_akreditasi
    ORDER BY id DESC
  `;

  connection.query(sql, (err, results) => {
    if (err) {
      return res.status(500).json({
        message: "Gagal mengambil data sertifikat",
        error: err.message,
      });
    }

    res.json(results);
  });
});

/* =========================================
   CREATE SERTIFIKAT
========================================= */
router.post("/", upload.single("foto"), (req, res) => {
  const { histori_akreditasi_id, file_name, keterangan, jenis_sertifikat } =
    req.body;
  const file = req.file ? req.file.filename : null;

  if (!file) {
    return res.status(400).json({
      message: "Foto wajib diupload",
    });
  }

  const sql = `
    INSERT INTO sertifikat_akreditasi
    (histori_akreditasi_id, file_name, file_path, keterangan, jenis_sertifikat)
    VALUES (?, ?, ?, ?, ?)
  `;

  const filePath = `uploads/sertifikat/${file}`;

  connection.query(
    sql,
    [histori_akreditasi_id, file_name, filePath, keterangan, jenis_sertifikat],
    (err, result) => {
      if (err) {
        return res.status(500).json({
          message: "Gagal menambahkan sertifikat",
          error: err.message,
        });
      }

      res.status(201).json({
        message: "Sertifikat berhasil ditambahkan",
        id: result.insertId,
      });
    },
  );
});

/* =========================================
   GET SERTIFIKAT BY ID
========================================= */
router.get("/detail/:id", (req, res) => {
  const { id } = req.params;

  const sql = `
    SELECT * FROM sertifikat_akreditasi
    WHERE id = ?
  `;

  connection.query(sql, [id], (err, results) => {
    if (err) {
      return res.status(500).json({
        message: "❌ Gagal mengambil data sertifikat",
        error: err.message,
      });
    }

    if (results.length === 0) {
      return res.status(404).json({
        message: "Data tidak ditemukan",
      });
    }

    res.json(results[0]);
  });
});

/* =========================================
   UPDATE SERTIFIKAT
========================================= */
router.put("/:id", upload.single("foto"), (req, res) => {
  const { id } = req.params;
  const { histori_akreditasi_id, file_name, keterangan, jenis_sertifikat } =
    req.body;
  const newFile = req.file ? req.file.filename : null;

  // 1. Cari data lama untuk mendapatkan path file lama
  const getOldFile = "SELECT file_path FROM sertifikat_akreditasi WHERE id = ?";
  connection.query(getOldFile, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "Data tidak ditemukan" });
    }

    const oldFilePath = results[0].file_path;
    let sql = "";
    let params = [];

    // 2. Jika ada upload foto baru
    if (newFile) {
      const newPath = `uploads/sertifikat/${newFile}`;
      sql = `
        UPDATE sertifikat_akreditasi 
        SET histori_akreditasi_id = ?, file_name = ?, file_path = ?, keterangan = ?, jenis_sertifikat = ?
        WHERE id = ?
      `;
      params = [
        histori_akreditasi_id,
        file_name,
        newPath,
        keterangan,
        jenis_sertifikat,
        id,
      ];

      // Hapus file lama secara fisik
      if (oldFilePath && fs.existsSync(oldFilePath)) {
        fs.unlinkSync(oldFilePath);
      }
    } else {
      // Jika tidak ada upload foto baru
      sql = `
        UPDATE sertifikat_akreditasi 
        SET histori_akreditasi_id = ?, file_name = ?, keterangan = ?, jenis_sertifikat = ?
        WHERE id = ?
      `;
      params = [
        histori_akreditasi_id,
        file_name,
        keterangan,
        jenis_sertifikat,
        id,
      ];
    }

    // 3. Eksekusi Update
    connection.query(sql, params, (err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ message: "Gagal update", error: err.message });
      }

      // Log Admin (Pastikan req.user ada dari middleware auth jika dipakai)
      const {
        id_user = null,
        email = "-",
        nama_lengkap = "UNKNOWN",
      } = req.user || {};
      logAdmin({
        id_user,
        email,
        nama_lengkap,
        aktivitas: "AKSI",
        keterangan: `Update sertifikat ID ${id}`,
        req,
      });

      res.status(200).json({ message: "✅ Sertifikat berhasil diupdate!" });
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
      return res
        .status(404)
        .json({ message: "❌ Sertifikat tidak ditemukan." });
    }

    const filePath = results[0].file_path;
    if (filePath && fs.existsSync(filePath)) {
      fs.unlinkSync(filePath);
    }

    const deleteSql = "DELETE FROM sertifikat_akreditasi WHERE id = ?";
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        return res
          .status(500)
          .json({ message: "❌ Gagal menghapus sertifikat" });
      }

      const {
        id_user = null,
        email = "-",
        nama_lengkap = "UNKNOWN",
      } = req.user || {};

      logAdmin({
        id_user,
        email,
        nama_lengkap,
        aktivitas: "AKSI",
        keterangan: `Menghapus sertifikat ID ${id}`,
        req,
      });

      res.status(200).json({ message: "✅ Sertifikat berhasil dihapus!" });
    });
  });
});

export default router;
