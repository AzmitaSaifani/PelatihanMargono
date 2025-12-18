// backend/routes/auth/pendaftaran.js
import { sendEmail } from "../../utils/email.js";
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
  async (req, res) => {
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
      tanggal_daftar,
      str,
      provinsi_asal,
      jenis_nakes,
      kabupaten_kantor,
      provinsi_kantor,
    } = req.body;

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

    // ======================
    // CEK KUOTA
    // ======================
    const cekKuotaSQL = `
      SELECT kuota - (
        SELECT COUNT(*) FROM pendaftaran_tb WHERE id_pelatihan = ?
      ) AS sisa
      FROM pelatihan_tb
      WHERE id_pelatihan = ?
    `;

    connection.query(
      cekKuotaSQL,
      [id_pelatihan, id_pelatihan],
      async (err, kuotaRes) => {
        if (err) {
          console.error("❌ Error cek kuota:", err);
          return res.status(500).json({ message: "Gagal cek kuota" });
        }

        if (kuotaRes[0].sisa <= 0) {
          return res.status(400).json({ message: "❌ Kuota sudah penuh!" });
        }

        // ======================
        // INSERT PENDAFTARAN
        // ======================
        const insertSQL = `
          INSERT INTO pendaftaran_tb (
            id_pendaftaran, id_pelatihan, nik, nip, gelar_depan, nama_peserta, gelar_belakang,
            asal_instansi, tempat_lahir, tanggal_lahir, pendidikan, jenis_kelamin, agama,
            status_pegawai, kabupaten_asal, alamat_kantor, alamat_rumah, no_wa, email,
            tanggal_daftar, str, provinsi_asal, jenis_nakes, kabupaten_kantor,
            provinsi_kantor, surat_tugas, foto_4x6, status
          )
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
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
          "Menunggu Verifikasi Berkas",
        ];

        connection.query(insertSQL, values, async (err, result) => {
          if (err) {
            console.error("❌ Error insert pendaftaran:", err);
            return res.status(500).json({ message: "Gagal mendaftar" });
          }

          // ======================
          // KIRIM EMAIL (AMAN)
          // ======================
          try {
            await sendEmail({
              to: email,
              subject: "Status Pendaftaran – Menunggu Verifikasi Berkas",
              html: `
                <p>Yth. <b>${nama_peserta}</b>,</p>
                <p>Terima kasih telah mendaftar pelatihan di
                    <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>.
                  </p>

                  <p>
                    Status pendaftaran Anda saat ini adalah
                    <b>Menunggu Verifikasi Berkas</b>.
                  </p>

                  <p>
                    Tim kami akan melakukan verifikasi terhadap berkas yang telah Anda unggah.
                    Informasi selanjutnya akan disampaikan melalui <b>Email</b>.
                  </p>

                  <p>
                    Mohon memastikan email Anda aktif dan rutin memeriksa folder
                    <i>Inbox</i> maupun <i>Spam</i>.
                  </p>
                <br>
                <p>Hormat kami,<br>
                <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b></p>
              `,
            });
          } catch (emailErr) {
            console.error("⚠️ Email gagal dikirim:", emailErr.message);
            // EMAIL GAGAL ≠ PENDAFTARAN GAGAL
          }

          res.status(201).json({
            message: "✅ Pendaftaran berhasil",
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
// STATUS: BERKAS VALID → MENUNGGU PEMBAYARAN + EMAIL
// ========================================================
router.put("/:id/accept", (req, res) => {
  const { id } = req.params;

  // 1. Ambil data peserta
  const getPesertaSQL = `
    SELECT nama_peserta, email
    FROM pendaftaran_tb
    WHERE id_pendaftaran = ?
  `;

  connection.query(getPesertaSQL, [id], async (err, pesertaRes) => {
    if (err) {
      console.error("❌ Error ambil data peserta:", err);
      return res.status(500).json({ message: "Gagal mengambil data peserta" });
    }

    if (pesertaRes.length === 0) {
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });
    }

    const { nama_peserta, email } = pesertaRes[0];

    // 2. Update status
    const updateStatusSQL = `
      UPDATE pendaftaran_tb 
      SET status = 'Menunggu Pembayaran'
      WHERE id_pendaftaran = ?
    `;

    connection.query(updateStatusSQL, [id], async (err) => {
      if (err) {
        console.error("❌ Error update status:", err);
        return res.status(500).json({ message: "Gagal update status" });
      }

      // 3. Kirim email instruksi pembayaran
      try {
        await sendEmail({
          to: email,
          subject: "Instruksi Pembayaran Pelatihan",
          html: `
            <p>Yth. <b>${nama_peserta}</b>,</p>

            <p>
              Kami informasikan bahwa <b>berkas pendaftaran Anda telah dinyatakan valid</b>.
            </p>

            <p>
              Untuk melanjutkan proses pendaftaran, silakan melakukan pembayaran
              sesuai ketentuan pelatihan.
            </p>

            <p>
              <b>Langkah selanjutnya:</b>
              <ol>
                <li>Lakukan pembayaran sesuai informasi yang akan kami sampaikan</li>
                <li>Simpan bukti pembayaran</li>
                <li>Upload bukti pembayaran melalui sistem</li>
              </ol>
            </p>

            <p>
              Status pendaftaran Anda saat ini adalah:
              <b>Menunggu Pembayaran</b>
            </p>

            <p>
              Mohon memastikan email Anda aktif dan rutin memeriksa folder
              <i>Inbox</i> maupun <i>Spam</i>.
            </p>

            <br>
            <p>
              Hormat kami,<br>
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
            </p>
          `,
        });

        console.log("📧 Email menunggu pembayaran terkirim ke:", email);
      } catch (emailErr) {
        console.error("⚠️ Email gagal dikirim:", emailErr.message);
      }

      // 4. Response frontend
      res.json({
        message:
          "✅ Berkas valid. Status diubah ke Menunggu Pembayaran & email terkirim",
        status: "Menunggu Pembayaran",
      });
    });
  });
});

// ========================================================
//  STATUS: REJECT (VERIFIKASI BERKAS INVALID + EMAIL)
// ========================================================
router.put("/:id/reject", (req, res) => {
  const { id } = req.params;

  // 1. Ambil data peserta (email & nama)
  const getPesertaSQL = `
    SELECT nama_peserta, email
    FROM pendaftaran_tb
    WHERE id_pendaftaran = ?
  `;

  connection.query(getPesertaSQL, [id], async (err, pesertaRes) => {
    if (err) {
      console.error("❌ Error ambil data peserta:", err);
      return res.status(500).json({ message: "Gagal mengambil data peserta" });
    }

    if (pesertaRes.length === 0) {
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });
    }

    const { nama_peserta, email } = pesertaRes[0];

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

            <p>
              Tim kami akan menghubungi Anda untuk menyampaikan informasi
              lebih lanjut terkait perbaikan berkas yang diperlukan.
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

      // 4. Response ke frontend
      res.json({
        message: "❌ Berkas dinyatakan tidak valid & email terkirim",
        status: "Verifikasi Berkas Invalid",
      });
    });
  });
});

// ========================================================
// STATUS: PEMBAYARAN VALID → DITERIMA + EMAIL
// ========================================================
router.put("/:id/payment-valid", (req, res) => {
  const { id } = req.params;

  // 1. Ambil data peserta
  const getPesertaSQL = `
    SELECT nama_peserta, email
    FROM pendaftaran_tb
    WHERE id_pendaftaran = ?
  `;

  connection.query(getPesertaSQL, [id], async (err, pesertaRes) => {
    if (err) {
      console.error("❌ Error ambil data peserta:", err);
      return res.status(500).json({ message: "Gagal mengambil data peserta" });
    }

    if (pesertaRes.length === 0) {
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });
    }

    const { nama_peserta, email } = pesertaRes[0];

    // 2. Update status → DITERIMA
    const updateStatusSQL = `
      UPDATE pendaftaran_tb
      SET status = 'Diterima'
      WHERE id_pendaftaran = ?
    `;

    connection.query(updateStatusSQL, [id], async (err) => {
      if (err) {
        console.error("❌ Error update status pembayaran:", err);
        return res
          .status(500)
          .json({ message: "Gagal update status pembayaran" });
      }

      // 3. Kirim email konfirmasi diterima
      try {
        await sendEmail({
          to: email,
          subject: "Konfirmasi Pembayaran & Pendaftaran Diterima",
          html: `
            <p>Yth. <b>${nama_peserta}</b>,</p>

            <p>
              Terima kasih atas konfirmasi pembayaran yang telah Anda lakukan.
            </p>

            <p>
              Kami informasikan bahwa <b>pembayaran Anda telah kami terima dan valid</b>.
              Dengan demikian, <b>pendaftaran Anda dinyatakan DITERIMA</b>.
            </p>

            <p>
              Informasi lanjutan terkait pelaksanaan pelatihan
              (jadwal, teknis, dan ketentuan lainnya)
              akan kami sampaikan melalui email.
            </p>

            <p>
              Status pendaftaran Anda saat ini:
              <b>DITERIMA</b>
            </p>

            <br>
            <p>
              Hormat kami,<br>
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
            </p>
          `,
        });

        console.log("📧 Email pembayaran valid terkirim ke:", email);
      } catch (emailErr) {
        console.error("⚠️ Email gagal dikirim:", emailErr.message);
      }

      // 4. Response frontend
      res.json({
        message:
          "✅ Pembayaran valid. Status peserta DITERIMA & email terkirim",
        status: "Diterima",
      });
    });
  });
});

// ========================================================
// STATUS: PEMBAYARAN INVALID + EMAIL
// ========================================================
router.put("/:id/payment-invalid", (req, res) => {
  const { id } = req.params;

  // 1. Ambil data peserta
  const getPesertaSQL = `
    SELECT nama_peserta, email
    FROM pendaftaran_tb
    WHERE id_pendaftaran = ?
  `;

  connection.query(getPesertaSQL, [id], async (err, pesertaRes) => {
    if (err) {
      console.error("❌ Error ambil data peserta:", err);
      return res.status(500).json({ message: "Gagal mengambil data peserta" });
    }

    if (pesertaRes.length === 0) {
      return res.status(404).json({ message: "Pendaftaran tidak ditemukan" });
    }

    const { nama_peserta, email } = pesertaRes[0];

    // 2. Update status pembayaran invalid
    const updateStatusSQL = `
      UPDATE pendaftaran_tb
      SET status = 'Verifikasi Pembayaran Invalid'
      WHERE id_pendaftaran = ?
    `;

    connection.query(updateStatusSQL, [id], async (err) => {
      if (err) {
        console.error("❌ Error update status pembayaran:", err);
        return res
          .status(500)
          .json({ message: "Gagal update status pembayaran" });
      }

      // 3. Kirim email ke peserta
      try {
        await sendEmail({
          to: email,
          subject: "Informasi Verifikasi Pembayaran Pelatihan",
          html: `
            <p>Yth. <b>${nama_peserta}</b>,</p>

            <p>
              Terima kasih telah melakukan pembayaran untuk pelatihan di
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>.
            </p>

            <p>
              Setelah dilakukan verifikasi, kami informasikan bahwa
              <b>bukti pembayaran Anda belum dapat kami validasi</b>.
            </p>

            <p>
              Hal ini dapat disebabkan oleh:
              <ul>
                <li>Nominal pembayaran tidak sesuai</li>
                <li>Bukti pembayaran kurang jelas</li>
                <li>Data transfer tidak terbaca</li>
              </ul>
            </p>

            <p>
              Silakan melakukan <b>upload ulang bukti pembayaran</b>
              sesuai instruksi yang akan kami sampaikan selanjutnya.
            </p>

            <p>
              Status pendaftaran Anda saat ini:
              <b>Verifikasi Pembayaran Invalid</b>
            </p>

            <br>
            <p>
              Hormat kami,<br>
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
            </p>
          `,
        });

        console.log("📧 Email pembayaran invalid terkirim ke:", email);
      } catch (emailErr) {
        console.error("⚠️ Email gagal dikirim:", emailErr.message);
      }

      // 4. Response ke frontend
      res.json({
        message:
          "❌ Pembayaran tidak valid. Status diperbarui & email terkirim",
        status: "Verifikasi Pembayaran Invalid",
      });
    });
  });
});

export default router;
