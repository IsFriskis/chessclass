# chessclass

A chess class management system.

## Getting Started

### Installation

```bash
npm install
```

### Running the Server

```bash
npm start
```

The server will start on port 3000 (or the port specified in the PORT environment variable).

## API Endpoints

### Status Endpoint

**GET** `/status`

Returns the current status of the API.

**Response:**
```json
{
  "status": "OK",
  "timestamp": "2025-10-06T14:49:52.268Z",
  "uptime": 20.182674231,
  "service": "chessclass"
}
```

- `status`: Current status of the service (always "OK" when responding)
- `timestamp`: Current server time in ISO 8601 format
- `uptime`: Server uptime in seconds
- `service`: Name of the service