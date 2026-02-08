// ================= ADMIN AUTH =================
export const authAdmin = (req, res, next) => {
  if (req.session && req.session.admin) {
    req.user = req.session.admin; // { id_user, email, nama_lengkap, level }
    return next();
  }

  return res.status(401).json({
    ok: false,
    message: "Admin belum login",
  });
};

// ================= ROLE CHECK =================
export const onlySuperAdmin = (req, res, next) => {
  if (req.user.level !== 1) {
    return res.status(403).json({
      ok: false,
      message: "Akses khusus Super Admin",
    });
  }

  next();
};
