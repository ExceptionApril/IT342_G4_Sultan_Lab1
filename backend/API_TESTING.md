# API Testing Guide

Quick reference for testing the IT342 Lab1 Backend API endpoints.

## Base URL
```
http://localhost:8080
```

## Endpoints

### 1. Register a New User
**POST** `/api/auth/register`

**Request Body:**
```json
{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Success Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com"
  }
}
```

**cURL Example:**
```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"johndoe\",\"email\":\"john@example.com\",\"password\":\"password123\"}"
```

---

### 2. Login (Authenticate)
**POST** `/api/auth/login`

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**Success Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com"
  }
}
```

**cURL Example:**
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"john@example.com\",\"password\":\"password123\"}"
```

---

### 3. Get Current User Profile
**GET** `/api/user/me`

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**Success Response (200 OK):**
```json
{
  "id": 1,
  "username": "johndoe",
  "email": "john@example.com"
}
```

**cURL Example:**
```bash
curl -X GET http://localhost:8080/api/user/me \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

---

## Testing with Postman

### Step 1: Register a User
1. Create a new POST request to `http://localhost:8080/api/auth/register`
2. Set header: `Content-Type: application/json`
3. Set body (raw JSON):
   ```json
   {
     "username": "testuser",
     "email": "test@example.com",
     "password": "test123"
   }
   ```
4. Send request
5. **Save the JWT token** from the response

### Step 2: Login
1. Create a new POST request to `http://localhost:8080/api/auth/login`
2. Set header: `Content-Type: application/json`
3. Set body (raw JSON):
   ```json
   {
     "email": "test@example.com",
     "password": "test123"
   }
   ```
4. Send request
5. **Copy the JWT token** from the response

### Step 3: Get User Profile
1. Create a new GET request to `http://localhost:8080/api/user/me`
2. Set header: `Authorization: Bearer <paste_your_token_here>`
3. Send request
4. You should see your user profile information

---

## Common Error Responses

### 400 Bad Request
```json
{
  "message": "Validation error",
  "errors": ["Email is required", "Password must be at least 6 characters"]
}
```

### 401 Unauthorized
```json
{
  "message": "Invalid credentials"
}
```

### 403 Forbidden
```json
{
  "message": "Access denied"
}
```

### 409 Conflict
```json
{
  "message": "Email already exists"
}
```

---

## Testing Workflow

1. **Start the backend:**
   ```bash
   cd backend
   mvn spring-boot:run
   ```

2. **Verify server is running:**
   - Check console for: `Started Lab1Application`
   - Default port: `8080`

3. **Test registration:**
   - Register a new user
   - Verify you receive a JWT token

4. **Test login:**
   - Login with the same credentials
   - Verify you receive a JWT token

5. **Test protected endpoint:**
   - Use the JWT token to access `/api/user/me`
   - Verify you receive user profile data

6. **Test without token:**
   - Try accessing `/api/user/me` without Authorization header
   - Verify you get 401 Unauthorized

---

## Troubleshooting

### Issue: Connection refused
- Verify backend is running on port 8080
- Check for port conflicts: `netstat -ano | findstr :8080`

### Issue: 500 Internal Server Error
- Check backend logs for stack trace
- Verify database connection is working
- Check MySQL is running

### Issue: 401 Unauthorized on protected endpoints
- Verify token is included in Authorization header
- Check token format: `Bearer <token>` (space after Bearer)
- Verify token hasn't expired (24 hours by default)

### Issue: Database connection error
- Verify MySQL is running
- Check credentials in `application.properties`
- Verify database `it342` exists
- See [DATABASE_SETUP.md](DATABASE_SETUP.md) for help

---

## Next Steps for Lab 3

After verifying the backend works:
1. Test with the web application (React/Vite)
2. Implement mobile application (Android Kotlin)
3. Both clients should use the same backend
4. Implement logout functionality
5. Add proper error handling in clients
6. Update documentation with screenshots
