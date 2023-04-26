#!/bin/bash

# Function to spin down containers and exit
cleanup() {
  echo "Spinning down containers..."
  (docker-compose down)
  (cd ../woocommerce-example-shop && docker-compose down)
  exit 0
}

# Function to follow the logs of the second project's containers
follow_logs() {
  echo "Following logs for the wholesailor project's containers:"
  docker-compose logs -f &
  logs_pid=$!
}

# Trap SIGINT and EXIT signals
trap cleanup SIGINT EXIT

# Start the first Docker Compose project (woocommerce-example-shop)
echo "Starting first Docker Compose project (woocommerce-example-shop)..."
(cd ../woocommerce-example-shop && docker-compose up -d)

# Start the second Docker Compose project (wholesailor)
echo "Starting second Docker Compose project (wholesailor)..."
(docker-compose up -d --build)

# Follow the logs of the second project's containers
follow_logs

# Watch for changes in the app's source code
while inotifywait -r -e modify,attrib,close_write,move,create,delete ./backend; do
  echo "Changes detected. Rebuilding the app container..."
  (docker-compose up -d --build)

  # Kill the previous logs process
  kill $logs_pid

  # Follow the logs again
  follow_logs
done