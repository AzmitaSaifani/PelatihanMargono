(() => {
  let adminData = localStorage.getItem("admin");

  // Jika belum login, redirect
  if (!adminData) {
    window.location.href = "loginadmin.html";
    return;
  }

  try {
    adminData = JSON.parse(adminData);
  } catch (e) {
    // Jika data corrupt, hapus dan redirect
    localStorage.removeItem("admin");
    window.location.href = "loginadmin.html";
    return;
  }

  // Jika bukan admin, logout otomatis
  if (!adminData || adminData.level !== 1) {
    localStorage.removeItem("admin");
    window.location.href = "loginadmin.html";
  }
})();
