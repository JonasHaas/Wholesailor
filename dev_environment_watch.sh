#!/bin/bash

# Start the first Docker Compose project (woocommerce-example-shop)
echo "Starting first Docker Compose project (woocommerce-example-shop)..."
(cd ../woocommerce-example-shop && docker-compose up -d)

# Start the second Docker Compose project (wholesailor)
echo "Starting second Docker Compose project (wholesailor)..."
(cd ./wholesailor && docker-compose up -d --build)

# Watch for changes in the app's source code
echo "Watching for changes in the app's source code..."
while true; do
  inotifywait -r -e modify,create,delete ./wholesailor/backend
  echo "Changes detected. Rebuilding the app container..."
  (cd ./wholesailor && docker-compose up -d --build)
done