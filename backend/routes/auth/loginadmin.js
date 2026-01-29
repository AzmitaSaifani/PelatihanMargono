import express from "express";
import bcrypt from "bcryptjs";
import connection from "../../config/db.js";

const router = express.Router();

function getClientInfo(req) {
  return {
    ip: req.headers["x-forwarded-for"] || req.socket?.remoteAddress || null,
    userAgent: req.headers["user-agent"] || null,
  };
}

router.post("/", (req, res) => {
  const { email, password } = req.body;

  const sql = `
    SELECT * FROM user_tb
    WHERE email = ?
      AND status_user = 1
      AND aktivasi = 'Y'
    LIMIT 1
  `;

  connection.query(sql, [email], async (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Kesalahan server" });
    }

    if (results.length === 0) {
      return res
        .status(404)
        .json({ message: "Email tidak ditemukan atau nonaktif" });
    }

    const user = results[0];

    if (user.level_user !== 1) {
      return res
        .status(403)
        .json({ message: "Akses ditolak! Anda bukan admin." });
    }

    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return res.status(401).json({ message: "Password salah" });
    }

    const client = getClientInfo(req);

    // update last_login
    connection.query(
      "UPDATE user_tb SET last_login = NOW() WHERE id_user = ?",
      [user.id_user]
    );

    // simpan log login
    connection.query(
      `
      INSERT INTO log_admin
      (id_user, email, nama_lengkap, ip_address, user_agent, aktivitas, keterangan)
      VALUES (?, ?, ?, ?, ?, 'LOGIN', 'Admin login berhasil')
      `,
      [
        user.id_user,
        user.email,
        user.nama_lengkap,
        client.ip,
        client.userAgent,
      ],
      (err, result) => {
        if (err) {
          console.error("❌ Gagal simpan log LOGIN:", err);
        } else {
          console.log("✅ LOG LOGIN MASUK:", result.insertId);
        }
      }
    );

    res.json({
      message: "Login Admin Berhasil!",
      admin: {
        id_user: user.id_user,
        email: user.email,
        nama_lengkap: user.nama_lengkap,
        level: user.level_user,
      },
    });
  });
});

export default router;
