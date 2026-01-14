import connection from "../config/db.js";

export const logEmail = async ({
  id_pendaftaran,
  email,
  nama_penerima,
  jenis_email,
  subject,
  status,
  error_message = null,
}) => {
  const sql = `
    INSERT INTO email_log_tb
    (
      id_pendaftaran,
      email,
      nama_penerima,
      jenis_email,
      subject,
      status,
      error_message
    )
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;

  const values = [
    id_pendaftaran,
    email,
    nama_penerima,
    jenis_email,
    subject,
    status,
    error_message,
  ];

  return new Promise((resolve, reject) => {
    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal log email:", err);
        reject(err);
      } else {
        resolve(true);
      }
    });
  });
};
