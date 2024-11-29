#!/bin/bash

# Check if the TAG variable is passed as an argument, otherwise default to "latest"
if [ -z "$TAG" ]; then
    TAG="$1" # Use the first argument passed to the script if TAG is not set
    echo "TAG is set to: $TAG"
else
    echo "Using TAG from environment: $TAG"
fi

echo "Building Python application with tag: $TAG"
docker build -t ${TAG} -f ../../Dockerfile .
