#!/bin/bash

set -e

DOCKERUSER=${DOCKERUSER:-jscdroiddev}
DOCKERIMAGE=${DOCKERIMAGE:-jsc-opencode-dev}
DOCKERTAG=${DOCKERTAG:-1.0.0}
ISPUSH=${ISPUSH:-false}

echo "🚀 Starting build process..."
echo "⚙️  Building project..."

docker build -t ${DOCKERUSER}/${DOCKERIMAGE}:latest -t ${DOCKERUSER}/${DOCKERIMAGE}:${DOCKERTAG} -f ./etc/docker/Dockerfile .

echo "✅ Build process completed."

if [ "$ISPUSH" = "true" ]; then
    echo "📦 Pushing Docker image..."
    docker push ${DOCKERUSER}/${DOCKERIMAGE}:latest
    docker push ${DOCKERUSER}/${DOCKERIMAGE}:${DOCKERTAG}
    echo "✅ Docker image pushed successfully."
fi
