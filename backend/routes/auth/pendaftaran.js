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
    let dir;

    if (file.fieldname === "surat_tugas") {
      dir = "uploads/surat_tugas";
    } else if (file.fieldname === "foto_4x6") {
      dir = "uploads/foto_4x6";
    } else {
      return cb(new Error("Field file tidak dikenal"));
    }

    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },

  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  },
});

// VALIDASI FILE
function fileFilter(req, file, cb) {
  const allowed = ["image/jpeg", "image/png", "image/jpg", "application/pdf"];

  if (!allowed.includes(file.mimetype)) {
    return cb(new Error("Format file tidak didukung"));
  }

  cb(null, true);
}

const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 1 * 1024 * 1024 }, // 1 MB
});

// ======================
// GET Semua Pendaftaran (ADMIN)
// ======================
router.get("/", (req, res) => {
  const sql = `
    SELECT 
      p.*, 
      pel.nama_pelatihan
    FROM pendaftaran_tb p
    LEFT JOIN pelatihan_tb pel 
      ON p.id_pelatihan = pel.id_pelatihan
    ORDER BY p.id_pendaftaran DESC
  `;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error("❌ Error mengambil data pendaftaran:", err);
      return res
        .status(500)
        .json({ message: "Gagal mengambil data pendaftaran" });
    }

    res.json(results);
  });
});

// Route Pendaftaran
router.post(
  "/",
  upload.fields([
    { name: "surat_tugas", maxCount: 1 },
    { name: "foto_4x6", maxCount: 1 },
  ]),
  (req, res) => {
    const {
      id_pendaftaran,
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
      tanggal_daftar,
      str,
      provinsi_asal,
      jenis_nakes,
      kabupaten_kantor,
      provinsi_kantor,
    } = req.body;

    // Validasi data wajib
    if (
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

    const surat_tugas = req.files["surat_tugas"]
      ? req.files["surat_tugas"][0].filename
      : null;
    const foto_4x6 = req.files["foto_4x6"]
      ? req.files["foto_4x6"][0].filename
      : null;

    const cekKuota = `
      SELECT kuota - (
        SELECT COUNT(*) FROM pendaftaran_tb WHERE id_pelatihan = ?
      ) AS sisa
      FROM pelatihan_tb 
      WHERE id_pelatihan = ?
    `;

    connection.query(
      cekKuota,
      [id_pelatihan, id_pelatihan],
      (err, kuotaRes) => {
        if (err) {
          console.error("❌ Error cek kuota:", err);
          return res.status(500).json({ message: "Gagal mengecek kuota" });
        }

        const sisa = kuotaRes[0]?.sisa ?? 0;

        if (sisa <= 0) {
          return res.status(400).json({
            message: "❌ Kuota sudah penuh! Anda tidak dapat mendaftar.",
          });
        }

        const sql = `
      INSERT INTO pendaftaran_tb (
        id_pendaftaran, id_pelatihan, nik, nip, gelar_depan, nama_peserta, gelar_belakang,
        asal_instansi, tempat_lahir, tanggal_lahir, pendidikan, jenis_kelamin, agama,
        status_pegawai, kabupaten_asal, alamat_kantor, alamat_rumah, no_wa, email, tanggal_daftar, str, provinsi_asal, jenis_nakes, kabupaten_kantor,
        provinsi_kantor, surat_tugas, foto_4x6
      )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

        const values = [
          id_pendaftaran,
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
          tanggal_daftar,
          str,
          provinsi_asal,
          jenis_nakes,
          kabupaten_kantor,
          provinsi_kantor,
          surat_tugas,
          foto_4x6,
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
  }
);

// ======================
// 🟨 UPDATE PENDAFTARAN
// ======================
router.put(
  "/:id",
  upload.fields([
    { name: "surat_tugas", maxCount: 1 },
    { name: "foto_4x6", maxCount: 1 },
  ]),
  (req, res) => {
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
      tanggal_daftar,
      str,
      provinsi_asal,
      jenis_nakes,
      kabupaten_kantor,
      provinsi_kantor,
      status,
    } = req.body;

    const surat_tugas = req.files["surat_tugas"]
      ? req.files["surat_tugas"][0].filename
      : null;

    const foto_4x6 = req.files["foto_4x6"]
      ? req.files["foto_4x6"][0].filename
      : null;

    // Ambil data lama buat hapus file kalau ada file baru
    const getOldFile = `SELECT surat_tugas, foto_4x6 FROM pendaftaran_tb WHERE id_pendaftaran = ?`;
    connection.query(getOldFile, [id], (err, results) => {
      if (err)
        return res
          .status(500)
          .json({ message: "❌ Gagal mengambil data lama." });
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
        status_pegawai=?, kabupaten_asal=?, alamat_kantor=?, alamat_rumah=?, no_wa=?, email=?, tanggal_daftar=?, str=?, provinsi_asal=?, jenis_nakes=?, kabupaten_kantor=?,
        provinsi_kantor=?, status=?, surat_tugas=?, foto_4x6=?
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
        tanggal_daftar,
        str,
        provinsi_asal,
        jenis_nakes,
        kabupaten_kantor,
        provinsi_kantor,
        status,
        surat_tugas || oldFile,
        foto_4x6 || oldFile,
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
  }
);

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

// ========================================================
// 4️⃣ STATUS: ACCEPT (WAITING → WAITING_PAYMENT)
// ========================================================
router.put("/:id/accept", (req, res) => {
  const { id } = req.params;

  const sql = `
      UPDATE pendaftaran_tb 
      SET status = 'Menunggu Pembayaran'
      WHERE id_pendaftaran = ?
  `;

  connection.query(sql, [id], (err, result) => {
    if (err) return res.status(500).json({ message: "❌ Error update status" });

    if (result.affectedRows === 0)
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });

    res.json({
      message: "✅ Pendaftaran diterima!",
      status: "Menunggu Pembayaran",
    });
  });
});

// ========================================================
// 5️⃣ STATUS: REJECT (WAITING → REJECTED)
// ========================================================
router.put("/:id/reject", (req, res) => {
  const { id } = req.params;

  const sql = `
      UPDATE pendaftaran_tb 
      SET status = 'Ditolak'
      WHERE id_pendaftaran = ?
  `;

  connection.query(sql, [id], (err, result) => {
    if (err) return res.status(500).json({ message: "❌ Error update status" });

    if (result.affectedRows === 0)
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });

    res.json({
      message: "❌ Pendaftaran ditolak!",
      status: "Ditolak",
    });
  });
});

export default router;
