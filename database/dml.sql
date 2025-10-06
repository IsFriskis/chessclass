-- ============================================
-- Chess Class Application - DML Script
-- Data Manipulation Language (Sample Data)
-- ============================================

-- ============================================
-- Insert Users (Instructors, Students, Admin)
-- ============================================

-- Admin user
INSERT INTO users (username, email, password_hash, first_name, last_name, role, elo_rating)
VALUES 
('admin', 'admin@chessclass.com', '$2a$10$dummyhashforadmin', 'System', 'Administrator', 'admin', 1500);

-- Instructors
INSERT INTO users (username, email, password_hash, first_name, last_name, role, elo_rating)
VALUES 
('gm_fischer', 'fischer@chessclass.com', '$2a$10$dummyhashforuser1', 'Bobby', 'Fischer', 'instructor', 2800),
('gm_kasparov', 'kasparov@chessclass.com', '$2a$10$dummyhashforuser2', 'Garry', 'Kasparov', 'instructor', 2850),
('im_nakamura', 'nakamura@chessclass.com', '$2a$10$dummyhashforuser3', 'Hikaru', 'Nakamura', 'instructor', 2750);

-- Students
INSERT INTO users (username, email, password_hash, first_name, last_name, role, elo_rating)
VALUES 
('alice_chess', 'alice@student.com', '$2a$10$dummyhashforalice', 'Alice', 'Johnson', 'student', 1200),
('bob_player', 'bob@student.com', '$2a$10$dummyhashforbob', 'Bob', 'Smith', 'student', 1400),
('charlie_pawn', 'charlie@student.com', '$2a$10$dummyhashforcharlie', 'Charlie', 'Brown', 'student', 1100),
('diana_rook', 'diana@student.com', '$2a$10$dummyhashfordiana', 'Diana', 'Williams', 'student', 1600),
('evan_knight', 'evan@student.com', '$2a$10$dummyhashforevan', 'Evan', 'Martinez', 'student', 1350),
('fiona_bishop', 'fiona@student.com', '$2a$10$dummyhashforfiona', 'Fiona', 'Davis', 'student', 1500),
('george_king', 'george@student.com', '$2a$10$dummyhashforgeorge', 'George', 'Anderson', 'student', 1450),
('hannah_queen', 'hannah@student.com', '$2a$10$dummyhashforhannah', 'Hannah', 'Taylor', 'student', 1550);

-- ============================================
-- Insert Classes
-- ============================================

INSERT INTO classes (class_name, description, instructor_id, skill_level, max_students, start_date, end_date, schedule)
VALUES 
('Chess Fundamentals', 'Learn the basic rules, piece movement, and simple tactics for beginners.', 2, 'beginner', 20, '2025-02-01', '2025-04-01', 'Monday & Wednesday 6:00 PM'),
('Opening Strategies', 'Master popular chess openings including Italian Game, Spanish Opening, and Queen''s Gambit.', 3, 'intermediate', 15, '2025-02-05', '2025-04-05', 'Tuesday & Thursday 7:00 PM'),
('Advanced Tactics', 'Deep dive into tactical combinations, sacrifices, and positional play.', 2, 'advanced', 12, '2025-02-10', '2025-04-10', 'Friday 6:00 PM'),
('Endgame Mastery', 'Study essential endgame positions and techniques to convert advantages.', 4, 'intermediate', 15, '2025-02-15', '2025-04-15', 'Wednesday 7:30 PM'),
('Tournament Preparation', 'Prepare for competitive play with time management and psychological training.', 3, 'advanced', 10, '2025-03-01', '2025-05-01', 'Saturday 10:00 AM');

-- ============================================
-- Insert Class Enrollments
-- ============================================

-- Chess Fundamentals (Class 1) - Beginners
INSERT INTO class_enrollments (class_id, student_id, status, progress_percentage)
VALUES 
(1, 5, 'active', 25),   -- Alice
(1, 7, 'active', 30),   -- Charlie
(1, 9, 'active', 20);   -- Evan

-- Opening Strategies (Class 2) - Intermediate
INSERT INTO class_enrollments (class_id, student_id, status, progress_percentage)
VALUES 
(2, 6, 'active', 40),   -- Bob
(2, 8, 'active', 35),   -- Diana
(2, 10, 'active', 45);  -- Fiona

-- Advanced Tactics (Class 3) - Advanced
INSERT INTO class_enrollments (class_id, student_id, status, progress_percentage)
VALUES 
(3, 8, 'active', 50),   -- Diana
(3, 10, 'active', 55),  -- Fiona
(3, 12, 'active', 60);  -- Hannah

-- Endgame Mastery (Class 4) - Intermediate
INSERT INTO class_enrollments (class_id, student_id, status, progress_percentage)
VALUES 
(4, 6, 'active', 15),   -- Bob
(4, 11, 'active', 20);  -- George

-- Tournament Preparation (Class 5) - Advanced
INSERT INTO class_enrollments (class_id, student_id, status, progress_percentage)
VALUES 
(5, 10, 'active', 10),  -- Fiona
(5, 12, 'active', 15);  -- Hannah

-- ============================================
-- Insert Sample Games
-- ============================================

-- Game 1: Alice vs Bob
INSERT INTO games (white_player_id, black_player_id, class_id, result, time_control, opening_name, total_moves, pgn_notation)
VALUES 
(5, 6, 1, 'black_win', '10+0', 'Italian Game', 25, 
'1. e4 e5 2. Nf3 Nc6 3. Bc4 Bc5 4. c3 Nf6 5. d4 exd4 6. cxd4 Bb4+ 7. Bd2 Bxd2+ 8. Nbxd2 d5 9. exd5 Nxd5 10. Qb3 Na5 11. Qa4+ Nc6 12. Bb5 Nce7 13. O-O O-O 14. Rfe1 c6 15. Bd3 Bd7 16. Qc2 Ng6 17. Nc4 Qc7 18. Rad1 Rfe8 19. Ne3 Nxe3 20. Rxe3 Rxe3 21. fxe3 Re8 22. Qf2 Qe7 23. Nd2 Qxe3 24. Qxe3 Rxe3 25. Nf1 Re1');

-- Game 2: Diana vs Charlie
INSERT INTO games (white_player_id, black_player_id, class_id, result, time_control, opening_name, total_moves, pgn_notation)
VALUES 
(8, 7, 2, 'white_win', '15+10', 'Sicilian Defense', 30, 
'1. e4 c5 2. Nf3 d6 3. d4 cxd4 4. Nxd4 Nf6 5. Nc3 a6 6. Be3 e5 7. Nb3 Be6 8. f3 Be7 9. Qd2 O-O 10. O-O-O Nbd7 11. g4 b5 12. g5 b4 13. Ne2 Ne8 14. f4 a5 15. f5 Bc4 16. Nbd4 exd4 17. Nxd4 Nc5 18. Kb1 Qd7 19. Rg1 Rc8 20. Bh3 Qc7 21. Bf4 Qa7 22. Bxd6 Bxd6 23. Qxd6 Qxd4 24. Rxd4 Nxe4 25. Qd1 Nc3+ 26. bxc3 Rxc3 27. Qd4 Rc7 28. Rg4 f6 29. Rh4 Bf7 30. Qxb4');

-- Game 3: Fiona vs George
INSERT INTO games (white_player_id, black_player_id, class_id, result, time_control, opening_name, total_moves, pgn_notation)
VALUES 
(10, 11, 3, 'draw', '5+0', 'Queen''s Gambit Declined', 40, 
'1. d4 d5 2. c4 e6 3. Nc3 Nf6 4. Bg5 Be7 5. e3 O-O 6. Nf3 Nbd7 7. Rc1 c6 8. Bd3 dxc4 9. Bxc4 Nd5 10. Bxe7 Qxe7 11. O-O Nxc3 12. Rxc3 e5 13. dxe5 Nxe5 14. Nxe5 Qxe5 15. Qc2 Qxc3 16. Qxc3 Be6 17. Bxe6 fxe6 18. Qxc6 Rac8 19. Qxb7 Rc2 20. Qb3 Rxb2 21. Qc3 Rc2 22. Qb3 Rb2 23. Qc3 Rc2 24. Qb3 Rxf2 25. Rxf2 Rxf2 26. Kxf2 Kf7 27. Qb7+ Kf6 28. Qxa7 g5 29. Qa6 Kf5 30. a4 h5 31. a5 h4 32. Qb5+ Kg4 33. Qb4+ Kh5 34. Qxh4+ Kxh4 35. a6 Kg4 36. a7 Kf5 37. a8=Q e5 38. Qf3+ Kg6 39. h4 gxh4 40. Qg4+');

-- Game 4: Hannah vs Bob (in progress)
INSERT INTO games (white_player_id, black_player_id, class_id, result, time_control, opening_name, total_moves, pgn_notation)
VALUES 
(12, 6, 4, 'in_progress', '30+0', 'King''s Indian Defense', 15, 
'1. d4 Nf6 2. c4 g6 3. Nc3 Bg7 4. e4 d6 5. Nf3 O-O 6. Be2 e5 7. O-O Nc6 8. d5 Ne7 9. Ne1 Nd7 10. Be3 f5 11. f3 f4 12. Bf2 g5 13. Nd3 Ng6 14. c5 Nf6 15. Rc1');

-- ============================================
-- Insert Sample Game Moves (for Game 1)
-- ============================================

INSERT INTO game_moves (game_id, move_number, move_notation, position_fen, time_taken)
VALUES 
(1, 1, 'e4', 'rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1', 5),
(1, 2, 'e5', 'rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq e6 0 2', 4),
(1, 3, 'Nf3', 'rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2', 3),
(1, 4, 'Nc6', 'r1bqkbnr/pppp1ppp/2n5/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R w KQkq - 2 3', 5),
(1, 5, 'Bc4', 'r1bqkbnr/pppp1ppp/2n5/4p3/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 3 3', 4);

-- ============================================
-- End of DML Script
-- ============================================

-- ============================================
-- Verification Queries
-- ============================================

-- Count records in each table
SELECT 'Users' AS table_name, COUNT(*) AS record_count FROM users
UNION ALL
SELECT 'Classes', COUNT(*) FROM classes
UNION ALL
SELECT 'Enrollments', COUNT(*) FROM class_enrollments
UNION ALL
SELECT 'Games', COUNT(*) FROM games
UNION ALL
SELECT 'Game Moves', COUNT(*) FROM game_moves;

-- View active classes
SELECT * FROM v_active_classes;

-- View student progress
SELECT * FROM v_student_progress
ORDER BY games_won DESC;
