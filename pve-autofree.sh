#!/bin/bash
# Small fix and add some fun things UwU (small edit by DokT, https://github.com/Dok-T/)

# WHAT'S CHANGED?
# - Using "printf" instead of "echo" (except for the ASCII logo) (beceause I like C)
# - Coloroed ASCII logo
# - small fixes

# WARNING: THESE MODIFICATIONS ARE UNTESTED! PLEASE DEBUG IT OR TEST THIS!!!


# Functions
function exitme () {
    # Funny stuff, don't mind about this :)


    # If ALSA in not used/install, or it just doesn't beep at all, use these method to beep ;)
    # - beep; 
    # - echo -ne '\007'
   ( speaker-test -t sine -f 1000 )& pid=$! ; sleep 0.1s ; kill -9 $pid;
   printf "\e[91mCTRL+C PRESSED!!!\e[0m :(\n";
   printf "Goodbye!\n";
   exit 1;
}
function print_my_logo () {
    echo -e "
    \e[91m                                            /&@@@ \e[92m .@@&                         \e[0m
    \e[91m                                     @@@@@@@@@@@ \e[92m  @@@@@@@@@@@@#                \e[0m
    \e[91m                                 @@@@@@@@@@@@@@ \e[92m  @@@@@@@@@@@@@@@@@@*           \e[0m
    \e[91m                              @@@@@@@@@@@@@@@@ \e[92m  @@@@@@@@@@@@@@@@@@@@@@         \e[0m
    \e[91m              .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \e[92m  @@@@@@@@@@@@@@@@@@@@@@@@       \e[0m
    \e[91m             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \e[92m  @@@@@@@@@@@@@@@@@@@@@@@@@@(     \e[0m
    \e[91m            @@@@@(                 @@@@@@@@@ \e[92m  @@@@@@@@@@@@@@@@@@@@@@@@@@@@     \e[0m
    \e[94m           .        *@@@@@@@@,    \e[91m      @@@, \e[92m (@@@@@@@@@@@@@@@@@@@@@@@@@@@@&    \e[0m
    \e[94m           #@@@@@@@@@@@@@@@@@@@@@@@@@      \e[92m   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    \e[0m
    \e[94m           @@@@@@@@@@@@@@@ @@@@@@@@@@@@@@   \e[92m   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@    \e[0m
    \e[94m           @@@@@@@@@@,      #@@@@@@@@@@@@@ \e[93m  @   \e[92m  &@@@@@@@@@@@@@@@@@@@@@@@     \e[0m
    \e[94m         @@@@                 .@@@@@@@@@@  \e[93m @@@@@@&   \e[92m     .@@@@@@@@/.          \e[0m
    \e[94m        @@@                      @@@@@@@  \e[93m ,@@@@@@@@@@@@@    \e[93m        %@@@@      \e[0m
    \e[94m      /@@,                           @@*  \e[93m @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       \e[0m
    \e[94m     *@@                                 \e[93m @@@@@@@@@@@@@@@@@@@@@@@@@@@@@         \e[0m
    \e[94m     @@                                     \e[93m    @@@@@@@@@@@@@@@@@@@@            \e[0m
    \e[94m    @@.                                   \e[93m     (@@@      @@@@@@@@               \e[0m
    \e[94m    @@                                  \e[93m       @@@/       @@@@@                 \e[0m
    \e[94m    @                                 \e[93m        (@@@        @@@                   \e[0m
                                     \e[93m       /@@@@@@@@@@      %@@@                   \e[0m
                                  \e[93m              @     ,@@@@@@@@@@                   \e[0m
                                    \e[93m                      @@@                       \e[0m
    ";
}
# Variables
export apt_sources="/etc/apt/sources.list.d/";
export apt_list="/etc/apt/sources.list";


# Please see exitme() !
trap exitme INT;

print_my_logo;
printf "%s\n" "
Script originaly made by KiWindows (https://kiwindows.fr | https://github.com/kiwindows)

                            pve-autofree version 1.0.3

The purpose of this script is to disable the enterprise-repos of Proxmox VE and add the
             free one. It also disable the subscription popup on the WebGUI.

Once the free repos have been installed, the pveproxy service will automatically be restarted
                       and Proxmox VE will update and full upgrade
";

read -p "Would you like to continue ? [Y/N]" anwser;

case $anwser in
    y|Y|yes|Yes)
        mv $apt_sources/pve-enterprise.list $apt_sources/pve-entreprise.list.bak;
        sed '1s/./#&/' /etc/apt/sources.list.d/pve-entreprise.list.bak >$apt_sources/pve-enterprise.list;
        read -p "Would you like to remove the old pve-entreprise.list? [Y/N]" anwser2;
            case $anwser2 in
            y|Y|y|Yes)
                sudo rm -rf $apt_sources/pve-enterprise.list.bak
                printf "Should be deleted!\n";
            ;;
            n|N|no|No)
                printf "not removed!\n";
            ;;    
            *)
                exit 0;
            ;;
            esac

        printf "'# Free Proxmox VE depot'; echo 'deb http://download.proxmox.com/debian/pve buster pve-no-subscription';\n" | tee -a $apt_list/sources.list;
        read -p "The list has been changed. Would you like to update and fully upgrade Proxmox VE ?" awnser3;
        case $awnser3 in
            y|Y|yes|Yes)
                sudo apt update && apt full-upgrade -y;
            ;;
        esac

        sed -i.bak "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js;
        printf "pveproxy.service is restarting, you may refresh your tab in a few seconds...\n";
        printf "If the popup still appears, cleaning your browser cache may help.\n";
        sudo systemctl restart pveproxy.service;
        ;;
    n|N|no|No)
        exit 0
        ;;
    *)
        printf "No an expected answer. Abording!\n";
        # Relaunch script if wrong input is typed.
        bash $0
        ;;
esac
exit 1;
