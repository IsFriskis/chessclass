import { Component, signal, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Status, StatusResponse } from './services/status';

@Component({
  selector: 'app-root',
  imports: [CommonModule],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App implements OnInit {
  protected readonly title = signal('ChessClass Status');
  protected statusData = signal<StatusResponse | null>(null);
  protected isLoading = signal(false);
  private statusService = inject(Status);

  ngOnInit() {
    this.fetchStatus();
  }

  fetchStatus() {
    this.isLoading.set(true);
    this.statusService.getStatus().subscribe({
      next: (data) => {
        this.statusData.set(data);
        this.isLoading.set(false);
      },
      error: (error) => {
        console.error('Error:', error);
        this.isLoading.set(false);
      }
    });
  }
}
