import express from "express";
import connection from "../../config/db.js";
import { logAdmin } from "../../routes/auth/adminLogger.js";

const router = express.Router();

/**
 * GET struktur organisasi diklat (1 aktif)
 */
router.get("/", (req, res) => {
  connection.query(
    "SELECT * FROM struktur_organisasi_tb WHERE aktif = 1 LIMIT 1",
    (err, results) => {
      if (err) return res.status(500).json(err);
      res.json(results[0] || null);
    }
  );
});

export default router;
