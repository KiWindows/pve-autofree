#!/bin/bash
echo "
                                            /&@@@  .@@&                         
                                     @@@@@@@@@@@   @@@@@@@@@@@@#                
                                 @@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@*           
                              @@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@         
              .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@       
             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@(     
            @@@@@(                 @@@@@@@@@   @@@@@@@@@@@@@@@@@@@@@@@@@@@@     
           .        *@@@@@@@@,          @@@,  (@@@@@@@@@@@@@@@@@@@@@@@@@@@@&    
           #@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
           @@@@@@@@@@@@@@@ @@@@@@@@@@@@@@      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
           @@@@@@@@@@,      #@@@@@@@@@@@@@   @     &@@@@@@@@@@@@@@@@@@@@@@@     
         @@@@                 .@@@@@@@@@@   @@@@@@&        .@@@@@@@@/.          
        @@@                      @@@@@@@   ,@@@@@@@@@@@@@            %@@@@      
      /@@,                           @@*   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       
     *@@                                  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@         
     @@                                         @@@@@@@@@@@@@@@@@@@@            
    @@.                                        (@@@      @@@@@@@@               
    @@                                         @@@/       @@@@@                 
    @                                         (@@@        @@@                   
                                        /@@@@@@@@@@      %@@@                   
                                            @     ,@@@@@@@@@@                   
                                                      @@@                       

Script originaly made by KiWindows : https://kiwindows.fr , https://github.com/kiwindows

pve-autofree version 1.0.3

The purpose of this script is to disable the enterprise-repos of Proxmox VE and add the
free one. It also disable the subscription popup on the WebGUI.

Once the free repos have been installed, the pveproxy service will automatically be restarted
and Proxmox VE will update and full upgrade
"

read -p "Would you like to continue ? y/Y/yes/Yes n/N/no/No

" opt
case $opt in
    y|Y|yes|Yes)
        mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/.disabled-pve-enterprise.list
        { echo '# Free Proxmox VE depot'; echo 'deb http://download.proxmox.com/debian/pve buster pve-no-subscription'; } >> /etc/apt/sources.list.d/pve-free.list
        read -p "The list have been changed. Would you like to update and fully upgrade Proxmox VE ?

" optupdate
        case $optupdate in
            y|Y|yes|Yes)
                apt update && apt full-upgrade -y
                ;;
        esac
        sed -i.bak "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
        echo "pveproxy.service is restarting, remember to refresh your tab in a few seconds..."
        echo "If the popup still appears, cleaning your browser cache may help."
        systemctl restart pveproxy.service
        ;;
    n|N|no|No)
        exit
        ;;
    *)
        echo "No an expected answer. Abording."
        exit
        ;;
esac