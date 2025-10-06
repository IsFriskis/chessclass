-- ============================================
-- Chess Class Application - DDL Script
-- Data Definition Language (Schema Creation)
-- ============================================

-- Drop tables if they exist (for clean slate)
DROP TABLE IF EXISTS game_moves;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS class_enrollments;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS users;

-- ============================================
-- Table: users
-- Purpose: Store user information (students, instructors, admins)
-- ============================================
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK(role IN ('student', 'instructor', 'admin')),
    elo_rating INTEGER DEFAULT 1200,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT 1
);

-- Index on email for faster lookups during login
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- ============================================
-- Table: classes
-- Purpose: Store chess class information
-- ============================================
CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_name VARCHAR(100) NOT NULL,
    description TEXT,
    instructor_id INTEGER NOT NULL,
    skill_level VARCHAR(20) NOT NULL CHECK(skill_level IN ('beginner', 'intermediate', 'advanced', 'expert')),
    max_students INTEGER DEFAULT 20,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    schedule VARCHAR(100),
    is_active BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES users(user_id) ON DELETE RESTRICT
);

-- Index on instructor_id for faster queries
CREATE INDEX idx_classes_instructor ON classes(instructor_id);
CREATE INDEX idx_classes_dates ON classes(start_date, end_date);

-- ============================================
-- Table: class_enrollments
-- Purpose: Track student enrollments in classes
-- ============================================
CREATE TABLE class_enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK(status IN ('active', 'completed', 'dropped', 'pending')),
    progress_percentage INTEGER DEFAULT 0,
    final_grade VARCHAR(2),
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE(class_id, student_id)
);

-- Indexes for enrollment queries
CREATE INDEX idx_enrollments_class ON class_enrollments(class_id);
CREATE INDEX idx_enrollments_student ON class_enrollments(student_id);
CREATE INDEX idx_enrollments_status ON class_enrollments(status);

-- ============================================
-- Table: games
-- Purpose: Store chess games played by users
-- ============================================
CREATE TABLE games (
    game_id INTEGER PRIMARY KEY AUTOINCREMENT,
    white_player_id INTEGER NOT NULL,
    black_player_id INTEGER NOT NULL,
    class_id INTEGER,
    game_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    result VARCHAR(20) CHECK(result IN ('white_win', 'black_win', 'draw', 'in_progress')),
    time_control VARCHAR(50),
    opening_name VARCHAR(100),
    total_moves INTEGER DEFAULT 0,
    pgn_notation TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (white_player_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (black_player_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE SET NULL
);

-- Indexes for game queries
CREATE INDEX idx_games_white_player ON games(white_player_id);
CREATE INDEX idx_games_black_player ON games(black_player_id);
CREATE INDEX idx_games_class ON games(class_id);
CREATE INDEX idx_games_date ON games(game_date);

-- ============================================
-- Table: game_moves
-- Purpose: Store individual moves in a game
-- ============================================
CREATE TABLE game_moves (
    move_id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,
    move_number INTEGER NOT NULL,
    move_notation VARCHAR(10) NOT NULL,
    position_fen TEXT NOT NULL,
    time_taken INTEGER,
    comment TEXT,
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE
);

-- Index for move queries
CREATE INDEX idx_game_moves_game ON game_moves(game_id);
CREATE INDEX idx_game_moves_number ON game_moves(game_id, move_number);

-- ============================================
-- Views for common queries
-- ============================================

-- View: Active classes with instructor information
CREATE VIEW v_active_classes AS
SELECT 
    c.class_id,
    c.class_name,
    c.description,
    c.skill_level,
    c.start_date,
    c.end_date,
    c.max_students,
    u.first_name || ' ' || u.last_name AS instructor_name,
    u.email AS instructor_email,
    COUNT(ce.enrollment_id) AS current_enrollment
FROM classes c
JOIN users u ON c.instructor_id = u.user_id
LEFT JOIN class_enrollments ce ON c.class_id = ce.class_id AND ce.status = 'active'
WHERE c.is_active = 1
GROUP BY c.class_id;

-- View: Student progress summary
CREATE VIEW v_student_progress AS
SELECT 
    u.user_id,
    u.username,
    u.first_name || ' ' || u.last_name AS student_name,
    u.elo_rating,
    COUNT(DISTINCT ce.class_id) AS classes_enrolled,
    COUNT(DISTINCT g.game_id) AS games_played,
    SUM(CASE WHEN g.result = 'white_win' AND g.white_player_id = u.user_id THEN 1
             WHEN g.result = 'black_win' AND g.black_player_id = u.user_id THEN 1
             ELSE 0 END) AS games_won
FROM users u
LEFT JOIN class_enrollments ce ON u.user_id = ce.student_id AND ce.status = 'active'
LEFT JOIN games g ON (u.user_id = g.white_player_id OR u.user_id = g.black_player_id)
WHERE u.role = 'student'
GROUP BY u.user_id;

-- ============================================
-- End of DDL Script
-- ============================================
