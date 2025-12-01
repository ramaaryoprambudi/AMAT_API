import multer from 'multer';
import path from 'path';
import fs from 'fs';
import { fileURLToPath } from 'url';

// Get current directory in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Initialize upload directory on module load
(() => {
  const projectRoot = path.join(__dirname, '..', '..');
  const uploadDir = path.join(projectRoot, 'uploads', 'profile-photos');
  
  try {
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
  } catch (error) {
    console.error('Error initializing upload directory:', error);
  }
})();

// Konfigurasi storage untuk multer
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    // Use absolute path from project root
    const projectRoot = path.join(__dirname, '..', '..');
    const uploadDir = path.join(projectRoot, 'uploads', 'profile-photos');
    
    // Buat folder jika belum ada
    try {
      if (!fs.existsSync(uploadDir)) {
        fs.mkdirSync(uploadDir, { recursive: true });
      }
      cb(null, uploadDir);
    } catch (error) {
      console.error('Error creating upload directory:', error);
      cb(error, null);
    }
  },
  filename: function (req, file, cb) {
    // Generate unique filename
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    const extension = path.extname(file.originalname).toLowerCase();
    cb(null, `profile-${uniqueSuffix}${extension}`);
  }
});

// Filter file - hanya jpg dan png yang diizinkan
const fileFilter = (req, file, cb) => {
  const allowedMimes = ['image/jpeg', 'image/jpg', 'image/png'];
  const allowedExtensions = ['.jpg', '.jpeg', '.png'];
  
  const extension = path.extname(file.originalname).toLowerCase();
  
  if (allowedMimes.includes(file.mimetype) && allowedExtensions.includes(extension)) {
    cb(null, true);
  } else {
    cb(new Error('Hanya file JPG dan PNG yang diizinkan'), false);
  }
};

// Konfigurasi multer
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB max file size
    files: 1 // hanya 1 file
  },
  fileFilter: fileFilter
});

// Middleware untuk single file upload
const uploadSingle = upload.single('foto_profile');

// Enhanced middleware dengan error handling
const uploadProfilePhoto = (req, res, next) => {
  uploadSingle(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      if (err.code === 'LIMIT_FILE_SIZE') {
        return res.status(413).json({
          success: false,
          message: 'File terlalu besar. Maksimal 5MB',
          error_code: 'FILE_TOO_LARGE'
        });
      }
      
      if (err.code === 'LIMIT_UNEXPECTED_FILE') {
        return res.status(400).json({
          success: false,
          message: 'Field file tidak sesuai. Gunakan "foto_profile"',
          error_code: 'INVALID_FIELD_NAME'
        });
      }
      
      return res.status(400).json({
        success: false,
        message: 'Error uploading file',
        error: err.message,
        error_code: 'UPLOAD_ERROR'
      });
    } else if (err) {
      return res.status(400).json({
        success: false,
        message: err.message,
        error_code: 'INVALID_FILE_TYPE'
      });
    }
    
    // Jika ada file yang diupload, tambahkan path ke req.body
    if (req.file) {
      req.body.foto_path = req.file.path;
      req.body.foto_filename = req.file.filename;
      req.body.foto_url = `${req.protocol}://${req.get('host')}/uploads/profile-photos/${req.file.filename}`;
    }
    
    next();
  });
};

// Middleware untuk validasi file (opsional - jika tidak ada file)
const optionalUploadProfilePhoto = (req, res, next) => {
  uploadSingle(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      if (err.code === 'LIMIT_FILE_SIZE') {
        return res.status(413).json({
          success: false,
          message: 'File terlalu besar. Maksimal 5MB',
          error_code: 'FILE_TOO_LARGE'
        });
      }
      
      return res.status(400).json({
        success: false,
        message: 'Error uploading file',
        error: err.message,
        error_code: 'UPLOAD_ERROR'
      });
    } else if (err) {
      // Jika error karena file type, tapi tidak ada file, lewati
      if (!req.file) {
        return next();
      }
      
      return res.status(400).json({
        success: false,
        message: err.message,
        error_code: 'INVALID_FILE_TYPE'
      });
    }
    
    // Jika ada file yang diupload, tambahkan path ke req.body
    if (req.file) {
      req.body.foto_path = req.file.path;
      req.body.foto_filename = req.file.filename;
      req.body.foto_url = `${req.protocol}://${req.get('host')}/uploads/profile-photos/${req.file.filename}`;
    }
    
    next();
  });
};

// Fungsi untuk memastikan direktori upload ada
const ensureUploadDirectoryExists = () => {
  const projectRoot = path.join(__dirname, '..', '..');
  const uploadDir = path.join(projectRoot, 'uploads', 'profile-photos');
  
  try {
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
      console.log('✅ Upload directory created:', uploadDir);
    }
  } catch (error) {
    console.error('❌ Error creating upload directory:', error);
  }
};

// Fungsi untuk menghapus file lama
const deleteOldProfilePhoto = (filename) => {
  if (filename) {
    const projectRoot = path.join(__dirname, '..', '..');
    const filePath = path.join(projectRoot, 'uploads', 'profile-photos', filename);
    try {
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
      }
    } catch (error) {
      console.error('Error deleting old profile photo:', error);
    }
  }
};

// Middleware untuk validate image dimensions (opsional)
const validateImageDimensions = (req, res, next) => {
  if (!req.file) {
    return next();
  }
  
  // Bisa ditambahkan validasi dimensi gambar di sini
  // Untuk sekarang, skip
  next();
};

export {
  uploadProfilePhoto,
  optionalUploadProfilePhoto,
  deleteOldProfilePhoto,
  validateImageDimensions,
  ensureUploadDirectoryExists
};
