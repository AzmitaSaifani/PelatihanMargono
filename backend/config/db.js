import mysql from "mysql2";

const connection = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "",
  database: "pelatihanmargono1",
  port: 3307,

  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

connection.getConnection((err, conn) => {
  if (err) {
    console.error("❌ MySQL gagal connect:", err);
  } else {
    console.log("✅ MySQL connected");
    conn.release();
  }
});

export default connection;
