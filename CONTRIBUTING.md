# Contributing to ChessClass

Thank you for your interest in contributing to ChessClass! This document provides guidelines and instructions for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/chessclass.git`
3. Create a new branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes
6. Commit your changes: `git commit -m "Add your feature"`
7. Push to your fork: `git push origin feature/your-feature-name`
8. Create a Pull Request

## Development Setup

Follow the instructions in [QUICKSTART.md](QUICKSTART.md) to set up your development environment.

## Code Style Guidelines

### Java/Spring Boot

- Follow standard Java naming conventions
- Use meaningful variable and method names
- Add JavaDoc comments for public methods
- Use Lombok annotations to reduce boilerplate
- Keep methods small and focused
- Write unit tests for new functionality

Example:
```java
@Service
public class ChessLessonService {
    
    /**
     * Retrieves all chess lessons from the database
     * @return List of all chess lessons
     */
    public List<ChessLesson> getAllLessons() {
        return chessLessonRepository.findAll();
    }
}
```

### Angular/TypeScript

- Follow Angular style guide
- Use TypeScript strict mode
- Use meaningful component and service names
- Add type annotations
- Keep components focused on presentation
- Move business logic to services
- Write unit tests for components and services

Example:
```typescript
@Component({
  selector: 'app-lesson-list',
  templateUrl: './lesson-list.component.html',
  styleUrls: ['./lesson-list.component.css']
})
export class LessonListComponent implements OnInit {
  lessons: ChessLesson[] = [];
  
  constructor(private lessonService: ChessLessonService) { }
  
  ngOnInit(): void {
    this.loadLessons();
  }
}
```

### CSS

- Use meaningful class names
- Follow BEM naming convention when appropriate
- Keep styles scoped to components
- Use CSS variables for common values
- Ensure responsive design

## Project Structure

### Backend
```
backend/src/main/java/com/chessclass/app/
├── config/          # Configuration classes
├── controller/      # REST controllers
├── service/         # Business logic
├── repository/      # Data access
└── model/           # Domain entities
```

### Frontend
```
frontend/src/app/
├── components/      # Angular components
├── services/        # Angular services
├── models/          # TypeScript interfaces
└── app.module.ts    # Main module
```

## Adding New Features

### Backend

1. **Add Model**: Create entity in `model/`
2. **Add Repository**: Create repository interface in `repository/`
3. **Add Service**: Create service class in `service/`
4. **Add Controller**: Create REST controller in `controller/`
5. **Add Tests**: Create tests in `src/test/`

### Frontend

1. **Add Model**: Create interface in `models/`
2. **Add Service**: Create service in `services/`
3. **Add Component**: Create component in `components/`
4. **Update Module**: Register component in `app.module.ts`
5. **Add Tests**: Create spec files

## Testing

### Backend Tests

Run all tests:
```bash
cd backend
mvn test
```

Run specific test:
```bash
mvn test -Dtest=ChessClassApplicationTests
```

### Frontend Tests

Run all tests:
```bash
cd frontend
npm test
```

## API Guidelines

### REST Endpoints

- Use proper HTTP methods (GET, POST, PUT, DELETE)
- Use plural nouns for resource names
- Use proper HTTP status codes
- Return consistent JSON responses
- Document new endpoints in README.md

### Example Endpoint

```java
@GetMapping("/api/lessons")
public ResponseEntity<List<ChessLesson>> getAllLessons() {
    return ResponseEntity.ok(chessLessonService.getAllLessons());
}
```

## Database Changes

- Let JPA/Hibernate handle schema updates in development
- For production, create migration scripts
- Document any manual database changes
- Test with fresh database

## Commit Messages

Use clear, descriptive commit messages:

- Start with a verb (Add, Fix, Update, Remove)
- Keep first line under 50 characters
- Add detailed description if needed

Good examples:
```
Add user authentication feature
Fix lesson deletion bug
Update README with new API endpoints
Remove deprecated method
```

## Pull Request Guidelines

1. **Title**: Clear, descriptive title
2. **Description**: Explain what and why
3. **Tests**: Include tests for new features
4. **Documentation**: Update docs if needed
5. **Screenshots**: Add for UI changes
6. **Link Issues**: Reference related issues

## Code Review

All submissions require review. We will:
- Check code quality
- Verify tests pass
- Review documentation
- Test functionality
- Provide constructive feedback

## Areas for Contribution

### Features
- User authentication and authorization
- Chess board visualization
- Interactive chess puzzles
- Progress tracking
- Video lesson support
- Comments and ratings system
- Social features (share, follow)

### Improvements
- Performance optimization
- Better error handling
- Improved UI/UX
- Mobile responsiveness
- Accessibility improvements
- Internationalization

### Documentation
- API documentation
- Code examples
- Tutorial videos
- Troubleshooting guides

### Testing
- Unit tests
- Integration tests
- E2E tests
- Performance tests

## Questions?

- Open an issue for questions
- Check existing issues and PRs
- Read the documentation first

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Thank You!

Your contributions make ChessClass better for everyone!
