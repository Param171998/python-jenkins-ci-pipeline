#!/bin/bash
echo "Pushing Docker image to private registry..."
docker tag $TAG docker-registry/$TAG
docker push docker-registry/$TAG
