import express from "express";
import pelatihanRoutes from "./auth/pelatihan.js";
import registerRoute from "./auth/register.js";
import loginRoute from "./auth/login.js";
import pendaftaranRoute from "./auth/pendaftaran.js";
import pembayaranRoute from "./auth/pembayaran.js";
import institusiRoute from "./auth/institusi.js";
import penyelenggaraRoute from "./auth/penyelenggara.js";
import fasilitatorRoute from "./auth/fasilitator.js";
import galleryRoute from "./auth/gallery.js";
import kalenderRoute from "./auth/kalender.js";
import loginAdminRoute from "./auth/loginadmin.js";
import dashboardAdmin from "./auth/dashboard.js";


const router = express.Router();

router.use("/register", registerRoute);
router.use("/login", loginRoute);
router.use("/pelatihan", pelatihanRoutes);
router.use("/pendaftaran", pendaftaranRoute);
router.use("/pembayaran", pembayaranRoute);
router.use("/institusi", institusiRoute);
router.use("/penyelenggara", penyelenggaraRoute);
router.use("/fasilitator", fasilitatorRoute);
router.use("/gallery", galleryRoute);
router.use("/kalender", kalenderRoute);
router.use("/loginadmin", loginAdminRoute);
router.use("/dashboard", dashboardAdmin);


export default router;
