require("dotenv").config();

// Database configuration
// Ganti nilai hardcoded di bawah untuk production Cloud SQL
const config = {
  // Untuk Cloud SQL di Cloud Run, uncomment socketPath dan comment host/port
  // socketPath: "/cloudsql/bara-f786e:asia-southeast2:kings-sql",

  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "Kings123!",
  database: process.env.DB_NAME || "personal_finance",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
};

module.exports = config;
