#!/bin/bash

linux_distro()
{
    echo -e "\nChecking OS ..."

    if [ -f /etc/os-release ]; then
        . /etc/os-release

        DISTRO_FAMILY="${ID} ${ID_LIKE}"

        case "$DISTRO_FAMILY" in
            *debian*|*ubuntu*)
                echo -e "${GREEN}[OK] Debian Based${RESET}"
            ;;
            *rhel*|*fedora*|*centos*)
                echo -e "${GREEN}[OK] Red Hat Based${RESET}"
            ;;
            *)
                echo -e "${RED}OS $ID Not Supported${RESET}\n"
                exit 1
            ;;
        esac
    else
        echo -e "${RED}[ERROR] Unable to determine OS: file /etc/os-release not found.${RESET}"
        exit 1
    fi
}

"$1"