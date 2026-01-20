import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../../routes/auth/adminLogger.js";

const router = express.Router();

/* =========================
   CREATE HISTORI AKREDITASI
   ========================= */
router.post("/", (req, res) => {
  const {
    institusi_id,
    periode,
    keterangan,
    nomor_sk,
    link_sk,
    kategori_akreditasi,
    masa_berlaku,
  } = req.body;

  const sql = `
    INSERT INTO histori_akreditasi
    (institusi_id, periode, keterangan, nomor_sk, link_sk, kategori_akreditasi, masa_berlaku)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [
      institusi_id,
      periode,
      keterangan,
      nomor_sk,
      link_sk,
      kategori_akreditasi,
      masa_berlaku,
    ],
    (err) => {
      if (err) return res.status(500).json(err);

      // ✅ LOG ADMIN
      logAdmin({
        id_user: req.user.id,
        email: req.user.email,
        nama_lengkap: req.user.nama_lengkap,
        aktivitas: "CREATE AKREDITASI",
        keterangan: `Tambah histori akreditasi periode ${periode}`,
        req,
      });

      res.json({ message: "Histori akreditasi ditambahkan" });
    }
  );
});

/* =========================
   DELETE HISTORI AKREDITASI
   ========================= */
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  connection.query(
    "DELETE FROM histori_akreditasi WHERE id = ?",
    [id],
    (err) => {
      if (err) return res.status(500).json(err);

      // ✅ LOG ADMIN
      logAdmin({
        id_user: req.user.id,
        email: req.user.email,
        nama_lengkap: req.user.nama_lengkap,
        aktivitas: "DELETE AKREDITASI",
        keterangan: `Menghapus histori akreditasi ID ${id}`,
        req,
      });

      res.json({ message: "Histori akreditasi berhasil dihapus" });
    }
  );
});

export default router;
