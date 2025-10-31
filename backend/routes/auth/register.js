import express from "express";
import bcrypt from "bcryptjs";
import db from "../../config/db.js";

const router = express.Router();

router.post("/", async (req, res) => {
  const { email, password, nama_lengkap } = req.body;

  try {
    const cekUser = "SELECT * FROM user_tb WHERE email = ?";
    db.query(cekUser, [email], async (err, results) => {
      if (err) return res.status(500).json({ message: "Kesalahan server" });
      if (results.length > 0)
        return res.status(400).json({ message: "Email sudah digunakan" });

      const hashedPassword = await bcrypt.hash(password, 10);

      const sqlInsert = `
        INSERT INTO user_tb (email, password, nama_lengkap, level_user, aktivasi, status_user)
        VALUES (?, ?, ?, '2', 'Y', 1)
      `;

      db.query(sqlInsert, [email, hashedPassword, nama_lengkap], (err) => {
        if (err)
          return res
            .status(500)
            .json({ message: "Gagal registrasi", error: err });
        res.status(201).json({ message: "Registrasi berhasil, silakan login" });
      });
    });
  } catch (err) {
    res.status(500).json({ message: "Terjadi kesalahan", error: err });
  }
});

export default router;
