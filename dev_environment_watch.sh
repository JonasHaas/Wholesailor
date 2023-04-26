#!/bin/bash

# Function to spin down containers and exit
cleanup() {
  echo "Spinning down containers..."
  (docker-compose down)
  (cd ../woocommerce-example-shop && docker-compose down)
  exit 0
}

# Trap SIGINT and EXIT signals
trap cleanup SIGINT EXIT

# Start the first Docker Compose project (woocommerce-example-shop)
echo "Starting first Docker Compose project (woocommerce-example-shop)..."
(cd ../woocommerce-example-shop && docker-compose up -d)

# Start the second Docker Compose project (wholesailor)
echo "Starting second Docker Compose project (wholesailor)..."
(docker-compose up -d --build)

# Function to display logs of the second project's containers
#show_logs() {
#  echo "Displaying logs for the wholesailor project's containers:"
#  (docker-compose logs)
#}

# Wait for x seconds before showing the logs
#sleep 10

# Display logs for the wholesailor project's containers
#show_logs

# application endpoint
echo "Access the application at: http://127.0.0.1:5000/products"
echo ""

# Watch for changes in the app's source code
echo "Watching for changes in the app's source code..."
while true; do
  inotifywait -r -e modify,create,delete ./backend/app
  echo "Changes detected. Rebuilding the app container..."
  (docker-compose up -d --build)
done