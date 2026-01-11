import connection from "../../config/db.js";

export function logAdmin({
  id_user,
  email,
  nama_lengkap,
  aktivitas,
  keterangan,
  req,
}) {
  const ip =
    req.headers["x-forwarded-for"] ||
    req.connection?.remoteAddress ||
    req.socket?.remoteAddress ||
    null;

  const userAgent = req.headers["user-agent"] || null;

  const sql = `
    INSERT INTO log_admin
    (id_user, email, nama_lengkap, ip_address, user_agent, aktivitas, keterangan)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;

  connection.query(sql, [
    id_user,
    email,
    nama_lengkap,
    ip,
    userAgent,
    aktivitas,
    keterangan,
  ]);
}
