(() => {

  const MAX_SESSION = 2 * 60 * 60 * 1000; // 2 jam (dalam ms)

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

  // Cek expired session (2 jam)
  const now = Date.now();
  const sessionAge = now - adminData.loginTime;

  if (sessionAge > MAX_SESSION) {
    alert("Sesi login Anda telah berakhir. Silakan login kembali.");
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
