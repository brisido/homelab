#!/bin/bash

check_folder_exists()
{
    local DIRECTORY="${1}"

    FOLDER=$(echo "${DIRECTORY}" | awk -F'/' '{print $NF}')

    msg ${TITLE} "\nChecking if the \"${FOLDER}\" folder exists ..."

    if [ -d "../${DIRECTORY}" ]; then
        msg ${INFO} "\"${FOLDER}\" folder already exists."
    else
        msg ${ERROR} "\"${FOLDER}\" folder not found."

        msg ${TITLE} "\nCreating folder \"${DIRECTORY}\" ..."
        mkdir -p "../${DIRECTORY}"

        if [ -d "../${DIRECTORY}" ]; then
            msg ${INFO} "\"${FOLDER}\" folder already exists."
        fi
    fi
}

mkcert_install()
{
    msg ${TITLE} "\nInstalling mkcert and libnss3-tools ..."
    sudo apt update
    sudo apt install mkcert libnss3-tools -y

    msg ${TITLE} "\nmkcert installed version..."
    mkcert -version
}

create_ca()
{
    msg ${TITLE} "\nCreating Certificate Authority (CA) ..."
    mkcert -install

    msg ${TITLE} "\nCertificate Authority (CA) located in ..."
    mkcert -CAROOT

    msg ${WARN} "⚠️  rootCA-key.pem is the private key of your CA. Never share it!"

    MKCERT_DIR=$(mkcert -CAROOT)
    CA_FILE="rootCA.pem"
    
    check_folder_exists "${CA_DIR}"

    msg ${TITLE} "\nCopying Certificate Authority (CA) ..."
    cp "${MKCERT_DIR}/${CA_FILE}" "../${CA_DIR}/${NGINX_CERT_NAME}-ca.crt"
    msg ${INFO} "$(ls "../${CA_DIR}/${NGINX_CERT_NAME}-ca.crt")"

    msg ${TITLE} "\nPlease, run the following commands in your local Linux machine ..."
    msg ${BOX} \
    "   $ sudo cp ${CA_DIR}/${NGINX_CERT_NAME}-ca.crt /etc/pki/ca-trust/source/anchors/
    $ sudo update-ca-trust
    $ trust list | grep -A3 \"mkcert\""
}

generate_certs()
{
    check_folder_exists "${NGINX_CONF_DIR}"
    check_folder_exists "${NGINX_CERT_DIR}"

    NGINX_SERVER_NAME=$(grep -v '^[[:space:]]*#' ../${NGINX_CONF_DIR}/*.conf | awk '/server_name/ {sub(/;/, ""); print $NF}' | sort -u)
    
    msg ${TITLE} "\nGenerate a Certificate for all services ..."
    mkcert \
    -cert-file "../${NGINX_CERT_DIR}/${NGINX_CERT_NAME}.pem" \
    -key-file "../${NGINX_CERT_DIR}/${NGINX_CERT_NAME}-key.pem" \
    $NGINX_SERVER_NAME
}

"$1"