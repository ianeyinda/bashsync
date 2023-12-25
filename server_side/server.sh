#!/bin/bash

#script to create a server that pushes software updates


function http_server {
	if [[ -d application ]]
	then
		python3 -m http.server 8000
	else
		echo "important files missing ... attempting to create them"
		mkdir application
		mkdir -p application/version
		touch ./application/version/app.conf
		mkdir -p application/app
		touch ./application/app/app.sh
		echo "files created but are missing content inside them ... "
	fi

}

http_server
