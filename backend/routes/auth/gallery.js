import express from "express";
import connection from "../../config/db.js";
import { authAdmin } from "../../middleware/auth.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

const ALLOWED_KATEGORI = ["sarpras", "diskusi", "pelatihan"];

// === Konfigurasi upload foto gallery ===
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/gallery";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  },
});

const upload = multer({
  storage,
  limits: {
    fileSize: 3 * 1024 * 1024, // 3MB
  },
  fileFilter: (req, file, cb) => {
    const allowedTypes = ["image/jpeg", "image/png", "image/jpg"];

    if (!allowedTypes.includes(file.mimetype)) {
      return cb(new Error("FORMAT_FILE_INVALID"));
    }

    cb(null, true);
  },
});

// ======================================================
// ===============   CREATE GALLERY   ===================
// ======================================================
router.post("/", authAdmin, upload.single("foto"), (req, res) => {
  const { keterangan, kategori, status } = req.body;
  const foto = req.file ? req.file.filename : null;

  if (!foto) {
    return res.status(400).json({ message: "❌ Foto wajib diupload." });
  }

  if (!ALLOWED_KATEGORI.includes(kategori)) {
    return res.status(400).json({
      message: "❌ Kategori harus: sarpras, diskusi, atau pelatihan",
    });
  }

  const sql = `
    INSERT INTO gallery_tb (keterangan, foto, kategori, status)
    VALUES (?, ?, ?, ?)
  `;
  const values = [keterangan || null, foto, kategori, status || "1"];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal menambahkan gallery:", err);
      return res.status(500).json({
        message: "❌ Gagal menambahkan gallery",
        error: err.message,
      });
    }
    res.status(201).json({
      message: "✅ Gallery berhasil ditambahkan!",
      id_gallery: result.insertId,
    });
  });
});

// ======================================================
// ===============   READ ALL GALLERY   =================
// ======================================================
router.get("/", (req, res) => {
  const { admin, kategori } = req.query;

  let where = [];
  let params = [];

  if (kategori) {
    where.push("kategori = ?");
    params.push(kategori);
  }

  const whereSQL = where.length ? `WHERE ${where.join(" AND ")}` : "";
  const sql = `SELECT * FROM gallery_tb ${whereSQL} ORDER BY id DESC`;

  connection.query(sql, params, (err, results) => {
    if (err) {
      console.error("❌ Gagal mengambil gallery:", err);
      return res.status(500).json({
        message: "❌ Gagal mengambil gallery",
        error: err.message,
      });
    }

    res.status(200).json(results);
  });
});

// ======================================================
// ===============   READ DETAIL GALLERY   ==============
// ======================================================
router.get("/:id", authAdmin, (req, res) => {
  const { id } = req.params;

  const sql = "SELECT * FROM gallery_tb WHERE id = ?";
  connection.query(sql, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Gallery tidak ditemukan." });
    }
    res.status(200).json(results[0]);
  });
});

// ======================================================
// ===============   UPDATE GALLERY   ===================
// ======================================================
router.put("/:id", authAdmin, upload.single("foto"), (req, res) => {
  const { id } = req.params;
  const { keterangan, status, kategori } = req.body;
  const fotoBaru = req.file ? req.file.filename : null;

  if (kategori && !ALLOWED_KATEGORI.includes(kategori)) {
    return res.status(400).json({
      message: "❌ Kategori harus: sarpras, diskusi, atau pelatihan",
    });
  }

  const getOld = "SELECT foto FROM gallery_tb WHERE id = ?";
  connection.query(getOld, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Gallery tidak ditemukan." });
    }

    const oldFoto = results[0].foto;

    // hapus foto lama jika upload foto baru
    if (fotoBaru && oldFoto) {
      const oldPath = path.join("uploads/gallery", oldFoto);
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath);
    }

    const sql = `
      UPDATE gallery_tb
      SET keterangan=?, foto=?, kategori=?, status=?
      WHERE id=?
    `;

    const values = [
      keterangan || null,
      fotoBaru || oldFoto,
      kategori,
      status || "A",
      id,
    ];

    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal memperbarui gallery:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal memperbarui gallery" });
      }
      res.status(200).json({ message: "✅ Gallery berhasil diperbarui!" });
    });
  });
});

// ======================================================
// ===============   DELETE GALLERY   ===================
// ======================================================
router.delete("/:id", authAdmin, (req, res) => {
  const { id } = req.params;

  const getFoto = "SELECT foto FROM gallery_tb WHERE id = ?";
  connection.query(getFoto, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Gallery tidak ditemukan." });
    }

    const foto = results[0].foto;

    // hapus file foto
    if (foto) {
      const filePath = path.join("uploads/gallery", foto);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    const deleteSql = "DELETE FROM gallery_tb WHERE id = ?";
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        console.error("❌ Gagal menghapus gallery:", err);
        return res.status(500).json({ message: "❌ Gagal menghapus gallery" });
      }
      res.status(200).json({ message: "✅ Gallery berhasil dihapus!" });
    });
  });
});

router.use((err, req, res, next) => {
  // FILE TERLALU BESAR
  if (err instanceof multer.MulterError) {
    if (err.code === "LIMIT_FILE_SIZE") {
      return res.status(400).json({
        message: "Ukuran file maksimal 3MB",
      });
    }
  }

  // FORMAT SALAH
  if (err.message === "FORMAT_FILE_INVALID") {
    return res.status(400).json({
      message: "Format file harus JPG atau PNG",
    });
  }

  next(err);
});

export default router;
