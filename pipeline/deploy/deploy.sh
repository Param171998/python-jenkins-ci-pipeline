#!/bin/bash
echo "Deploying Python application..."
docker run -d --name python-app -p 5000:5000 docker-registry/$TAG
