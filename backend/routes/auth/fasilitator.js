import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

// === Konfigurasi upload foto fasilitator ===
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/fasilitator";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage });

// === CREATE: Tambah fasilitator ===
router.post("/", upload.single("foto"), (req, res) => {
  const { nama, keterangan, author, status } = req.body;
  const foto = req.file ? req.file.filename : null;

  if (!nama) {
    return res
      .status(400)
      .json({ message: "❌ Nama fasilitator wajib diisi." });
  }

  const sql = `
    INSERT INTO fasilitator_tb (foto, nama, keterangan, created_at, updated_at, author, status)
    VALUES (?, ?, ?, NOW(), NOW(), ?, ?)
  `;
  const values = [foto, nama, keterangan, author || "admin", status || "1"];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal menambahkan fasilitator:", err);
      return res.status(500).json({
        message: "❌ Gagal menambahkan fasilitator",
        error: err.message,
      });
    }
    res.status(201).json({
      message: "✅ fasilitator berhasil ditambahkan!",
      id_fasilitator: result.insertId,
    });
  });
});

// === READ: Lihat semua fasilitator ===
router.get("/", (req, res) => {
  const sql = "SELECT * FROM fasilitator_tb ORDER BY id_fasilitator DESC";
  connection.query(sql, (err, results) => {
    if (err) {
      console.error("❌ Gagal mengambil data fasilitator:", err);
      return res.status(500).json({
        message: "❌ Gagal mengambil data fasilitator",
        error: err.message,
      });
    }
    res.status(200).json(results);
  });
});

// === READ: Detail 1 fasilitator ===
router.get("/:id", (req, res) => {
  const { id } = req.params;
  const sql = "SELECT * FROM fasilitator_tb WHERE id_fasilitator = ?";
  connection.query(sql, [id], (err, results) => {
    if (err || results.length === 0) {
      return res
        .status(404)
        .json({ message: "❌ fasilitator tidak ditemukan." });
    }
    res.status(200).json(results[0]);
  });
});

// === UPDATE: Edit fasilitator ===
router.put("/:id", upload.single("foto"), (req, res) => {
  const { id } = req.params;
  const { nama, keterangan, author, status } = req.body;
  const fotoBaru = req.file ? req.file.filename : null;

  const getOld = "SELECT foto FROM fasilitator_tb WHERE id_fasilitator = ?";
  connection.query(getOld, [id], (err, results) => {
    if (err || results.length === 0) {
      return res
        .status(404)
        .json({ message: "❌ fasilitator tidak ditemukan." });
    }

    const oldFoto = results[0].foto;
    if (fotoBaru && oldFoto) {
      const oldPath = path.join("uploads/fasilitator", oldFoto);
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath);
    }

    const sql = `
      UPDATE fasilitator_tb
      SET foto=?, nama=?, keterangan=?, updated_at=NOW(), author=?, status=?
      WHERE id_fasilitator=?
    `;
    const values = [
      fotoBaru || oldFoto,
      nama,
      keterangan,
      author || "admin",
      status || "1",
      id,
    ];

    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal memperbarui fasilitator:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal memperbarui fasilitator" });
      }
      res.status(200).json({ message: "✅ fasilitator berhasil diperbarui!" });
    });
  });
});

// === DELETE: Hapus fasilitator ===
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  const getFoto = "SELECT foto FROM fasilitator_tb WHERE id_fasilitator = ?";
  connection.query(getFoto, [id], (err, results) => {
    if (err || results.length === 0) {
      return res
        .status(404)
        .json({ message: "❌ fasilitator tidak ditemukan." });
    }

    const foto = results[0].foto;
    if (foto) {
      const filePath = path.join("uploads/fasilitator", foto);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    const deleteSql = "DELETE FROM fasilitator_tb WHERE id_fasilitator = ?";
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        console.error("❌ Gagal menghapus fasilitator:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal menghapus fasilitator" });
      }
      res.status(200).json({ message: "✅ fasilitator berhasil dihapus!" });
    });
  });
});

export default router;
