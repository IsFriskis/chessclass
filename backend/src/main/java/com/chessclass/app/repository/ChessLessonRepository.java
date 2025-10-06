package com.chessclass.app.repository;

import com.chessclass.app.model.ChessLesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChessLessonRepository extends JpaRepository<ChessLesson, Long> {
    
    List<ChessLesson> findByLevel(String level);
    
    List<ChessLesson> findByTitleContainingIgnoreCase(String title);
}
