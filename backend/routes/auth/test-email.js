import express from "express";
import { sendEmail } from "../../utils/email.js";

const router = express.Router();

router.get("/test-email", async (req, res) => {
  const success = await sendEmail({
    to: "saifaniazmita@gmail.com",
    subject: "Tes Email Diklat Margono",
    html: `
      <h2>Halo 👋</h2>
      <p>Bismillah, kalau email ini masuk, berarti setup EMAIL BERHASIL ✅</p>
    `,
  });

  if (success) {
    res.json({ message: "Email berhasil dikirim" });
  } else {
    res.status(500).json({ message: "Email gagal dikirim" });
  }
});

export default router;
