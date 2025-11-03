#!/usr/bin/env node
import { config } from "dotenv";
config();

import jwt from 'jsonwebtoken';

console.log('🔍 JWT Debug Tool');
console.log('================');

// Check environment variables
console.log('Environment:');
console.log('NODE_ENV:', process.env.NODE_ENV);
console.log('JWT_SECRET:', process.env.JWT_SECRET ? '***set***' : 'NOT SET');
console.log('JWT_EXPIRES_IN:', process.env.JWT_EXPIRES_IN || '7d (default)');

// Current server time
console.log('\nServer Time Info:');
const now = new Date();
console.log('Current server time:', now.toISOString());
console.log('Server timezone:', Intl.DateTimeFormat().resolvedOptions().timeZone);
console.log('Server UTC offset:', now.getTimezoneOffset(), 'minutes');

// Test token creation
console.log('\n🧪 Creating test token...');
const testPayload = {
  user: {
    id: 1,
    uid: 'test-uid',
    email: 'test@example.com'
  }
};

const secret = process.env.JWT_SECRET || 'fallback_secret_key_change_in_production';
const expiresIn = process.env.JWT_EXPIRES_IN || '7d';

try {
  const testToken = jwt.sign(testPayload, secret, { expiresIn });
  console.log('✅ Token created successfully');
  
  // Decode token to see content
  const decoded = jwt.decode(testToken, { complete: true });
  console.log('\nToken details:');
  console.log('Header:', JSON.stringify(decoded.header, null, 2));
  console.log('Payload:', JSON.stringify(decoded.payload, null, 2));
  console.log('Issued at:', new Date(decoded.payload.iat * 1000).toISOString());
  console.log('Expires at:', new Date(decoded.payload.exp * 1000).toISOString());
  
  const timeLeft = Math.floor((decoded.payload.exp * 1000 - Date.now()) / 1000 / 60);
  console.log('Time left:', timeLeft, 'minutes');
  
  // Test verification
  console.log('\n🔐 Testing token verification...');
  const verified = jwt.verify(testToken, secret);
  console.log('✅ Token verification successful');
  console.log('Verified payload:', JSON.stringify(verified, null, 2));
  
} catch (error) {
  console.error('❌ JWT Error:', error.message);
  if (error.name === 'TokenExpiredError') {
    console.log('Token expired at:', error.expiredAt);
  }
}

// If there's a test token provided as argument
if (process.argv[2]) {
  console.log('\n🔍 Checking provided token...');
  const providedToken = process.argv[2];
  
  try {
    const decoded = jwt.decode(providedToken, { complete: true });
    if (!decoded) {
      console.log('❌ Invalid token format');
    } else {
      console.log('Token header:', JSON.stringify(decoded.header, null, 2));
      console.log('Token payload:', JSON.stringify(decoded.payload, null, 2));
      console.log('Issued at:', new Date(decoded.payload.iat * 1000).toISOString());
      console.log('Expires at:', new Date(decoded.payload.exp * 1000).toISOString());
      
      const isExpired = Date.now() > decoded.payload.exp * 1000;
      console.log('Is expired:', isExpired);
      
      if (isExpired) {
        const expiredSince = Math.floor((Date.now() - decoded.payload.exp * 1000) / 1000 / 60);
        console.log('Expired since:', expiredSince, 'minutes ago');
      } else {
        const timeLeft = Math.floor((decoded.payload.exp * 1000 - Date.now()) / 1000 / 60);
        console.log('Time left:', timeLeft, 'minutes');
      }
      
      // Try to verify
      try {
        const verified = jwt.verify(providedToken, secret);
        console.log('✅ Token is valid');
      } catch (verifyError) {
        console.log('❌ Token verification failed:', verifyError.message);
      }
    }
  } catch (error) {
    console.error('❌ Error analyzing token:', error.message);
  }
}

console.log('\nUsage: node jwt-debug.js [token_to_check]');