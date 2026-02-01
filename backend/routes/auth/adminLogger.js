import connection from "../../config/db.js";

// =====================
// HELPER: NORMALIZE IP
// =====================
function normalizeIp(ip) {
  if (!ip) return null;
  if (ip === "::1") return "127.0.0.1"; // localhost IPv6
  if (ip.startsWith("::ffff:")) return ip.replace("::ffff:", ""); // IPv4-mapped IPv6
  return ip;
}

// =====================
// LOG ADMIN
// =====================
export function logAdmin({
  id_user = null,
  email = "-",
  nama_lengkap = "SYSTEM",
  aktivitas,
  keterangan = null,
  req,
}) {
  if (!aktivitas) return;

  const rawIp =
    req?.headers["x-forwarded-for"] || req?.socket?.remoteAddress || null;

  const ip = normalizeIp(rawIp);

  const userAgent = req?.headers["user-agent"] || null;

  const sql = `
    INSERT INTO log_admin
    (id_user, email, nama_lengkap, ip_address, user_agent, aktivitas, keterangan)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;

  connection.query(
    sql,
    [
      id_user,
      email || "-",
      nama_lengkap || "SYSTEM",
      ip,
      userAgent,
      aktivitas,
      keterangan,
    ],
    (err) => {
      if (err) {
        console.error("❌ Gagal simpan log admin:", err);
      }
    }
  );
}

// =====================
// LOG ADMIN LOGOUT
// =====================
export function logAdminLogout({ id_user, email, nama_lengkap, req }) {
  if (!id_user) return;

  logAdmin({
    id_user,
    email,
    nama_lengkap,
    aktivitas: "LOGOUT",
    keterangan: "Admin logout",
    req,
  });
}
