#!/bin/bash

#client script to check for updates and update
current_version=$(cat app.conf | grep version |cut -d'=' -f2)
echo $current_version
function check_update {
	echo "hello checking for updates ..."
	version=$(curl -s 192.168.2.112:8000/application/version/app.conf | grep version | cut -d "=" -f2) #should be a static ip address
	if [[ $version == $current_version ]]
	then
		echo "app is up to date"
	else
		echo "new application is available"
		update
	fi
}

function update {
        if [ -d previous_version ]
                then
                        mv app.conf app.sh previous_version
                        echo "updating ... downloading the new version"
                        wget -q http://192.168.2.112:8000/application/app/app.sh 2>/dev/null
                        wget -q http://192.168.2.112:8000/application/version/app.conf 2>/dev/null
                else 
                        mkdir previous_version
                        mv app.conf app.sh previous_version
                        echo "updating ... downloading the new version"
                        wget -q http://192.168.2.112:8000/application/app/app.sh 2>/dev/null
                        wget -q http://192.168.2.112:8000/application/version/app.conf 2>/dev/null
                fi

}

while [ true ]
do
        echo "Enter 1 to check for update and update"
        echo "Enter * to quit"
	read -p "Enter and option please: " opt
        case $opt in
         "1") check_update ;;
         "*") exit 0 ;;
	esac
done
