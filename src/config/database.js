import { config } from "dotenv";
config();

// Database configuration
const dbConfig = {
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "Kings123!",
  database: process.env.DB_NAME || "personal_finance",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
};

// Cloud Run dengan Cloud SQL menggunakan Unix socket
if (process.env.NODE_ENV === 'production') {
  // Untuk Cloud Run, WAJIB menggunakan socketPath
  dbConfig.socketPath = "/cloudsql/bara-f786e:asia-southeast2:kings-sql";
} else {
  // Development menggunakan TCP
  dbConfig.host = process.env.DB_HOST || "localhost";
  dbConfig.port = process.env.DB_PORT || 3306;
}

export default dbConfig;
