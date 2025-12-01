import { config } from "dotenv";
config();

// Database configuration
// Ganti nilai hardcoded di bawah untuk production Cloud SQL
const dbConfig = {
  // Untuk Cloud SQL di Cloud Run, uncomment socketPath dan comment host/port
  //socketPath: "/cloudsql/bara-f786e:asia-southeast2:kings-sql",
  
  host: process.env.DB_HOST, 
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl: {
    // Untuk demo / tugas boleh false dulu, supaya gak perlu CA file.
    // Nanti kalau mau lebih aman baru pakai CA cert Aiven.
    rejectUnauthorized: false,
  },
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
};

export default dbConfig;






