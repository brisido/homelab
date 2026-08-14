#!/bin/bash

msg()
{
    local STATUS="${1}"
    local MESSAGE="${2}"

    echo -e "${STATUS} ${MESSAGE} ${RESET}"
}

ca_menu()
{
    clear

    read -p "
    [ Homelab Manager ] ===================================
    ===================== [ Create/Update CA Certificates ]

    1. Install mkcert and Create Certificate Authority (CA)
    2. Generate a Certificate for all services
    3. Run all options above (1 and 2)
    4. Go Back
    5. Exit

    Please enter your choice [1-5]

    > " option

    case $option in
    1)
        source ssl-certificates.sh mkcert_install
        source ssl-certificates.sh create_ca
    ;;
    2)
        source ssl-certificates.sh generate_certs
    ;;
    3)
        source ssl-certificates.sh mkcert_install
        source ssl-certificates.sh create_ca
        source ssl-certificates.sh generate_certs
    ;;
    4)
        start_menu
    ;;
    5)
        msg ${TITLE} "\n\tThanks for using this script!"
        exit 0
    ;;
    *)
        msg ${ERROR} "Invalid option. Please try again."
        sleep 2
        ca_menu
    ;;
    esac
}

start_menu()
{
    clear

    read -p "
    [ Homelab Manager ] ===================================
    ===================================== [ Start Homelab ]

    1. Run Homelab
    2. Check Docker Dependencies
    3. Pull Docker Images
    4. Create/Update CA Certificates
    5. Go Back
    6. Exit

    Please enter your choice [1-6]

    > " option

    case $option in
    1)
        source docker_settings.sh docker_compose "up -d"
    ;;
    2)
        source operating_system.sh linux_distro
        source docker_settings.sh docker_install
        source docker_settings.sh docker_network
    ;;
    3)
        source docker_settings.sh docker_compose "pull"
    ;;
    4)
        ca_menu
    ;;
    5)
        main_menu
    ;;
    6)
        msg ${TITLE} "\n\tThanks for using this script!"
        exit 0
    ;;
    *)
        msg ${ERROR} "Invalid option. Please try again."
        sleep 2
        start_menu
    ;;
    esac
}

main_menu()
{
    clear

    read -p "
    [ Homelab Manager ] ===================================
    ========================================= [ Main Menu ]

    1. Start Homelab
    2. Stop Homelab
    3. Restart Homelab
    4. Restart NGINX
    5. Load New Service
    6. Exit

    Please enter your choice [1-6]

    > " option

    case $option in
    1)
        start_menu
    ;;
    2)
        source docker_settings.sh docker_compose "down"
    ;;
    3)
        source docker_settings.sh docker_compose "down"
        source docker_settings.sh docker_compose "up -d"
    ;;
    4)
        msg ${TITLE} "\nRestarting NGINX ..."
        docker compose --project-directory ../infra/nginx/ restart
    ;;
    5)
        source docker_settings.sh docker_compose "up -d"

        source ssl-certificates.sh generate_certs

        msg ${TITLE} "\nRestarting NGINX ..."
        docker compose --project-directory ../infra/nginx/ restart
    ;;
    6)
        msg ${TITLE} "\n\tThanks for using this script!"
        exit 0
    ;;
    *)
        msg ${ERROR} "Invalid option. Please try again."
        sleep 2
        main_menu
    ;;
    esac
}

source variables.sh

main_menu