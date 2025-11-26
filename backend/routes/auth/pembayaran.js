// backend/routes/auth/pembayaran.js
import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

/* ==========================================================================
   🔧 KONFIGURASI UPLOAD BUKTI TRANSFER
   ========================================================================== */
const storageTransfer = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/bukti_transfer";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  },
});

const uploadTransfer = multer({ storage: storageTransfer });

/* ==========================================================================
   1️⃣ CREATE PEMBAYARAN (PENDING)
   POST /pembayaran/:id_pendaftaran
   ========================================================================== */
router.post(
  "/:id_pendaftaran",
  uploadTransfer.single("bukti_transfer"),
  (req, res) => {
    const { id_pendaftaran } = req.params;

    if (!req.file) {
      return res
        .status(400)
        .json({ message: "❌ Bukti transfer wajib diupload!" });
    }

    const bukti_transfer = req.file.filename;

    const sql = `
    INSERT INTO pembayaran_tb (id_pendaftaran, bukti_transfer, status)
    VALUES (?, ?, 'PENDING')
  `;

    connection.query(sql, [id_pendaftaran, bukti_transfer], (err, result) => {
      if (err) {
        console.error("❌ Error insert pembayaran:", err);
        return res.status(500).json({ message: "Gagal menyimpan pembayaran" });
      }

      res.status(201).json({
        message: "✅ Bukti transfer berhasil dikirim!",
        id_pembayaran: result.insertId,
        status: "PENDING",
      });
    });
  }
);

/* ==========================================================================
   2️⃣ GET ALL PEMBAYARAN
   GET /pembayaran
   ========================================================================== */
router.get("/", (req, res) => {
  const sql = "SELECT * FROM pembayaran_tb ORDER BY id_pembayaran DESC";

  connection.query(sql, (err, results) => {
    if (err) {
      console.error("❌ Error ambil pembayaran:", err);
      return res
        .status(500)
        .json({ message: "Gagal mengambil data pembayaran" });
    }

    res.json(results);
  });
});

/* ==========================================================================
   3️⃣ GET PEMBAYARAN BY ID PENDAFTARAN
   GET /pembayaran/pendaftaran/:id
   ========================================================================== */
router.get("/pendaftaran/:id", (req, res) => {
  const { id } = req.params;

  const sql = `
    SELECT * FROM pembayaran_tb
    WHERE id_pendaftaran = ?
  `;

  connection.query(sql, [id], (err, results) => {
    if (err) {
      console.error("❌ Error GET BY PENDAFTARAN:", err);
      return res.status(500).json({ message: "Gagal mengambil data" });
    }

    res.json(results);
  });
});

/* ==========================================================================
   4️⃣ UPDATE STATUS PEMBAYARAN + UPDATE PENDAFTARAN OTOMATIS
   PUT /pembayaran/:id_pembayaran/status
   ========================================================================== */
router.put("/:id_pembayaran/status", (req, res) => {
  const { id_pembayaran } = req.params;
  const { status } = req.body; // VALID / INVALID

  // Validasi input
  if (!["VALID", "INVALID"].includes(status)) {
    return res.status(400).json({ message: "Status harus VALID atau INVALID" });
  }

  // 1️⃣ Ambil id_pendaftaran dari pembayaran
  connection.query(
    `SELECT id_pendaftaran FROM pembayaran_tb WHERE id_pembayaran = ?`,
    [id_pembayaran],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      if (result.length === 0)
        return res.status(404).json({ message: "Pembayaran tidak ditemukan" });

      const id_pendaftaran = result[0].id_pendaftaran;

      // 2️⃣ Update status pembayaran
      connection.query(
        `UPDATE pembayaran_tb SET status = ? WHERE id_pembayaran = ?`,
        [status, id_pembayaran],
        (err2) => {
          if (err2) return res.status(500).json({ error: err2.message });

          // 3️⃣ Tentukan status pendaftaran
          let newStatus = status === "VALID" ? "diterima" : "menunggu";

          // 4️⃣ Update status pendaftaran
          connection.query(
            `UPDATE pendaftaran_tb SET status = ? WHERE id_pendaftaran = ?`,
            [newStatus, id_pendaftaran],
            (err3) => {
              if (err3) return res.status(500).json({ error: err3.message });

              res.status(200).json({
                message: "Status pembayaran & pendaftaran berhasil diperbarui",
                pembayaran_status: status,
                pendaftaran_status: newStatus,
              });
            }
          );
        }
      );
    }
  );
});

/* ==========================================================================
   5️⃣ DELETE PEMBAYARAN
   ========================================================================== */
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  const sqlGet =
    "SELECT bukti_transfer FROM pembayaran_tb WHERE id_pembayaran = ?";

  connection.query(sqlGet, [id], (err, result) => {
    if (err) return res.status(500).json({ message: "Gagal mengambil data" });
    if (result.length === 0)
      return res.status(404).json({ message: "Data tidak ditemukan" });

    const file = result[0].bukti_transfer;
    const filePath = path.join("uploads/bukti_transfer", file);

    if (fs.existsSync(filePath)) fs.unlinkSync(filePath);

    const sqlDelete = "DELETE FROM pembayaran_tb WHERE id_pembayaran = ?";
    connection.query(sqlDelete, [id], (err) => {
      if (err)
        return res.status(500).json({ message: "Gagal menghapus pembayaran" });

      res.json({ message: "🗑️ Pembayaran berhasil dihapus!" });
    });
  });
});

export default router;
