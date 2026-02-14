# Database Setup Guide

This guide will help you set up MySQL database for the IT342 Lab1 Backend.

## Prerequisites

- MySQL Server 8.0+ installed and running
- MySQL command-line client or MySQL Workbench

## Option 1: Automatic Setup (Recommended)

The application is configured to automatically:
- Create the database if it doesn't exist
- Initialize the schema on startup

### Steps:

1. **Start MySQL Server**
   ```bash
   # Windows - Start MySQL service
   net start MySQL80
   
   # Or check if it's running
   sc query MySQL80
   ```

2. **Configure Database Credentials**
   
   Edit `backend/src/main/resources/application.properties` or set environment variables:
   
   ```properties
   # Using application.properties (Development)
   spring.datasource.username=root
   spring.datasource.password=your_password
   
   # OR using Environment Variables (Production - Recommended)
   DB_USERNAME=root
   DB_PASSWORD=your_password
   JWT_SECRET=your_secure_jwt_secret_at_least_32_characters
   ```

3. **Run the Application**
   ```bash
   cd backend
   mvn spring-boot:run
   ```
   
   The database and tables will be created automatically.

## Option 2: Manual Setup

If you prefer to set up the database manually:

### Step 1: Access MySQL

```bash
mysql -u root -p
```

### Step 2: Run the Setup Script

```bash
mysql -u root -p < backend/database-setup.sql
```

Or manually execute:

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS it342 
  CHARACTER SET utf8mb4 
  COLLATE utf8mb4_unicode_ci;

-- Use database
USE it342;

-- Run schema from schema.sql file
SOURCE backend/src/main/resources/schema.sql;
```

### Step 3: Verify Setup

```sql
USE it342;
SHOW TABLES;
DESCRIBE users;
```

Expected output:
```
+--------+
| Tables |
+--------+
| users  |
+--------+

+------------+--------------+------+-----+-------------------+-------------------+
| Field      | Type         | Null | Key | Default           | Extra             |
+------------+--------------+------+-----+-------------------+-------------------+
| id         | bigint       | NO   | PRI | NULL              | auto_increment    |
| username   | varchar(50)  | NO   | UNI | NULL              |                   |
| email      | varchar(255) | NO   | UNI | NULL              |                   |
| password   | varchar(255) | NO   |     | NULL              |                   |
| created_at | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| updated_at | timestamp    | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+------------+--------------+------+-----+-------------------+-------------------+
```

## Database Configuration Details

### Connection URL
```
jdbc:mysql://localhost:3306/it342?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true
```

**Parameters:**
- `createDatabaseIfNotExist=true` - Automatically creates the database
- `useSSL=false` - Disables SSL for local development
- `allowPublicKeyRetrieval=true` - Allows retrieving public key from server

### Default Credentials
- **Username:** `root` (configurable via `DB_USERNAME` env variable)
- **Password:** (empty by default, set via `DB_PASSWORD` env variable)
- **Database:** `it342`

## Security Best Practices

### For Development:
1. Use default credentials in `application.properties`
2. Never commit passwords to Git (add `.env` files to `.gitignore`)

### For Production:
1. Use environment variables:
   ```bash
   export DB_USERNAME=your_username
   export DB_PASSWORD=your_secure_password
   export JWT_SECRET=your_very_long_secure_jwt_secret_key
   ```

2. Or use application configuration:
   ```bash
   java -jar app.jar --spring.datasource.username=user --spring.datasource.password=pass
   ```

## Troubleshooting

### Issue: "Access denied for user 'root'@'localhost'"
**Solution:** Verify your MySQL root password or create a new user:

```sql
CREATE USER 'it342user'@'localhost' IDENTIFIED BY 'it342pass';
GRANT ALL PRIVILEGES ON it342.* TO 'it342user'@'localhost';
FLUSH PRIVILEGES;
```

Then update `application.properties`:
```properties
spring.datasource.username=it342user
spring.datasource.password=it342pass
```

### Issue: "Unknown database 'it342'"
**Solution:** The database should be created automatically. If not:

```sql
CREATE DATABASE it342;
```

### Issue: "Table 'users' doesn't exist"
**Solution:** 
1. Check `spring.sql.init.mode=always` in `application.properties`
2. Or manually run `database-setup.sql`

### Issue: Connection timeout or can't connect
**Solution:**
1. Verify MySQL is running: `sc query MySQL80` (Windows)
2. Check MySQL is listening on port 3306: `netstat -an | find "3306"`
3. Verify MySQL server status: `mysql -u root -p -e "STATUS;"`

## Database Schema

### Users Table
Stores user authentication information.

| Column     | Type         | Description                          |
|------------|--------------|--------------------------------------|
| id         | BIGINT       | Primary key, auto-increment          |
| username   | VARCHAR(50)  | Unique username (not null)           |
| email      | VARCHAR(255) | Unique email address (not null)      |
| password   | VARCHAR(255) | BCrypt hashed password (not null)    |
| created_at | TIMESTAMP    | Account creation timestamp           |
| updated_at | TIMESTAMP    | Last update timestamp (auto-updated) |

**Constraints:**
- Primary Key: `id`
- Unique: `email`, `username`
- Index: `email` (for faster lookups)

**Notes:**
- Passwords are encrypted using BCrypt (handled by Spring Security)
- Charset: `utf8mb4` with `utf8mb4_unicode_ci` collation (supports emojis and international characters)
- Engine: InnoDB (supports transactions)

## Next Steps

After database setup:
1. Test the backend: `cd backend && mvn spring-boot:run`
2. Check logs for successful database connection
3. Test API endpoints:
   - POST `/api/auth/register` - Create new user
   - POST `/api/auth/login` - Login user
   - GET `/api/user/me` - Get user profile (requires JWT token)

## References

- Spring Boot Data JPA: https://spring.io/projects/spring-boot
- MySQL Documentation: https://dev.mysql.com/doc/
- JWT: https://jwt.io/
