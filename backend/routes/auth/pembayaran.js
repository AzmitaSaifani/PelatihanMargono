import { logAdmin } from "../../routes/auth/adminLogger.js";
import { sendEmail } from "../../utils/email.js";
import { logEmail } from "../../utils/emailLogger.js";
import { sendWhatsApp } from "../../utils/whatsapp.js";
import { logWhatsApp } from "../../utils/whatsappLogger.js";
import { decryptId } from "../../routes/auth//token.js";
import express from "express";
import connection from "../../config/db.js";
import { authAdmin } from "../../middleware/auth.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

/* UPLOAD */
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/bukti_transfer";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const unique = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, unique + path.extname(file.originalname));
  },
});
const upload = multer({ storage });

/* CREATE PEMBAYARAN + EMAIL PENDING */
router.post("/", upload.single("bukti_transfer"), (req, res) => {
  const { token } = req.body;

  if (!token) {
    return res.status(400).json({
      message: "token pendaftaran wajib dikirim",
    });
  }

  let id_pendaftaran;
  try {
    id_pendaftaran = decryptId(token);
  } catch {
    return res.status(403).json({
      message: "Token tidak valid",
    });
  }

  if (!req.file) {
    return res.status(400).json({
      message: "Bukti pembayaran wajib diupload!",
    });
  }

  const bukti_transfer = req.file.filename;

  const sqlCari = `
    SELECT 
      daftar.nama_peserta,
      daftar.email,
      daftar.no_wa,
      daftar.status,
      pel.nama_pelatihan,
      pel.lokasi,
      pel.tanggal_mulai,
      pel.tanggal_selesai
    FROM pendaftaran_tb daftar
    JOIN pelatihan_tb pel
      ON daftar.id_pelatihan = pel.id_pelatihan
    WHERE daftar.id_pendaftaran = ?
  `;

  connection.query(sqlCari, [id_pendaftaran], async (err, hasil) => {
    if (err) {
      return res.status(500).json({
        message: "Gagal mencari data pendaftaran",
      });
    }

    if (hasil.length === 0) {
      return res.status(404).json({
        message: "Data pendaftaran tidak ditemukan",
      });
    }

    const allowedStatus = [
      "Menunggu Pembayaran",
      "Verifikasi Pembayaran Invalid",
    ];

    if (!allowedStatus.includes(hasil[0].status)) {
      return res.status(403).json({
        message:
          "Upload pembayaran hanya dapat dilakukan setelah berkas dinyatakan valid",
      });
    }

    const {
      nama_peserta,
      email,
      no_wa,
      nama_pelatihan,
      lokasi,
      tanggal_mulai,
      tanggal_selesai,
    } = hasil[0];

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

    const tglMulaiFormatted = formatTanggal(tanggal_mulai);
    const tglSelesaiFormatted = formatTanggal(tanggal_selesai);
    const waktuPelaksanaan = `${tglMulaiFormatted} s.d. ${tglSelesaiFormatted}`;

    // ======================
    // FORMAT NOMOR WA
    // ======================
    let cleanNoWa = (no_wa || "").replace(/[^0-9]/g, "");

    if (cleanNoWa.startsWith("0")) {
      cleanNoWa = "62" + cleanNoWa.slice(1);
    }

    console.log("KIRIM WA KE:", cleanNoWa);

    // ======================
    // INSERT PEMBAYARAN
    // ======================
    const sqlInsert = `
      INSERT INTO pembayaran_tb
      (id_pendaftaran, bukti_transfer, status, uploaded_at)
      VALUES (?, ?, 'PENDING', NOW())
    `;

    connection.query(
      sqlInsert,
      [id_pendaftaran, bukti_transfer],
      async (err2, result) => {
        if (err2) {
          return res.status(500).json({
            message: "Gagal menyimpan pembayaran",
          });
        }

        let emailStatus = "GAGAL";
        let emailError = null;

        let waStatus = "GAGAL";
        let waError = null;

        // ======================
        // TEMPLATE PESAN WA
        // ======================
        const pesanWA =
          `. ` +
          `Halo ${nama_peserta}, bukti pembayaran Anda telah berhasil kami terima. ` +
          `Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. ` +
          `Pelatihan: ${nama_pelatihan} yang akan dilaksanakan pada ${waktuPelaksanaan} di ${lokasi}. ` +
          `Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. ` +
          `Terima kasih`;

        // ======================
        // EMAIL (TERPISAH)
        // ======================
        try {
          const sent = await sendEmail({
            to: email,
            subject: "Konfirmasi Penerimaan Bukti Pembayaran",
            html: `
              <p>Yth. <b>${nama_peserta}</b>,</p>

              <p>
                Bukti pembayaran Anda telah kami terima dan sedang dalam proses verifikasi.
              </p>

              <p>Status: <b>PENDING</b></p>

              <table cellpadding="6">
                <tr>
                  <td>Nama Pelatihan</td>
                  <td>:</td>
                  <td>${nama_pelatihan}</td>
                </tr>
                <tr>
                  <td>Lokasi</td>
                  <td>:</td>
                  <td>${lokasi}</td>
                </tr>
                <tr>
                  <td>Waktu</td>
                  <td>:</td>
                  <td>${waktuPelaksanaan}</td>
                </tr>
              </table>

              <br>
              <p>Hormat kami,<br>
              <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b></p>
            `,
          });

          if (sent) emailStatus = "TERKIRIM";
        } catch (errEmail) {
          emailError = errEmail.message;
          console.error("Email gagal:", errEmail.message);
        }

        // ======================
        // WHATSAPP (TERPISAH)
        // ======================
        try {
          const waRes = await sendWhatsApp(cleanNoWa, pesanWA);

          console.log("RESPON WA:", waRes);

          if (waRes) waStatus = "TERKIRIM";
        } catch (errWA) {
          waError = errWA.message;
          console.error("WA gagal:", errWA.message);
        }

        // ======================
        // LOG EMAIL
        // ======================
        await logEmail({
          id_pendaftaran,
          email,
          nama_penerima: nama_peserta,
          jenis_email: "PEMBAYARAN_PENDING",
          subject: "Konfirmasi Penerimaan Bukti Pembayaran",
          status: emailStatus,
          error_message: emailStatus === "GAGAL" ? emailError : null,
        });

        // ======================
        // LOG WHATSAPP
        // ======================
        await logWhatsApp({
          id_pendaftaran,
          no_wa: cleanNoWa,
          nama_penerima: nama_peserta,
          jenis_wa: "PEMBAYARAN_PENDING",
          pesan: pesanWA,
          status: waStatus,
          error_message: waStatus === "GAGAL" ? waError : null,
        });

        return res.status(201).json({
          success: true,
          message: "Bukti pembayaran berhasil diupload & notifikasi terkirim",
          id_pembayaran: result.insertId,
          status: "PENDING",
        });
      },
    );
  });
});

/* GET ALL */
router.get("/", (req, res) => {
  const sql = `
      SELECT 
      bayar.id_pembayaran,
      bayar.id_pendaftaran,
      bayar.bukti_transfer,
      bayar.status AS status_bayar,
      bayar.uploaded_at,

      daftar.nama_peserta,
      daftar.no_wa,
      daftar.email,
      daftar.harga_pelatihan,

      pel.id_pelatihan,
      pel.nama_pelatihan,
      pel.lokasi,
      pel.tanggal_mulai,
      pel.tanggal_selesai,
      pel.link_grup

    FROM pembayaran_tb bayar
    LEFT JOIN pendaftaran_tb daftar 
      ON bayar.id_pendaftaran = daftar.id_pendaftaran
    LEFT JOIN pelatihan_tb pel 
      ON daftar.id_pelatihan = pel.id_pelatihan
    ORDER BY bayar.id_pembayaran DESC

    `;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error("❌ GET pembayaran error:", err);
      return res.status(500).json({
        message: "Gagal mengambil data pembayaran",
        error: err.sqlMessage, // 🔥 biar kelihatan jelas saat debug
      });
    }

    res.json(results);
  });
});

// ========================================================
// VALIDATE PEMBAYARAN → UPDATE STATUS + EMAIL PESERTA
// ========================================================
router.put("/:id/validate", authAdmin, (req, res) => {
  const { id } = req.params;

  const getDataSQL = `
    SELECT 
      bayar.id_pendaftaran,
      daftar.nama_peserta,
      daftar.email,
      daftar.no_wa,

      pel.nama_pelatihan,
      pel.lokasi,
      pel.tanggal_mulai,
      pel.tanggal_selesai,
      pel.link_grup

    FROM pembayaran_tb bayar
    JOIN pendaftaran_tb daftar
      ON bayar.id_pendaftaran = daftar.id_pendaftaran
    JOIN pelatihan_tb pel
      ON daftar.id_pelatihan = pel.id_pelatihan
    WHERE bayar.id_pembayaran = ?
  `;

  connection.query(getDataSQL, [id], async (err, dataRes) => {
    if (err) {
      console.error("❌ Error ambil data:", err);
      return res
        .status(500)
        .json({ message: "Gagal mengambil data pembayaran" });
    }

    if (dataRes.length === 0) {
      return res
        .status(404)
        .json({ message: "Data pembayaran tidak ditemukan" });
    }

    const {
      id_pendaftaran,
      nama_peserta,
      email,
      no_wa,
      nama_pelatihan,
      lokasi,
      tanggal_mulai,
      tanggal_selesai,
      link_grup,
    } = dataRes[0];

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
    // FORMAT NOMOR WA
    // ======================
    let cleanNoWa = (no_wa || "").replace(/[^0-9]/g, "");

    if (cleanNoWa.startsWith("0")) {
      cleanNoWa = "62" + cleanNoWa.slice(1);
    }

    console.log("KIRIM WA KE:", cleanNoWa);

    // ======================
    // UPDATE PEMBAYARAN
    // ======================
    const updateBayarSQL = `
      UPDATE pembayaran_tb
      SET status = 'VALID'
      WHERE id_pembayaran = ?
    `;

    connection.query(updateBayarSQL, [id], async (err) => {
      if (err) {
        console.error("❌ Error update pembayaran:", err);
        return res.status(500).json({ message: "Gagal update pembayaran" });
      }

      // ======================
      // UPDATE PENDAFTARAN
      // ======================
      const updateDaftarSQL = `
        UPDATE pendaftaran_tb
        SET status = 'Diterima'
        WHERE id_pendaftaran = ?
      `;

      connection.query(updateDaftarSQL, [id_pendaftaran], async (err) => {
        if (err) {
          console.error("❌ Error update pendaftaran:", err);
          return res
            .status(500)
            .json({ message: "Gagal update status pendaftaran" });
        }

        let emailStatus = "GAGAL";
        let emailError = null;

        let waStatus = "GAGAL";
        let waError = null;

        // ======================
        // TEMPLATE PESAN WA
        // ======================
        const pesanWA =
          `. ` +
          `Halo ${nama_peserta}, pembayaran Anda telah kami terima dan dinyatakan VALID. ` +
          `Status pendaftaran Anda: DITERIMA. ` +
          `Pelatihan: ${nama_pelatihan} yang akan dilaksanakan pada ${waktuPelaksanaan} di ${lokasi}. ` +
          `${
            link_grup
              ? `Silakan bergabung ke grup peserta untuk memudahkan koordinasi dan penyampaian informasi pelatihan,: ${link_grup}. `
              : `Informasi pelatihan selanjutnya akan kami sampaikan melalui grup pelatihan. `
          }` +
          `Terima kasih`;

        // ======================
        // EMAIL (TERPISAH)
        // ======================
        try {
          const sent = await sendEmail({
            to: email,
            subject: "Konfirmasi Pembayaran & Pendaftaran Diterima",
            html: `
                <p>Yth. <b>${nama_peserta}</b>,</p>

                <p>
                  Terima kasih. Kami informasikan bahwa
                  <b>pembayaran Anda telah kami terima dan dinyatakan valid</b>.
                </p>

                <p>
                  Dengan ini, status pendaftaran Anda dinyatakan:
                  <b>DITERIMA</b>.
                </p>

                <hr>

                <p><b>Detail Pelatihan:</b></p>
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
                      <td><b>Lokasi</b></td>
                      <td>:</td>
                      <td>${lokasi}</td>
                    </tr>
                    <tr>
                      <td><b>Waktu Pelaksanaan</b></td>
                      <td>:</td>
                      <td>${tglMulaiFormatted} s.d. ${tglSelesaiFormatted}</td>
                    </tr>
                  </table>

                  <br>

                  ${
                    link_grup_wa
                      ? `
                        <p>
                          Untuk memudahkan koordinasi dan penyampaian informasi pelatihan,
                          silakan bergabung ke <b>Grup WhatsApp Peserta</b> melalui tautan berikut:
                        </p>

                        <p>
                          <a href="${link_grup_wa}" target="_blank">
                             Gabung Grup WhatsApp Peserta Pelatihan
                          </a>
                        </p>
                      `
                      : `
                        <p>
                          Informasi grup WhatsApp peserta akan kami sampaikan
                          melalui email selanjutnya.
                        </p>
                      `
                  }

                <br>
                <p>
                  Hormat kami,<br>
                  <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
                </p>
              `,
          });

          if (sent) emailStatus = "TERKIRIM";
        } catch (errEmail) {
          emailError = errEmail.message;
          console.error("Email gagal:", errEmail.message);
        }

        // ======================
        // WHATSAPP (TERPISAH)
        // ======================
        try {
          const waRes = await sendWhatsApp(cleanNoWa, pesanWA);

          console.log("RESPON WA:", waRes);

          if (waRes) waStatus = "TERKIRIM";
        } catch (errWA) {
          waError = errWA.message;
          console.error("WA gagal:", errWA.message);
        }

        // ======================
        // LOG EMAIL
        // ======================
        await logEmail({
          id_pendaftaran,
          email,
          nama_penerima: nama_peserta,
          jenis_email: "PEMBAYARAN_VALID",
          subject: "Konfirmasi Pembayaran & Pendaftaran Diterima",
          status: emailStatus,
          error_message: emailStatus === "GAGAL" ? emailError : null,
        });

        // ======================
        // LOG WHATSAPP
        // ======================
        await logWhatsApp({
          id_pendaftaran,
          no_wa: cleanNoWa,
          nama_penerima: nama_peserta,
          jenis_wa: "PEMBAYARAN_VALID",
          pesan: pesanWA,
          status: waStatus,
          error_message: waStatus === "GAGAL" ? waError : null,
        });

        // ======================
        // LOG ADMIN
        // ======================
        const user = req.session.admin;

        logAdmin({
          id_user: user.id_user,
          email: user.email,
          nama_lengkap: user.nama_lengkap,
          aktivitas: "AKSI",
          keterangan: `Validasi pembayaran VALID untuk ID ${id_pendaftaran} (${nama_peserta})`,
          req,
        });

        res.json({
          message: "✅ Pembayaran valid + Email & WhatsApp terkirim",
        });
      });
    });
  });
});

// ========================================================
// INVALID PEMBAYARAN → UPDATE STATUS + EMAIL PESERTA
// ========================================================
router.put("/:id/invalid", authAdmin, (req, res) => {
  const { id } = req.params;

  const getDataSQL = `
    SELECT 
      bayar.id_pendaftaran,
      daftar.nama_peserta,
      daftar.email,
      daftar.no_wa,

      pel.nama_pelatihan,
      pel.lokasi,
      pel.tanggal_mulai,
      pel.tanggal_selesai
    FROM pembayaran_tb bayar
    JOIN pendaftaran_tb daftar
      ON bayar.id_pendaftaran = daftar.id_pendaftaran
    JOIN pelatihan_tb pel
      ON daftar.id_pelatihan = pel.id_pelatihan
    WHERE bayar.id_pembayaran = ?
  `;

  connection.query(getDataSQL, [id], async (err, dataRes) => {
    if (err) {
      console.error("❌ Error ambil data:", err);
      return res
        .status(500)
        .json({ message: "Gagal mengambil data pembayaran" });
    }

    if (dataRes.length === 0) {
      return res
        .status(404)
        .json({ message: "Data pembayaran tidak ditemukan" });
    }

    const {
      id_pendaftaran,
      nama_peserta,
      email,
      no_wa,
      nama_pelatihan,
      lokasi,
      tanggal_mulai,
      tanggal_selesai,
    } = dataRes[0];

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
    // FORMAT NOMOR WA
    // ======================
    let cleanNoWa = (no_wa || "").replace(/[^0-9]/g, "");

    if (cleanNoWa.startsWith("0")) {
      cleanNoWa = "62" + cleanNoWa.slice(1);
    }

    console.log("KIRIM WA KE:", cleanNoWa);

    // ======================
    // UPDATE PEMBAYARAN → INVALID
    // ======================
    const updateBayarSQL = `
      UPDATE pembayaran_tb
      SET status = 'INVALID'
      WHERE id_pembayaran = ?
    `;

    connection.query(updateBayarSQL, [id], async (err) => {
      if (err) {
        console.error("❌ Error update pembayaran:", err);
        return res
          .status(500)
          .json({ message: "Gagal update status pembayaran" });
      }

      // ======================
      // UPDATE PENDAFTARAN
      // ======================
      const updateDaftarSQL = `
        UPDATE pendaftaran_tb
        SET status = 'Verifikasi Pembayaran Invalid'
        WHERE id_pendaftaran = ?
      `;

      connection.query(updateDaftarSQL, [id_pendaftaran], async (err) => {
        if (err) {
          console.error("❌ Error update pendaftaran:", err);
          return res
            .status(500)
            .json({ message: "Gagal update status pendaftaran" });
        }

        let emailStatus = "GAGAL";
        let emailError = null;

        let waStatus = "GAGAL";
        let waError = null;

        // ======================
        // TEMPLATE PESAN WA
        // ======================
        const pesanWA =
          `. ` +
          `Halo ${nama_peserta}, pembayaran Anda belum dapat kami validasi. ` +
          `Status saat ini: Verifikasi Pembayaran Invalid. ` +
          `Pelatihan: ${nama_pelatihan} (${waktuPelaksanaan}) di ${lokasi}. ` +
          `Silakan upload ulang bukti pembayaran yang valid melalui sistem. ` +
          `Terima kasih.`;

        // ======================
        // EMAIL (TERPISAH)
        // ======================
        const tglMulaiFormatted = formatTanggal(tanggal_mulai);
        const tglSelesaiFormatted = formatTanggal(tanggal_selesai);

        try {
          const sent = await sendEmail({
            to: email,
            subject: "Informasi Pembayaran Belum Valid",
            html: `
                <p>Yth. <b>${nama_peserta}</b>,</p>

                <p>
                  Terima kasih atas partisipasi Anda dalam program pelatihan kami.
                  Setelah dilakukan verifikasi, kami informasikan bahwa
                  <b>bukti pembayaran yang Anda kirimkan belum dapat kami validasi</b>.
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
                    <td><b>Lokasi</b></td>
                    <td>:</td>
                    <td>${lokasi}</td>
                  </tr>
                  <tr>
                    <td><b>Waktu Pelaksanaan</b></td>
                    <td>:</td>
                    <td>${tglMulaiFormatted} s.d. ${tglSelesaiFormatted}</td>
                  </tr>
                </table>

                <br>

                <p>
                  Adapun kemungkinan penyebab pembayaran belum valid:
                  <ul>
                    <li>Bukti transfer tidak jelas</li>
                    <li>Nominal tidak sesuai</li>
                    <li>Data pembayaran tidak lengkap</li>
                  </ul>
                </p>

                <p>
                  Silakan melakukan unggah ulang bukti pembayaran yang valid
                  melalui link berikut:
                </p>
                <a href="http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=${token}">
                Upload Bukti Pembayaran
                </a>

                <br>
                <p>
                  Hormat kami,<br>
                  <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
                </p>
              `,
          });

          if (sent) emailStatus = "TERKIRIM";
        } catch (errEmail) {
          emailError = errEmail.message;
          console.error("Email gagal:", errEmail.message);
        }

        // ======================
        // WHATSAPP (TERPISAH)
        // ======================
        try {
          const waRes = await sendWhatsApp(cleanNoWa, pesanWA);

          console.log("RESPON WA:", waRes);

          if (waRes) waStatus = "TERKIRIM";
        } catch (errWA) {
          waError = errWA.message;
          console.error("WA gagal:", errWA.message);
        }

        // ======================
        // LOG EMAIL
        // ======================
        await logEmail({
          id_pendaftaran,
          email,
          nama_penerima: nama_peserta,
          jenis_email: "PEMBAYARAN_INVALID",
          subject: "Informasi Pembayaran Belum Valid",
          status: emailStatus,
          error_message: emailStatus === "GAGAL" ? emailError : null,
        });

        // ======================
        // LOG WHATSAPP
        // ======================
        await logWhatsApp({
          id_pendaftaran,
          no_wa: cleanNoWa,
          nama_penerima: nama_peserta,
          jenis_wa: "PEMBAYARAN_INVALID",
          pesan: pesanWA,
          status: waStatus,
          error_message: waStatus === "GAGAL" ? waError : null,
        });

        // ======================
        // LOG ADMIN
        // ======================
        const user = req.session.admin;

        logAdmin({
          id_user: user.id_user,
          email: user.email,
          nama_lengkap: user.nama_lengkap,
          aktivitas: "AKSI",
          keterangan: `Validasi pembayaran INVALID untuk ID ${id_pendaftaran} (${nama_peserta})`,
          req,
        });

        res.json({
          message: "⚠️ Pembayaran INVALID + Email & WhatsApp terkirim",
        });
      });
    });
  });
});

/* SET PEMBAYARAN MENJADI PENDING */
router.put("/:id/pending", authAdmin, (req, res) => {
  const { id } = req.params;

  const sql = `
        UPDATE pembayaran_tb 
        SET status='PENDING'
        WHERE id_pembayaran=?
    `;

  connection.query(sql, [id], (err) => {
    if (err)
      return res
        .status(500)
        .json({ message: "Gagal mengubah status ke PENDING" });

    res.json({ message: "Status pembayaran dikembalikan ke PENDING!" });
  });
});

/* DELETE PEMBAYARAN */
router.delete("/:id", authAdmin, (req, res) => {
  connection.query(
    "SELECT bukti_transfer FROM pembayaran_tb WHERE id_pembayaran=?",
    [req.params.id],
    (err, rows) => {
      if (rows.length === 0)
        return res.status(404).json({ message: "Data tidak ditemukan" });

      const filePath = "uploads/bukti_transfer/" + rows[0].bukti_transfer;
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);

      connection.query(
        "DELETE FROM pembayaran_tb WHERE id_pembayaran=?",
        [req.params.id],
        () => res.json({ message: "Pembayaran dihapus!" }),
      );
    },
  );
});

// ======================
// EXPORT EXCEL PEMBAYARAN
// ======================
import ExcelJS from "exceljs";

router.get("/export/excel", authAdmin, async (req, res) => {
  try {
    const { id_pelatihan, status_bayar, tanggal_mulai, tanggal_selesai } =
      req.query;

    let where = [];
    let params = [];

    if (id_pelatihan) {
      where.push("pel.id_pelatihan = ?");
      params.push(id_pelatihan);
    }

    if (status_bayar) {
      where.push("bayar.status = ?");
      params.push(status_bayar);
    }

    if (tanggal_mulai && tanggal_selesai) {
      where.push("DATE(bayar.uploaded_at) BETWEEN ? AND ?");
      params.push(tanggal_mulai, tanggal_selesai);
    }

    const whereSQL = where.length ? `WHERE ${where.join(" AND ")}` : "";

    const sql = `
        SELECT
          daftar.nama_peserta,
          pel.nama_pelatihan,
          daftar.no_wa,
          daftar.email,
          bayar.status AS status_bayar,
          bayar.uploaded_at
        FROM pembayaran_tb bayar
        JOIN pendaftaran_tb daftar
          ON bayar.id_pendaftaran = daftar.id_pendaftaran
        JOIN pelatihan_tb pel
          ON daftar.id_pelatihan = pel.id_pelatihan
        ${whereSQL}
        ORDER BY bayar.uploaded_at DESC
      `;

    const [rows] = await connection.promise().query(sql, params);

    // ======================
    // BUAT EXCEL
    // ======================
    const workbook = new ExcelJS.Workbook();
    const sheet = workbook.addWorksheet("Data Pembayaran");

    sheet.mergeCells("A1:F1");
    sheet.mergeCells("A2:F2");

    sheet.getCell("A1").value = "DATA PEMBAYARAN PESERTA";
    sheet.getCell("A2").value = "DIKLAT RSUD Prof. Dr. Margono Soekarjo";

    ["A1", "A2"].forEach((c) => {
      sheet.getCell(c).font = { bold: true };
      sheet.getCell(c).alignment = { horizontal: "center" };
    });

    sheet.addRow([]);

    sheet.getRow(4).values = [
      "No",
      "Nama Peserta",
      "Pelatihan",
      "Harga",
      "No WhatsApp",
      "Email",
      "Status Pembayaran",
      "Tanggal Upload",
    ];

    sheet.getRow(4).font = { bold: true };

    sheet.columns = [
      { width: 5 },
      { width: 25 },
      { width: 30 },
      { width: 18 },
      { width: 30 },
      { width: 20 },
      { width: 20 },
    ];

    rows.forEach((row, i) => {
      sheet.addRow([
        i + 1,
        row.nama_peserta,
        row.nama_pelatihan,
        Number(row.harga || 0),
        row.no_wa,
        row.email,
        row.status_bayar,
        row.uploaded_at,
      ]);
    });
    // format kolom harga jadi Rupiah
    sheet.getColumn(4).numFmt = '"Rp" #,##0';

    res.setHeader(
      "Content-Disposition",
      `attachment; filename=Data_Pembayaran_${Date.now()}.xlsx`,
    );
    res.setHeader(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    );

    await workbook.xlsx.write(res);
    res.end();
  } catch (err) {
    console.error("❌ Export Excel Pembayaran Error:", err);
    res.status(500).json({ message: "Gagal export Excel pembayaran" });
  }
});

export default router;
