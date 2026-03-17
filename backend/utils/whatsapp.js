import axios from "axios";

export async function sendWhatsApp(nohp, pesan) {
  try {
    const token = "abcabc123456defgh!";
    const baseUrl = "http://36.67.13.3:7173/whatsappReminder/api/kirim_diklat";

    // Gunakan URLSearchParams agar encoding rapi dan standar
    const params = new URLSearchParams({
      token: token,
      nohp: nohp,
      pesan: pesan,
    }).toString();
    const fullUrl = `${baseUrl}?${params.toString()}`;

    const response = await axios.get(fullUrl);

    console.log("WA terkirim ke:", nohp);
    console.log("Response Server:", response.data);

    return response.data;
  } catch (err) {
    console.error("❌ Kesalahan Koneksi API WA:", err.message);
    return null;
  }
}
