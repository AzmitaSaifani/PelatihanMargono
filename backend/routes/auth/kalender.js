import express from "express";
import connection from "../../config/db.js";

const router = express.Router();

/* ============================================================
   CREATE — Tambah event kalender pelatihan
   ============================================================ */
router.post("/", (req, res) => {
  const {
    nama_pelatihan,
    waktu_mulai_pelatihan,
    waktu_selesai_pelatihan,
    jumlah_peserta,
    warna,
  } = req.body;

  if (!nama_pelatihan || !waktu_mulai_pelatihan || !waktu_selesai_pelatihan) {
    return res.status(400).json({
      message: "❌ Nama pelatihan, waktu mulai, dan waktu selesai wajib diisi.",
    });
  }

  const sql = `
    INSERT INTO kalender_pelatihan_tb 
    (nama_pelatihan, waktu_mulai_pelatihan, waktu_selesai_pelatihan, jumlah_peserta, warna)
    VALUES (?, ?, ?, ?, ?)
  `;

  const values = [
    nama_pelatihan,
    waktu_mulai_pelatihan,
    waktu_selesai_pelatihan,
    jumlah_peserta,
    warna,
  ];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal menambahkan kalender:", err);
      return res.status(500).json({
        message: "❌ Gagal menambahkan kalender",
        error: err.message,
      });
    }

    res.status(201).json({
      message: "✅ Kalender pelatihan berhasil ditambahkan!",
      id_kalender: result.insertId,
    });
  });
});

/* ============================================================
   READ — Ambil semua kalender
   ============================================================ */
router.get("/", (req, res) => {
  const sql = `
    SELECT * FROM kalender_pelatihan_tb
    ORDER BY waktu_mulai_pelatihan ASC
  `;

  connection.query(sql, (err, result) => {
    if (err) {
      console.error("❌ Gagal mengambil data kalender:", err);
      return res.status(500).json({
        message: "❌ Gagal mengambil data kalender",
        error: err.message,
      });
    }

    res.status(200).json(result);
  });
});

/* ============================================================
   READ — Ambil 1 kalender by ID
   ============================================================ */
router.get("/:id", (req, res) => {
  const { id } = req.params;

  const sql = `SELECT * FROM kalender_pelatihan_tb WHERE id_kalender = ?`;

  connection.query(sql, [id], (err, result) => {
    if (err || result.length === 0) {
      return res
        .status(404)
        .json({ message: "❌ Data kalender tidak ditemukan." });
    }

    res.status(200).json(result[0]);
  });
});

/* ============================================================
   UPDATE — Edit kalender
   ============================================================ */
router.put("/:id", (req, res) => {
  const { id } = req.params;

  const {
    nama_pelatihan,
    waktu_mulai_pelatihan,
    waktu_selesai_pelatihan,
    jumlah_peserta,
    warna,
  } = req.body;

  const sql = `
    UPDATE kalender_pelatihan_tb
    SET nama_pelatihan=?, waktu_mulai_pelatihan=?, waktu_selesai_pelatihan=?, 
        jumlah_peserta=?, warna=?
    WHERE id_kalender=?
  `;

  const values = [
    nama_pelatihan,
    waktu_mulai_pelatihan,
    waktu_selesai_pelatihan,
    jumlah_peserta,
    warna,
    id,
  ];

  connection.query(sql, values, (err) => {
    if (err) {
      console.error("❌ Gagal memperbarui data kalender:", err);
      return res.status(500).json({
        message: "❌ Gagal memperbarui data kalender",
        error: err.message,
      });
    }
    res
      .status(200)
      .json({ message: "✅ Kalender pelatihan berhasil diperbarui!" });
  });
});

/* ============================================================
   DELETE — Hapus kalender
   ============================================================ */
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  const sql = `DELETE FROM kalender_pelatihan_tb WHERE id_kalender = ?`;

  connection.query(sql, [id], (err) => {
    if (err) {
      console.error("❌ Gagal menghapus kalender:", err);
      return res.status(500).json({ message: "❌ Gagal menghapus kalender" });
    }

    res
      .status(200)
      .json({ message: "✅ Kalender pelatihan berhasil dihapus!" });
  });
});

export default router;
