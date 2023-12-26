#!/usr/bin/env bash

if [ ! -d "good" ]; then
    mkdir -p "good"
    echo "已创建工作目录"
else
    echo "工作目录已经存在"
fi
cd good 
NEZHA_SERVER=${NEZHA_SERVER:-''}
NEZHA_PORT=${NEZHA_PORT:-''}
NEZHA_KEY=${NEZHA_KEY:-''}
TLS=${TLS:-'1'}
ARGO_DOMAIN=${ARGO_DOMAIN:-''}
WEB_DOMAIN=${WEB_DOMAIN:-'example.com'}
ARGO_AUTH=${ARGO_AUTH:-''}
CFIP=${CFIP:-'icook.hk'}
NAME=${NAME:-''}
SERVER_PORT="${SERVER_PORT:-${PORT:-3000}}"

check_systemctl() {
  if ! command -v systemctl &>/dev/null; then
    CHECK_WGET=$(wget 2>&1 | head -n 1)
    grep -qi 'busybox' <<< "$CHECK_WGET" && ${PACKAGE_INSTALL[int]} wget >/dev/null 2>&1

    DEPS_CHECK=("bash" "rc-update" "ss" "python3")
    DEPS_INSTALL=("bash" "openrc" "iproute2" "python3")
    for ((g=0; g<${#DEPS_CHECK[@]}; g++)); do
      [ ! $(type -p ${DEPS_CHECK[g]}) ] && [[ ! "${DEPS[@]}" =~ "${DEPS_INSTALL[g]}" ]] && DEPS+=(${DEPS_INSTALL[g]})
    done
    if [ "${#DEPS[@]}" -ge 1 ]; then
      info "\n $(text 7) ${DEPS[@]} \n"
      ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
      ${PACKAGE_INSTALL[int]} "${DEPS[@]}" >/dev/null 2>&1
    else
      info "\n $(text 8) \n"
    fi

    [ ! $(type -p systemctl) ] && wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -O /bin/systemctl && chmod a+x /bin/systemctl
  fi
}


check_systemctl

# Check if .env file exists
if [ ! -f .env ]; then
  # If .env file does not exist, initialize it with default values
  echo "NEZHA_SERVER=$NEZHA_SERVER
NEZHA_PORT=$NEZHA_PORT
NEZHA_KEY=$NEZHA_KEY
TLS=$TLS
ARGO_DOMAIN=$ARGO_DOMAIN
WEB_DOMAIN=$WEB_DOMAIN
ARGO_AUTH=$ARGO_AUTH
CFIP=$CFIP
NAME=$NAME
SERVER_PORT=$SERVER_PORT" > .env
fi

read -p "Do you want to update the .env file? (y/n) [n]: " update_env
update_env=${update_env:-"n"}

update_variable() {
  local var_name=$1
  local var_value=$2
  local prompt="Current value for $var_name: $var_value"
  echo "$prompt"
  read -p "Do you want to change the value for $var_name? (y/n) [n]: " change_var
  change_var=${change_var:-"n"}
  if [ "$change_var" = "y" ]; then
    read -p "Please enter the new value for $var_name: " new_var_value
    echo "$var_name=$new_var_value" >> .env
  else
    echo "$var_name=$var_value" >> .env
  fi
}

if [ "$update_env" = "y" ]; then
  # Clear the .env file
  > .env
  update_variable "ARGO_AUTH" $ARGO_AUTH
  update_variable "NEZHA_SERVER" $NEZHA_SERVER
  update_variable "NEZHA_KEY" $NEZHA_KEY
  update_variable "NEZHA_PORT" $NEZHA_PORT
  update_variable "TLS" $TLS
  update_variable "ARGO_DOMAIN" $ARGO_DOMAIN
  update_variable "WEB_DOMAIN" $WEB_DOMAIN
  update_variable "CFIP" $CFIP
  update_variable "NAME" $NAME
  update_variable "SERVER_PORT" $SERVER_PORT
fi
curl -SsL https://raw.githubusercontent.com/mjjonone/good/main/vps.sh -o vps.sh
chmod 755 vps.sh

# Create systemd service file
echo "[Unit]
Description=GOOD Script

[Service]
EnvironmentFile=$(pwd)/.env
WorkingDirectory=$(pwd)
ExecStart=/bin/sh -c './vps.sh > ./good.log 2>&1'
Restart=always

[Install]
WantedBy=multi-user.target" |  tee /etc/systemd/system/good.service

# Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable good.service
systemctl start good.service