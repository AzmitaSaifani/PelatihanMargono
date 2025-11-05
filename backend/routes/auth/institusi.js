import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

// === Konfigurasi upload foto institusi ===
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/institusi";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage });

// === CREATE: Tambah institusi kerjasama ===
router.post("/", upload.single("foto"), (req, res) => {
  const { nama, link_terkait } = req.body;
  const foto = req.file ? req.file.filename : null;

  if (!nama) {
    return res.status(400).json({ message: "❌ Nama institusi wajib diisi." });
  }

  const sql = `
    INSERT INTO institusi_kerjasama_tb (nama, foto, link_terkait)
    VALUES (?, ?, ?)
  `;
  const values = [nama, foto, link_terkait];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal menambahkan institusi:", err);
      return res.status(500).json({
        message: "❌ Gagal menambahkan institusi",
        error: err.message,
      });
    }
    res.status(201).json({
      message: "✅ Institusi berhasil ditambahkan!",
      id_institusi: result.insertId,
    });
  });
});

// === READ: Lihat semua institusi ===
router.get("/", (req, res) => {
  const sql = "SELECT * FROM institusi_kerjasama_tb ORDER BY id_institusi DESC";
  connection.query(sql, (err, results) => {
    if (err) {
      console.error("❌ Gagal mengambil data institusi:", err);
      return res.status(500).json({
        message: "❌ Gagal mengambil data institusi",
        error: err.message,
      });
    }
    res.status(200).json(results);
  });
});

// === READ: Detail 1 institusi ===
router.get("/:id", (req, res) => {
  const { id } = req.params;
  const sql = "SELECT * FROM institusi_kerjasama_tb WHERE id_institusi = ?";
  connection.query(sql, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Institusi tidak ditemukan." });
    }
    res.status(200).json(results[0]);
  });
});

// === UPDATE: Edit institusi ===
router.put("/:id", upload.single("foto"), (req, res) => {
  const { id } = req.params;
  const { nama, link_terkait } = req.body;
  const foto = req.file ? req.file.filename : null;

  const getOld = "SELECT foto FROM institusi_kerjasama_tb WHERE id_institusi = ?";
  connection.query(getOld, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Institusi tidak ditemukan." });
    }

    const oldFoto = results[0].foto;
    if (foto && oldFoto) {
      const oldPath = path.join("uploads/institusi", oldFoto);
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath);
    }

    const sql = `
      UPDATE institusi_kerjasama_tb
      SET nama=?, foto=?, link_terkait=?
      WHERE id_institusi=?
    `;
    const values = [nama, foto || oldFoto, link_terkait, id];

    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal memperbarui institusi:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal memperbarui institusi" });
      }
      res.status(200).json({ message: "✅ Institusi berhasil diperbarui!" });
    });
  });
});

// === DELETE: Hapus institusi ===
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  const getFoto = "SELECT foto FROM institusi_kerjasama_tb WHERE id_institusi = ?";
  connection.query(getFoto, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Institusi tidak ditemukan." });
    }

    const foto = results[0].foto;
    if (foto) {
      const filePath = path.join("uploads/institusi", foto);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    const deleteSql = "DELETE FROM institusi_kerjasama_tb WHERE id_institusi = ?";
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        console.error("❌ Gagal menghapus institusi:", err);
        return res.status(500).json({ message: "❌ Gagal menghapus institusi" });
      }
      res.status(200).json({ message: "✅ Institusi berhasil dihapus!" });
    });
  });
});

export default router;
