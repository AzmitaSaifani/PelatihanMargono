import bcrypt from "bcryptjs";

const plain = "admin123"; // password asli
const hash = "$2b$10$L0TdUoR2E48DrxaZCvzHGO107xLnpw0hukuMQfpK5ArwDNz8wwEUa"; // hash dari DB kamu

bcrypt.compare(plain, hash).then((result) => {
  console.log("COMPARE RESULT:", result);
});
