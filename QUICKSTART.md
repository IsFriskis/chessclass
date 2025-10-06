# ChessClass Quick Start Guide

This guide will help you get the ChessClass application up and running quickly.

## Prerequisites Check

Before you start, make sure you have the following installed:

```bash
# Check Java version (should be 17+)
java -version

# Check Maven version (should be 3.6+)
mvn -version

# Check Node.js version (should be 18+)
node --version

# Check npm version
npm --version

# Check Docker version
docker --version

# Check Docker Compose version
docker compose version
```

## Quick Start (3 Steps)

### Step 1: Start the Database

From the project root directory:

```bash
docker compose up -d
```

Wait a few seconds for PostgreSQL to initialize.

### Step 2: Start the Backend

Open a terminal and run:

```bash
cd backend
mvn spring-boot:run
```

The backend will be available at `http://localhost:8080`

### Step 3: Start the Frontend

Open a new terminal and run:

```bash
cd frontend
npm install
npm start
```

The frontend will be available at `http://localhost:4200`

## Verify Everything is Working

### Test the Backend API

```bash
# Get all lessons (should return empty array initially)
curl http://localhost:8080/api/lessons

# Create a new lesson
curl -X POST http://localhost:8080/api/lessons \
  -H "Content-Type: application/json" \
  -d '{"title":"My First Lesson","description":"Learning chess basics","level":"beginner"}'

# Get all lessons again (should show the lesson you just created)
curl http://localhost:8080/api/lessons
```

### Test the Frontend

Open your browser and go to `http://localhost:4200`. You should see:
- A purple gradient header with "ChessClass" title
- An "Add New Lesson" button
- Any lessons you've created displayed as cards

## API Endpoints Reference

### Lessons API

- **GET** `/api/lessons` - Get all lessons
- **GET** `/api/lessons/{id}` - Get lesson by ID
- **GET** `/api/lessons/level/{level}` - Get lessons by level (beginner, intermediate, advanced)
- **GET** `/api/lessons/search?title={title}` - Search lessons by title
- **POST** `/api/lessons` - Create a new lesson
- **PUT** `/api/lessons/{id}` - Update a lesson
- **DELETE** `/api/lessons/{id}` - Delete a lesson

### Example API Calls

#### Create a Lesson

```bash
curl -X POST http://localhost:8080/api/lessons \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Chess Openings",
    "description": "Learn popular chess openings",
    "level": "intermediate"
  }'
```

#### Get Lessons by Level

```bash
curl http://localhost:8080/api/lessons/level/beginner
```

#### Search Lessons by Title

```bash
curl http://localhost:8080/api/lessons/search?title=Chess
```

#### Update a Lesson

```bash
curl -X PUT http://localhost:8080/api/lessons/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Updated Title",
    "description": "Updated description",
    "level": "advanced"
  }'
```

#### Delete a Lesson

```bash
curl -X DELETE http://localhost:8080/api/lessons/1
```

## Database Management

### Connect to PostgreSQL

```bash
docker exec -it chessclass-db psql -U chessuser -d chessclass
```

### Useful PostgreSQL Commands

```sql
-- List all tables
\dt

-- View table structure
\d chess_lessons

-- View all lessons
SELECT * FROM chess_lessons;

-- Count lessons by level
SELECT level, COUNT(*) FROM chess_lessons GROUP BY level;

-- Exit psql
\q
```

## Troubleshooting

### Backend won't start

1. Make sure PostgreSQL is running:
   ```bash
   docker ps | grep chessclass-db
   ```

2. Check if port 8080 is already in use:
   ```bash
   lsof -i :8080
   ```

3. Check backend logs for errors

### Frontend won't start

1. Make sure Node modules are installed:
   ```bash
   cd frontend
   npm install
   ```

2. Check if port 4200 is already in use:
   ```bash
   lsof -i :4200
   ```

3. Clear npm cache if needed:
   ```bash
   npm cache clean --force
   ```

### Database connection issues

1. Verify PostgreSQL is running:
   ```bash
   docker compose ps
   ```

2. Restart the database:
   ```bash
   docker compose restart
   ```

3. Check database logs:
   ```bash
   docker logs chessclass-db
   ```

## Stopping the Application

### Stop the Frontend
Press `Ctrl+C` in the terminal where `npm start` is running

### Stop the Backend
Press `Ctrl+C` in the terminal where `mvn spring-boot:run` is running

### Stop the Database
```bash
docker compose down
```

To also remove the database data:
```bash
docker compose down -v
```

## Development Tips

### Backend Hot Reload

The backend uses Spring Boot DevTools, which provides automatic restart when you make code changes. Just edit your Java files and save - the application will restart automatically.

### Frontend Hot Reload

The Angular development server (`ng serve` / `npm start`) automatically reloads when you make changes to your TypeScript, HTML, or CSS files.

### Database Persistence

Your lessons are stored in PostgreSQL and will persist even if you restart the database (unless you use `docker compose down -v`).

## Next Steps

- Explore the backend code in `backend/src/main/java/com/chessclass/app/`
- Explore the frontend code in `frontend/src/app/`
- Add more features like user authentication, comments, ratings, etc.
- Customize the UI styling in the component CSS files
- Add more complex chess features like board visualization

## Need Help?

- Check the main [README.md](README.md) for detailed documentation
- Review the API endpoints and test them with curl
- Check the browser console for frontend errors
- Check the terminal output for backend errors
