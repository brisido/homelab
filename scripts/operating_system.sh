#!/bin/bash

linux_distro()
{
    msg ${TITLE} "\nChecking OS ..."

    if [ -f /etc/os-release ]; then
        . /etc/os-release

        DISTRO_FAMILY="${ID} ${ID_LIKE}"

        case "$DISTRO_FAMILY" in
            *debian*|*ubuntu*)
                msg ${INFO} "Debian Based"
            ;;
            *rhel*|*fedora*|*centos*)
                msg ${INFO} "Red Hat Based"
            ;;
            *)
                msg ${CRITICAL} "Operational System $ID Not Supported."
                exit 1
            ;;
        esac
    else
        msg ${CRITICAL} "Unable to determine OS: file /etc/os-release not found."
        exit 1
    fi
}

"$1"