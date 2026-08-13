#!/bin/bash

check_folder_exists()
{
    local DIRECTORY="${1}"

    FOLDER=$(echo "${DIRECTORY}" | awk -F'/' '{print $NF}')

    echo -e "\nChecking if the \"${FOLDER}\" folder exists ..."

    if [ -d "../${DIRECTORY}" ]; then
        echo -e "${GREEN}[OK] \"${FOLDER}\" folder already exists.${RESET}"
    else
        echo -e "${RED}[ERROR] \"${FOLDER}\" folder not found.${RESET}"

        echo -e "\nCreating folder \"${DIRECTORY}\" ..."
        mkdir -p "../${DIRECTORY}"

        if [ -d "../${DIRECTORY}" ]; then
            echo -e "${GREEN}[OK] \"${FOLDER}\" folder already exists.${RESET}"
        fi
    fi
}

mkcert_install()
{
    echo -e "\nInstalling mkcert and libnss3-tools ..."
    sudo apt update
    sudo apt install mkcert libnss3-tools -y

    echo -e "\nmkcert installed version..."
    mkcert -version
}

create_ca()
{
    echo -e "\nCreating CA ..."
    mkcert -install

    echo -e "\nCA located in ..."
    mkcert -CAROOT

    echo -e "\n\n${YELLOW}⚠️  rootCA-key.pem is the private key of your CA. Never share it!${RESET}\n\n"

    MKCERT_DIR=$(mkcert -CAROOT)
    CA_FILE="rootCA.pem"
    
    check_folder_exists "${CA_DIR}"

    echo -e "\nCopying CA to ${CA_DIR}/${NGINX_CERT_NAME}-ca.crt ..."
    cp "${MKCERT_DIR}/${CA_FILE}" "../${CA_DIR}/${NGINX_CERT_NAME}-ca.crt"
    echo -e "${GREEN}$(ls "../${CA_DIR}/${NGINX_CERT_NAME}-ca.crt")${RESET}"

    echo -e "\nConfigure your local Linux machine ..."
    echo -e "${GRAY_BGD}
    $ sudo cp ${CA_DIR}/${NGINX_CERT_NAME}-ca.crt /etc/pki/ca-trust/source/anchors/
    $ sudo update-ca-trust
    $ trust list | grep -A3 \"mkcert\"${RESET}"
}

generate_certs()
{
    check_folder_exists "${NGINX_CONF_DIR}"
    check_folder_exists "${NGINX_CERT_DIR}"

    NGINX_SERVER_NAME=$(grep -v '^[[:space:]]*#' ../${NGINX_CONF_DIR}/*.conf | awk '/server_name/ {sub(/;/, ""); print $NF}' | sort -u)
    
    echo -e "\nGenerate a Certificate for all services ..."
    mkcert \
    -cert-file "../${NGINX_CERT_DIR}/${NGINX_CERT_NAME}.pem" \
    -key-file "../${NGINX_CERT_DIR}/${NGINX_CERT_NAME}-key.pem" \
    $NGINX_SERVER_NAME
}

"$1"