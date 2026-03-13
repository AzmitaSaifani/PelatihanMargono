import axios from "axios";

export async function sendWhatsApp({ nohp, pesan }) {
  try {
    const url = `http://36.67.13.3:7173/whatsappReminder/api/kirim_diklat?token=abcabc123456defgh!&nohp=${nohp}&pesan=${pesan}`;

    const response = await axios.get(url, {
      params: {
        token: "abcabc123456defgh!",
        nohp,
        pesan,
      },
    });

    console.log("WA terkirim ke:", nohp);
    console.log("Response WA:", response.data);

    return response.data;
  } catch (err) {
    console.error("WhatsApp gagal dikirim:", err.message);
    return null;
  }
}
