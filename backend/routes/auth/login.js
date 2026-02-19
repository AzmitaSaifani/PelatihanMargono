import express from "express";
import bcrypt from "bcryptjs";
import db from "../../config/db.js";

const router = express.Router();

router.post("/", (req, res) => {
  const { email, password } = req.body;

  // ===============================
  // CEK CAPTCHA
  // ===============================
  if (!req.session.captchaAnswer) {
    return res.status(400).json({
      message: "Captcha tidak ditemukan. Silakan refresh.",
    });
  }

  if (parseInt(captcha) !== req.session.captchaAnswer) {
    return res.status(400).json({
      message: "Captcha salah.",
    });
  }

  // Hapus captcha setelah dipakai
  req.session.captchaAnswer = null;

  const sql = "SELECT * FROM user_tb WHERE email = ? AND status_user = 1";

  db.query(sql, [email], async (err, results) => {
    if (err) return res.status(500).json({ message: "Kesalahan server" });
    if (results.length === 0)
      return res.status(404).json({ message: "Email tidak ditemukan" });

    const user = results[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(401).json({ message: "Password salah" });

    // SET SESSION
    req.session.admin = {
      id_user: user.id_user,
      email: user.email,
      nama_lengkap: user.nama_lengkap,
      level_user: user.level_user,
    };

    // UPDATE LAST LOGIN
    db.query(
      "UPDATE user_tb SET last_login = NOW() WHERE id_user = ?",
      [user.id_user],
      (updateErr) => {
        if (updateErr) {
          console.error("Gagal update last_login:", updateErr);
        }

        // RESPONSE DIKIRIM SETELAH UPDATE
        req.session.save(() => {
          res.json({
            message: "Login berhasil",
            user: {
              id: user.id_user,
              nama: user.nama_lengkap,
              email: user.email,
              loginTime: Date.now(),
            },
          });
        });
      },
    );
  });
});

export default router;
