#!/bin/bash

# Function to spin down containers and exit
cleanup() {
  echo "Spinning down containers..."
  (docker-compose down)
  exit 0
}

# Trap SIGINT and EXIT signals
trap cleanup SIGINT EXIT

# Start the Docker Compose project (wholesailor)
echo "Starting Docker Compose project (wholesailor)..."
(docker-compose up --build)

# Wait for the user to interrupt the script
while true; do
  sleep 1
done