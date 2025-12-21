// backend/routes/auth/pendaftaran.js
import { sendEmail } from "../../utils/email.js";
import express from "express";
import connection from "../../config/db.js";
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

// ======================
// GET Semua Pendaftaran (ADMIN)
// ======================
router.get("/:id/cek-upload", (req, res) => {
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

    // ✅ BOLEH AKSES HALAMAN
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

    // =====================================================
    // 1️⃣ AMBIL HARGA PELATIHAN
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
      // 2️⃣ CEK KUOTA
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

          // ======================
          // INSERT PENDAFTARAN
          // ======================
          const insertSQL = `
          INSERT INTO pendaftaran_tb (
            id_pendaftaran, id_pelatihan, harga_pelatihan,  nik, nip, gelar_depan, nama_peserta, gelar_belakang,
            asal_instansi, tempat_lahir, tanggal_lahir, pendidikan, jenis_kelamin, agama,
            status_pegawai, kabupaten_asal, alamat_kantor, alamat_rumah, no_wa, email, str, provinsi_asal, jenis_nakes, kabupaten_kantor,
            provinsi_kantor, surat_tugas, foto_4x6, status
          )
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;

          const values = [
            id_pendaftaran,
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
            kabupaten_asal,
            alamat_kantor,
            alamat_rumah,
            no_wa,
            email,
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
    });
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
    SELECT 
      d.nama_peserta,
      d.email,
      d.harga_pelatihan,
      p.nama_pelatihan
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

    const { nama_peserta, email, harga_pelatihan, nama_pelatihan } =
      pesertaRes[0];

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
              Nama Pelatihan: ${nama_pelatihan}
            </p>

            <p>
              Untuk melanjutkan proses pendaftaran, silakan melakukan pembayaran dengan melakukan transfer ke nomor rekening berikut:
            </p>

              <p>
                <b>Bank BNI</b><br>
                <b>No. Rekening: 3380009008</b><br>
                <b>a.n RSUD Prof. Dr. Margono Soekarjo</b>
              </p>

              <p>
                <b>Biaya Pelatihan:</b>
                <b>Rp ${Number(harga_pelatihan).toLocaleString("id-ID")}</b>
              </p>

            <p>
              <b>Langkah selanjutnya:</b>
              <ol>
                <li>Lakukan pembayaran sesuai nominal di atas</li>
                <li>Simpan bukti pembayaran</li>
                <li>
                  Upload bukti pembayaran melalui link berikut:<br>
                  <a href="http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?id_pendaftaran=${id}">
                    Upload Bukti Pembayaran
                  </a>
                </li>
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
              akan kami sampaikan melalui grup WhatsApp pelatihan, 
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
    SELECT 
      d.nama_peserta,
      d.email,
      d.harga_pelatihan,
      p.nama_pelatihan
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

    const { nama_peserta, email, harga_pelatihan, nama_pelatihan } =
      pesertaRes[0];

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
              <b>Detail Pelatihan:</b><br>
              Nama Pelatihan: <b>${nama_pelatihan}</b><br>
              Biaya Pelatihan: <b>Rp ${Number(harga_pelatihan).toLocaleString("id-ID")}</b>
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

// ======================
// EXPORT EXCEL
// ======================

router.get("/export/excel", async (req, res) => {
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
      where.push("YEAR(daftar.created_at) = ?");
      params.push(tahun);
    }

    if (tanggal_mulai && tanggal_selesai) {
      where.push("DATE(daftar.created_at) BETWEEN ? AND ?");
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
          [id_pelatihan]
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
      `attachment; filename=Data_Pendaftaran_${Date.now()}.xlsx`
    );
    res.setHeader(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    );

    await workbook.xlsx.write(res);
    res.end();
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Gagal export Excel" });
  }
});

export default router;
