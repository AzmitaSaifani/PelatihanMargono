import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../../routes/auth/adminLogger.js";

const router = express.Router();

/* =========================
   GET ALL
========================= */
router.get("/", (req, res) => {
  connection.query("SELECT * FROM tim_kerja ORDER BY id DESC", (err, rows) => {
    if (err) return res.status(500).json(err);
    res.json(rows);
  });
});

/* =========================
   CREATE
========================= */
router.post("/", (req, res) => {
  const { jabatan } = req.body;

  const sql = `
    INSERT INTO tim_kerja (jabatan)
    VALUES (?)
  `;

  connection.query(sql, [jabatan], (err) => {
    if (err) return res.status(500).json(err);

    res.json({ message: "Tim kerja berhasil ditambahkan" });
  });
});

/* =========================
   UPDATE
========================= */
router.put("/:id", (req, res) => {
  const sql = `
    UPDATE tim_kerja
    SET jabatan = ?
    WHERE id = ?
  `;

  connection.query(sql, [req.body.jabatan, req.params.id], (err) => {
    if (err) return res.status(500).json(err);

    res.json({ message: "Tim kerja diperbarui" });
  });
});

/* =========================
   DELETE
========================= */
router.delete("/:id", (req, res) => {
  connection.query(
    "DELETE FROM tim_kerja WHERE id = ?",
    [req.params.id],
    (err) => {
      if (err) return res.status(500).json(err);

      res.json({ message: "Tim kerja berhasil dihapus" });
    },
  );
});

export default router;
