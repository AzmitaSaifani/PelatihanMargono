import express from "express";
import db from "../../config/db.js";
import bcrypt from "bcryptjs";
import { auth } from "../../middleware/auth.js";
import { logAdmin } from "./adminLogger.js";

const router = express.Router();

/* ======================================================
   GET ALL ADMIN (LEVEL 1 ONLY)
====================================================== */
router.get("/", auth, (req, res) => {
  const sql = `
    SELECT 
      id_user,
      email,
      nama_lengkap,
      level_user,
      status_user,
      aktivasi,
      last_login
    FROM user_tb
    WHERE level_user = 1
    ORDER BY id_user DESC
  `;

  db.query(sql, (err, results) => {
    if (err) {
      console.error("GET ADMIN ERROR:", err);
      return res.status(500).json({ message: "Gagal mengambil data admin" });
    }
    res.status(200).json(results);
  });
});

/* ======================================================
   CREATE ADMIN
====================================================== */
router.post("/", auth, async (req, res) => {
  const { email, password, nama_lengkap } = req.body;

  if (!email || !password || !nama_lengkap) {
    return res.status(400).json({
      message: "Email, password, dan nama lengkap wajib diisi",
    });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const sql = `
      INSERT INTO user_tb
      (email, password, nama_lengkap, level_user, status_user, aktivasi)
      VALUES (?, ?, ?, 1, 1, 'Y')
    `;

    db.query(sql, [email, hashedPassword, nama_lengkap], (err, result) => {
      if (err) {
        if (err.code === "ER_DUP_ENTRY") {
          return res.status(409).json({ message: "Email sudah terdaftar" });
        }
        console.error("CREATE ADMIN ERROR:", err);
        return res.status(500).json({ message: "Gagal menambahkan admin" });
      }

      // ✅ LOG ADMIN
      logAdmin({
        id_user: req.user.id,
        email: req.user.email,
        nama_lengkap: req.user.nama_lengkap,
        aktivitas: "CREATE ADMIN",
        keterangan: `Menambah admin baru (${email})`,
        req,
      });

      res.status(201).json({ message: "Admin berhasil ditambahkan" });
    });
  } catch (err) {
    console.error("HASH ERROR:", err);
    res.status(500).json({ message: "Kesalahan server" });
  }
});

/* ======================================================
   UPDATE STATUS ADMIN (AKTIF / NONAKTIF)
====================================================== */
router.put("/:id/status", auth, (req, res) => {
  const { status_user } = req.body;
  const { id } = req.params;

  if (![0, 1].includes(Number(status_user))) {
    return res.status(400).json({ message: "Status tidak valid" });
  }

  const sql = `
    UPDATE user_tb
    SET status_user = ?
    WHERE id_user = ? AND level_user = 1
  `;

  db.query(sql, [status_user, id], (err, result) => {
    if (err) {
      console.error("UPDATE STATUS ERROR:", err);
      return res.status(500).json({ message: "Gagal update status admin" });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Admin tidak ditemukan" });
    }

    // ✅ LOG ADMIN
    logAdmin({
      id_user: req.user.id,
      email: req.user.email,
      nama_lengkap: req.user.nama_lengkap,
      aktivitas: "UPDATE ADMIN STATUS",
      keterangan: `Update status admin ID ${id} menjadi ${status_user}`,
      req,
    });

    res.json({ message: "Status admin berhasil diperbarui" });
  });
});

/* ======================================================
   DELETE ADMIN
====================================================== */
router.delete("/:id", auth, (req, res) => {
  const { id } = req.params;

  // ❌ Cegah admin menghapus dirinya sendiri
  if (Number(id) === Number(req.user.id)) {
    return res.status(400).json({
      message: "Tidak bisa menghapus akun admin sendiri",
    });
  }

  const sql = `
    DELETE FROM user_tb
    WHERE id_user = ? AND level_user = 1
  `;

  db.query(sql, [id], (err, result) => {
    if (err) {
      console.error("DELETE ADMIN ERROR:", err);
      return res.status(500).json({ message: "Gagal menghapus admin" });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Admin tidak ditemukan" });
    }

    // ✅ LOG ADMIN
    logAdmin({
      id_user: req.user.id,
      email: req.user.email,
      nama_lengkap: req.user.nama_lengkap,
      aktivitas: "DELETE ADMIN",
      keterangan: `Menghapus admin ID ${id}`,
      req,
    });

    res.json({ message: "Admin berhasil dihapus" });
  });
});

export default router;
