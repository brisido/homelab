#!/bin/bash

RESET='\033[0m'
RED='\033[031m'
GREEN='\033[032m'
YELLOW='\033[033m'
BLUE='\033[034m'
GRAY_BGD='\033[040m'

DOCKER_FOLDERS=("infra" "apps")
DOCKER_SERVICES=()
DOCKER_COMPOSE_FILE='compose.yml'
DOCKER_NETWORK_NAME='homelab-net'

NGINX_CONF_DIR='infra/nginx/conf.d'
NGINX_CERT_DIR='infra/nginx/certs'
NGINX_CERT_NAME='homelab'

CA_DIR="certificates"