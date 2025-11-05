// backend/routes/auth/pendaftaran.js
import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

// Konfigurasi upload file
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    if (file.fieldname === "surat_tugas") {
      const dir = "uploads/surat_tugas";
      if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
      cb(null, dir);
    } else {
      cb(new Error("Field file tidak dikenal"));
    }
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueSuffix}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage });

// Route Pendaftaran
router.post(
  "/",
  upload.single("surat_tugas"), // hanya 1 file
  (req, res) => {
    const {
      id_user,
      id_pelatihan,
      nik,
      nip,
      gelar_depan,
      nama_peserta,
      gelar_belakang,
      asal_instansi,
      tempat_lahir,
      tanggal_lahir,
      pendidikan,
      jenis_kelamin,
      agama,
      status_pegawai,
      kabupaten_asal,
      alamat_kantor,
      alamat_rumah,
      no_wa,
      email,
      profesi,
      jabatan,
      str,
      provinsi_asal,
      jenis_nakes,
      kabupaten_kantor,
      provinsi_kantor,
    } = req.body;

    // Validasi data wajib
    if (
      !id_user ||
      !id_pelatihan ||
      !nik ||
      !nip ||
      !nama_peserta ||
      !pendidikan ||
      !jenis_kelamin ||
      !no_wa ||
      !email
    ) {
      return res.status(400).json({
        message: "❌ Data wajib tidak boleh kosong!",
      });
    }

    const surat_tugas = req.file ? req.file.filename : null;

    const sql = `
      INSERT INTO pendaftaran_tb (
        id_user, id_pelatihan, nik, nip, gelar_depan, nama_peserta, gelar_belakang,
        asal_instansi, tempat_lahir, tanggal_lahir, pendidikan, jenis_kelamin, agama,
        status_pegawai, kabupaten_asal, alamat_kantor, alamat_rumah, no_wa, email,
        profesi, jabatan, str, provinsi_asal, jenis_nakes, kabupaten_kantor,
        provinsi_kantor, surat_tugas
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const values = [
      id_user,
      id_pelatihan,
      nik,
      nip,
      gelar_depan,
      nama_peserta,
      gelar_belakang,
      asal_instansi,
      tempat_lahir,
      tanggal_lahir,
      pendidikan,
      jenis_kelamin,
      agama,
      status_pegawai,
      kabupaten_asal,
      alamat_kantor,
      alamat_rumah,
      no_wa,
      email,
      profesi,
      jabatan,
      str,
      provinsi_asal,
      jenis_nakes,
      kabupaten_kantor,
      provinsi_kantor,
      surat_tugas,
    ];

    // Gunakan pool.getConnection biar koneksi stabil
    connection.query(sql, values, (err, result) => {
      if (err) {
        console.error("❌ Error insert pendaftaran:", err);
        return res.status(500).json({
          message: "Gagal mendaftar pelatihan",
          error: err.message,
        });
      }

      res.status(201).json({
        message: "✅ Pendaftaran pelatihan berhasil dikirim!",
        id_pendaftaran: result.insertId,
      });
    });
  }
);

// ======================
// 🟨 UPDATE PENDAFTARAN
// ======================
router.put("/:id", upload.single("surat_tugas"), (req, res) => {
  const { id } = req.params;
  const {
    nik,
    nip,
    gelar_depan,
    nama_peserta,
    gelar_belakang,
    asal_instansi,
    tempat_lahir,
    tanggal_lahir,
    pendidikan,
    jenis_kelamin,
    agama,
    status_pegawai,
    kabupaten_asal,
    alamat_kantor,
    alamat_rumah,
    no_wa,
    email,
    profesi,
    jabatan,
    str,
    provinsi_asal,
    jenis_nakes,
    kabupaten_kantor,
    provinsi_kantor,
  } = req.body;

  const surat_tugas = req.file ? req.file.filename : null;

  // Ambil data lama buat hapus file kalau ada file baru
  const getOldFile = `SELECT surat_tugas FROM pendaftaran_tb WHERE id_pendaftaran = ?`;
  connection.query(getOldFile, [id], (err, results) => {
    if (err)
      return res.status(500).json({ message: "❌ Gagal mengambil data lama." });
    if (results.length === 0)
      return res
        .status(404)
        .json({ message: "❌ Data pendaftaran tidak ditemukan." });

    const oldFile = results[0].surat_tugas;
    if (surat_tugas && oldFile) {
      const oldPath = path.join("uploads/surat_tugas", oldFile);
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath);
    }

    const sql = `
      UPDATE pendaftaran_tb SET
        nik=?, nip=?, gelar_depan=?, nama_peserta=?, gelar_belakang=?, asal_instansi=?,
        tempat_lahir=?, tanggal_lahir=?, pendidikan=?, jenis_kelamin=?, agama=?,
        status_pegawai=?, kabupaten_asal=?, alamat_kantor=?, alamat_rumah=?, no_wa=?, email=?,
        profesi=?, jabatan=?, str=?, provinsi_asal=?, jenis_nakes=?, kabupaten_kantor=?,
        provinsi_kantor=?, surat_tugas=?
      WHERE id_pendaftaran=?
    `;

    const values = [
      nik,
      nip,
      gelar_depan,
      nama_peserta,
      gelar_belakang,
      asal_instansi,
      tempat_lahir,
      tanggal_lahir,
      pendidikan,
      jenis_kelamin,
      agama,
      status_pegawai,
      kabupaten_asal,
      alamat_kantor,
      alamat_rumah,
      no_wa,
      email,
      profesi,
      jabatan,
      str,
      provinsi_asal,
      jenis_nakes,
      kabupaten_kantor,
      provinsi_kantor,
      surat_tugas || oldFile,
      id,
    ];

    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal memperbarui pendaftaran:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal memperbarui pendaftaran." });
      }

      res
        .status(200)
        .json({ message: "✅ Data pendaftaran berhasil diperbarui!" });
    });
  });
});

// ======================
// 🟥 DELETE PENDAFTARAN
// ======================
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  // Cek dulu apakah datanya ada
  const getFile = `SELECT surat_tugas FROM pendaftaran_tb WHERE id_pendaftaran = ?`;
  connection.query(getFile, [id], (err, results) => {
    if (err)
      return res.status(500).json({ message: "❌ Gagal mengambil data." });
    if (results.length === 0)
      return res
        .status(404)
        .json({ message: "❌ Data pendaftaran tidak ditemukan." });

    const file = results[0].surat_tugas;
    if (file) {
      const filePath = path.join("uploads/surat_tugas", file);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    const deleteQuery = `DELETE FROM pendaftaran_tb WHERE id_pendaftaran = ?`;
    connection.query(deleteQuery, [id], (err) => {
      if (err) {
        console.error("❌ Gagal menghapus data:", err);
        return res.status(500).json({ message: "❌ Gagal menghapus data." });
      }

      res
        .status(200)
        .json({ message: "✅ Data pendaftaran berhasil dihapus!" });
    });
  });
});

export default router;
