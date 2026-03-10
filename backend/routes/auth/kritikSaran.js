import express from "express";
import connection from "../../config/db.js";
import { maskPhone } from "../../utils/maskPhone.js";

const router = express.Router();

// =====================================================
// CREATE – KIRIM KRITIK & SARAN (SUPPORT ANONIM)
// =====================================================
router.post("/", (req, res) => {
  const { nama_lengkap, no_hp, kritik, saran, is_anonim } = req.body;

  if (!no_hp) {
    return res.status(400).json({
      message: "❌ Nomor HP wajib diisi",
    });
  }

  if (!kritik && !saran) {
    return res.status(400).json({
      message: "❌ Kritik atau saran harus diisi",
    });
  }

  const anonim = is_anonim === "Y" ? "Y" : "N";

  const sql = `
    INSERT INTO kritik_saran_tb
    (nama_lengkap, is_anonim, no_hp, kritik, saran, status)
    VALUES (?, ?, ?, ?, ?, 'NONAKTIF')
  `;

  connection.query(
    sql,
    [anonim === "Y" ? null : nama_lengkap, anonim, no_hp, kritik, saran],
    (err, result) => {
      if (err) {
        console.error("❌ Insert kritik error:", err);
        return res.status(500).json({
          message: "Gagal menyimpan kritik dan saran",
        });
      }

      res.status(201).json({
        message: "✅ Terima kasih atas kritik dan saran Anda",
        id_kritik: result.insertId,
      });
    },
  );
});

// =====================================================
// GET – PUBLIK (HANYA YANG AKTIF)
// =====================================================
router.get("/", (req, res) => {
  const sql = `
    SELECT 
      id_kritik,
      nama_lengkap,
      is_anonim,
      no_hp,
      kritik,
      saran,
      created_at
    FROM kritik_saran_tb
    WHERE status = 'AKTIF'
    ORDER BY created_at DESC
  `;

  connection.query(sql, (err, rows) => {
    if (err) {
      console.error("❌ Get kritik error:", err);
      return res.status(500).json({
        message: "Gagal mengambil data kritik",
      });
    }

    const result = rows.map((row) => ({
      id_kritik: row.id_kritik,
      nama_lengkap: row.is_anonim === "Y" ? "Anonim" : row.nama_lengkap,
      no_hp: maskPhone(row.no_hp),
      kritik: row.kritik,
      saran: row.saran,
      created_at: row.created_at,
    }));

    res.json(result);
  });
});

// =====================================================
// GET – ADMIN (SEMUA DATA + FILTER STATUS)
// =====================================================
router.get("/admin", (req, res) => {
  const { status } = req.query;

  let where = "";
  let params = [];

  if (status) {
    where = "WHERE status = ?";
    params.push(status);
  }

  const sql = `
    SELECT *
    FROM kritik_saran_tb
    ${where}
    ORDER BY created_at DESC
  `;

  connection.query(sql, params, (err, rows) => {
    if (err) {
      console.error("❌ Admin get kritik error:", err);
      return res.status(500).json({
        message: "Gagal mengambil data kritik",
      });
    }

    res.json(rows);
  });
});

// =====================================================
// UPDATE STATUS – AKTIF / NONAKTIF (ADMIN)
// =====================================================
router.put("/:id/status", (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  if (!["AKTIF", "NONAKTIF"].includes(status)) {
    return res.status(400).json({
      message: "Status harus AKTIF atau NONAKTIF",
    });
  }

  const sql = `
    UPDATE kritik_saran_tb
    SET status = ?
    WHERE id_kritik = ?
  `;

  connection.query(sql, [status, id], (err) => {
    if (err) {
      console.error("❌ Update status error:", err);
      return res.status(500).json({
        message: "Gagal mengubah status",
      });
    }

    res.json({
      message: `✅ Status kritik berhasil diubah menjadi ${status}`,
    });
  });
});

// =====================================================
// DELETE – HAPUS KRITIK (ADMIN OPSIONAL)
// =====================================================
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  connection.query(
    "DELETE FROM kritik_saran_tb WHERE id_kritik = ?",
    [id],
    (err) => {
      if (err) {
        console.error("❌ Delete kritik error:", err);
        return res.status(500).json({
          message: "Gagal menghapus data",
        });
      }

      res.json({
        message: "🗑️ Kritik & saran berhasil dihapus",
      });
    },
  );
});

export default router;
