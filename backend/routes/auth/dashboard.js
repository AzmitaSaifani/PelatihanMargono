import express from "express";
import connection from "../../config/db.js";

const router = express.Router();

router.get("/statistik", async (req, res) => {
  try {
    const [pendaftaran, pembayaran, pelatihan] = await Promise.all([
      // ======================
      // STATISTIK PENDAFTARAN
      // ======================
      connection.promise().query(`
        SELECT
          COUNT(*) AS total,
          SUM(status = 'Menunggu Verifikasi Berkas') AS menunggu_verifikasi_berkas,
          SUM(status = 'Verifikasi Berkas Invalid') AS pendaftaran_invalid_berkas,
          SUM(status = 'Menunggu Pembayaran') AS menunggu_pembayaran,
          SUM(status = 'Diterima') AS diterima,
          SUM(status = 'Perlu Perbaikan') AS perlu_perbaikan
        FROM pendaftaran_tb
      `),

      // ======================
      // STATISTIK PEMBAYARAN
      // ======================
      connection.promise().query(`
        SELECT
          COUNT(*) AS total,
          SUM(status = 'PENDING') AS pending,
          SUM(status = 'VALID') AS valid,
          SUM(status = 'INVALID') AS invalid
        FROM pembayaran_tb
      `),

      // ======================
      // STATISTIK PELATIHAN
      // ======================
      connection.promise().query(`
        SELECT
          COUNT(*) AS total,
          SUM(status = 'publish') AS aktif,
          SUM(status = 'draft') AS draft,
          SUM(status = 'selesai') AS selesai,
          SUM(kuota) AS total_kuota,
          (
            SELECT COUNT(*) 
            FROM pendaftaran_tb 
            WHERE status = 'Diterima'
          ) AS total_peserta_diterima
        FROM pelatihan_tb
      `),
    ]);

    res.json({
      pendaftaran: pendaftaran[0][0],
      pembayaran: pembayaran[0][0],
      pelatihan: pelatihan[0][0],
    });
  } catch (err) {
    console.error("❌ Statistik dashboard error:", err);
    res.status(500).json({
      message: "Gagal mengambil statistik dashboard",
    });
  }
});

export default router;
