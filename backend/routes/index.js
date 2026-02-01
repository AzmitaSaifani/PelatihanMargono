import express from "express";

const router = express.Router();

// =====================
// BODY PARSER
// =====================
router.use(express.json());
router.use(express.urlencoded({ extended: true }));

// AUTH & USER
import registerRoute from "./auth/register.js";
import loginRoute from "./auth/login.js";
import logAdminRoute from "./auth/logadmin.js";
import loginAdminRoute from "./auth/loginadmin.js";
import adminRoutes from "./auth/admin.js";
import logoutAdminRoute from "./auth/logoutadmin.js";

// CORE DATA
import pelatihanRoutes from "./auth/pelatihan.js";
import pendaftaranRoute from "./auth/pendaftaran.js";
import pembayaranRoute from "./auth/pembayaran.js";

// MASTER DATA
import institusiRoute from "./auth/institusi.js";
import penyelenggaraRoute from "./auth/penyelenggara.js";
import fasilitatorRoute from "./auth/fasilitator.js";
import galleryRoute from "./auth/gallery.js";
import kalenderRoute from "./auth/kalender_pelatihan.js";

// ADMIN & PROFIL
import dashboardAdmin from "./auth/dashboard.js";
import profilDiklatRoutes from "./auth/profil-diklat.js";
import historiAkreditasiRoutes from "./auth/histori_akreditasi.js";
import sertifikatAkreditasiRoutes from "./auth/sertifikat_akreditasi.js";
import timKerjaRoutes from "./auth/tim_kerja.js";
import strukturOrganisasiRoutes from "./auth/struktur_organisasi.js";
import kritikSaranRoutes from "./auth/kritikSaran.js";

/* ===========================
   AUTH
=========================== */
router.use("/register", registerRoute);
router.use("/login", loginRoute);
router.use("/log-admin", logAdminRoute);
router.use("/loginadmin", loginAdminRoute);
router.use("/admin", adminRoutes);
router.use("/admin/logout", logoutAdminRoute);

/* ===========================
   DASHBOARD ADMIN
=========================== */
router.use("/dashboard", dashboardAdmin);

/* ===========================
   PELATIHAN & TRANSAKSI
=========================== */
router.use("/pelatihan", pelatihanRoutes);
router.use("/pendaftaran", pendaftaranRoute);
router.use("/pembayaran", pembayaranRoute);

/* ===========================
   MASTER DATA
=========================== */
router.use("/institusi", institusiRoute);
router.use("/penyelenggara", penyelenggaraRoute);
router.use("/fasilitator", fasilitatorRoute);
router.use("/gallery", galleryRoute);

/* ===========================
 KALENDER PELATIHAN
=========================== */
router.use("/kalender", kalenderRoute);

/* ===========================
   PROFIL & DOKUMEN
=========================== */
router.use("/profil-diklat", profilDiklatRoutes);
router.use("/histori-akreditasi", historiAkreditasiRoutes);
router.use("/sertifikat-akreditasi", sertifikatAkreditasiRoutes);
router.use("/tim-kerja", timKerjaRoutes);
router.use("/struktur-organisasi", strukturOrganisasiRoutes);

/* ===========================
   FEEDBACK
=========================== */
router.use("/kritik-saran", kritikSaranRoutes);

export default router;
