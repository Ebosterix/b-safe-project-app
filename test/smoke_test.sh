#!/bin/bash
set -e

IMAGE_NAME="b-safe-app:test"
CONTAINER_NAME="b-safe-smoke-test"
PORT=8090
EXPECTED_TEXT="B-Safe App"

echo "Building image for test..."
docker build -t $IMAGE_NAME .

echo "Starting container for smoke test..."
docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME

echo "Waiting for Nginx to start..."
sleep 3

echo "Checking HTTP response..."
HTTP_STATUS=$(curl -s -o /tmp/response.html -w "%{http_code}" http://localhost:$PORT)

if [ "$HTTP_STATUS" -ne 200 ]; then
  echo "FAIL: Expected HTTP 200, got $HTTP_STATUS"
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME
  exit 1
fi

echo "Checking page content..."
if ! grep -q "$EXPECTED_TEXT" /tmp/response.html; then
  echo "FAIL: Expected text '$EXPECTED_TEXT' not found in response"
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME
  exit 1
fi

echo "PASS: Smoke test successful (HTTP 200, content verified)"

echo "Cleaning up test container..."
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

exit 0
