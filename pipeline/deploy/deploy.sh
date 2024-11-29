#!/bin/bash

# Check if the TAG variable is passed as an argument, otherwise default to "latest"
if [ -z "$TAG" ]; then
    TAG="$1" # Use the first argument passed to the script if TAG is not set
    echo "TAG is set to: $TAG"
else
    echo "Using TAG from environment: $TAG"
fi


echo "Deploying Python application..."
docker run -d --name python-app -p 9442:9442 docker-registry:5000/$TAG
