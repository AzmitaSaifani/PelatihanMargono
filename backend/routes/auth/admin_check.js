(() => {
  const MAX_SESSION = 2 * 60 * 60 * 1000; // 2 jam

  const adminRaw = localStorage.getItem("admin");

  if (!adminRaw) {
    window.location.href = "loginadmin.html";
    return;
  }

  let adminData;
  try {
    adminData = JSON.parse(adminRaw);
  } catch {
    localStorage.clear();
    window.location.href = "loginadmin.html";
    return;
  }

  // Jika bukan admin
  if (adminData.level !== 1) {
    localStorage.clear();
    window.location.href = "loginadmin.html";
    return;
  }

  const now = Date.now();

  // Expired
  if (now - adminData.lastActive > MAX_SESSION) {
    alert("Sesi login Anda telah berakhir");
    localStorage.clear();
    window.location.href = "loginadmin.html";
    return;
  }

  // 🔥 Update last active
  adminData.lastActive = now;
  localStorage.setItem("admin", JSON.stringify(adminData));

  // 🔥🔥 INI YANG HILANG SEBELUMNYA
  // Sinkronkan field untuk header API
  localStorage.setItem("admin_id", adminData.id_user);
  localStorage.setItem("admin_email", adminData.email);
  localStorage.setItem("admin_nama", adminData.nama_lengkap);
})();
