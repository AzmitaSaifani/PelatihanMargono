const admin = JSON.parse(localStorage.getItem("admin"));

if (!admin || admin.level !== 1) {
  localStorage.removeItem("admin");
  window.location.href = "loginadmin.html";
}
