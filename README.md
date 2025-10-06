# chessclass

A comprehensive chess class management application.

## Features

- User management (students, instructors, admins)
- Class scheduling and enrollment
- Chess game tracking with PGN notation
- ELO rating system
- Progress tracking

## Database

The application includes a complete database schema with DDL and DML scripts.

See [database/README.md](database/README.md) for:
- Database setup instructions
- Schema documentation
- Sample data details
- Usage examples

### Quick Start

```bash
# Create SQLite database
sqlite3 database/chessclass.db < database/ddl.sql
sqlite3 database/chessclass.db < database/dml.sql
```

## License

MIT License - See [LICENSE](LICENSE) file for details