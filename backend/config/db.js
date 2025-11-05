import mysql from "mysql2";

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "pelatihanmargono1",
  port: 3307,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

db.connect((err) => {
  if (err) {
    console.error(
      "❌ Error connecting to MySQL:",
      JSON.stringify(err, null, 2)
    );
    return;
  }
  console.log("✅ Connected to MySQL database.");
});

export default db;
