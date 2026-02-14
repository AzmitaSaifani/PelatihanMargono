(async () => {
  try {
    const res = await fetch("http://localhost:5000/api/admin/me", {
      credentials: "include",
    });

    if (!res.ok) {
      window.location.href = "loginadmin.html";
      return;
    }

    const data = await res.json();

    if (!data.ok || !data.admin) {
      window.location.href = "loginadmin.html";
      return;
    }

    // inject nama admin ke navbar
    const nama = document.getElementById("namaAdmin");
    if (nama) {
      nama.innerText = data.admin.nama_lengkap;
    }
  } catch (err) {
    console.error("Session error:", err);
    window.location.href = "loginadmin.html";
  }
})();
