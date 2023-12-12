#!/bin/bash

function is_api_up {
  curl --silent --fail http://localhost:9000/v1/health-check
  return $?
}

# Clone and start the eurogamer-api project
if [ ! -d "eurogamer-api" ]; then
  git clone https://github.com/alexandrubb23/eurogamer-api.git
fi
cd eurogamer-api
./start.sh  # Assuming this script exists and starts the API
cd ..

# Wait for the API to be up and running with a timeout
echo "⌛ Waiting for the API to start..."
timeout=60 # Timeout in seconds (e.g., 60 seconds = 1 minute)
elapsed=0   # Time elapsed
while ! is_api_up; do
  if [ $elapsed -ge $timeout ]; then
    echo "⏰ Timeout waiting for API to start"
    exit 1
  fi

  printf '.'
  sleep 5
  elapsed=$((elapsed + 5))
done
echo "🚀 API is up and running!"

# Clone and start the eurogamer-client project
if [ ! -d "eurogamer-client" ]; then
  git clone https://github.com/alexandrubb23/eurogamer-client.git
fi
cd eurogamer-client
# Add commands to start the client project, e.g., npm install and npm start
npm i
npm run dev
