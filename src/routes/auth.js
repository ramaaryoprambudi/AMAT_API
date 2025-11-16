import express from 'express';
import AuthController from '../controllers/authController.js';
import { authenticateToken, rateLimiter } from '../middleware/auth.js';
import { authValidation } from '../middleware/validation.js';
import { asyncHandler } from '../middleware/errorHandler.js';
import { uploadProfilePhoto, optionalUploadProfilePhoto } from '../middleware/upload.js';

const router = express.Router();

// Rate limiting for auth endpoints - Relaxed for development/testing
const authRateLimit = rateLimiter(1000, 15 * 60 * 1000); // 1000 requests per 15 minutes

// Public routes (no authentication required)

// POST /api/auth/register - Register new user
router.post('/register',
  // authRateLimit, // Disabled for development testing
  optionalUploadProfilePhoto,
  authValidation.register,
  asyncHandler(AuthController.register)
);

// POST /api/auth/login - Login user
router.post('/login',
  // authRateLimit, // Disabled for development testing
  authValidation.login,
  asyncHandler(AuthController.login)
);

// Protected routes (authentication required)

// GET /api/auth/profile - Get current user profile
router.get('/profile',
  authenticateToken,
  asyncHandler(AuthController.getProfile)
);

// PUT /api/auth/profile - Update user profile
router.put('/profile',
  authenticateToken,
  optionalUploadProfilePhoto,
  authValidation.updateProfile,
  asyncHandler(AuthController.updateProfile)
);

// PUT /api/auth/change-password - Change password
router.put('/change-password',
  authenticateToken,
  authValidation.changePassword,
  asyncHandler(AuthController.changePassword)
);

// POST /api/auth/logout - Logout user
router.post('/logout',
  authenticateToken,
  asyncHandler(AuthController.logout)
);

// DELETE /api/auth/account - Delete user account
router.delete('/account',
  authenticateToken,
  authValidation.deleteAccount,
  asyncHandler(AuthController.deleteAccount)
);

// GET /api/auth/verify - Verify token validity
router.get('/verify',
  authenticateToken,
  asyncHandler(AuthController.verifyToken)
);

// POST /api/auth/refresh - Refresh token
router.post('/refresh',
  authenticateToken,
  asyncHandler(AuthController.refreshToken)
);

export default router;