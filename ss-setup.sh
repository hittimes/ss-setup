#!/bin/bash

init() {
	#make preperation
	apt-get update
	apt-get upgrade
	apt-get install build-essential python-pip python-m2crypto python-dev python-gevent supervisor

	pip install shadowsocks
}

set_config() {

	#make dir foe shadowsocks config
	if [ -d /etc/shadowsocks] then
		rm /etc/shadowsocks
	fi

	echo "Please enter server ip:"
	read ip
	echo "Please enter root usr port:"
	read port
	echo "Please enter root usr password:"
	read password

	config_file="/etc/shadowsocks/config.json"

	echo "{"					>>	$config_file
	echo "	\"server\":\"${ip}\","			>>	$config_file
	echo "	\"port_password\": {"			>>	$config_file
	echo "		\"${port}\":\"${password}\""	>>	$config_file
	echo "	},"					>>	$config_file
	echo "	\"timeout\": 600,"			>>	$config_file
	echo "	\"method\": \"aes-256-cfb\""		>>	$config_file
	echo "}"					>>	$config_file
}

set_service() {
	service_file="/etc/init.d/shadowsocks"

	if [ -f "$service_file" ]; then
		return 0
	fi

	copy shadowsocks $service_file
	chmod +x $service_file
}

init()
set_config()
set_service()
