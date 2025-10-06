import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ChessLesson } from '../models/chess-lesson.model';

@Injectable({
  providedIn: 'root'
})
export class ChessLessonService {
  private apiUrl = 'http://localhost:8080/api/lessons';

  constructor(private http: HttpClient) { }

  getAllLessons(): Observable<ChessLesson[]> {
    return this.http.get<ChessLesson[]>(this.apiUrl);
  }

  getLessonById(id: number): Observable<ChessLesson> {
    return this.http.get<ChessLesson>(`${this.apiUrl}/${id}`);
  }

  getLessonsByLevel(level: string): Observable<ChessLesson[]> {
    return this.http.get<ChessLesson[]>(`${this.apiUrl}/level/${level}`);
  }

  searchLessonsByTitle(title: string): Observable<ChessLesson[]> {
    return this.http.get<ChessLesson[]>(`${this.apiUrl}/search?title=${title}`);
  }

  createLesson(lesson: ChessLesson): Observable<ChessLesson> {
    return this.http.post<ChessLesson>(this.apiUrl, lesson);
  }

  updateLesson(id: number, lesson: ChessLesson): Observable<ChessLesson> {
    return this.http.put<ChessLesson>(`${this.apiUrl}/${id}`, lesson);
  }

  deleteLesson(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}
