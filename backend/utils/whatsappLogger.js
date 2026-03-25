import connection from "../config/db.js";

export const logWhatsApp = async ({
  id_pendaftaran,
  no_wa,
  nama_penerima,
  jenis_wa,
  status,
  error_message = null,
}) => {

  // ✅ Mapping subject otomatis
  const subjectMap = {
    BERKAS_PENDING: "Pendaftaran Berhasil – Menunggu Verifikasi Berkas",
    BERKAS_VALID: "Berkas Diterima – Pendaftaran Disetujui",
    BERKAS_INVALID: "Berkas Tidak Valid – Perlu Perbaikan",
  };

  const subject = subjectMap[jenis_wa] || "Notifikasi Pendaftaran";


  const sql = `
    INSERT INTO log_wa
    (
      id_pendaftaran,
      no_wa,
      nama_penerima,
      jenis_wa,
      subject,
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
    subject,
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
