(() => {
  const MAX_SESSION = 2 * 60 * 60 * 1000; // 2 jam (dalam ms)

  const adminRaw = localStorage.getItem("admin");

  // Jika belum login
  if (!adminRaw) {
    window.location.href = "loginadmin.html";
    return;
  }

  let adminData;
  try {
    adminData = JSON.parse(adminRaw);
  } catch (err) {
    localStorage.removeItem("admin");
    window.location.href = "loginadmin.html";
    return;
  }

  // SESSION EXPIRED
  const now = Date.now();

  if (now - adminData.lastActive > MAX_SESSION) {
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

  // UPDATE AKTIVITAS TERAKHIR 🔥
  adminData.lastActive = now;
  localStorage.setItem("admin", JSON.stringify(adminData));
})();
