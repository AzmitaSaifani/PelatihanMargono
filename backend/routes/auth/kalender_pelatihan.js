import { logAdmin } from "../../routes/auth/adminLogger.js";
import express, { Router } from "express";
import connection from "../../config/db.js";
import { authAdmin } from "../../middleware/auth.js";
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
router.post("/", authAdmin, upload.single("file_kalender"), (req, res) => {
  const adminId = req.user.id_user;
  const adminEmail = req.user.email;
  const adminNama = req.user.nama_lengkap;

  const { tahun, judul, status } = req.body;

  if (!tahun || !judul || !req.file) {
    return res.status(400).json({
      message: "❌ Tahun, judul, dan file kalender wajib diisi",
    });
  }

  const fileKalender = req.file.filename;
  const tipe_file = mapTipeFile(fileKalender);

  const sql = `
    INSERT INTO kalender_pelatihan
    (tahun, judul, file_kalender, tipe_file, status, uploaded_by)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [tahun, judul, fileKalender, tipe_file, status || "aktif", adminId],
    (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({
          message: "❌ Gagal menambahkan kalender",
        });
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
        message: "✅ Kalender berhasil ditambahkan",
        id_kalender: result.insertId,
      });
    },
  );
});

// Update

router.put("/:id", authAdmin, upload.single("file_kalender"), (req, res) => {
  const adminId = req.user.id_user;
  const adminEmail = req.user.email;
  const adminNama = req.user.nama_lengkap;

  const { id } = req.params;
  const { tahun, judul, status } = req.body;

  const getSql = "SELECT * FROM kalender_pelatihan WHERE id_kalender=?";

  connection.query(getSql, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({
        message: "❌ Kalender tidak ditemukan",
      });
    }

    const dataLama = results[0];

    // ===============================
    // ambil value lama jika tidak dikirim
    // ===============================
    const tahunFinal = tahun || dataLama.tahun;
    const judulFinal = judul || dataLama.judul;
    const statusFinal = status || dataLama.status;

    let fileFinal = dataLama.file_kalender;

    // ===============================
    // jika upload file baru
    // ===============================
    if (req.file) {
      const oldPath = path.join(
        __dirname,
        "../../uploads/kalender",
        dataLama.file_kalender,
      );

      if (dataLama.file_kalender && fs.existsSync(oldPath)) {
        fs.unlinkSync(oldPath);
      }

      fileFinal = req.file.filename;
    }

    const tipe_file = mapTipeFile(fileFinal);

    const updateSql = `
      UPDATE kalender_pelatihan
      SET tahun=?, judul=?, file_kalender=?, tipe_file=?, status=?, uploaded_by=?, updated_at=NOW()
      WHERE id_kalender=?
    `;

    connection.query(
      updateSql,
      [tahunFinal, judulFinal, fileFinal, tipe_file, statusFinal, adminId, id],
      (err) => {
        if (err) {
          console.error(err);
          return res.status(500).json({
            message: "❌ Gagal memperbarui kalender",
          });
        }

        logAdmin({
          id_user: adminId,
          email: adminEmail,
          nama_lengkap: adminNama,
          aktivitas: "AKSI",
          keterangan: `Update kalender pelatihan ID ${id}`,
          req,
        });

        res.json({
          message: "✅ Kalender berhasil diperbarui",
        });
      },
    );
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
   EDIT KALENDER
====================================================== */
router.put("/:id/status", authAdmin, (req, res) => {
  const { status } = req.body;

  connection.query(
    "UPDATE kalender_pelatihan SET status=? WHERE id_kalender=?",
    [status, req.params.id],
    (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: "Gagal update status" });
      }

      if (result.affectedRows === 0) {
        return res.status(404).json({ message: "Data tidak ditemukan" });
      }

      res.json({ message: "Status berhasil diubah" });
    },
  );
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
