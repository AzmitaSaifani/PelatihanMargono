import express from "express";
import cors from "cors";

import authRoutes from "./routes/index.js";
import registerRoute from "./routes/auth/register.js";
import loginRoute from "./routes/auth/login.js";
import pendaftaranRoute from "./routes/auth/pendaftaran.js";

const app = express();

app.use(cors());
app.use(express.json());

// ROUTES
app.use("/api/register", registerRoute);
app.use("/api/login", loginRoute);
app.use("/api/pendaftaran", pendaftaranRoute);
app.use("/auth", authRoutes);

// TEST ROUTE
app.get("/", (req, res) => {
  res.send("✅ Server API pelatihan jalan!");
});

const PORT = 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server berjalan di http://localhost:${PORT}`);
});
