(async () => {
  try {
    const res = await fetch("http://localhost:5000/api/admin/me", {
      credentials: "include",
    });

    if (!res.ok) return;

    const data = await res.json();

    // PERBAIKAN: Akses level_user dari data.admin (sesuai struktur admin_guard)
    // Gunakan == agar aman jika level_user berupa string atau number
    if (data.ok && data.admin && Number(data.admin.level_user) === 1) {
      const menu = document.getElementById("menuSuperAdmin");

      if (menu) {
        // Cek apakah link sudah ada supaya tidak double saat refresh/load
        if (!document.getElementById("linkKelolaAdmin")) {
          menu.insertAdjacentHTML(
            "beforeend",
            `
            <li>
              <a id="linkKelolaAdmin" class="dropdown-item" href="admin.html">
                Kelola Admin
              </a>
            </li>
          `,
          );
        }
      }
    }
  } catch (err) {
    console.error("Role error:", err);
  }
})();
