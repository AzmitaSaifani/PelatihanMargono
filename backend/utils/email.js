import nodemailer from "nodemailer";

const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST,
  port: Number(process.env.EMAIL_PORT),
  secure: false, // wajib false untuk port 587
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

// fungsi kirim email
export const sendEmail = async ({ to, subject, html }) => {
  try {
    const info = await transporter.sendMail({
      from: `"DIKLAT RSUD PROF. DR. MARGONO SOEKARJO" <${process.env.EMAIL_USER}>`,
      to,
      subject,
      html,
    });

    console.log("📧 Email terkirim:", info.messageId);
    return true;
  } catch (error) {
    console.error("❌ Gagal kirim email:", error);
    return false;
  }
};
