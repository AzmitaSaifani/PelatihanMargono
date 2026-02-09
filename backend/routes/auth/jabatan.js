import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../auth/adminLogger.js";

const router = express.Router();

/* =========================
   CREATE JABATAN (AWAL)
========================= */
router.post("/", (req, res) => {
  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  if (!adminId) {
    return res.status(401).json({ message: "Admin tidak terautentikasi" });
  }

  const {
    nama_jabatan,
    parent_id,
    level_jabatan,
    jenis_relasi,
    urutan,
    keterangan,
  } = req.body;

  if (!nama_jabatan) {
    return res.status(400).json({ message: "Nama jabatan wajib diisi" });
  }

  const sql = `
    INSERT INTO jabatan
    (nama_jabatan, parent_id, level_jabatan, jenis_relasi, urutan, keterangan)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [
      nama_jabatan,
      parent_id || null,
      level_jabatan || 1,
      jenis_relasi || "komando",
      urutan || 0,
      keterangan || null,
    ],
    (err, result) => {
      if (err) {
        console.error("Gagal tambah jabatan:", err);
        return res.status(500).json({ message: "Gagal menambah jabatan" });
      }

      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "AKSI",
        keterangan: `Tambah jabatan ${nama_jabatan}`,
        req,
      });

      res.status(201).json({
        message: "Jabatan berhasil ditambahkan",
        id_jabatan: result.insertId,
      });
    },
  );
});

/* =========================
   UPDATE JABATAN
========================= */
router.put("/:id", (req, res) => {
  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  const { id } = req.params;
  const {
    nama_jabatan,
    parent_id,
    level_jabatan,
    jenis_relasi,
    urutan,
    keterangan,
  } = req.body;

  const sql = `
    UPDATE jabatan
    SET nama_jabatan=?, parent_id=?, level_jabatan=?,
        jenis_relasi=?, urutan=?, keterangan=?
    WHERE id_jabatan=?
  `;

  connection.query(
    sql,
    [
      nama_jabatan,
      parent_id || null,
      level_jabatan,
      jenis_relasi,
      urutan,
      keterangan,
      id,
    ],
    (err) => {
      if (err) {
        console.error("Gagal update jabatan:", err);
        return res.status(500).json({ message: "Gagal update jabatan" });
      }

      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "AKSI",
        keterangan: `Update jabatan ID ${id}`,
        req,
      });

      res.json({ message: "Jabatan berhasil diperbarui" });
    },
  );
});

/* =========================
   READ STRUKTUR (TREE)
========================= */
router.get("/", (req, res) => {
  const sql = `
    SELECT id_jabatan, nama_jabatan, parent_id,
           level_jabatan, jenis_relasi, urutan
    FROM jabatan
    ORDER BY level_jabatan ASC, urutan ASC
  `;

  connection.query(sql, (err, rows) => {
    if (err) {
      return res.status(500).json({ message: "Gagal ambil struktur jabatan" });
    }
    res.json(rows);
  });
});

export default router;
