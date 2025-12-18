import { sendEmail } from "../../utils/email.js";
import express from "express";
import connection from "../../config/db.js";
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
  const { id_pendaftaran } = req.body;

  if (!id_pendaftaran) {
    return res.status(400).json({
      message: "ID pendaftaran wajib dikirim",
    });
  }

  if (!req.file) {
    return res.status(400).json({
      message: "Bukti pembayaran wajib diupload!",
    });
  }

  const bukti_transfer = req.file.filename;

  const sqlCari = `
    SELECT nama_peserta, email, status
    FROM pendaftaran_tb
    WHERE id_pendaftaran = ?
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

    if (hasil[0].status !== "Menunggu Pembayaran") {
      return res.status(403).json({
        message: "Upload pembayaran belum diizinkan",
      });
    }

    const { nama_peserta, email } = hasil[0];

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

        // =====================
        // KIRIM EMAIL PENDING
        // =====================
        let emailStatus = "Email gagal dikirim";

        try {
          const sent = await sendEmail({
            to: email,
            subject: "Konfirmasi Penerimaan Bukti Pembayaran",
            html: `
                <p>Yth. <b>${nama_peserta}</b>,</p>

                <p>
                  Terima kasih. Bukti pembayaran Anda telah kami terima
                  dan saat ini sedang dalam proses <b>verifikasi oleh tim kami</b>.
                </p>

                <p>
                  Status pembayaran Anda saat ini:
                  <b>PENDING (Menunggu Verifikasi Pembayaran)</b>.
                </p>

                <p>
                  Hasil verifikasi akan kami informasikan melalui email
                  setelah proses pengecekan selesai.
                </p>

                <br>
                <p>
                  Hormat kami,<br>
                  <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
                </p>
              `,
          });

          if (sent) emailStatus = "Email konfirmasi terkirim";
        } catch (errEmail) {
          console.error("⚠️ Email PENDING gagal:", errEmail);
        }

        res.status(201).json({
          message: `Bukti pembayaran berhasil diupload. ${emailStatus}`,
          id_pembayaran: result.insertId,
        });
      }
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
      pel.nama_pelatihan
    FROM pembayaran_tb bayar
    LEFT JOIN pendaftaran_tb daftar 
        ON bayar.id_pendaftaran = daftar.id_pendaftaran
    LEFT JOIN pelatihan_tb pel 
        ON daftar.id_pelatihan = pel.id_pelatihan
    ORDER BY bayar.id_pembayaran DESC
  `;

  connection.query(sql, (err, results) => {
    if (err)
      return res
        .status(500)
        .json({ message: "Gagal mengambil data pembayaran" });

    res.json(results);
  });
});


// ========================================================
// VALIDATE PEMBAYARAN → UPDATE STATUS + EMAIL PESERTA
// ========================================================
router.put("/:id/validate", (req, res) => {
  const { id } = req.params;

  // 1. Ambil data pembayaran + peserta
  const getDataSQL = `
    SELECT 
      bayar.id_pendaftaran,
      daftar.nama_peserta,
      daftar.email
    FROM pembayaran_tb bayar
    JOIN pendaftaran_tb daftar
      ON bayar.id_pendaftaran = daftar.id_pendaftaran
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

    const { id_pendaftaran, nama_peserta, email } = dataRes[0];

    // 2. Update status pembayaran → VALID
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

      // 3. Update status pendaftaran → DITERIMA
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

        // 4. Kirim email ke peserta
        try {
          await sendEmail({
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

              <p>
                Informasi lebih lanjut mengenai jadwal dan teknis pelatihan
                akan disampaikan melalui email berikutnya.
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

        res.json({
          message:
            "✅ Pembayaran valid. Status peserta DITERIMA & email terkirim",
        });
      });
    });
  });
});

// ========================================================
// INVALID PEMBAYARAN → UPDATE STATUS + EMAIL PESERTA
// ========================================================
router.put("/:id/invalid", (req, res) => {
  const { id } = req.params;

  // 1. Ambil data peserta
  const getDataSQL = `
    SELECT 
      bayar.id_pendaftaran,
      daftar.nama_peserta,
      daftar.email
    FROM pembayaran_tb bayar
    JOIN pendaftaran_tb daftar
      ON bayar.id_pendaftaran = daftar.id_pendaftaran
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

    const { id_pendaftaran, nama_peserta, email } = dataRes[0];

    // 2. Update status pembayaran → INVALID
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

      // 3. Update status pendaftaran (opsional tapi disarankan)
      const updateDaftarSQL = `
        UPDATE pendaftaran_tb
        SET status = 'Perlu Perbaikan'
        WHERE id_pendaftaran = ?
      `;

      connection.query(updateDaftarSQL, [id_pendaftaran], async (err) => {
        if (err) {
          console.error("❌ Error update pendaftaran:", err);
          return res
            .status(500)
            .json({ message: "Gagal update status pendaftaran" });
        }

        // 4. Kirim email ke peserta
        let emailStatus = "Email gagal dikirim";

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

              <p>
                Hal ini dapat disebabkan oleh:
                <ul>
                  <li>Bukti transfer tidak jelas</li>
                  <li>Nominal tidak sesuai</li>
                  <li>Data pembayaran tidak lengkap</li>
                </ul>
              </p>

              <p>
                Silakan melakukan unggah ulang bukti pembayaran yang valid
                melalui sistem pendaftaran.
              </p>

              <br>
              <p>
                Hormat kami,<br>
                <b>DIKLAT RSUD Prof. Dr. Margono Soekarjo</b>
              </p>
            `,
          });

          if (sent) emailStatus = "Email notifikasi terkirim";
        } catch (emailErr) {
          console.error("⚠️ Email gagal dikirim:", emailErr);
        }

        res.json({
          message: `⚠️ Pembayaran ditandai INVALID. ${emailStatus}`,
        });
      });
    });
  });
});

/* SET PEMBAYARAN MENJADI PENDING */
router.put("/:id/pending", (req, res) => {
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
router.delete("/:id", (req, res) => {
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
        () => res.json({ message: "Pembayaran dihapus!" })
      );
    }
  );
});

export default router;
