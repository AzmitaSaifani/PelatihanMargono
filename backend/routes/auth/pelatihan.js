import express from "express";
import db from "../../config/db.js";
const router = express.Router();

// ===== POST /pelatihan =====
router.post("/", (req, res) => {
  const {
    nama_pelatihan,
    deskripsi,
    narasumber,
    lokasi,
    alamat_lengkap,
    tanggal_mulai,
    tanggal_selesai,
    waktu_mulai,
    waktu_selesai,
    kuota,
    kategori,
    tipe_pelatihan,
    durasi,
    flyer_url,
    status,
    created_by,
  } = req.body;

  // Validasi sederhana
  if (!nama_pelatihan || !tanggal_mulai || !tanggal_selesai) {
    return res.status(400).json({ message: "Nama dan tanggal wajib diisi" });
  }

  const sql = `
    INSERT INTO pelatihan 
    (nama_pelatihan, deskripsi, narasumber, lokasi, alamat_lengkap, tanggal_mulai, tanggal_selesai, waktu_mulai, waktu_selesai, kuota, kategori, tipe_pelatihan, durasi, flyer_url, status, created_by)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  const values = [
    nama_pelatihan,
    deskripsi,
    narasumber,
    lokasi,
    alamat_lengkap,
    tanggal_mulai,
    tanggal_selesai,
    waktu_mulai,
    waktu_selesai,
    kuota,
    kategori || "internal",
    tipe_pelatihan,
    durasi,
    flyer_url,
    status || "draft",
    created_by || null,
  ];

  db.query(sql, values, (err, result) => {
    if (err) {
      console.error("Error insert pelatihan:", err);
      return res
        .status(500)
        .json({ message: "Gagal menambahkan pelatihan", error: err });
    }
    res.status(201).json({
      message: "Pelatihan berhasil ditambahkan",
      id_pelatihan: result.insertId,
    });
  });
});

export default router;