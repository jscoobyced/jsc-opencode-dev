#!/bin/bash

set -e

DOCKERUSER=${DOCKERUSER:-jscdroiddev}
DOCKERIMAGE=${DOCKERIMAGE:-jsc-opencode-dev}
DOCKERTAG=${DOCKERTAG:-1.0.0}
ISPUSH=${ISPUSH:-false}

echo "🚀 Starting build process..."
echo "⚙️  Building project..."

ALSO_PUSH=""

if [ "$ISPUSH" = "true" ]; then
    ALSO_PUSH="--push "
    echo "📦 Will also be pushing Docker image..."
fi

docker buildx build --platform linux/amd64,linux/arm64 $ALSO_PUSH-t ${DOCKERUSER}/${DOCKERIMAGE}:latest -t ${DOCKERUSER}/${DOCKERIMAGE}:${DOCKERTAG} -f ./etc/docker/Dockerfile .

echo "✅ Build process completed."
if [ "$ISPUSH" = "true" ]; then
    echo "✅ Docker image pushed successfully."
fi
