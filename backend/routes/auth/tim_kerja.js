import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../../routes/auth/adminLogger.js";

const router = express.Router();

/* =========================
   GET ALL TIM KERJA
========================= */
router.get("/", (req, res) => {
  connection.query("SELECT * FROM tim_kerja ORDER BY id DESC", (err, rows) => {
    if (err) {
      console.error("ERROR TIM_KERJA:", err);
      return res.status(500).json({ message: err.message });
    }
    res.json(rows);
  });
});

/* =========================
   CREATE TIM KERJA
========================= */
router.post("/", (req, res) => {
  const { jabatan, institusi_id } = req.body;

  const sql = `
    INSERT INTO tim_kerja (institusi_id, jabatan)
    VALUES (?, ?)
  `;

  connection.query(sql, [institusi_id, jabatan], (err, result) => {
    if (err) return res.status(500).json(err);

    const {
      id_user = null,
      email = "-",
      nama_lengkap = "UNKNOWN",
    } = req.user || {};

    logAdmin({
      id_user,
      email,
      nama_lengkap,
      aktivitas: "AKSI",
      keterangan: `Tambah tim kerja ID ${result.insertId}`,
      req,
    });

    res.json({ message: "Tim kerja berhasil ditambahkan" });
  });
});

/* =========================
   UPDATE TIM KERJA
========================= */
router.put("/:id", (req, res) => {
  const { id } = req.params;
  const { jabatan } = req.body;

  const sql = `
    UPDATE tim_kerja
    SET jabatan = ?
    WHERE id = ?
  `;

  connection.query(sql, [jabatan, id], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Gagal update tim kerja" });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Tim kerja tidak ditemukan" });
    }

    const {
      id_user = null,
      email = "-",
      nama_lengkap = "UNKNOWN",
    } = req.user || {};

    logAdmin({
      id_user,
      email,
      nama_lengkap,
      aktivitas: "AKSI",
      keterangan: `Edit tim kerja ID ${id}`,
      req,
    });

    res.json({ message: "Tim kerja berhasil diperbarui" });
  });
});

/* =========================
   DELETE TIM KERJA
========================= */
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  connection.query(
    "DELETE FROM tim_kerja WHERE id = ?",
    [id],
    (err, result) => {
      if (err) return res.status(500).json(err);

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Tim kerja tidak ditemukan" });
      }

      const {
        id_user = null,
        email = "-",
        nama_lengkap = "UNKNOWN",
      } = req.user || {};

      logAdmin({
        id_user,
        email,
        nama_lengkap,
        aktivitas: "AKSI",
        keterangan: `Delete tim kerja ID ${id}`,
        req,
      });

      res.json({ message: "Tim kerja berhasil dihapus" });
    },
  );
});

export default router;
