# ChessClass Status Frontend

A basic Angular frontend application that prompts a status endpoint to check the system status.

## Features

- **Status Check**: Click the "Check Status" button to fetch the current system status
- **Loading State**: Shows a spinner while fetching status
- **Error Handling**: Displays error messages when the status endpoint is unavailable
- **Responsive Design**: Clean, modern UI with responsive layout

## Getting Started

### Prerequisites

- Node.js (v18 or higher)
- npm

### Installation

```bash
cd chessclass-frontend
npm install
```

### Development Server

Run the development server:

```bash
npm start
```

Navigate to `http://localhost:4200/` in your browser.

### Build

Build the application for production:

```bash
npm run build
```

The build artifacts will be stored in the `dist/chessclass-frontend/` directory.

## API Integration

The application expects a status endpoint at `/api/status` that returns a JSON response with the following structure:

```json
{
  "status": "ok",
  "message": "System is running",
  "timestamp": "2025-10-06T14:52:49.025Z"
}
```

### Configuring the API Endpoint

The status endpoint URL can be modified in `src/app/services/status.ts`:

```typescript
private statusEndpoint = '/api/status';
```

## Project Structure

```
chessclass-frontend/
├── src/
│   ├── app/
│   │   ├── services/
│   │   │   └── status.ts          # Status service for API calls
│   │   ├── app.ts                 # Main app component
│   │   ├── app.html               # App template
│   │   ├── app.css                # App styles
│   │   └── app.config.ts          # App configuration
│   ├── index.html                 # Main HTML file
│   └── main.ts                    # Application entry point
└── package.json                   # Project dependencies
```

## Technologies Used

- Angular 19+ (with standalone components)
- TypeScript
- RxJS for reactive programming
- Angular HttpClient for API calls
