import express from "express";
import multer from "multer";
import path from "path";
import fs from "fs";
import connection from "../../config/db.js";
import { logAdmin } from "../auth/adminLogger.js";

const router = express.Router();

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/anggota";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname).toLowerCase());
  },
});

const upload = multer({ storage });

/* =========================
   CREATE ANGGOTA
========================= */
router.post("/", upload.single("foto"), (req, res) => {
  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  const { nama_lengkap, nip, email, no_hp } = req.body;
  const foto = req.file ? req.file.filename : null;

  if (!nama_lengkap) {
    return res.status(400).json({ message: "Nama wajib diisi" });
  }

  const sql = `
    INSERT INTO anggota_organisasi
    (nama_lengkap, nip, email, no_hp, foto)
    VALUES (?, ?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [nama_lengkap, nip, email, no_hp, foto],
    (err, result) => {
      if (err) {
        return res.status(500).json({ message: "Gagal tambah anggota" });
      }

      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "AKSI",
        keterangan: `Tambah anggota ${nama_lengkap}`,
        req,
      });

      res.status(201).json({
        message: "Anggota berhasil ditambahkan",
        id_anggota: result.insertId,
      });
    },
  );
});

/* =========================
   UPDATE ANGGOTA
========================= */
router.put("/:id", upload.single("foto"), (req, res) => {
  const { id } = req.params;
  let  { nama_lengkap, nip, email, no_hp, status } = req.body;

  status = status === "0" ? 0 : 1;

  const foto = req.file ? req.file.filename : null;

  const sql = `
    UPDATE anggota_organisasi
    SET nama_lengkap=?, nip=?, email=?, no_hp=?,
        foto=COALESCE(?, foto), status=?
    WHERE id_anggota=?
  `;

  connection.query(
    sql,
    [nama_lengkap, nip, email, no_hp, foto, status, id],
    (err) => {
      if (err) {
        return res.status(500).json({ message: "Gagal update anggota" });
      }
      res.json({ message: "Anggota berhasil diperbarui" });
    },
  );
});

/* =========================
   READ ANGGOTA
========================= */
router.get("/", (req, res) => {
  connection.query(
    "SELECT * FROM anggota_organisasi ORDER BY nama_lengkap ASC",
    (err, rows) => {
      if (err) {
        return res.status(500).json({ message: "Gagal ambil anggota" });
      }
      res.json(rows);
    },
  );
});

export default router;
