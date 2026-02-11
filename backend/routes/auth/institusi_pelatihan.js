import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../../routes/auth/adminLogger.js";

const router = express.Router();

/* =========================
   CREATE INSTITUSI PELATIHAN
========================= */
router.post("/", (req, res) => {
  const { nama_institusi, deskripsi, kategori_rs, tahun_berdiri } = req.body;

  const sql = `
    INSERT INTO institusi_pelatihan
    (nama_institusi, deskripsi, kategori_rs, tahun_berdiri)
    VALUES (?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [nama_institusi, deskripsi, kategori_rs, tahun_berdiri],
    (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: "Gagal menambahkan institusi" });
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
        keterangan: `Tambah institusi pelatihan ID ${result.insertId}`,
        req,
      });

      res.json({ message: "Institusi pelatihan berhasil ditambahkan" });
    },
  );
});

/* =========================
   UPDATE INSTITUSI PELATIHAN
========================= */
router.put("/:id", (req, res) => {
  const { id } = req.params;

  const { nama_institusi, deskripsi, kategori_rs, tahun_berdiri } = req.body;

  const sql = `
    UPDATE institusi_pelatihan
    SET
      nama_institusi = ?,
      deskripsi = ?,
      kategori_rs = ?,
      tahun_berdiri = ?,
      updated_at = CURRENT_TIMESTAMP
    WHERE id = ?
  `;

  connection.query(
    sql,
    [nama_institusi, deskripsi, kategori_rs, tahun_berdiri, id],
    (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: "Gagal update institusi" });
      }

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Institusi tidak ditemukan" });
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
        keterangan: `Edit institusi pelatihan ID ${id}`,
        req,
      });

      res.json({ message: "Institusi pelatihan berhasil diperbarui" });
    },
  );
});

/* =========================
   DELETE INSTITUSI PELATIHAN
========================= */
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  connection.query(
    "DELETE FROM institusi_pelatihan WHERE id = ?",
    [id],
    (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: "Gagal menghapus institusi" });
      }

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Institusi tidak ditemukan" });
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
        keterangan: `Delete institusi pelatihan ID ${id}`,
        req,
      });

      res.json({ message: "Institusi pelatihan berhasil dihapus" });
    },
  );
});

/* =========================
   GET ALL INSTITUSI
========================= */
router.get("/", (req, res) => {
  connection.query(
    "SELECT * FROM institusi_pelatihan ORDER BY created_at DESC",
    (err, rows) => {
      if (err) {
        console.error(err);
        return res
          .status(500)
          .json({ message: "Gagal mengambil data institusi" });
      }

      res.json(rows);
    },
  );
});

/* =========================
   GET DETAIL INSTITUSI
========================= */
router.get("/:id", (req, res) => {
  const { id } = req.params;

  connection.query(
    "SELECT * FROM institusi_pelatihan WHERE id = ?",
    [id],
    (err, rows) => {
      if (err) {
        console.error(err);
        return res
          .status(500)
          .json({ message: "Gagal mengambil detail institusi" });
      }

      if (rows.length === 0) {
        return res.status(404).json({ message: "Institusi tidak ditemukan" });
      }

      res.json(rows[0]);
    },
  );
});

export default router;
