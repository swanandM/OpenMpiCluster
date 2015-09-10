#!/bin/bash

FILE=/etc/ansible/hosts
k=1
ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/' >> mpiHosts

while read line;do
      if [ -n "$line" ]; then
      	if [[ "$line" != *"["* ]]; then
        	string="$line"
		set -- $string
		echo "Line # $k: $1"  
                cp ~/OpenMpiCluster/host_vars/hpc  ~/OpenMpiCluster/host_vars/$1
		IP="$(cut -d "=" -f 2 <<< "$2")"
		echo "$IP"
		if [[ $IP != 127.0.0.1 ]]; then
		echo "$IP" >> mpiHosts
		fi

                 
        fi
      fi
      ((k++))

done < $FILE
echo "Total number of lines in file: $k"

