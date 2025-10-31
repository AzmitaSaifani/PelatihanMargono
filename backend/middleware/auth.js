// menyimpan objek user di req.session.user, buat middleware untuk cek login.
// backend/middleware/auth.js
module.exports = {
  ensureAuth: (req, res, next) => {
    // pakai session:
    if (req.session && req.session.user) return next();
    // jika pakai JWT, ganti logika sesuai token
    return res.status(401).json({ ok: false, message: "Belum login" });
  },
};
