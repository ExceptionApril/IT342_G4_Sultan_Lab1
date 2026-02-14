-- IT342 Lab1 Database Setup Script
-- Run this script to set up the database manually if needed

-- Step 1: Create Database (if not exists)
CREATE DATABASE IF NOT EXISTS it342 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

-- Step 2: Use the database
USE it342;

-- Step 3: Create Users Table
CREATE TABLE IF NOT EXISTS users (
  id BIGINT NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_users_email (email),
  UNIQUE KEY uk_users_username (username),
  INDEX idx_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Step 4: Verify table creation
SHOW TABLES;
DESCRIBE users;

-- Optional: Create a test user (for development only)
-- Password is BCrypt hash of 'password123'
-- INSERT INTO users (username, email, password) 
-- VALUES ('testuser', 'test@example.com', '$2a$10$XYZ...');
