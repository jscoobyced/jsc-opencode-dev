FROM node:26.5.1-alpine

# Update package repositories and install necessary packages
RUN apk update
# Install essential packages
RUN apk add --no-cache git curl wget bash tzdata sudo
# Install additional packages for development
RUN apk add --no-cache yarn postgresql-client \
    mysql-client sqlite sqlite-dev build-base \
    zlib-dev libffi-dev openssl-dev \
    mandoc man-pages
RUN rm -rf /var/cache/apk/*

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
RUN curl -fsSL https://opencode.ai/install | bash
RUN mkdir -p ~/.config/opencode

# Configure GIT
RUN git config --global user.name "$OPENCODE_NAME"
RUN git config --global user.email "$OPENCODE_EMAIL"
RUN git config --global init.defaultBranch main

# Create workspace directory and set it as the working directory
RUN mkdir -p /home/node/workspace
WORKDIR /home/node/workspace

# Set the default command
CMD ["bash"]