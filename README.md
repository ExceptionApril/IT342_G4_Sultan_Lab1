# IT342_G4_Sultan_Lab1

## Project description
Simple authentication demo with a Spring Boot backend and a React (Vite) web client. Users can register, log in, and fetch their profile using JWT-based auth.

## Technologies used
- Java 17 (target upgrade planned to Java 21)
- Spring Boot 3.2.x (Web, Security, Data JPA, Validation)
- MySQL
- JWT (jjwt)
- React 18 + Vite

## Steps to run backend
1. Open [backend/src/main/resources/application.properties](backend/src/main/resources/application.properties) and set MySQL credentials.
2. Create the database `it342` in MySQL.
3. Create the `users` table using [backend/src/main/resources/schema.sql](backend/src/main/resources/schema.sql) (or allow JPA `ddl-auto=update`).
4. From the `backend/` folder, run:
	 ```bash
	 ./mvnw spring-boot:run
	 ```
	 The API runs at `http://localhost:8080`.

## Steps to run web app
1. From the `web/` folder, install dependencies:
	 ```bash
	 npm install
	 ```
2. Start the dev server:
	 ```bash
	 npm run dev
	 ```
	 Vite will print the local URL (usually `http://localhost:5173`).

## Steps to run mobile app
The `mobile/` folder is currently a placeholder. Add your mobile project later, then update these steps.

## List of API endpoints
Base URL: `http://localhost:8080`

- `POST /api/auth/register`
	- Request body: `username`, `email`, `password`
	- Response: JWT token + user info
- `POST /api/auth/login`
	- Request body: `email`, `password`
	- Response: JWT token + user info
- `GET /api/user/me`
	- Requires: `Authorization: Bearer <token>`
	- Response: current user info

## Task Checklist Update
See [TASK_CHECKLIST.md](TASK_CHECKLIST.md) for DONE / IN-PROGRESS / TODO status.

## Repository requirements
- Public repo name: `IT342_G5_<Lastname>_Lab1`
- Required structure:
	- `/web`
	- `/backend`
	- `/mobile` (may be empty for now)
	- `/docs`
	- `README.md`
	- `TASK_CHECKLIST.md`