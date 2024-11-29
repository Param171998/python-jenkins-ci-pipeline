#!/bin/bash

# Check if the TAG variable is passed as an argument
if [ -z "$TAG" ]; then
    TAG="$1" # Use the first argument passed to the script
    echo "TAG is set to: $TAG"
else
    echo "Using TAG from environment: $TAG"
fi

# Check if the REGISTRY variable is passed as an argument
if [ -z "$REGISTRY" ]; then
    REGISTRY="$2" # Use the second argument passed to the script
    echo "REGISTRY is set to: $REGISTRY"
else
    echo "Using REGISTRY from environment: $REGISTRY"
fi


cat <<EOF
***************************************************
                    Deploy stage
***************************************************
EOF

echo "Deploying Python application..."

docker run -d --name python-app -p 9442:9442 ${REGISTRY}:5000/$TAG
