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
import adminRoutes from "./auth/admin.js"
import dashboardAdmin from "./auth/dashboard.js";
import profilDiklatRoutes from "./auth/profil-diklat.js";
import historiAkreditasiRoutes from "./auth/histori_akreditasi.js";
import sertifikatAkreditasiRoutes from "./auth/sertifikat_akreditasi.js";
import timKerjaRoutes from "./auth/tim_kerja.js";
import strukturOrganisasiRoutes from "./auth/struktur_organisasi.js";


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
router.use("/admin", adminRoutes);
router.use("/dashboard", dashboardAdmin);
router.use("/profil-diklat", profilDiklatRoutes);
router.use("/histori-akreditasi", historiAkreditasiRoutes);
router.use("/sertifikat-akreditasi", sertifikatAkreditasiRoutes);
router.use("/tim-kerja", timKerjaRoutes);
router.use("/struktur-organisasi", strukturOrganisasiRoutes);

export default router;
