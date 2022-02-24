#! /bin/bash
display_infos() {
	echo -e "\t#Architecture: $(uname -a)"
	echo -e "\t#CPU physical: $(cat /proc/cpuinfo | grep processor | wc -l)"
	echo -e "\t#vCPU: $(cat /proc/cpuinfo | grep processor | wc -l)"
	echo -e "\t#Memory Usage: $(free -m | awk 'NR==2 {printf "%s/%sMB (%.2f%%)", $3, $2, $3 * 100 / $2}')"
	echo -e "\t#Disk Usage: $(df -h | awk '$NF=="/"{printf "%d/%dGb (%s)", $3,$2,$5}')"
	echo -e "\t#CPU load: $(top -bn1 | grep load | awk '{printf "%.1f%%\n", $(NF-2)}')"
	echo -e "\t#Last boot: $(who -b | awk '{print $3" "$4" "$5}')"
	echo -e "\t#LVM use: $(lsblk | grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no";exit;}}')"
	echo -e "\t#Connexions TCP: $(netstat -an | grep ESTABLISHED |  wc -l)"
	echo -e "\t#User log: $(who | cut -d ' ' -f 1 | sort -u | wc -l)"
	echo -e "\t#Network: IP $(hostname -I)($(ip a | grep link/ether | awk '{print $2}'))"
	echo -e "\t#Sudo: $(grep -a sudo /var/log/auth.log | wc -l)"
}

wall "$(display_infos)"