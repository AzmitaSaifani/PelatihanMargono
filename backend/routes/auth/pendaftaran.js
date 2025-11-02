import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

// KONFIGURASI UPLOAD FILE
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    if (file.fieldname === "bukti_pembayaran") {
      const dir = "uploads/bukti_pembayaran";
      if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
      cb(null, dir);
    } else if (file.fieldname === "surat_tugas") {
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

// ROUTE PENDAFTARAN
router.post(
  "/daftar",
  upload.fields([
    // { name: "bukti_pembayaran", maxCount: 1 },
    { name: "surat_tugas", maxCount: 1 },
  ]),
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

    // const bukti_pembayaran = req.files?.bukti_pembayaran?.[0]?.filename || null;
    const surat_tugas = req.files?.surat_tugas?.[0]?.filename || null;

    // if (!bukti_pembayaran) {
    //   return res.status(400).json({
    //     message: "❌ Bukti pembayaran wajib diupload!",
    //   });
    // }

    const sql = `
      INSERT INTO pendaftaran (
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
    //   bukti_pembayaran,
      surat_tugas,
    ];

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

export default router;
