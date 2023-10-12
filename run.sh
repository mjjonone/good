#!/bin/sh

RESET="\033[0m"
BOLD="\033[1m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"

export NEZHA_SERVER=${NEZHA_SERVER:-''}
export NEZHA_PORT=${NEZHA_PORT:-''}
export NEZHA_KEY=${NEZHA_KEY:-''}
export TLS=${TLS:-'1'}
export ARGO_DOMAIN=${ARGO_DOMAIN:-''}
export WEB_DOMAIN=${WEB_DOMAIN:-'example.com'}
export ARGO_AUTH=${ARGO_AUTH:-''}
export CFIP=${CFIP:-'icook.hk'}
export NAME=${NAME:-''}
export SERVER_PORT="${SERVER_PORT:-${PORT:-3000}}"

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL1="https://github.com/mjjonone/good/raw/main/test"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL1="https://github.com/mjjonone/good/raw/main/test-arm64"
else
  echo -e "${RED}Unsupported architecture: $ARCH${RESET}"
  exit 1
fi

if [ -e test ]; then
  echo "test file already exists, skipping download."
else
  echo -e "${GREEN}Downloading test file...${RESET}"
  curl -sSL "$DOWNLOAD_URL1" -o test
  echo -e "${GREEN}Download completed.${RESET}"
fi

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL="https://github.com/mjjonone/good/raw/main/go"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL="https://github.com/mjjonone/good/raw/main/go-arm64"
else
  echo -e "${RED}Unsupported architecture: $ARCH${RESET}"
  exit 1
fi

if [ -e go ]; then
  echo "go file already exists, skipping download."
  echo -e "${GREEN}going...${RESET}"
  chmod 755 go
  ./go
else
  echo -e "${GREEN}Downloading go file...${RESET}"
  curl -sSL "$DOWNLOAD_URL" -o go
  echo -e "${GREEN}Download completed.${RESET}"
  echo -e "${GREEN}going...${RESET}"
  chmod 755 go
  ./go
fi