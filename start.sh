#!/bin/bash

if [ ! -f ./opencode.jsonc ]; then
  cat <<EOF > ./opencode.jsonc
{
  "\$schema": "https://opencode.ai/config.json",
  "autoupdate": true,
  "enabled_providers": ["llama.cpp"],
  "provider": {
    "llama.cpp": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "llama-server",
      "options": {
        "baseURL": "http://127.0.0.1:8080/v1",
      },
      "models": {
        "qwen-3-5": {
          "name": "Qwen-3-5 (local)",
          "limit": {
            "context": 120000,
            "output": 65536,
          },
        },
      },
    },
  },
}
EOF
  echo "Created default opencode.jsonc configuration file. Please review and customize it as needed."
fi

if [ ! -f docker-compose.yml ]; then
  cat <<EOF > docker-compose.yml
services:
  jsc-opencode-dev:
    image: jscdroiddev:jsc-opencode-dev
    container_name: jsc-opencode-dev
    hostname: jsc-opencode-dev
    stdin_open: true
    tty: true
    volumes:
      - ./project:/home/node/workspace
      - ./opencode.jsonc:/home/node/.config/opencode/opencode.jsonc
EOF
  echo "Created default docker-compose.yml configuration file."
fi

docker compose up -d
docker compose exec jsc-opencode-dev bash
docker compose down