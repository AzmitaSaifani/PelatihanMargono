import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

// === Konfigurasi upload foto penyelenggara ===
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/penyelenggara";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage });

// === CREATE: Tambah penyelenggara ===
router.post("/", upload.single("foto"), (req, res) => {
  const { nama, keterangan, author, status } = req.body;
  const foto = req.file ? req.file.filename : null;

  if (!nama) {
    return res.status(400).json({ message: "❌ Nama penyelenggara wajib diisi." });
  }

  const sql = `
    INSERT INTO penyelenggara_tb (foto, nama, keterangan, created_at, updated_at, author, status)
    VALUES (?, ?, ?, NOW(), NOW(), ?, ?)
  `;
  const values = [foto, nama, keterangan, author || "admin", status || "1"];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal menambahkan penyelenggara:", err);
      return res.status(500).json({
        message: "❌ Gagal menambahkan penyelenggara",
        error: err.message,
      });
    }
    res.status(201).json({
      message: "✅ Penyelenggara berhasil ditambahkan!",
      id_penyelenggara: result.insertId,
    });
  });
});

// === READ: Lihat semua penyelenggara ===
router.get("/", (req, res) => {
  const { admin } = req.query;

  // Jika admin = 1 → ambil semua data
  let sql = "SELECT * FROM penyelenggara_tb ORDER BY id_penyelenggara DESC";

  // Jika bukan admin → hanya data aktif
  if (!admin) {
    sql = "SELECT * FROM penyelenggara_tb WHERE status = '1' ORDER BY id_penyelenggara DESC";
  }

  connection.query(sql, (err, results) => {
    if (err) {
      console.error("❌ Gagal mengambil data penyelenggara:", err);
      return res.status(500).json({
        message: "❌ Gagal mengambil data penyelenggara",
        error: err.message,
      });
    }
    res.status(200).json(results);
  });
});

// === READ: Detail 1 penyelenggara ===
router.get("/:id", (req, res) => {
  const { id } = req.params;
  const sql = "SELECT * FROM penyelenggara_tb WHERE id_penyelenggara = ?";
  connection.query(sql, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Penyelenggara tidak ditemukan." });
    }
    res.status(200).json(results[0]);
  });
});

// === UPDATE: Edit penyelenggara ===
router.put("/:id", upload.single("foto"), (req, res) => {
  const { id } = req.params;
  const { nama, keterangan, author, status } = req.body;
  const fotoBaru = req.file ? req.file.filename : null;

  const getOld = "SELECT foto FROM penyelenggara_tb WHERE id_penyelenggara = ?";
  connection.query(getOld, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Penyelenggara tidak ditemukan." });
    }

    const oldFoto = results[0].foto;
    if (fotoBaru && oldFoto) {
      const oldPath = path.join("uploads/penyelenggara", oldFoto);
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath);
    }

    const sql = `
      UPDATE penyelenggara_tb
      SET foto=?, nama=?, keterangan=?, updated_at=NOW(), author=?, status=?
      WHERE id_penyelenggara=?
    `;
    const values = [fotoBaru || oldFoto, nama, keterangan, author || "admin", status || "1", id];

    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal memperbarui penyelenggara:", err);
        return res.status(500).json({ message: "❌ Gagal memperbarui penyelenggara" });
      }
      res.status(200).json({ message: "✅ Penyelenggara berhasil diperbarui!" });
    });
  });
});

// === DELETE: Hapus penyelenggara ===
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  const getFoto = "SELECT foto FROM penyelenggara_tb WHERE id_penyelenggara = ?";
  connection.query(getFoto, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Penyelenggara tidak ditemukan." });
    }

    const foto = results[0].foto;
    if (foto) {
      const filePath = path.join("uploads/penyelenggara", foto);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    const deleteSql = "DELETE FROM penyelenggara_tb WHERE id_penyelenggara = ?";
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        console.error("❌ Gagal menghapus penyelenggara:", err);
        return res.status(500).json({ message: "❌ Gagal menghapus penyelenggara" });
      }
      res.status(200).json({ message: "✅ Penyelenggara berhasil dihapus!" });
    });
  });
});

export default router;
