# ChessClass Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         Browser                                  │
│                                                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Angular Frontend (http://localhost:4200)                 │  │
│  │                                                             │  │
│  │  - app.component.ts (Main App)                             │  │
│  │  - lesson-list.component.ts (Lesson List & CRUD)           │  │
│  │  - chess-lesson.service.ts (API Client)                    │  │
│  │  - chess-lesson.model.ts (Data Model)                      │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ HTTP/REST API
                              │ (CORS Enabled)
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  Spring Boot Backend (http://localhost:8080)                    │
│                                                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  REST API Layer                                            │  │
│  │  - ChessLessonController.java                             │  │
│  │    GET    /api/lessons                                     │  │
│  │    GET    /api/lessons/{id}                                │  │
│  │    GET    /api/lessons/level/{level}                       │  │
│  │    GET    /api/lessons/search?title={title}                │  │
│  │    POST   /api/lessons                                     │  │
│  │    PUT    /api/lessons/{id}                                │  │
│  │    DELETE /api/lessons/{id}                                │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Service Layer                                             │  │
│  │  - ChessLessonService.java                                │  │
│  │    (Business Logic)                                        │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Repository Layer                                          │  │
│  │  - ChessLessonRepository.java                             │  │
│  │    (Spring Data JPA)                                       │  │
│  └───────────────────────────────────────────────────────────┘  │
│                              │                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Domain Model                                              │  │
│  │  - ChessLesson.java                                       │  │
│  │    (JPA Entity)                                            │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              │ JDBC
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  PostgreSQL Database (localhost:5432)                           │
│  (Docker Container)                                              │
│                                                                   │
│  Database: chessclass                                            │
│  User: chessuser                                                 │
│                                                                   │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │  Table: chess_lessons                                      │  │
│  │                                                             │  │
│  │  - id (bigint, PK)                                         │  │
│  │  - title (varchar)                                         │  │
│  │  - description (text)                                      │  │
│  │  - level (varchar)                                         │  │
│  │  - created_at (timestamp)                                  │  │
│  │  - updated_at (timestamp)                                  │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

## Technology Stack

### Frontend (Angular 17)
- **Framework**: Angular 17 with TypeScript
- **HTTP Client**: Angular HttpClient
- **Styling**: Custom CSS with gradient design
- **Build Tool**: Angular CLI
- **Development Server**: Webpack Dev Server

### Backend (Spring Boot 3.2.1)
- **Framework**: Spring Boot 3.2.1
- **Language**: Java 17
- **Web**: Spring Web MVC
- **Data Access**: Spring Data JPA
- **Database Driver**: PostgreSQL JDBC Driver
- **Build Tool**: Maven
- **Additional**: Lombok, Spring Boot DevTools

### Database (PostgreSQL 15)
- **Database**: PostgreSQL 15 Alpine
- **Container**: Docker
- **Orchestration**: Docker Compose
- **Data Persistence**: Docker Volume

## Data Flow

### Creating a Lesson

```
User Input (Frontend)
    │
    ├─> lesson-list.component.ts
    │   - User fills form
    │   - Clicks "Save"
    │
    ├─> chess-lesson.service.ts
    │   - Calls createLesson(lesson)
    │   - HTTP POST to /api/lessons
    │
    ├─> ChessLessonController.java
    │   - @PostMapping("/api/lessons")
    │   - Validates request
    │
    ├─> ChessLessonService.java
    │   - createLesson(lesson)
    │   - Business logic
    │
    ├─> ChessLessonRepository.java
    │   - save(lesson)
    │   - JPA operation
    │
    ├─> Hibernate/JPA
    │   - Generates SQL INSERT
    │
    └─> PostgreSQL Database
        - Stores the lesson
        - Returns generated ID
```

### Retrieving Lessons

```
Frontend Request
    │
    ├─> chess-lesson.service.ts
    │   - Calls getAllLessons()
    │   - HTTP GET to /api/lessons
    │
    ├─> ChessLessonController.java
    │   - @GetMapping("/api/lessons")
    │
    ├─> ChessLessonService.java
    │   - getAllLessons()
    │
    ├─> ChessLessonRepository.java
    │   - findAll()
    │   - JPA operation
    │
    ├─> Hibernate/JPA
    │   - Generates SQL SELECT
    │
    ├─> PostgreSQL Database
    │   - Returns lesson records
    │
    └─> JSON Response
        - Serialized to frontend
        - Displayed as cards
```

## Component Details

### Frontend Components

#### app.component
- Root component
- Displays header with title
- Contains lesson-list component

#### lesson-list.component
- Main feature component
- Displays all lessons as cards
- Provides form for adding new lessons
- Handles CRUD operations
- Communicates with backend via service

#### chess-lesson.service
- Injectable service
- HTTP client wrapper
- API endpoints:
  - getAllLessons()
  - getLessonById(id)
  - getLessonsByLevel(level)
  - searchLessonsByTitle(title)
  - createLesson(lesson)
  - updateLesson(id, lesson)
  - deleteLesson(id)

### Backend Components

#### ChessLessonController
- REST API endpoints
- Request validation
- Response formatting
- CORS configuration

#### ChessLessonService
- Business logic layer
- Transaction management
- Error handling

#### ChessLessonRepository
- Data access layer
- Extends JpaRepository
- Custom query methods:
  - findByLevel(level)
  - findByTitleContainingIgnoreCase(title)

#### ChessLesson Entity
- JPA Entity
- Maps to chess_lessons table
- Automatic timestamp management
- Lombok annotations for boilerplate reduction

### Configuration

#### Backend Configuration (application.properties)
- Server port: 8080
- Database connection
- JPA/Hibernate settings
- SQL logging enabled
- CORS allowed origins

#### Frontend Configuration (environment.ts)
- API URL: http://localhost:8080/api
- Production flag

#### Database Configuration (docker-compose.yml)
- PostgreSQL image: postgres:15-alpine
- Port mapping: 5432:5432
- Environment variables
- Volume for data persistence
- Network configuration

## Security Considerations

### Current Implementation
- CORS enabled for localhost:4200
- No authentication/authorization
- Direct database access via JPA

### Future Enhancements
- Add Spring Security
- Implement JWT authentication
- Add user roles and permissions
- Input validation and sanitization
- Rate limiting
- HTTPS in production

## Deployment Considerations

### Current Setup (Development)
- Backend: mvn spring-boot:run
- Frontend: npm start
- Database: Docker container

### Production Recommendations
- Backend: Build JAR and deploy to server/cloud
- Frontend: Build production bundle and serve via Nginx
- Database: Managed PostgreSQL service
- Add reverse proxy (Nginx)
- Add SSL/TLS certificates
- Environment-specific configurations
- Logging and monitoring
- Backup strategy

## Scalability

### Current Limitations
- Single instance backend
- No caching
- No load balancing

### Future Improvements
- Horizontal scaling with load balancer
- Redis cache for frequent queries
- Database connection pooling optimization
- CDN for frontend assets
- Microservices architecture if needed

## Monitoring and Logging

### Backend
- Spring Boot Actuator (can be added)
- SQL query logging (enabled)
- Application logs

### Frontend
- Browser console logs
- Error tracking (can add Sentry)

### Database
- PostgreSQL logs via Docker logs
- Query performance monitoring
