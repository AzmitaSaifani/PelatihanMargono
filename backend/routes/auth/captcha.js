import express from "express";

const router = express.Router();

/**
 * GET /api/admin/captcha
 * Generate captcha dan simpan jawabannya di session
 */
router.get("/", (req, res) => {
  const num1 = Math.floor(Math.random() * 10) + 1;
  const num2 = Math.floor(Math.random() * 10) + 1;
  const operator = Math.random() > 0.5 ? "+" : "-";

  const answer = operator === "+" ? num1 + num2 : num1 - num2;

  // Simpan di session
  req.session.captchaAnswer = answer;

  res.json({
    question: `${num1} ${operator} ${num2} = ?`,
  });
});

export default router;
