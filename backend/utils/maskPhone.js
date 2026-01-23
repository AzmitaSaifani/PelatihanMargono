export const maskPhone = (phone) => {
  if (!phone) return "-";

  // contoh: 085671234567 → 08567****567
  if (phone.length < 7) return phone;

  const awal = phone.slice(0, 5);
  const akhir = phone.slice(-3);

  return `${awal}****${akhir}`;
};