# Changelogs
saucisson
## 1.2.1 - 01/06/2020

*   New logo in RGB color, thanks to https://github.com/Dok-T/ :)

## 1.2 - 31/05/2020

*   Back to the sed method for removing the subscription message

## 1.1.1 - 24/05/2020

*   Added variables for a more readable code
*   Patch file is now downloaded in the same repertory as the proxmoxlib.js file

## 1.1 - 23/05/2020

*   Add free depot : now creates a files in /etc/apt.sources.list.d/ named "pve-free.list" instead of editing "/etc/apt.sources.list".
*   Remove enterprise depot : now rename the file from "/etc/apt/sources.list.d/pve-enterprise.list" to ".disabled-pve-enterprise.list" instead of editing the file to comment the line.
*   Sub popup remover : now uses patch and a script, special thanks to @patphobos on Twitter for the script !
*   Add free depot : now check if the pve-free.list exists, if so then it won't change, else it will create it.
*   Remove enterprise depot : actually the same, checks if the pve-enterprise.list exists, if so it will be renamed, else nothing will be done.
*   Sub popup remover : as it now uses the patch command, it will check by himself if the patch already have been applied.

## 1.0.3 - 22/05/2020

*   Fully fonctionnal. Works with sed by editing the concerned files