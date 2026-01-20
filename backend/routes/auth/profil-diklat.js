import express from "express";
import connection from "../../config/db.js";

const router = express.Router();

/**
 * GET /api/profil-diklat
 * Aggregator untuk halaman profil diklat
 */
router.get("/", async (req, res) => {
  try {
    // 1️⃣ Ambil institusi (asumsi satu institusi utama)
    const institusi = await new Promise((resolve, reject) => {
      connection.query(
        "SELECT * FROM institusi_pelatihan ORDER BY id ASC LIMIT 1",
        (err, results) => {
          if (err) reject(err);
          else resolve(results[0]);
        }
      );
    });

    if (!institusi) {
      return res.status(404).json({ message: "Institusi tidak ditemukan" });
    }

    // 2️⃣ Ambil histori akreditasi
    const histori = await new Promise((resolve, reject) => {
      connection.query(
        "SELECT * FROM histori_akreditasi WHERE institusi_id = ? ORDER BY id ASC",
        [institusi.id],
        (err, results) => {
          if (err) reject(err);
          else resolve(results);
        }
      );
    });

    // 3️⃣ Ambil sertifikat (berdasarkan histori terakhir)
    let sertifikat = [];
    if (histori.length > 0) {
      const historiAktif = histori[histori.length - 1];
      sertifikat = await new Promise((resolve, reject) => {
        connection.query(
          "SELECT * FROM sertifikat_akreditasi WHERE histori_akreditasi_id = ?",
          [historiAktif.id],
          (err, results) => {
            if (err) reject(err);
            else resolve(results);
          }
        );
      });
    }

    // 4️⃣ Ambil tim kerja
    const timKerja = await new Promise((resolve, reject) => {
      connection.query(
        "SELECT * FROM tim_kerja WHERE institusi_id = ? ORDER BY id ASC",
        [institusi.id],
        (err, results) => {
          if (err) reject(err);
          else resolve(results);
        }
      );
    });

    // 5️⃣ RESPONSE FINAL
    res.json({
      institusi,
      histori,
      sertifikat,
      timKerja,
    });
  } catch (err) {
    console.error("❌ Gagal load profil diklat:", err);
    res.status(500).json({ message: "Gagal load profil diklat" });
  }
});

export default router;
