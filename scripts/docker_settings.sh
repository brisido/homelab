#!/bin/bash

docker_compose()
{
    for DOCKER_FOLDER in "${DOCKER_FOLDERS[@]}"; do
        echo -e "\n${DOCKER_FOLDER} folder ..."
        if [ -d "../${DOCKER_FOLDER}" ]; then
            for DOCKER_SUBFOLDER in "../${DOCKER_FOLDER}"/*/; do
                docker compose --project-directory ${DOCKER_SUBFOLDER} ${1}
            done
        else
            echo -e "${YELLOW}[WARN] Service not found.${RESET}"
        fi
    done
}

docker_network()
{
    echo -e "\nChecking for Docker Network ..."

    if [ $(docker network ls | grep $DOCKER_NETWORK_NAME | wc -l) != 1 ]; then
        echo -e "${RED}[ERROR] Docker Network not found.${RESET}"

        echo -e "\nCreating Docker Network ..."
        docker network create $DOCKER_NETWORK_NAME

        if [ $(docker network ls | grep $DOCKER_NETWORK_NAME | wc -l) == 1 ]; then
            echo -e "${GREEN}[OK] Docker Network \"$DOCKER_NETWORK_NAME\" created!${RESET}\n"
        else
            echo -e "${RED}[ERROR] An unexpected error occurred.${RESET}\n"
            exit 1
        fi
    else
        echo -e "${GREEN}[OK] Docker Network $DOCKER_NETWORK_NAME:${RESET}\n"
        
        docker network inspect $DOCKER_NETWORK_NAME
    fi
}

docker_install()
{
    echo -e "\nChecking for Docker ..."

    if [ docker -v 2> /dev/null ]; then
        echo -e "${RED}[ERROR] Docker not found.${RESET}"

        case "$DISTRO_FAMILY" in
            *debian*|*ubuntu*)
                # Add Docker's official GPG key:
                sudo apt update
                sudo apt install ca-certificates curl
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc

                # Add the repository to Apt sources:
                sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
uites: $(. /etc/os-release && echo "$VERSION_CODENAME")
omponents: stable
rchitectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

                sudo apt update

                # Install Docker
                sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

                # Check Docker Version
                docker -v
            ;;
            *rhel*|*fedora*|*centos*)
                echo 'Red Hat Based - under construction'

                sudo dnf update

                # TO DO
                # sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

            ;;
            *)
                echo -e "${RED}OS $ID Not Supported${RESET}\n"
                exit 1
            ;;
        esac
    else
        echo -e "${GREEN}$(docker -v)${RESET}"
    fi
}

"$@"