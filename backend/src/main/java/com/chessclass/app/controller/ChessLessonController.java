package com.chessclass.app.controller;

import com.chessclass.app.model.ChessLesson;
import com.chessclass.app.service.ChessLessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/lessons")
@CrossOrigin(origins = "http://localhost:4200")
public class ChessLessonController {

    @Autowired
    private ChessLessonService chessLessonService;

    @GetMapping
    public ResponseEntity<List<ChessLesson>> getAllLessons() {
        return ResponseEntity.ok(chessLessonService.getAllLessons());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ChessLesson> getLessonById(@PathVariable Long id) {
        return chessLessonService.getLessonById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/level/{level}")
    public ResponseEntity<List<ChessLesson>> getLessonsByLevel(@PathVariable String level) {
        return ResponseEntity.ok(chessLessonService.getLessonsByLevel(level));
    }

    @GetMapping("/search")
    public ResponseEntity<List<ChessLesson>> searchLessonsByTitle(@RequestParam String title) {
        return ResponseEntity.ok(chessLessonService.searchLessonsByTitle(title));
    }

    @PostMapping
    public ResponseEntity<ChessLesson> createLesson(@RequestBody ChessLesson lesson) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(chessLessonService.createLesson(lesson));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ChessLesson> updateLesson(@PathVariable Long id, 
                                                     @RequestBody ChessLesson lessonDetails) {
        try {
            return ResponseEntity.ok(chessLessonService.updateLesson(id, lessonDetails));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteLesson(@PathVariable Long id) {
        chessLessonService.deleteLesson(id);
        return ResponseEntity.noContent().build();
    }
}
