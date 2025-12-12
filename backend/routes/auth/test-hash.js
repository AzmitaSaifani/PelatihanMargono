// test-hash.js
import bcrypt from "bcryptjs";

const plain = "admin123"; // password yang harus kamu pakai di Postman
const storedHash = "$2b$10$GZpZmkjF55P3W66A0JXcJebFo2nC4mNxk8mP3WL5R/DXtfVLv2E3S"; // GANTI dgn value dari DB

bcrypt.compare(plain, storedHash, (err, same) => {
  if (err) return console.error("ERR:", err);
  console.log("match?", same);
});
