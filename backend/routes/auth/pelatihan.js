import express from "express";
import connection from "../../config/db.js";
import multer from "multer";
import path from "path";
import fs from "fs";

const router = express.Router();

// === Konfigurasi upload untuk flyer ===
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = "uploads/flyer";
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, `${uniqueName}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage });

// === CREATE: Tambah pelatihan ===
router.post("/", upload.single("flyer_url"), (req, res) => {
  // ===============================
  // AMBIL IDENTITAS ADMIN (BENAR)
  // ===============================
  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  if (!adminId) {
    return res.status(401).json({
      message: "❌ Admin tidak terautentikasi",
    });
  }

  let {
    nama_pelatihan,
    jumlah_jpl,
    lokasi,
    alamat_lengkap,
    tanggal_mulai,
    tanggal_selesai,
    kuota,
    warna,
    harga,
    kategori,
    kriteria_peserta,
    tipe_pelatihan,
    durasi,
    status,
  } = req.body;

  warna = warna || "#3498db";

  // FIX TANGGAL KOSONG
  tanggal_mulai = tanggal_mulai && tanggal_mulai !== "" ? tanggal_mulai : null;
  tanggal_selesai =
    tanggal_selesai && tanggal_selesai !== "" ? tanggal_selesai : null;

  if (!nama_pelatihan || !tanggal_mulai || !tanggal_selesai) {
    return res.status(400).json({
      message:
        "❌ Nama pelatihan, tanggal mulai, dan tanggal selesai wajib diisi.",
    });
  }

  // ---------- VALIDASI KATEGORI ----------
  if (!ALLOWED_KATEGORI.includes(kategori)) {
    return res.status(400).json({
      message: "❌ Kategori pelatihan harus: Nakes atau Non Nakes",
    });
  }

  // ===============================
  // VALIDASI TANGGAL (ADMIN)
  // ===============================
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const mulai = new Date(tanggal_mulai);
  mulai.setHours(0, 0, 0, 0);

  const selesai = new Date(tanggal_selesai);
  selesai.setHours(0, 0, 0, 0);

  // ❌ tanggal mulai tidak boleh sebelum hari ini
  if (mulai < today) {
    return res.status(400).json({
      message: "❌ Tanggal mulai pelatihan tidak boleh sebelum hari ini.",
    });
  }

  // ❌ tanggal selesai tidak boleh sebelum tanggal mulai
  if (selesai < mulai) {
    return res.status(400).json({
      message: "❌ Tanggal selesai tidak boleh lebih awal dari tanggal mulai.",
    });
  }

  if (harga < 0) {
    return res.status(400).json({
      message: "❌ Harga tidak boleh negatif",
    });
  }

  const flyer_url = req.file ? req.file.filename : null;

  const sql = `
    INSERT INTO pelatihan_tb (
      nama_pelatihan, jumlah_jpl, lokasi, alamat_lengkap,
      tanggal_mulai, tanggal_selesai, kuota, warna, harga,
      kategori, kriteria_peserta, tipe_pelatihan, durasi, flyer_url, status, created_by, created_at
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
  `;

  const values = [
    nama_pelatihan,
    jumlah_jpl,
    lokasi,
    alamat_lengkap,
    tanggal_mulai,
    tanggal_selesai,
    kuota,
    warna,
    harga || 0,
    kategori,
    kriteria_peserta,
    tipe_pelatihan,
    durasi,
    flyer_url,
    status || "draft",
    adminId,
  ];

  connection.query(sql, values, (err, result) => {
    if (err) {
      console.error("❌ Gagal menambahkan pelatihan:", err);
      return res.status(500).json({
        message: "❌ Gagal menambahkan pelatihan",
        error: err.message,
      });
    }

    // ================= ADMIN LOG =================
    logAdmin({
      id_user: adminId,
      email: adminEmail,
      nama_lengkap: adminNama,
      aktivitas: "CREATE_PELATIHAN",
      keterangan: `Menambahkan pelatihan: ${nama_pelatihan}`,
      req,
    });

    res.status(201).json({
      message: "✅ Pelatihan berhasil ditambahkan",
      id_pelatihan: result.insertId,
    });
  });
});

// === GET: Detail pelatihan by ID ===
router.get("/:id", (req, res) => {
  const { id } = req.params;

  const sql = `SELECT * FROM pelatihan_tb WHERE id_pelatihan = ?`;

  connection.query(sql, [id], (err, results) => {
    if (err) {
      console.error("❌ Error ambil detail:", err);
      return res
        .status(500)
        .json({ message: "Gagal mengambil detail pelatihan" });
    }

    if (results.length === 0) {
      return res.status(404).json({ message: "Pelatihan tidak ditemukan" });
    }

    res.status(200).json(results[0]);
  });
});

// ======================
// EXPORT EXCEL PELATIHAN
// ======================
import ExcelJS from "exceljs";

router.get("/export/excel", async (req, res) => {
  try {
    const { status, kategori, tahun } = req.query;

    let where = [];
    let params = [];

    if (status) {
      where.push("p.status = ?");
      params.push(status);
    }

    if (kategori) {
      where.push("p.kategori = ?");
      params.push(kategori);
    }

    if (tahun) {
      where.push("YEAR(p.tanggal_mulai) = ?");
      params.push(tahun);
    }

    const whereSQL = where.length ? `WHERE ${where.join(" AND ")}` : "";

    // ======================
    // QUERY DATA PELATIHAN
    // ======================
    const sql = `
      SELECT 
        p.nama_pelatihan,
        p.jumlah_jpl,
        p.lokasi,
        p.alamat_lengkap,
        p.tanggal_mulai,
        p.tanggal_selesai,
        p.kuota,
        p.warna,
        p.harga,
        p.kategori,
        p.kriteria_peserta,
        p.tipe_pelatihan,
        p.durasi,
        p.status,
        p.created_at
      FROM pelatihan_tb p
      ${whereSQL}
      ORDER BY p.tanggal_mulai ASC
    `;

    const [rows] = await connection.promise().query(sql, params);

    // ======================
    // BUAT EXCEL
    // ======================
    const workbook = new ExcelJS.Workbook();
    const sheet = workbook.addWorksheet("Data Pelatihan");

    // ==================================================
    // JUDUL
    // ==================================================
    sheet.mergeCells("A1:P1");
    sheet.mergeCells("A2:P2");
    sheet.mergeCells("A3:P3");

    sheet.getCell("A1").value = "DATA PELATIHAN";
    sheet.getCell("A2").value = "DIKLAT RSUD Prof. Dr. Margono Soekarjo";
    sheet.getCell("A3").value = `Total Pelatihan : ${rows.length}`;

    ["A1", "A2", "A3"].forEach((cell) => {
      sheet.getCell(cell).font = { bold: true, size: 12 };
      sheet.getCell(cell).alignment = { horizontal: "center" };
    });

    // Spasi
    sheet.addRow([]);
    sheet.addRow([]);

    // ==================================================
    // HEADER TABEL (BARIS 6)
    // ==================================================
    const headerRow = sheet.getRow(6);
    headerRow.values = [
      "No",
      "Nama Pelatihan",
      "Jumlah JPL",
      "Lokasi",
      "Alamat Lengkap",
      "Tanggal Mulai",
      "Tanggal Selesai",
      "Kuota",
      "Warna",
      "Harga",
      "Kategori",
      "Kriteria Peserta",
      "Tipe Pelatihan",
      "Durasi",
      "Status",
      "Dibuat Tanggal",
    ];

    headerRow.font = { bold: true };
    headerRow.alignment = { horizontal: "center", vertical: "middle" };
    headerRow.eachCell((cell) => {
      cell.border = {
        top: { style: "thin" },
        left: { style: "thin" },
        bottom: { style: "thin" },
        right: { style: "thin" },
      };
    });

    // ==================================================
    // LEBAR KOLOM
    // ==================================================
    sheet.columns = [
      { width: 5 },
      { width: 30 },
      { width: 35 },
      { width: 25 },
      { width: 20 },
      { width: 35 },
      { width: 15 },
      { width: 15 },
      { width: 12 },
      { width: 12 },
      { width: 10 },
      { width: 20 },
      { width: 20 },
      { width: 15 },
      { width: 15 },
      { width: 20 },
    ];

    // ==================================================
    // DATA (MULAI BARIS 7)
    // ==================================================
    rows.forEach((row, index) => {
      const dataRow = sheet.addRow([
        index + 1,
        row.nama_pelatihan,
        row.jumlah_jpl,
        row.lokasi,
        row.alamat_lengkap,
        row.tanggal_mulai,
        row.tanggal_selesai,
        row.kuota,
        row.warna,
        row.harga > 0 ? row.harga : 0,
        row.kategori,
        row.kriteria_peserta,
        row.tipe_pelatihan,
        row.durasi,
        row.status,
        row.created_at,
      ]);

      dataRow.eachCell((cell) => {
        cell.border = {
          top: { style: "thin" },
          left: { style: "thin" },
          bottom: { style: "thin" },
          right: { style: "thin" },
        };
        cell.alignment = { vertical: "middle" };
      });
    });

    // ======================
    // RESPONSE
    // ======================
    res.setHeader(
      "Content-Disposition",
      `attachment; filename=Data_Pelatihan_${Date.now()}.xlsx`
    );
    res.setHeader(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    );

    await workbook.xlsx.write(res);
    res.end();
  } catch (err) {
    console.error("❌ Export Excel Pelatihan error:", err);
    res.status(500).json({ message: "Gagal export Excel pelatihan" });
  }
});

// === READ: Lihat semua pelatihan ===
router.get("/", (req, res) => {
  const sql = `
  SELECT 
    p.id_pelatihan,
    p.nama_pelatihan,
    p.jumlah_jpl,
    p.lokasi,
    p.alamat_lengkap,
    p.tanggal_mulai,
    p.tanggal_selesai,
    p.kuota,
    p.warna,
    p.harga,
    p.kategori,
    p.kriteria_peserta,
    p.tipe_pelatihan,
    p.durasi,
    p.flyer_url,
    p.status,
    p.created_by,
    p.created_at,
    p.updated_at,

    /* jumlah peserta yang status = Diterima */
    (
      SELECT COUNT(*) 
      FROM pendaftaran_tb d 
      WHERE d.id_pelatihan = p.id_pelatihan
      AND d.status = 'Diterima'
    ) AS jumlah_Diterima,

    /* sisa kuota (kuota - peserta Diterima) */
    p.kuota -
    (
      SELECT COUNT(*) 
      FROM pendaftaran_tb d 
      WHERE d.id_pelatihan = p.id_pelatihan
      AND d.status = 'Diterima'
    ) AS sisa_kuota

    FROM pelatihan_tb p
    ORDER BY p.tanggal_mulai ASC
  `;

  connection.query(sql, (err, result) => {
    if (err) {
      console.error("❌ Gagal mengambil data pelatihan:", err);
      return res.status(500).json({
        message: "Gagal mengambil data pelatihan",
        error: err.message,
      });
    }
    res.status(200).json(result);
  });
});

// === UPDATE: Edit pelatihan ===
router.put("/:id", upload.single("flyer_url"), (req, res) => {
  const adminId = req.headers["x-admin-id"];
  const adminEmail = req.headers["x-admin-email"];
  const adminNama = req.headers["x-admin-nama"];

  if (!adminId) {
    return res.status(401).json({ message: "❌ Admin tidak terautentikasi" });
  }

  const { id } = req.params;
  const {
    nama_pelatihan,
    jumlah_jpl,
    lokasi,
    alamat_lengkap,
    tanggal_mulai,
    tanggal_selesai,
    kuota,
    warna,
    harga,
    kategori,
    kriteria_peserta,
    tipe_pelatihan,
    durasi,
    status,
    updated_by,
  } = req.body;

  if (kategori && !ALLOWED_KATEGORI.includes(kategori)) {
    return res.status(400).json({
      message: "❌ Kategori pelatihan harus: Nakes atau Non Nakes",
    });
  }

  const flyer_url = req.file ? req.file.filename : null;

  // Ambil data lama untuk hapus file lama jika ada upload baru
  const getOldFlyer = `SELECT flyer_url FROM pelatihan_tb WHERE id_pelatihan = ?`;
  connection.query(getOldFlyer, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Pelatihan tidak ditemukan." });
    }

    const oldFlyer = results[0].flyer_url;
    if (flyer_url && oldFlyer) {
      const oldPath = path.join("uploads/flyer", oldFlyer);
      if (fs.existsSync(oldPath)) fs.unlinkSync(oldPath); // hapus file lama
    }

    const sql = `
      UPDATE pelatihan_tb
      SET nama_pelatihan=?, jumlah_jpl=?, lokasi=?, alamat_lengkap=?,
          tanggal_mulai=?, tanggal_selesai=?, kuota=?, warna=?, harga=?,
          kategori=?, kriteria_peserta=?, tipe_pelatihan=?, durasi=?, flyer_url=?, status=?, updated_at=NOW()
      WHERE id_pelatihan=?
    `;

    const values = [
      nama_pelatihan,
      jumlah_jpl,
      lokasi,
      alamat_lengkap,
      tanggal_mulai,
      tanggal_selesai,
      kuota,
      warna,
      harga || 0,
      kategori,
      kriteria_peserta,
      tipe_pelatihan,
      durasi,
      flyer_url || oldFlyer,
      status,
      id,
    ];

    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal memperbarui pelatihan:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal memperbarui pelatihan" });
      }

      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "UPDATE_PELATIHAN",
        keterangan: `Update pelatihan ID ${id}`,
        req,
      });

      res.status(200).json({ message: "✅ Pelatihan berhasil diperbarui!" });
    });
  });
});

// === DELETE: Hapus pelatihan ===
router.delete("/:id", (req, res) => {
  const { id } = req.params;

  // Ambil nama file dulu biar bisa dihapus dari folder
  const getFlyer = `SELECT flyer_url FROM pelatihan_tb WHERE id_pelatihan = ?`;
  connection.query(getFlyer, [id], (err, results) => {
    if (err || results.length === 0) {
      return res.status(404).json({ message: "❌ Pelatihan tidak ditemukan." });
    }

    const flyer = results[0].flyer_url;
    if (flyer) {
      const flyerPath = path.join("uploads/flyer", flyer);
      if (fs.existsSync(flyerPath)) fs.unlinkSync(flyerPath); // hapus file
    }

    const deleteSql = `DELETE FROM pelatihan_tb WHERE id_pelatihan = ?`;
    connection.query(deleteSql, [id], (err) => {
      if (err) {
        console.error("❌ Gagal menghapus pelatihan:", err);
        return res
          .status(500)
          .json({ message: "❌ Gagal menghapus pelatihan" });
      }

      logAdmin({
        id_user: adminId,
        email: adminEmail,
        nama_lengkap: adminNama,
        aktivitas: "DELETE_PELATIHAN",
        keterangan: `Hapus pelatihan ID ${id}`,
        req,
      });

      res.status(200).json({ message: "✅ Pelatihan berhasil dihapus!" });
    });
  });
});

export default router;
