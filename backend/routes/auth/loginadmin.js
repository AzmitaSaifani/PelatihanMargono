import { logAdmin } from "../../routes/auth/adminLogger.js";
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

      logAdmin({
        aktivitas: "LOGIN_ERROR",
        keterangan: "Kesalahan server saat login",
        req,
      });

      return res.status(500).json({ message: "Kesalahan server" });
    }

    // EMAIL TIDAK DITEMUKAN
    if (results.length === 0) {
      logAdmin({
        id_user: null,
        email,
        nama_lengkap: "UNKNOWN",
        aktivitas: "LOGIN_GAGAL",
        keterangan: "Email tidak ditemukan atau nonaktif",
        req,
      });

      return res
        .status(404)
        .json({ message: "Email tidak ditemukan atau nonaktif" });
    }

    const user = results[0];

    // BUKAN ADMIN/SUPERADMIN
    if (user.level_user !== 1 && user.level_user !== 2) {
      logAdmin({
        id_user: user.id_user,
        email: user.email,
        nama_lengkap: user.nama_lengkap,
        aktivitas: "LOGIN_DITOLAK",
        keterangan: "Bukan akun admin",
        req,
      });

      return res
        .status(403)
        .json({ message: "Akses ditolak! Anda bukan admin." });
    }

    // PASSWORD SALAH
    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      logAdmin({
        id_user: user.id_user,
        email: user.email,
        nama_lengkap: user.nama_lengkap,
        aktivitas: "LOGIN_GAGAL",
        keterangan: "Password salah",
        req,
      });

      return res.status(401).json({ message: "Password salah" });
    }

    req.session.admin = {
      id_user: user.id_user,
      email: user.email,
      nama_lengkap: user.nama_lengkap,
      level_user: user.level_user,
    };

    req.session.save(() => {
      if (err) {
        console.error("SESSION SAVE ERROR:", err);
        return res.status(500).json({ message: "Gagal menyimpan session" });
      }

      // LOGIN BERHASIL
      connection.query(
        "UPDATE user_tb SET last_login = NOW() WHERE id_user = ?",
        [user.id_user]
      );

      logAdmin({
        id_user: user.id_user,
        email: user.email,
        nama_lengkap: user.nama_lengkap,
        aktivitas: "LOGIN",
        keterangan: "Admin login berhasil",
        req,
      });

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
});

export default router;
