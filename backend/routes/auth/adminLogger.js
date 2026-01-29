import connection from "../../config/db.js";

export function logAdmin({
  id_user,
  email,
  nama_lengkap,
  aktivitas,
  keterangan,
  req,
}) {
  if (!id_user || !aktivitas) return;

  const ip =
    req.headers["x-forwarded-for"] || req.socket?.remoteAddress || null;

  const userAgent = req.headers["user-agent"] || null;

  const sql = `
    INSERT INTO log_admin
    (id_user, email, nama_lengkap, ip_address, user_agent, aktivitas, keterangan)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [id_user, email, nama_lengkap, ip, userAgent, aktivitas, keterangan],
    (err, result) => {
      if (err) {
        console.error("❌ Gagal simpan log admin:", err);
      } else {
        console.log("✅ LOG ADMIN MASUK DB:", result.insertId);
      }
    }
  );
}
