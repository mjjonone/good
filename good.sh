#!/bin/sh

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

update_variable() {
  local var_name=$1
  local var_value=$2
  local prompt="Current value for $var_name: $var_value"
  echo "$prompt"
  read -p "Do you want to change the value for $var_name? (y/n) [n]: " change_var
  change_var=${change_var:-"n"}
  if [ "$change_var" = "y" ]; then
    read -p "Please enter the new value for $var_name: " new_var_value
    export $var_name=$new_var_value
  else
    export $var_name=$var_value
  fi
}

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

echo "ARGO_AUTH: $ARGO_AUTH"
echo "NEZHA_SERVER: $NEZHA_SERVER"
echo "NEZHA_KEY: $NEZHA_KEY"
echo "NEZHA_PORT: $NEZHA_PORT"
echo "TLS: $TLS"
echo "ARGO_DOMAIN: $ARGO_DOMAIN"
echo "WEB_DOMAIN: $WEB_DOMAIN"
echo "CFIP: $CFIP"
echo "NAME: $NAME"
echo "SERVER_PORT: $SERVER_PORT"

curl -SsL https://raw.githubusercontent.com/mjjonone/good/main/vps.sh -o vps.sh
chmod 755 vps.sh
nohup bash vps.sh > good.log 2>&1 &