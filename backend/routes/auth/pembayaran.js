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

/* CREATE PEMBAYARAN */
router.post("/", upload.single("bukti_pembayaran"), (req, res) => {
  const { nama_peserta, no_wa, id_pelatihan } = req.body;

  if (!req.file) {
    return res
      .status(400)
      .json({ message: "Bukti pembayaran wajib diupload!" });
  }

  const bukti_transfer = req.file.filename;

  const sqlCari = `
      SELECT id_pendaftaran
      FROM pendaftaran_tb
      WHERE nama_peserta=? AND no_wa=? AND id_pelatihan=?
      ORDER BY id_pendaftaran DESC
      LIMIT 1
  `;

  connection.query(
    sqlCari,
    [nama_peserta, no_wa, id_pelatihan],
    (err, hasil) => {
      if (err)
        return res
          .status(500)
          .json({ message: "Gagal mencari data pendaftaran" });

      if (hasil.length === 0)
        return res
          .status(404)
          .json({ message: "Data pendaftaran tidak ditemukan" });

      const id_pendaftaran = hasil[0].id_pendaftaran;

      const sqlInsert = `
          INSERT INTO pembayaran_tb (id_pendaftaran, bukti_transfer, status, uploaded_at)
          VALUES (?, ?, 'PENDING', NOW())
      `;

      connection.query(
        sqlInsert,
        [id_pendaftaran, bukti_transfer],
        (err2, result) => {
          if (err2)
            return res
              .status(500)
              .json({ message: "Gagal menyimpan pembayaran" });

          res.status(201).json({
            message: "Bukti pembayaran berhasil diupload!",
            id_pembayaran: result.insertId,
          });
        }
      );
    }
  );
});

/* GET ALL */
router.get("/", (req, res) => {
  const sql = `
    SELECT 
      bayar.id_pembayaran,
      bayar.bukti_transfer,
      bayar.status AS status_bayar,
      bayar.uploaded_at,
      daftar.nama_peserta,
      daftar.no_wa,
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

/* VALIDATE PEMBAYARAN */
router.put("/:id/validate", (req, res) => {
  const { id } = req.params;

  const sql = `
      UPDATE pembayaran_tb 
      SET status='VALID'
      WHERE id_pembayaran=?
  `;

  connection.query(sql, [id], (err) => {
    if (err)
      return res.status(500).json({ message: "Gagal memvalidasi pembayaran" });

    res.json({ message: "Pembayaran ditandai VALID!" });
  });
});

/* INVALID PEMBAYARAN */
router.put("/:id/invalid", (req, res) => {
  const { id } = req.params;

  const sql = `
      UPDATE pembayaran_tb 
      SET status='INVALID'
      WHERE id_pembayaran=?
  `;

  connection.query(sql, [id], (err) => {
    if (err) return res.status(500).json({ message: "Gagal mengubah status" });

    res.json({ message: "Pembayaran ditandai INVALID!" });
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
