import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

// === Konfigurasi upload untuk flyer ===
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/flyer";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage });

// === CREATE: Tambah pelatihan ===
router.post("/", upload.single("flyer_url"), (req, res) => {
  let {
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
    status,
    created_by,
  } = req.body;

  // FIX TANGGAL KOSONG
  tanggal_mulai = tanggal_mulai && tanggal_mulai !== "" ? tanggal_mulai : null;
  tanggal_selesai =
    tanggal_selesai && tanggal_selesai !== "" ? tanggal_selesai : null;

  if (!nama_pelatihan || !tanggal_mulai || !tanggal_selesai) {
    return res.status(400).json({
      message:
        "❌ Nama pelatihan, tanggal mulai, dan tanggal selesai wajib diisi.",
    });
  }

  const flyer_url = req.file ? req.file.filename : null;

  const sql = `
    INSERT INTO pelatihan_tb (
      nama_pelatihan, deskripsi, narasumber, lokasi, alamat_lengkap,
      tanggal_mulai, tanggal_selesai, waktu_mulai, waktu_selesai, kuota,
      kategori, tipe_pelatihan, durasi, flyer_url, status, created_by, created_at
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
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
    created_by,
  ];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal menambahkan pelatihan:", err);
      return res.status(500).json({
        message: "❌ Gagal menambahkan pelatihan",
        error: err.message,
      });
    }

    res.status(201).json({
      message: "✅ Pelatihan berhasil ditambahkan!",
      id_pelatihan: result.insertId,
    });
  });
});

// === GET: Detail pelatihan by ID ===
router.get("/:id", (req, res) => {
  const { id } = req.params;

  const sql = `SELECT * FROM pelatihan_tb WHERE id_pelatihan = ?`;

  connection.query(sql, [id], (err, results) => {
    if (err) {
      console.error("❌ Error ambil detail:", err);
      return res
        .status(500)
        .json({ message: "Gagal mengambil detail pelatihan" });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: "Pelatihan tidak ditemukan" });
    }

    res.status(200).json(results[0]);
  });
});

// === READ: Lihat semua pelatihan ===
router.get("/", (req, res) => {
  const sql = `
  SELECT 
    p.id_pelatihan,
    p.nama_pelatihan,
    p.deskripsi,
    p.narasumber,
    p.lokasi,
    p.alamat_lengkap,
    p.tanggal_mulai,
    p.tanggal_selesai,
    p.waktu_mulai,
    p.waktu_selesai,
    p.kuota,
    p.kategori,
    p.tipe_pelatihan,
    p.durasi,
    p.flyer_url,
    p.status,
    p.created_by,
    p.created_at,
    p.updated_at,

    /* jumlah peserta yang status = diterima */
    (
      SELECT COUNT(*) 
      FROM pendaftaran_tb d 
      WHERE d.id_pelatihan = p.id_pelatihan
      AND d.status = 'diterima'
    ) AS jumlah_diterima,

    /* sisa kuota (kuota - peserta diterima) */
    p.kuota -
    (
      SELECT COUNT(*) 
      FROM pendaftaran_tb d 
      WHERE d.id_pelatihan = p.id_pelatihan
      AND d.status = 'diterima'
    ) AS sisa_kuota

    FROM pelatihan_tb p
    ORDER BY p.tanggal_mulai ASC
  `;

  connection.query(sql, (err, result) => {
    if (err) {
      console.error("❌ Gagal mengambil data pelatihan:", err);
      return res.status(500).json({
        message: "Gagal mengambil data pelatihan",
        error: err.message,
      });
    }
    res.status(200).json(result);
  });
});

// === UPDATE: Edit pelatihan ===
router.put("/:id", upload.single("flyer_url"), (req, res) => {
  const { id } = req.params;
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
    status,
    updated_by,
  } = req.body;

  const flyer_url = req.file ? req.file.filename : null;

  // Ambil data lama untuk hapus file lama jika ada upload baru
  const getOldFlyer = `SELECT flyer_url FROM pelatihan_tb WHERE id_pelatihan = ?`;
  connection.query(getOldFlyer, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Pelatihan tidak ditemukan." });
    }

    const oldFlyer = results[0].flyer_url;
    if (flyer_url && oldFlyer) {
      const oldPath = path.join("uploads/flyer", oldFlyer);
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath); // hapus file lama
    }

    const sql = `
      UPDATE pelatihan_tb
      SET nama_pelatihan=?, deskripsi=?, narasumber=?, lokasi=?, alamat_lengkap=?,
          tanggal_mulai=?, tanggal_selesai=?, waktu_mulai=?, waktu_selesai=?, kuota=?,
          kategori=?, tipe_pelatihan=?, durasi=?, flyer_url=?, status=?, updated_at=NOW()
      WHERE id_pelatihan=?
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
      kategori,
      tipe_pelatihan,
      durasi,
      flyer_url || oldFlyer,
      status,
      id,
    ];

    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal memperbarui pelatihan:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal memperbarui pelatihan" });
      }
      res.status(200).json({ message: "✅ Pelatihan berhasil diperbarui!" });
    });
  });
});

// === DELETE: Hapus pelatihan ===
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  // Ambil nama file dulu biar bisa dihapus dari folder
  const getFlyer = `SELECT flyer_url FROM pelatihan_tb WHERE id_pelatihan = ?`;
  connection.query(getFlyer, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Pelatihan tidak ditemukan." });
    }

    const flyer = results[0].flyer_url;
    if (flyer) {
      const flyerPath = path.join("uploads/flyer", flyer);
      if (fs.existsSync(flyerPath)) fs.unlinkSync(flyerPath); // hapus file
    }

    const deleteSql = `DELETE FROM pelatihan_tb WHERE id_pelatihan = ?`;
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        console.error("❌ Gagal menghapus pelatihan:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal menghapus pelatihan" });
      }

      res.status(200).json({ message: "✅ Pelatihan berhasil dihapus!" });
    });
  });
});

export default router;
