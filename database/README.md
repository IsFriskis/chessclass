# Chess Class Database

This directory contains the database schema and sample data for the Chess Class application.

## Files

- **ddl.sql**: Data Definition Language - Database schema (tables, indexes, views)
- **dml.sql**: Data Manipulation Language - Sample data for testing and development

## Database Schema

### Tables

1. **users**: Stores user accounts (students, instructors, admins)
   - Includes authentication info, personal details, and ELO ratings
   
2. **classes**: Chess class definitions
   - Contains class details, skill levels, schedules, and instructor assignments
   
3. **class_enrollments**: Student enrollment records
   - Tracks which students are enrolled in which classes
   - Includes progress tracking and status
   
4. **games**: Chess games played by users
   - Records game outcomes, players, and PGN notation
   - Can be linked to specific classes
   
5. **game_moves**: Individual moves within games
   - Stores move-by-move data including FEN positions
   - Useful for game analysis and replay

### Views

- **v_active_classes**: Lists active classes with enrollment counts
- **v_student_progress**: Summarizes student statistics and performance

## Setup Instructions

### SQLite (Recommended for development)

```bash
# Create the database and schema
sqlite3 chessclass.db < ddl.sql

# Load sample data
sqlite3 chessclass.db < dml.sql
```

### PostgreSQL

```bash
# Create database
createdb chessclass

# Run DDL
psql -d chessclass -f ddl.sql

# Run DML
psql -d chessclass -f dml.sql
```

### MySQL/MariaDB

```bash
# Create database
mysql -e "CREATE DATABASE chessclass;"

# Run DDL (may need minor syntax adjustments)
mysql chessclass < ddl.sql

# Run DML
mysql chessclass < dml.sql
```

## Sample Data

The DML script includes:
- 1 admin user
- 3 instructor users
- 8 student users
- 5 chess classes across different skill levels
- Multiple class enrollments
- 4 sample games with varying outcomes
- Sample game moves for detailed analysis

### Test Credentials

All test users have dummy password hashes. For actual implementation, use proper bcrypt hashing.

Example users:
- **Admin**: admin@chessclass.com
- **Instructors**: fischer@chessclass.com, kasparov@chessclass.com, nakamura@chessclass.com
- **Students**: alice@student.com, bob@student.com, etc.

## Usage Examples

### Query active classes
```sql
SELECT * FROM v_active_classes;
```

### Get student progress
```sql
SELECT * FROM v_student_progress
WHERE games_played > 0
ORDER BY elo_rating DESC;
```

### Find games for a specific student
```sql
SELECT g.*, 
       u1.username as white_player,
       u2.username as black_player
FROM games g
JOIN users u1 ON g.white_player_id = u1.user_id
JOIN users u2 ON g.black_player_id = u2.user_id
WHERE g.white_player_id = 5 OR g.black_player_id = 5;
```

### Check class enrollment status
```sql
SELECT c.class_name, 
       u.first_name || ' ' || u.last_name as student_name,
       ce.status,
       ce.progress_percentage
FROM class_enrollments ce
JOIN classes c ON ce.class_id = c.class_id
JOIN users u ON ce.student_id = u.user_id
WHERE ce.status = 'active';
```

## Database Considerations

### Indexes
The schema includes indexes on frequently queried columns for optimal performance:
- User email and role lookups
- Class and enrollment queries
- Game player searches

### Constraints
- Foreign key constraints ensure referential integrity
- Check constraints validate enum-like fields
- Unique constraints prevent duplicate enrollments

### Timestamps
All major tables include `created_at` and `updated_at` timestamps for audit trails.

## Extending the Schema

To add new features, consider:
- **Lessons table**: Track individual lesson content within classes
- **Assignments table**: Store homework and practice problems
- **Forums table**: Enable class discussions
- **Ratings/Reviews table**: Allow students to rate classes
- **Tournaments table**: Organize competitive events

## Migration Strategy

For production use:
1. Use a migration tool (e.g., Flyway, Liquibase, or Alembic)
2. Version control all schema changes
3. Test migrations on staging before production
4. Maintain rollback scripts for each migration

## License

MIT License - See LICENSE file in the root directory
