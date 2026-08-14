#!/bin/bash

CRITICAL='\n\033[041m[CRITICAL]'
ERROR='\n\033[031m[ERROR]'
INFO='\n\033[032m[OK]'
WARN='\n\033[033m[WARN]'
TITLE='\033[036m'
BOX='\033[040m'
RESET='\033[0m'

DOCKER_FOLDERS=("infra" "apps")
DOCKER_NETWORK_NAME='homelab-net'

NGINX_CONF_DIR='infra/nginx/conf.d'
NGINX_CERT_DIR='infra/nginx/certs'
NGINX_CERT_NAME='homelab'

CA_DIR='certificates'