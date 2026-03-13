import axios from "axios";

export async function sendWhatsApp({ nohp, pesan }) {
  try {
    const url = "http://36.67.13.3:7173/whatsappReminder/api/kirim_diklat";

    const response = await axios.get(url, {
      params: {
        token: "abcabc123456defgh!", // Pastikan token aktif
        nohp: nohp, // Sekarang formatnya sudah 628xxx
        pesan: pesan, // Axios otomatis mengubah newline menjadi format URL
      },
    });

    console.log("WA terkirim ke:", nohp);
    console.log("Response Server:", response.data);

    return response.data;
  } catch (err) {
    console.error("Kesalahan Koneksi API:", err.message);
    return null;
  }
}
