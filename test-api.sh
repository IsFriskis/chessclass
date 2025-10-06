#!/bin/bash

# ChessClass API Test Script
# This script tests all the backend API endpoints

echo "=========================================="
echo "ChessClass API Test Script"
echo "=========================================="
echo ""

API_URL="http://localhost:8080/api/lessons"

# Check if backend is running
echo "1. Checking if backend is running..."
if curl -s --fail "$API_URL" > /dev/null; then
    echo "✓ Backend is running"
else
    echo "✗ Backend is not running. Please start it with: cd backend && mvn spring-boot:run"
    exit 1
fi
echo ""

# Test GET all lessons
echo "2. Testing GET /api/lessons"
curl -s "$API_URL" | jq .
echo ""

# Test POST - Create a new lesson
echo "3. Testing POST /api/lessons (Creating a lesson)"
LESSON_ID=$(curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d '{"title":"Test Lesson","description":"This is a test lesson","level":"beginner"}' \
  | jq -r '.id')
echo "✓ Created lesson with ID: $LESSON_ID"
echo ""

# Test GET by ID
echo "4. Testing GET /api/lessons/$LESSON_ID"
curl -s "$API_URL/$LESSON_ID" | jq .
echo ""

# Test GET by level
echo "5. Testing GET /api/lessons/level/beginner"
curl -s "$API_URL/level/beginner" | jq .
echo ""

# Test search
echo "6. Testing GET /api/lessons/search?title=Test"
curl -s "$API_URL/search?title=Test" | jq .
echo ""

# Test PUT - Update lesson
echo "7. Testing PUT /api/lessons/$LESSON_ID (Updating the lesson)"
curl -s -X PUT "$API_URL/$LESSON_ID" \
  -H "Content-Type: application/json" \
  -d '{"title":"Updated Test Lesson","description":"This lesson has been updated","level":"intermediate"}' \
  | jq .
echo ""

# Test DELETE
echo "8. Testing DELETE /api/lessons/$LESSON_ID (Deleting the lesson)"
curl -s -X DELETE "$API_URL/$LESSON_ID"
echo "✓ Lesson deleted"
echo ""

# Final check
echo "9. Final check - GET all lessons"
curl -s "$API_URL" | jq .
echo ""

echo "=========================================="
echo "✓ All API tests completed successfully!"
echo "=========================================="
