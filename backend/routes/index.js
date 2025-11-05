import express from "express";
import pelatihanRoutes from "./auth/pelatihan.js";
import registerRoute from "./auth/register.js";
import loginRoute from "./auth/login.js";
import pendaftaranRoute from "./auth/pendaftaran.js";
import institusiRoute from "./auth/institusi.js";

const router = express.Router();

router.use("/register", registerRoute);
router.use("/login", loginRoute);
router.use("/pelatihan", pelatihanRoutes);
router.use("/pendaftaran", pendaftaranRoute);
router.use("/institusi", institusiRoute);

export default router;
