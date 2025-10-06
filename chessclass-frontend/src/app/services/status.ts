import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';

export interface StatusResponse {
  status: string;
  message: string;
  timestamp: string;
}

@Injectable({
  providedIn: 'root'
})
export class Status {
  private http = inject(HttpClient);
  private statusEndpoint = '/api/status';

  getStatus(): Observable<StatusResponse> {
    return this.http.get<StatusResponse>(this.statusEndpoint).pipe(
      catchError(error => {
        console.error('Error fetching status:', error);
        return of({
          status: 'error',
          message: 'Failed to fetch status',
          timestamp: new Date().toISOString()
        });
      })
    );
  }
}
