import express from "express";
import connection from "../../config/db.js";
import { authAdmin } from "../../middleware/auth.js";
import { logAdmin } from "./adminLogger.js";
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
router.post("/", authAdmin, upload.single("foto"), (req, res) => {
  const { nama, keterangan, author, status } = req.body;
  const foto = req.file ? req.file.filename : null;

  if (!nama) {
    return res
      .status(400)
      .json({ message: "❌ Nama fasilitator wajib diisi." });
  }

  const adminId = req.user.id_user;
  const adminEmail = req.user.email;
  const adminNama = req.user.nama_lengkap;

  const sql = `
    INSERT INTO fasilitator_tb (foto, nama, keterangan, created_at, updated_at, author, status)
    VALUES (?, ?, ?, NOW(), NOW(), ?, ?)
  `;
  const values = [foto, nama, keterangan, author || "admin", status || "1"];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("CREATE ERROR:", err);
      return res.status(500).json({
        message: "Gagal menambahkan fasilitator",
      });
    }

    // LOG HANYA SAAT BERHASIL
    logAdmin({
      id_user: adminId,
      email: adminEmail,
      nama_lengkap: adminNama,
      aktivitas: "AKSI",
      keterangan: `CREATE FASILITATOR [ID:${result.insertId}] ${nama}`,
      req,
    });

    res.status(201).json({
      message: "Fasilitator berhasil ditambahkan",
      id_fasilitator: result.insertId,
    });
  });
});

router.get("/public", (req, res) => {
  const sql = `
    SELECT * FROM fasilitator_tb
    WHERE status = '1'
    ORDER BY id_fasilitator DESC
  `;

  connection.query(sql, (err, results) => {
    if (err) {
      return res.status(500).json({ message: "Gagal mengambil data" });
    }
    res.json(results);
  });
});

// === READ: Lihat semua fasilitator ===
router.get("/", authAdmin, (req, res) => {
  let sql;

  // Jika superadmin atau admin → ambil semua
  if ([1, 2].includes(Number(req.user.level_user))) {
    sql = "SELECT * FROM fasilitator_tb ORDER BY id_fasilitator DESC";
  } else {
    sql =
      "SELECT * FROM fasilitator_tb WHERE status = '1' ORDER BY id_fasilitator DESC";
  }

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
router.get("/:id", authAdmin, (req, res) => {
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
router.put("/:id", authAdmin, upload.single("foto"), (req, res) => {
  const { id } = req.params;
  const { nama, keterangan, author, status } = req.body;
  const fotoBaru = req.file ? req.file.filename : null;

  const adminId = req.user.id_user;
  const adminEmail = req.user.email;
  const adminNama = req.user.nama_lengkap;

  const getOld = "SELECT foto FROM fasilitator_tb WHERE id_fasilitator = ?";
  connection.query(getOld, [id], (err, results) => {
    if (err || results.length === 0) {
      return res
        .status(404)
        .json({ message: "❌ fasilitator tidak ditemukan." });
    }

    const oldFoto = results[0].foto;
    const oldNama = results[0].nama;

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
        console.error("UPDATE ERROR:", err);
        return res.status(500).json({
          message: "Gagal memperbarui fasilitator",
        });
      }

      // LOG SAAT BERHASIL
      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "AKSI",
        keterangan: `UPDATE FASILITATOR [ID:${id}] dari "${oldNama}" menjadi "${nama}"`,
        req,
      });

      res.status(200).json({
        message: "Fasilitator berhasil diperbarui",
      });
    });
  });
});

// === DELETE: Hapus fasilitator ===
router.delete("/:id", authAdmin, (req, res) => {
  const { id } = req.params;

  const adminId = req.user.id_user;
  const adminEmail = req.user.email;
  const adminNama = req.user.nama_lengkap;

  const getFoto = "SELECT foto FROM fasilitator_tb WHERE id_fasilitator = ?";
  connection.query(getFoto, [id], (err, results) => {
    if (err || results.length === 0) {
      return res
        .status(404)
        .json({ message: "❌ fasilitator tidak ditemukan." });
    }

    const oldNama = results[0].nama;
    const foto = results[0].foto;
    if (foto) {
      const filePath = path.join("uploads/fasilitator", foto);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    const deleteSql = "DELETE FROM fasilitator_tb WHERE id_fasilitator = ?";
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        console.error("DELETE ERROR:", err);
        return res.status(500).json({
          message: "Gagal menghapus fasilitator",
        });
      }

      // LOG SETELAH BERHASIL
      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "AKSI",
        keterangan: `DELETE FASILITATOR [ID:${id}] ${oldNama}`,
        req,
      });

      res.json({
        message: "Fasilitator berhasil dihapus",
      });
    });
  });
});

export default router;
