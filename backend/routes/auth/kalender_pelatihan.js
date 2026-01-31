import { logAdmin } from "../../routes/auth/adminLogger.js";
import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import { fileURLToPath } from "url";
import path from "path";
import fs from "fs";

const router = express.Router();

/* ======================================================
   HELPER: MAP TIPE FILE KE ENUM DB
====================================================== */
function mapTipeFile(filename) {
  const ext = path.extname(filename).toLowerCase();

  if (ext === ".pdf") return "pdf";
  if ([".jpg", ".jpeg", ".png", ".webp"].includes(ext)) return "image";
  if ([".xls", ".xlsx", ".csv"].includes(ext)) return "excel";

  return "lainnya";
}

/* ======================================================
   KONFIGURASI UPLOAD
====================================================== */
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = path.join(__dirname, "../../uploads/kalender");
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    cb(null, dir);
  },

  filename: (req, file, cb) => {
    const { tahun } = req.body;

    if (!tahun) {
      return cb(new Error("Tahun wajib diisi sebelum upload file"));
    }

    const ext = path.extname(file.originalname);
    const filename = `kalender-${tahun}${ext}`;

    cb(null, filename);
  },
});

const upload = multer({ storage });
/* ======================================================
   CREATE / UPDATE (BERDASARKAN TAHUN)
====================================================== */
router.post("/", upload.single("file_kalender"), (req, res) => {
  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  if (!adminId) {
    return res.status(401).json({ message: "❌ Admin tidak terautentikasi" });
  }

  const { tahun, judul, status } = req.body;
  const file = req.file?.filename;

  if (!tahun || !judul || !file) {
    return res.status(400).json({
      message: "❌ Tahun, judul, dan file kalender wajib diisi",
    });
  }

  const fileKalender  = req.file.filename;

  const tipe_file = mapTipeFile(file);

  const checkSql =
    "SELECT id_kalender, file_kalender FROM kalender_pelatihan WHERE tahun = ?";

  connection.query(checkSql, [tahun], (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "❌ Server error" });
    }

    /* ================= UPDATE ================= */
    if (results.length > 0) {
      const oldFile = results[0].file_kalender;

      if (oldFile) {
        const oldPath = path.join(__dirname, "../../uploads/kalender", oldFile);
        if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath);
      }

      const updateSql = `
        UPDATE kalender_pelatihan
        SET judul=?, file_kalender=?, tipe_file=?, status=?, uploaded_by=?, updated_at=NOW()
        WHERE tahun=?
      `;

      connection.query(
        updateSql,
        [judul, fileKalender , tipe_file, status || "aktif", adminId, tahun],
        (err) => {
          if (err) {
            console.error(err);
            return res
              .status(500)
              .json({ message: "❌ Gagal memperbarui kalender" });
          }

          logAdmin({
            id_user: adminId,
            email: adminEmail,
            nama_lengkap: adminNama,
            aktivitas: "AKSI",
            keterangan: `Update kalender pelatihan tahun ${tahun}`,
            req,
          });

          res.json({
            message: `✅ Kalender pelatihan tahun ${tahun} berhasil diperbarui`,
          });
        }
      );
    } else {
      /* ================= INSERT ================= */
      const insertSql = `
        INSERT INTO kalender_pelatihan
        (tahun, judul, file_kalender, tipe_file, status, uploaded_by)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

      connection.query(
        insertSql,
        [tahun, judul, fileKalender , tipe_file, status || "aktif", adminId],
        (err, result) => {
          if (err) {
            console.error(err);
            return res
              .status(500)
              .json({ message: "❌ Gagal menambahkan kalender" });
          }

          logAdmin({
            id_user: adminId,
            email: adminEmail,
            nama_lengkap: adminNama,
            aktivitas: "AKSI",
            keterangan: `Menambahkan kalender pelatihan tahun ${tahun}`,
            req,
          });

          res.status(201).json({
            message: `✅ Kalender pelatihan tahun ${tahun} berhasil ditambahkan`,
            id_kalender: result.insertId,
          });
        }
      );
    }
  });
});

/* ======================================================
   READ ALL
====================================================== */
router.get("/", (req, res) => {
  const { admin } = req.query;

  let sql = `
    SELECT k.*, u.nama_lengkap AS uploaded_by_nama
    FROM kalender_pelatihan k
    JOIN user_tb u ON u.id_user = k.uploaded_by
  `;

  if (!admin) {
    sql += " WHERE k.status = 'aktif'";
  }

  sql += " ORDER BY k.tahun DESC";

  connection.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      return res
        .status(500)
        .json({ message: "❌ Gagal mengambil data kalender" });
    }
    res.json(results);
  });
});

/* ======================================================
   DELETE
====================================================== */
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  if (!adminId) {
    return res.status(401).json({ message: "❌ Admin tidak terautentikasi" });
  }

  const getSql =
    "SELECT tahun, file_kalender FROM kalender_pelatihan WHERE id_kalender=?";

  connection.query(getSql, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Kalender tidak ditemukan" });
    }

    const { tahun, file_kalender } = results[0];

    if (file_kalender) {
      const filePath = path.join("uploads/kalender", file_kalender);
      if (fs.existsSync(filePath)) fs.unlinkSync(filePath);
    }

    connection.query(
      "DELETE FROM kalender_pelatihan WHERE id_kalender=?",
      [id],
      (err) => {
        if (err) {
          console.error(err);
          return res
            .status(500)
            .json({ message: "❌ Gagal menghapus kalender" });
        }

        logAdmin({
          id_user: adminId,
          email: adminEmail,
          nama_lengkap: adminNama,
          aktivitas: "AKSI",
          keterangan: `Hapus kalender pelatihan tahun ${tahun}`,
          req,
        });

        res.json({ message: "✅ Kalender berhasil dihapus" });
      }
    );
  });
});

// ===============================
// GET KALENDER AKTIF (FRONTEND)
// ===============================
router.get("/aktif/latest", (req, res) => {
  const sql = `
    SELECT tahun, judul, file_kalender
    FROM kalender_pelatihan
    WHERE status = 'aktif'
    ORDER BY tahun DESC
    LIMIT 1
  `;

  connection.query(sql, (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({
        message: "Kalender pelatihan belum tersedia",
      });
    }

    res.json(results[0]);
  });
});

export default router;
