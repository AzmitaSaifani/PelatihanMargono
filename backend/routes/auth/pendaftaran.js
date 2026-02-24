// backend/routes/auth/pendaftaran.js
import { logAdmin } from "../../routes/auth/adminLogger.js";
import { sendEmail } from "../../utils/email.js";
import { logEmail } from "../../utils/emailLogger.js";
import { encryptId, decryptId } from "../../routes/auth/token.js";
import express from "express";
import connection from "../../config/db.js";
import { authAdmin } from "../../middleware/auth.js";
import multer from "multer";
import path from "path";
import fs from "fs";
import ExcelJS from "exceljs";

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

// ========================================================
// CEK DUPLIKAT NIK / NIP PADA PELATIHAN YANG SAMA
// ========================================================
router.get("/check-duplikat", (req, res) => {
  const { id_pelatihan, nik, nip } = req.query;

  if (!id_pelatihan || !nik || !nip) {
    return res.status(400).json({
      message: "Parameter id_pelatihan, nik, dan nip wajib diisi",
    });
  }

  const sql = `
    SELECT id_pendaftaran
    FROM pendaftaran_tb
    WHERE id_pelatihan = ?
      AND (nik = ? OR nip = ?)
    LIMIT 1
  `;

  connection.query(sql, [id_pelatihan, nik, nip], (err, rows) => {
    if (err) {
      console.error("❌ Error cek duplikat:", err);
      return res.status(500).json({
        message: "Gagal mengecek data duplikat",
      });
    }

    if (rows.length > 0) {
      return res.json({
        duplicate: true,
        message: "NIK atau NIP sudah terdaftar pada pelatihan yang sama",
      });
    }

    res.json({
      duplicate: false,
      message: "Data belum terdaftar, boleh lanjut",
    });
  });
});

// ======================
// GET Semua Pendaftaran (ADMIN)
// ======================
router.get("/:id/cek-upload", authAdmin, (req, res) => {
  const { id } = req.params;

  const sql = `
    SELECT id_pendaftaran, status
    FROM pendaftaran_tb
    WHERE id_pendaftaran = ?
  `;

  connection.query(sql, [id], (err, rows) => {
    if (err) {
      return res.status(500).json({
        message: "Gagal cek data pendaftaran",
      });
    }

    if (rows.length === 0) {
      return res.status(404).json({
        message: "Pendaftaran tidak ditemukan",
      });
    }

    if (rows[0].status !== "Menunggu Pembayaran") {
      return res.status(403).json({
        message: "Upload pembayaran belum diizinkan",
      });
    }

    //  BOLEH AKSES HALAMAN
    res.json({ ok: true });
  });
});

router.get("/", (req, res) => {
  const sql = `
    SELECT 
      daftar.*,
      pel.nama_pelatihan
    FROM pendaftaran_tb daftar
    LEFT JOIN pelatihan_tb pel
      ON daftar.id_pelatihan = pel.id_pelatihan
    ORDER BY daftar.id_pendaftaran DESC
  `;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({
        message: "Gagal mengambil data pendaftaran",
      });
    }

    res.json(results);
  });
});

// Route Pendaftaran
router.post(
  "/public",
  upload.fields([
    { name: "surat_tugas", maxCount: 1 },
    { name: "foto_4x6", maxCount: 1 },
  ]),
  async (req, res) => {
    const {
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
      pangkat_golongan,
      kabupaten_asal,
      alamat_kantor,
      alamat_rumah,
      no_wa,
      email,
      str,
      provinsi_asal,
      jenis_nakes,
      jabatan,
      kabupaten_kantor,
      provinsi_kantor,
    } = req.body;

    // ======================
    // VALIDASI LOGIKA JABATAN
    // ======================

    if (!jenis_nakes) {
      jabatan = null;
    }

    if (jenis_nakes === "Lain-lain") {
      jabatan = "Lain-lain";
    }

    // Kalau bukan ASN → pangkat null
    if (
      status_pegawai !== "ASN Kemenkes" &&
      status_pegawai !== "ASN Non Kemenkes"
    ) {
      pangkat_golongan = null;
    }

    // VALIDASI
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
      return res
        .status(400)
        .json({ message: "❌ Data wajib tidak boleh kosong!" });
    }

    const surat_tugas = req.files?.surat_tugas?.[0]?.filename ?? null;
    const foto_4x6 = req.files?.foto_4x6?.[0]?.filename ?? null;

    // =====================================================
    // AMBIL HARGA PELATIHAN
    // =====================================================
    const getHargaSQL = `
      SELECT harga
      FROM pelatihan_tb
      WHERE id_pelatihan = ?
    `;

    connection.query(getHargaSQL, [id_pelatihan], (err, hargaRes) => {
      if (err) {
        console.error("❌ Error ambil harga:", err);
        return res
          .status(500)
          .json({ message: "Gagal mengambil harga pelatihan" });
      }

      if (hargaRes.length === 0) {
        return res.status(404).json({
          message: "Pelatihan tidak ditemukan",
        });
      }

      const harga_pelatihan = hargaRes[0].harga;

      // =====================================================
      // CEK KUOTA
      // =====================================================
      const cekKuotaSQL = `
        SELECT kuota - (
          SELECT COUNT(*) 
          FROM pendaftaran_tb 
          WHERE id_pelatihan = ?
        ) AS sisa
        FROM pelatihan_tb
        WHERE id_pelatihan = ?
      `;

      connection.query(
        cekKuotaSQL,
        [id_pelatihan, id_pelatihan],
        (err, kuotaRes) => {
          if (err) {
            console.error("❌ Error cek kuota:", err);
            return res.status(500).json({
              message: "Gagal cek kuota",
            });
          }

          if (kuotaRes[0].sisa <= 0) {
            return res.status(400).json({
              message: "❌ Kuota sudah penuh!",
            });
          }

          if (status_pegawai === "Non ASN") {
            pangkat_golongan = null;
          }

          // ======================
          // INSERT PENDAFTARAN
          // ======================
          const insertSQL = `
          INSERT INTO pendaftaran_tb (
            id_pelatihan, harga_pelatihan,  nik, nip, gelar_depan, nama_peserta, gelar_belakang,
            asal_instansi, tempat_lahir, tanggal_lahir, pendidikan, jenis_kelamin, agama,
            status_pegawai, pangkat_golongan, kabupaten_asal, alamat_kantor, alamat_rumah, no_wa, email, str, provinsi_asal, jenis_nakes, jabatan, kabupaten_kantor,
            provinsi_kantor, surat_tugas, foto_4x6, status
          )
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

          const values = [
            id_pelatihan,
            harga_pelatihan,
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
            pangkat_golongan,
            kabupaten_asal,
            alamat_kantor,
            alamat_rumah,
            no_wa,
            email,
            str,
            provinsi_asal,
            jenis_nakes,
            jabatan,
            kabupaten_kantor,
            provinsi_kantor,
            surat_tugas,
            foto_4x6,
            "Menunggu Verifikasi Berkas",
          ];

          connection.query(insertSQL, values, async (err, result) => {
            if (err) {
              console.error("❌ Error insert pendaftaran:", err);
              return res.status(500).json({ message: "Gagal mendaftar" });
            }

            const newId = result.insertId;

            // ======================
            // AMBIL DATA PELATIHAN
            // ======================
            const getPelatihanSQL = `
              SELECT 
                nama_pelatihan,
                tanggal_mulai,
                tanggal_selesai
              FROM pelatihan_tb
              WHERE id_pelatihan = ?
            `;

            connection.query(
              getPelatihanSQL,
              [id_pelatihan],
              async (err, pelRes) => {
                if (err || pelRes.length === 0) {
                  console.error("❌ Error ambil data pelatihan:", err);
                  return res.status(500).json({
                    message: "Gagal mengambil data pelatihan",
                  });
                }

                const { nama_pelatihan, tanggal_mulai, tanggal_selesai } =
                  pelRes[0];

                const formatTanggal = (dateStr) => {
                  return new Date(dateStr).toLocaleDateString("id-ID", {
                    day: "numeric",
                    month: "long",
                    year: "numeric",
                  });
                };

                const waktuPelaksanaan = `${formatTanggal(
                  tanggal_mulai,
                )} s.d. ${formatTanggal(tanggal_selesai)}`;

                // ======================
                // KIRIM EMAIL (AMAN)
                // ======================
                let emailStatus = "GAGAL";
                try {
                  const sent = await sendEmail({
                    to: email,
                    subject:
                      "Pendaftaran Berhasil – Menunggu Verifikasi Berkas",
                    html: `
                  <p>Yth. <b>${nama_peserta}</b>,</p>

                  <p>
                    Terima kasih telah mendaftar pelatihan di
                    <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>.
                  </p>

                  <p><b>Detail Pendaftaran Pelatihan:</b></p>
                    <table cellpadding="6" cellspacing="0" style="border-collapse:collapse;">
                      <tr>
                        <td><b>Nama Peserta</b></td>
                        <td>:</td>
                        <td>${nama_peserta}</td>
                      </tr>
                      <tr>
                        <td><b>Nama Pelatihan</b></td>
                        <td>:</td>
                        <td>${nama_pelatihan}</td>
                      </tr>
                      <tr>
                        <td><b>Waktu Pelaksanaan</b></td>
                        <td>:</td>
                        <td>${waktuPelaksanaan}</td>
                      </tr>
                    </table>

                    <br>

                    <p>
                      Berkas pendaftaran Anda telah kami terima dan saat ini
                      sedang dalam proses <b>verifikasi oleh tim kami</b>.
                    </p>

                    <p>
                      Status pendaftaran Anda saat ini:
                      <b>Menunggu Verifikasi Berkas</b>
                    </p>

                    <p>
                      Informasi lanjutan akan kami sampaikan melalui email berikutnya.
                    </p>

                  <br>
                  <p>
                    Hormat kami,<br>
                    <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
                  </p>
                `,
                  });
                  if (sent) emailStatus = "TERKIRIM";

                  await logEmail({
                    id_pendaftaran: newId,
                    email,
                    nama_penerima: nama_peserta,
                    jenis_email: "BERKAS_PENDING",
                    subject:
                      "Pendaftaran Berhasil – Menunggu Verifikasi Berkas",
                    status: emailStatus,
                  });
                } catch (errEmail) {
                  await logEmail({
                    id_pendaftaran: newId,
                    email,
                    nama_penerima: nama_peserta,
                    jenis_email: "BERKAS_PENDING",
                    subject:
                      "Pendaftaran Berhasil – Menunggu Verifikasi Berkas",
                    status: "GAGAL",
                    error_message: errEmail.message,
                  });
                }

                res.status(201).json({
                  message: "✅ Pendaftaran berhasil",
                  id_pendaftaran: newId,
                });
              },
            );
          });
        },
      );
    });
  },
);
// ======================
// UPDATE PENDAFTARAN
// ======================
router.put(
  "/:id",
  authAdmin,
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
      pangkat_golongan,
      kabupaten_asal,
      alamat_kantor,
      alamat_rumah,
      no_wa,
      email,
      tanggal_daftar,
      str,
      provinsi_asal,
      jenis_nakes,
      jabatan,
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
        status_pegawai=?, pangkat_golongan=?, kabupaten_asal=?, alamat_kantor=?, alamat_rumah=?, no_wa=?, email=?, tanggal_daftar=?, str=?, provinsi_asal=?, jenis_nakes=?, jabatan=?, kabupaten_kantor=?,
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
        pangkat_golongan,
        kabupaten_asal,
        alamat_kantor,
        alamat_rumah,
        no_wa,
        email,
        tanggal_daftar,
        str,
        provinsi_asal,
        jenis_nakes,
        jabatan,
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
  },
);

// ======================
//  DELETE PENDAFTARAN
// ======================
router.delete("/:id", authAdmin, (req, res) => {
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
// STATUS: BERKAS VALID → MENUNGGU PEMBAYARAN + EMAIL
// ========================================================
router.put("/:id/accept", authAdmin, (req, res) => {
  const { id } = req.params;

  const getPesertaSQL = `
    SELECT 
      d.nama_peserta,
      d.email,
      d.harga_pelatihan,
      p.nama_pelatihan,
    p.tanggal_mulai,
    p.tanggal_selesai
  FROM pendaftaran_tb d
  JOIN pelatihan_tb p
    ON d.id_pelatihan = p.id_pelatihan
  WHERE d.id_pendaftaran = ?
  `;

  connection.query(getPesertaSQL, [id], async (err, pesertaRes) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Gagal mengambil data peserta" });
    }

    if (pesertaRes.length === 0) {
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });
    }

    const {
      nama_peserta,
      email,
      harga_pelatihan,
      nama_pelatihan,
      tanggal_mulai,
      tanggal_selesai,
    } = pesertaRes[0];

    // ======================
    // FORMAT TANGGAL
    // ======================
    const formatTanggal = (dateStr) => {
      if (!dateStr) return "-";
      return new Date(dateStr).toLocaleDateString("id-ID", {
        day: "numeric",
        month: "long",
        year: "numeric",
      });
    };

    const waktuPelaksanaan = `${formatTanggal(
      tanggal_mulai,
    )} s.d. ${formatTanggal(tanggal_selesai)}`;

    // 🔐 TOKEN PEMBAYARAN
    const token = encryptId(id);

    // ======================
    // UPDATE STATUS
    // ======================
    const updateStatusSQL = `
      UPDATE pendaftaran_tb 
      SET status = 'Menunggu Pembayaran'
      WHERE id_pendaftaran = ?
    `;

    connection.query(updateStatusSQL, [id], async (err) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: "Gagal update status" });
      }

      // 📧 EMAIL
      let emailStatus = "GAGAL";
      let errorMessage = null;

      try {
        const sent = await sendEmail({
          to: email,
          subject: "Instruksi Pembayaran Pelatihan",
          html: `
            <p>Yth. <b>${nama_peserta}</b>,</p>

            <p>
              Terima kasih telah mendaftar pelatihan di
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>.
            </p>

            <p>
              Berkas pendaftaran Anda telah <b>DINYATAKAN VALID</b>.
            </p>

            <hr>

            <p><b>Detail Pelatihan:</b></p>
            <table cellpadding="6" cellspacing="0" style="border-collapse:collapse;">
              <tr>
                <td><b>Nama Pelatihan</b></td>
                <td>:</td>
                <td>${nama_pelatihan}</td>
              </tr>
              <tr>
                <td><b>Waktu Pelaksanaan</b></td>
                <td>:</td>
                <td>${waktuPelaksanaan}</td>
              </tr>
              <tr>
                <td><b>Biaya</b></td>
                <td>:</td>
                <td><b>Rp ${Number(harga_pelatihan).toLocaleString(
                  "id-ID",
                )}</b></td>
              </tr>
            </table>

            <br>

            <p><b>Langkah Selanjutnya:</b></p>
            <ol>
              <li>Lakukan pembayaran sesuai nominal</li>
              <li>Simpan bukti transfer</li>
              <li>
                Upload bukti pembayaran melalui link berikut:<br>
                <a href="http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=${token}">
                  Upload Bukti Pembayaran
                </a>
              </li>
            </ol>

            <p>
              Status pendaftaran Anda saat ini:
              <b>Menunggu Pembayaran</b>
            </p>

            <br>
            <p>
              Hormat kami,<br>
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
            </p>
          `,
        });

        if (sent !== false) {
          emailStatus = "TERKIRIM";
        }
      } catch (emailErr) {
        console.error("Email gagal dikirim:", emailErr.message);
      }

      // 2️⃣ Log email ke database (WAJIB setelah try/catch)
      await logEmail({
        id_pendaftaran: id,
        email,
        nama_penerima: nama_peserta,
        jenis_email: "BERKAS_VALID",
        subject: "Berkas Dinyatakan Valid – Menunggu Pembayaran",
        status: emailStatus,
        error_message: emailStatus === "GAGAL" ? errorMessage : null,
      });

      console.log("ADMIN HEADER:", {
        adminId,
      });

      // ================= ADMIN LOG =================
      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "AKSI",
        keterangan: `Verifikasi berkas VALID untuk ID ${id} (${nama_peserta})`,
        req,
      });

      res.json({
        message:
          "✅ Berkas valid. Status diubah ke Menunggu Pembayaran & email terkirim",
        status: "Menunggu Pembayaran",
      });
    });
  });
});

// ========================================================
// VALIDASI TOKEN UNTUK HALAMAN UPLOAD PEMBAYARAN
// ========================================================
router.get("/validate-token/:token", (req, res) => {
  const { token } = req.params;

  let id_pendaftaran;
  try {
    id_pendaftaran = decryptId(token);
  } catch {
    return res.status(403).json({ message: "Token tidak valid" });
  }

  const sql = `
    SELECT id_pendaftaran, status
    FROM pendaftaran_tb
    WHERE id_pendaftaran = ?
  `;

  connection.query(sql, [id_pendaftaran], (err, rows) => {
    if (err) return res.status(500).json({ message: "Server error" });

    if (rows.length === 0) {
      return res.status(404).json({ message: "Data tidak ditemukan" });
    }

    if (rows[0].status !== "Menunggu Pembayaran") {
      return res.status(403).json({
        message:
          "Pembayaran hanya dapat dilakukan jika status Menunggu Pembayaran",
      });
    }

    res.json({
      ok: true,
      id_pendaftaran,
    });
  });
});

// ========================================================
//  STATUS: REJECT (VERIFIKASI BERKAS INVALID + EMAIL)
// ========================================================
router.put("/:id/reject", authAdmin, (req, res) => {
  const { id } = req.params;

  // 1. Ambil data peserta (email & nama)
  const getPesertaSQL = `
    SELECT
      nama_peserta,
      email,
      p.nama_pelatihan,
      p.tanggal_mulai,
      p.tanggal_selesai
    FROM pendaftaran_tb d
    JOIN pelatihan_tb p
      ON d.id_pelatihan = p.id_pelatihan
    WHERE d.id_pendaftaran = ?
  `;

  connection.query(getPesertaSQL, [id], async (err, pesertaRes) => {
    if (err) {
      console.error("❌ Error ambil data peserta:", err);
      return res.status(500).json({ message: "Gagal mengambil data peserta" });
    }

    if (pesertaRes.length === 0) {
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });
    }

    const {
      nama_peserta,
      email,
      nama_pelatihan,
      tanggal_mulai,
      tanggal_selesai,
    } = pesertaRes[0];

    // ======================
    // FORMAT TANGGAL
    // ======================
    const formatTanggal = (dateStr) => {
      if (!dateStr) return "-";
      return new Date(dateStr).toLocaleDateString("id-ID", {
        day: "numeric",
        month: "long",
        year: "numeric",
      });
    };

    const waktuPelaksanaan = `${formatTanggal(
      tanggal_mulai,
    )} s.d. ${formatTanggal(tanggal_selesai)}`;

    // ======================
    // UPDATE STATUS
    // ======================
    const updateStatusSQL = `
      UPDATE pendaftaran_tb 
      SET status = 'Verifikasi Berkas Invalid'
      WHERE id_pendaftaran = ?
    `;

    connection.query(updateStatusSQL, [id], async (err) => {
      if (err) {
        console.error("❌ Error update status:", err);
        return res.status(500).json({ message: "Gagal update status" });
      }

      // 2. Update status
      const updateStatusSQL = `
      UPDATE pendaftaran_tb 
      SET status = 'Verifikasi Berkas Invalid'
      WHERE id_pendaftaran = ?
    `;

      connection.query(updateStatusSQL, [id], async (err) => {
        if (err) {
          console.error("❌ Error update status:", err);
          return res.status(500).json({ message: "Gagal update status" });
        }

        // 3. Kirim email (AMAN: gagal email ≠ gagal update)
        try {
          await sendEmail({
            to: email,
            subject: "Informasi Verifikasi Berkas Pendaftaran Pelatihan",
            html: `
            <p>Yth. <b>${nama_peserta}</b>,</p>

            <p>
              Terima kasih telah mendaftar pelatihan di
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>.
            </p>

            <p>
              Setelah dilakukan proses verifikasi, kami informasikan bahwa
              <b>berkas pendaftaran Anda dinyatakan belum valid</b>.
            </p>

            <hr>

            <p><b>Detail Pelatihan:</b></p>
            <table cellpadding="6" cellspacing="0" style="border-collapse:collapse;">
              <tr>
                <td><b>Nama Pelatihan</b></td>
                <td>:</td>
                <td>${nama_pelatihan}</td>
              </tr>
              <tr>
                <td><b>Waktu Pelaksanaan</b></td>
                <td>:</td>
                <td>${waktuPelaksanaan}</td>
              </tr>
            </table>

            <br>

            <p>
              Adapun beberapa kemungkinan penyebab berkas belum valid, antara lain:
            </p>
            <ul>
              <li>Dokumen tidak lengkap</li>
              <li>Format dokumen tidak sesuai</li>
              <li>Data pada dokumen tidak terbaca dengan jelas</li>
            </ul>

            <p>
              Tim kami akan menghubungi Anda untuk menyampaikan
              informasi lebih lanjut terkait perbaikan berkas.
            </p>

            <p>
              Mohon memastikan email dan nomor kontak Anda tetap aktif.
            </p>

            <br>
            <p>
              Hormat kami,<br>
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
            </p>
          `,
          });

          console.log("📧 Email verifikasi invalid terkirim ke:", email);
        } catch (emailErr) {
          console.error("⚠️ Email gagal dikirim:", emailErr.message);
        }

        await logEmail({
          id_pendaftaran: id,
          email,
          nama_penerima: nama_peserta,
          jenis_email: "BERKAS_INVALID",
          subject: "Berkas Tidak Valid",
          status: "TERKIRIM",
        });

        console.log("ADMIN HEADER:", {
          adminId,
        });

        // ================= ADMIN LOG =================
        logAdmin({
          id_user: adminId,
          email: adminEmail,
          nama_lengkap: adminNama,
          aktivitas: "AKSI",
          keterangan: `Verifikasi berkas INVALID untuk ID ${id} (${nama_peserta})`,
          req,
        });

        // 4. Response ke frontend
        res.json({
          message: "❌ Berkas dinyatakan tidak valid & email terkirim",
          status: "Verifikasi Berkas Invalid",
        });
      });
    });
  });
});

// ======================
// EXPORT EXCEL
// ======================

router.get("/export/excel", authAdmin, async (req, res) => {
  try {
    const {
      id_pelatihan,
      tahun,
      tanggal_mulai,
      tanggal_selesai,
      nama_peserta,
    } = req.query;

    let where = [];
    let params = [];

    if (id_pelatihan) {
      where.push("daftar.id_pelatihan = ?");
      params.push(id_pelatihan);
    }

    if (tahun) {
      where.push("YEAR(daftar.tanggal_daftar) = ?");
      params.push(tahun);
    }

    if (tanggal_mulai && tanggal_selesai) {
      where.push("DATE(daftar.tanggal_daftar) BETWEEN ? AND ?");
      params.push(tanggal_mulai, tanggal_selesai);
    }

    if (nama_peserta) {
      where.push("daftar.nama_peserta LIKE ?");
      params.push(`%${nama_peserta}%`);
    }

    const whereSQL = where.length ? `WHERE ${where.join(" AND ")}` : "";

    // ======================
    // QUERY DATA
    // ======================
    const sql = `
      SELECT 
        daftar.nama_peserta,
        daftar.nik,
        daftar.nip,
        daftar.jenis_kelamin,
        daftar.pendidikan,
        daftar.jenis_nakes,
        daftar.no_wa,
        daftar.email,
        daftar.asal_instansi,
        daftar.kabupaten_asal,
        daftar.provinsi_asal,
        daftar.status,
        daftar.created_at,
        pel.nama_pelatihan
      FROM pendaftaran_tb daftar
      LEFT JOIN pelatihan_tb pel 
        ON daftar.id_pelatihan = pel.id_pelatihan
      ${whereSQL}
      ORDER BY daftar.created_at DESC
    `;

    const [rows] = await connection.promise().query(sql, params);

    // ======================
    // NAMA PELATIHAN
    // ======================
    let namaPelatihan = "Semua Pelatihan";

    if (id_pelatihan) {
      const [pel] = await connection
        .promise()
        .query(
          "SELECT nama_pelatihan FROM pelatihan_tb WHERE id_pelatihan = ?",
          [id_pelatihan],
        );
      if (pel.length) namaPelatihan = pel[0].nama_pelatihan;
    }

    const workbook = new ExcelJS.Workbook();
    const sheet = workbook.addWorksheet("Data Pendaftaran");

    // ==================================================
    // JUDUL
    // ==================================================
    sheet.mergeCells("A1:O1");
    sheet.mergeCells("A2:O2");
    sheet.mergeCells("A3:O3");

    sheet.getCell("A1").value = "DATA PENDAFTARAN PESERTA";
    sheet.getCell("A2").value = `Pelatihan : ${namaPelatihan}`;
    sheet.getCell("A3").value = "DIKLAT RSUD Prof. Dr. Margono Soekarjo";

    ["A1", "A2", "A3"].forEach((cell) => {
      sheet.getCell(cell).font = { bold: true, size: 12 };
      sheet.getCell(cell).alignment = { horizontal: "center" };
    });

    // Spasi
    sheet.addRow([]);
    sheet.addRow([]);

    // ==================================================
    // HEADER TABEL (BARIS 6)
    // ==================================================
    const headerRow = sheet.getRow(6);
    headerRow.values = [
      "No",
      "Nama Peserta",
      "NIK",
      "NIP",
      "Jenis Kelamin",
      "Pendidikan",
      "Jenis Nakes",
      "No WhatsApp",
      "Email",
      "Instansi",
      "Kabupaten",
      "Provinsi",
      "Pelatihan",
      "Status",
      "Tanggal Daftar",
    ];

    headerRow.font = { bold: true };
    headerRow.alignment = { horizontal: "center", vertical: "middle" };
    headerRow.eachCell((cell) => {
      cell.border = {
        top: { style: "thin" },
        left: { style: "thin" },
        bottom: { style: "thin" },
        right: { style: "thin" },
      };
    });

    // ==================================================
    // LEBAR KOLOM
    // ==================================================
    sheet.columns = [
      { width: 5 },
      { width: 25 },
      { width: 18 },
      { width: 18 },
      { width: 15 },
      { width: 18 },
      { width: 20 },
      { width: 18 },
      { width: 30 },
      { width: 30 },
      { width: 20 },
      { width: 20 },
      { width: 30 },
      { width: 20 },
      { width: 20 },
    ];

    // ==================================================
    // DATA (MULAI BARIS 7)
    // ==================================================
    rows.forEach((row, index) => {
      const dataRow = sheet.addRow([
        index + 1,
        row.nama_peserta,
        row.nik,
        row.nip,
        row.jenis_kelamin,
        row.pendidikan,
        row.jenis_nakes,
        row.no_wa,
        row.email,
        row.asal_instansi,
        row.kabupaten_asal,
        row.provinsi_asal,
        row.nama_pelatihan,
        row.status,
        row.created_at,
      ]);

      dataRow.eachCell((cell) => {
        cell.border = {
          top: { style: "thin" },
          left: { style: "thin" },
          bottom: { style: "thin" },
          right: { style: "thin" },
        };
        cell.alignment = { vertical: "middle" };
      });
    });

    rows.forEach((row, i) => {
      sheet.addRow({ no: i + 1, ...row });
    });

    res.setHeader(
      "Content-Disposition",
      `attachment; filename=Data_Pendaftaran_${Date.now()}.xlsx`,
    );
    res.setHeader(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    );

    await workbook.xlsx.write(res);
    res.end();
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Gagal export Excel" });
  }
});

export default router;
