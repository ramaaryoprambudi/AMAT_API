import { config } from "dotenv";
config();

// Database configuration
// Ganti nilai hardcoded di bawah untuk production Cloud SQL
const dbConfig = {
  // Untuk Cloud SQL di Cloud Run, uncomment socketPath dan comment host/port
  //socketPath: "/cloudsql/bara-f786e:asia-southeast2:kings-sql",
  
  host: process.env.DB_HOST, // ⬅ WAJIB di-set, jangan dibiarkan kosong
  port: process.env.DB_PORT,
  user: process.env.DB_USER || "avnadmin",
  password: process.env.DB_PASSWORD || "AVNS_srshgCgm00D1lDvmGOb",
  database: process.env.DB_NAME || "personal_finance",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
};

export default dbConfig;




