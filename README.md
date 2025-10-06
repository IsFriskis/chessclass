# ChessClass

A full-stack chess learning application with Java Spring Boot backend, PostgreSQL database, and Angular frontend.

## Technology Stack

### Backend
- **Java 17**
- **Spring Boot 3.2.1**
- **Spring Data JPA**
- **PostgreSQL 15**
- **Maven**

### Frontend
- **Angular 17**
- **TypeScript**
- **RxJS**
- **HTML/CSS**

### Database
- **PostgreSQL 15** (via Docker)

## Project Structure

```
chessclass/
├── backend/                 # Spring Boot backend
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/chessclass/app/
│   │   │   │       ├── ChessClassApplication.java
│   │   │   │       ├── config/
│   │   │   │       ├── controller/
│   │   │   │       ├── model/
│   │   │   │       ├── repository/
│   │   │   │       └── service/
│   │   │   └── resources/
│   │   │       └── application.properties
│   │   └── test/
│   └── pom.xml
├── frontend/                # Angular frontend
│   ├── src/
│   │   ├── app/
│   │   │   ├── components/
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   ├── app.component.*
│   │   │   └── app.module.ts
│   │   ├── assets/
│   │   ├── environments/
│   │   ├── index.html
│   │   ├── main.ts
│   │   └── styles.css
│   ├── angular.json
│   ├── package.json
│   └── tsconfig.json
└── docker-compose.yml       # PostgreSQL database setup
```

## Prerequisites

- **Java 17** or higher
- **Maven 3.6+**
- **Node.js 18+** and **npm**
- **Docker** and **Docker Compose**
- **Git**

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/IsFriskis/chessclass.git
cd chessclass
```

### 2. Start PostgreSQL Database

Start the PostgreSQL database using Docker Compose:

```bash
docker compose up -d
```

This will start a PostgreSQL container on port 5432 with:
- Database: `chessclass`
- Username: `chessuser`
- Password: `chesspass`

To stop the database:
```bash
docker compose down
```

### 3. Setup and Run Backend

Navigate to the backend directory:

```bash
cd backend
```

Build the project:
```bash
mvn clean install
```

Run the Spring Boot application:
```bash
mvn spring-boot:run
```

The backend will start on `http://localhost:8080`

#### API Endpoints

- `GET /api/lessons` - Get all lessons
- `GET /api/lessons/{id}` - Get lesson by ID
- `GET /api/lessons/level/{level}` - Get lessons by level
- `GET /api/lessons/search?title={title}` - Search lessons by title
- `POST /api/lessons` - Create a new lesson
- `PUT /api/lessons/{id}` - Update a lesson
- `DELETE /api/lessons/{id}` - Delete a lesson

### 4. Setup and Run Frontend

Open a new terminal and navigate to the frontend directory:

```bash
cd frontend
```

Install dependencies:
```bash
npm install
```

Run the Angular development server:
```bash
npm start
```

The frontend will start on `http://localhost:4200`

## Development

### Backend Development

- The backend uses **Spring Boot DevTools** for hot reloading
- Database schema is automatically created/updated based on JPA entities
- CORS is configured to allow requests from `http://localhost:4200`

### Frontend Development

- The Angular development server provides hot reloading
- The frontend communicates with the backend API at `http://localhost:8080/api`
- Components are organized by feature in the `components/` directory

### Database Management

To view the PostgreSQL database:

```bash
docker exec -it chessclass-db psql -U chessuser -d chessclass
```

Useful PostgreSQL commands:
- `\dt` - List all tables
- `\d chess_lessons` - Describe chess_lessons table
- `SELECT * FROM chess_lessons;` - View all lessons
- `\q` - Exit psql

## Testing

### Backend Tests

```bash
cd backend
mvn test
```

### Frontend Tests

```bash
cd frontend
npm test
```

## Building for Production

### Backend

```bash
cd backend
mvn clean package
java -jar target/chessclass-backend-0.0.1-SNAPSHOT.jar
```

### Frontend

```bash
cd frontend
npm run build
```

The production build will be in `frontend/dist/chessclass-frontend/`

## Features

- **CRUD Operations**: Create, Read, Update, and Delete chess lessons
- **Level-based Organization**: Lessons categorized by skill level (Beginner, Intermediate, Advanced)
- **Search Functionality**: Search lessons by title
- **RESTful API**: Clean REST API design
- **Responsive UI**: Modern, responsive user interface
- **Database Persistence**: Data stored in PostgreSQL database

## Future Enhancements

- User authentication and authorization
- Lesson content with chess board integration
- Progress tracking
- Interactive chess puzzles
- Video lessons support
- User comments and ratings

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Marcos Martínez Fernández

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.