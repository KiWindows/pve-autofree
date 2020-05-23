# Changelogs

## 1.1 - 23/05/2020

*   Add free depot : now creates a files in /etc/apt.sources.list.d/ named "pve-free.list" instead of editing "/etc/apt.sources.list".
*   Remove enterprise depot : now rename the file from "/etc/apt/sources.list.d/pve-enterprise.list" to ".disabled-pve-enterprise.list" instead of editing the file to comment the line.
*   Sub popup remover : now uses patch and a script, special thanks to @patphobos on Twitter for the script !
*   Add free depot : now check if the pve-free.list exists, if so then it won't change, else it will create it.
*   Remove enterprise depot : actually the same, checks if the pve-enterprise.list exists, if so it will be renamed, else nothing will be done.
*   Sub popup remover : as it now uses the patch command, it will check by himself if the patch already have been applied.

## 1.0.3 - 22/05/2020

Fully fonctionnal. Works with sed by editing the concerned files

*saucisse*