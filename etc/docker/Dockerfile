FROM alpine/git AS ai-docs

WORKDIR /app
RUN git clone https://github.com/jscoobyced/jsc-agent-fleet.git

FROM node:alpine

# Update package repositories and install necessary packages
RUN apk update
# Install essential packages
RUN apk add --no-cache git curl wget bash tzdata sudo
# Install additional packages for development
RUN apk add --no-cache build-base mandoc man-pages \
    mysql-client sqlite sqlite-dev mariadb-client postgresql-client \
    zlib-dev libffi-dev openssl-dev ripgrep 7zip \
    imagemagick potrace rsvg-convert \
    python3 py3-pip github-cli
RUN rm -rf /var/cache/apk/*

RUN npm install -g npm@latest
RUN npm install -g pnpm@latest --allow-scripts=pnpm

ARG OPENCODE_NAME="OpenCode User"
ARG OPENCODE_EMAIL="jsc-opencode-dev@example.com"

# Set timezone (defaults to Asia/Bangkok)
ARG TZ=Asia/Bangkok
ENV TZ=$TZ
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Configure bashrc
COPY etc/config/bashrc /etc/bash/bashrc
RUN chmod u+x /etc/bash/bashrc
RUN chown node:node /etc/bash/bashrc

# Enable sudo for the node user
RUN echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER node

# Install OpenCode CLI
RUN curl -fsSL https://opencode.ai/v2/install | bash
RUN mkdir -p ~/.config/opencode

COPY --from=ai-docs /app/jsc-agent-fleet/agents /home/node/.config/opencode/agents
COPY --from=ai-docs /app/jsc-agent-fleet/skills /home/node/.config/opencode/skills

# Configure GIT
RUN git config --global user.name "$OPENCODE_NAME"
RUN git config --global user.email "$OPENCODE_EMAIL"
RUN git config --global init.defaultBranch main

# Create workspace directory and set it as the working directory
RUN mkdir -p /home/node/workspace
WORKDIR /home/node/workspace

COPY --from=ai-docs /app/jsc-agent-fleet/.ai /home/node/workspace/.ai

RUN /home/node/.opencode/bin/opencode plugin add @dietrichgebert/ponytail

# Set the default command
CMD ["bash"]