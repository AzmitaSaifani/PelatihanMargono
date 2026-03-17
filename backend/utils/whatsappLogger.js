import connection from "../config/db.js";

export const logWhatsApp = async ({
  id_pendaftaran,
  no_wa,
  nama_penerima,
  jenis_wa,
  pesan,
  status,
  error_message = null,
}) => {
  const sql = `
    INSERT INTO log_wa
    (
      id_pendaftaran,
      no_wa,
      nama_penerima,
      jenis_wa,
      pesan,
      status,
      error_message
    )
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;

  const values = [
    id_pendaftaran,
    no_wa,
    nama_penerima,
    jenis_wa,
    pesan,
    status,
    error_message,
  ];

  return new Promise((resolve, reject) => {
    connection.query(sql, values, (err) => {
      if (err) {
        console.error("❌ Gagal log WhatsApp:", err);
        reject(err);
      } else {
        resolve(true);
      }
    });
  });
};
