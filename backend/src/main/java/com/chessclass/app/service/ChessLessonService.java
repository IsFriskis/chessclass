package com.chessclass.app.service;

import com.chessclass.app.model.ChessLesson;
import com.chessclass.app.repository.ChessLessonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ChessLessonService {

    @Autowired
    private ChessLessonRepository chessLessonRepository;

    public List<ChessLesson> getAllLessons() {
        return chessLessonRepository.findAll();
    }

    public Optional<ChessLesson> getLessonById(Long id) {
        return chessLessonRepository.findById(id);
    }

    public List<ChessLesson> getLessonsByLevel(String level) {
        return chessLessonRepository.findByLevel(level);
    }

    public List<ChessLesson> searchLessonsByTitle(String title) {
        return chessLessonRepository.findByTitleContainingIgnoreCase(title);
    }

    public ChessLesson createLesson(ChessLesson lesson) {
        return chessLessonRepository.save(lesson);
    }

    public ChessLesson updateLesson(Long id, ChessLesson lessonDetails) {
        return chessLessonRepository.findById(id)
                .map(lesson -> {
                    lesson.setTitle(lessonDetails.getTitle());
                    lesson.setDescription(lessonDetails.getDescription());
                    lesson.setLevel(lessonDetails.getLevel());
                    return chessLessonRepository.save(lesson);
                })
                .orElseThrow(() -> new RuntimeException("Lesson not found with id: " + id));
    }

    public void deleteLesson(Long id) {
        chessLessonRepository.deleteById(id);
    }
}
