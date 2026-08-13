#!/bin/bash

ca_menu()
{
    clear

    read -p "
    [ Homelab Manager ] ===================================
    ===================== [ Create/Update CA Certificates ]

    1. Install mkcert and Create CA
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
        echo -e "\n\tThanks for using this script!\n"
        exit 0
    ;;
    *)
        echo -e "\n\t${RED}Invalid option. Please try again.${RESET}\n"
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
        source docker_settings.sh docker_compose infra "up -d"
    ;;
    2)
        source operating_system.sh linux_distro
        source docker_settings.sh docker_install
        source docker_settings.sh docker_network
    ;;
    3)
        source docker_settings.sh docker_compose infra "pull"
    ;;
    4)
        ca_menu
        # source ssl-certificates.sh generate_certs
    ;;
    5)
        main_menu
    ;;
    6)
        echo -e "\n\tThanks for using this script!\n"
        exit 0
    ;;
    *)
        echo -e "\n\t${RED}Invalid option. Please try again.${RESET}\n"
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
    3. Exit

    Please enter your choice [1-3]

    > " option

    case $option in
    1)
        start_menu
    ;;
    2)
        source docker_settings.sh docker_compose infra "down"
    ;;
    3)
        echo -e "\n\tThanks for using this script!\n"
        exit 0
    ;;
    *)
        echo -e "\n\t${RED}Invalid option. Please try again.${RESET}\n"
        sleep 2
        main_menu
    ;;
    esac
}

source variables.sh

main_menu