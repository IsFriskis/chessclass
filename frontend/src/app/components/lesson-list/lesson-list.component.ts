import { Component, OnInit } from '@angular/core';
import { ChessLesson } from '../../models/chess-lesson.model';
import { ChessLessonService } from '../../services/chess-lesson.service';

@Component({
  selector: 'app-lesson-list',
  templateUrl: './lesson-list.component.html',
  styleUrls: ['./lesson-list.component.css']
})
export class LessonListComponent implements OnInit {
  lessons: ChessLesson[] = [];
  newLesson: ChessLesson = {
    title: '',
    description: '',
    level: 'beginner'
  };
  isAddingLesson = false;

  constructor(private lessonService: ChessLessonService) { }

  ngOnInit(): void {
    this.loadLessons();
  }

  loadLessons(): void {
    this.lessonService.getAllLessons().subscribe(
      (data) => {
        this.lessons = data;
      },
      (error) => {
        console.error('Error loading lessons:', error);
      }
    );
  }

  showAddLessonForm(): void {
    this.isAddingLesson = true;
  }

  hideAddLessonForm(): void {
    this.isAddingLesson = false;
    this.resetNewLesson();
  }

  addLesson(): void {
    if (this.newLesson.title && this.newLesson.description) {
      this.lessonService.createLesson(this.newLesson).subscribe(
        (data) => {
          this.lessons.push(data);
          this.hideAddLessonForm();
        },
        (error) => {
          console.error('Error creating lesson:', error);
        }
      );
    }
  }

  deleteLesson(id: number | undefined): void {
    if (id && confirm('Are you sure you want to delete this lesson?')) {
      this.lessonService.deleteLesson(id).subscribe(
        () => {
          this.lessons = this.lessons.filter(lesson => lesson.id !== id);
        },
        (error) => {
          console.error('Error deleting lesson:', error);
        }
      );
    }
  }

  resetNewLesson(): void {
    this.newLesson = {
      title: '',
      description: '',
      level: 'beginner'
    };
  }
}
