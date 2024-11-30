#!/bin/bash

# Check if the TAG variable is passed as an argument
if [ -z "$TAG" ]; then
    TAG="$1" # Use the first argument passed to the script
    echo "TAG is set to: $TAG"
else
    echo "Using TAG from environment: $TAG"
fi

cat <<EOF
***************************************************
                    Build stage                                    
***************************************************
EOF

echo "Building Python application with tag: $TAG"
docker build -t ${TAG} -f pipeline/build/Dockerfile .
