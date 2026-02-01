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

      const {
        id_user = null,
        email = "-",
        nama_lengkap = "UNKNOWN",
      } = req.user || {};

      // ✅ LOG ADMIN
      logAdmin({
        id_user,
        email,
        nama_lengkap,
        aktivitas: "AKSI",
        keterangan: `Tambah histori akreditasi ID ${id}`,
        req,
      });

      res.json({ message: "Histori akreditasi ditambahkan" });
    }
  );
});

/* =========================
   UPDATE HISTORI AKREDITASI
   ========================= */
router.put("/:id", (req, res) => {
  const { id } = req.params;
  const { periode, kategori_akreditasi, nomor_sk, masa_berlaku } = req.body;

  const sql = `
    UPDATE histori_akreditasi
    SET
      periode = ?,
      kategori_akreditasi = ?,
      nomor_sk = ?,
      masa_berlaku = ?
    WHERE id = ?
  `;

  connection.query(
    sql,
    [periode, kategori_akreditasi, nomor_sk, masa_berlaku, id],
    (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: "Gagal update histori" });
      }

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Histori tidak ditemukan" });
      }

      const {
        id_user = null,
        email = "-",
        nama_lengkap = "UNKNOWN",
      } = req.user || {};

      // ✅ LOG ADMIN
      logAdmin({
        id_user,
        email,
        nama_lengkap,
        aktivitas: "AKSI",
        keterangan: `Edit histori akreditasi ID ${id}`,
        req,
      });

      res.json({ message: "Histori akreditasi berhasil diperbarui" });
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

      const {
        id_user = null,
        email = "-",
        nama_lengkap = "UNKNOWN",
      } = req.user || {};

      // ✅ LOG ADMIN
      logAdmin({
        id_user,
        email,
        nama_lengkap,
        aktivitas: "AKSI",
        keterangan: `Delete histori akreditasi ID ${id}`,
        req,
      });

      res.json({ message: "Histori akreditasi berhasil dihapus" });
    }
  );
});

export default router;
