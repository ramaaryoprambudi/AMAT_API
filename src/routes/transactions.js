import express from 'express';
import TransactionController from '../controllers/transactionController.js';
import { transactionValidation } from '../middleware/validation.js';
import { asyncHandler } from '../middleware/errorHandler.js';
import { authenticateToken, checkResourceOwnership } from '../middleware/auth.js';

const router = express.Router();

// All transaction routes require authentication
router.use(authenticateToken);

// GET /api/transactions/dashboard - Get balance and recent activity
router.get('/dashboard', asyncHandler(TransactionController.getDashboard));

// GET /api/transactions/history - Get transaction history with formatted date/time
router.get('/history', asyncHandler(TransactionController.getTransactionHistory));

// GET /api/transactions - Get all transactions (with filters)
router.get('/', asyncHandler(TransactionController.getAllTransactions));

// GET /api/transactions/search - Search transactions
router.get('/search', asyncHandler(TransactionController.searchTransactions));

// GET /api/transactions/report/monthly - Get monthly report
router.get('/report/monthly', asyncHandler(TransactionController.getMonthlyReport));

// GET /api/transactions/statistics - Get transaction statistics
router.get('/statistics', asyncHandler(TransactionController.getStatistics));

// GET /api/transactions/daily/:date - Get daily transactions
router.get('/daily/:date', asyncHandler(TransactionController.getDailyTransactions));

// GET /api/transactions/:id - Get transaction by ID
router.get('/:id', 
  checkResourceOwnership('transaction'),
  asyncHandler(TransactionController.getTransactionById)
);

// POST /api/transactions - Create new transaction
router.post('/',
  transactionValidation.create,
  asyncHandler(TransactionController.createTransaction)
);

// PUT /api/transactions/:id - Update transaction
router.put('/:id',
  checkResourceOwnership('transaction'),
  transactionValidation.update,
  asyncHandler(TransactionController.updateTransaction)
);

// DELETE /api/transactions/:id - Delete transaction
router.delete('/:id', 
  checkResourceOwnership('transaction'),
  asyncHandler(TransactionController.deleteTransaction)
);

export default router;