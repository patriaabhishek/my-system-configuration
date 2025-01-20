# FROM mcr.microsoft.com/devcontainers/python:1-3.12
FROM mcr.microsoft.com/devcontainers/universal:2-focal

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1
# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
# Enable Docker Buildkit
ENV DOCKER_BUILDKIT=1

# Setup SSL
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR=/etc/ssl/certs/
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
ENV PIP_CERT=/etc/ssl/certs/ca-certificates.crt
ENV GRPC_DEFAULT_SSL_ROOTS_FILE_PATH=/etc/ssl/certs/ca-certificates.crt
ENV POETRY_HOME=/etc/poetry

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx && \
    apt-get clean -y && \
    rm -rf /tmp/scripts

USER root
# RUN usermod -aG sudo vscode
# USER vscode
RUN usermod -aG sudo codespace
USER codespace
