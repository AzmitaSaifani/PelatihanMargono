window.editPelatihan = async (id) => {
  const res = await fetch(`http://localhost:5000/api/pelatihan/${id}`);
  const data = await res.json();

  // Isi form modal
  document.getElementById("edit_id_pelatihan").value = data.id_pelatihan;
  document.getElementById("edit_nama_pelatihan").value = data.nama_pelatihan;
  document.getElementById("edit_deskripsi").value = data.deskripsi || "";
  document.getElementById("edit_narasumber").value = data.narasumber || "";
  document.getElementById("edit_tanggal_mulai").value = data.tanggal_mulai;
  document.getElementById("edit_tanggal_selesai").value = data.tanggal_selesai;
  document.getElementById("edit_waktu_mulai").value = data.waktu_mulai;
  document.getElementById("edit_waktu_selesai").value = data.waktu_selesai;

  new bootstrap.Modal(document.getElementById("modalEditPelatihan")).show();
};


document.getElementById("formEditPelatihan").addEventListener("submit", async (e) => {
  e.preventDefault();

  const id = document.getElementById("edit_id_pelatihan").value;
  const formData = new FormData(e.target);

  const res = await fetch(`${API}/${id}`, {
    method: "PUT",
    body: formData,
  });

  const data = await res.json();
  alert(data.message);

  modalEdit.hide();
  loadPelatihan(); // refresh tabel
});
