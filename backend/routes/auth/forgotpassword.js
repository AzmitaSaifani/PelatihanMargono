// file: routes/auth.js
import express from "express";
import nodemailer from "nodemailer";

const router = express.Router();

router.post("/forgot-password", async (req, res) => {
  const { email } = req.body;

  // Cek kalau email kosong
  if (!email) return res.status(400).json({ message: "Email wajib diisi" });

  try {
    // Di sini kamu bisa cek di database apakah email terdaftar
    // Misal kita skip dulu pengecekan DB

    // Buat transporter untuk kirim email
    const transporter = nodemailer.createTransport({
      service: "gmail", // Bisa diganti sesuai provider (Yahoo, Outlook, dll)
      auth: {
        user: "emailkamu@gmail.com", // Ganti dengan email kamu
        pass: "password_aplikasi",   // Pakai app password, bukan password Gmail biasa
      },
    });

    // Buat link reset password (dummy dulu)
    const resetLink = `http://localhost:5000/reset-password?email=${encodeURIComponent(email)}`;

    // Kirim email
    await transporter.sendMail({
      from: '"Diklat RSMS" <emailkamu@gmail.com>', // Nama pengirim
      to: email,
      subject: "Reset Password Akun Diklat RSMS",
      html: `
        <p>Halo,</p>
        <p>Kami menerima permintaan untuk mereset password akun Anda.</p>
        <p>Klik tautan berikut untuk mengatur ulang password Anda:</p>
        <a href="${resetLink}">${resetLink}</a>
        <p>Jika Anda tidak meminta reset password, abaikan email ini.</p>
        <p>Terima kasih,</p>
        <p><strong>Tim Diklat RSMS</strong></p>
      `,
    });

    return res.json({ message: "Tautan reset password telah dikirim ke email Anda." });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Gagal mengirim email reset password." });
  }
});

export default router;
