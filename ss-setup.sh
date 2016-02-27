#!/bin/bash

init() {
	apt-get update
	apt-get upgrade
	apt-get install build-essential python-pip python-m2crypto python-dev python-gevent supervisor
	apt-get install vim
	mkdir /etc/shadowsocks
	
	pip install shadowsocks
}

set_config() {
	echo "Please enter server ip:"
	read ip
	echo "Please enter root usr port:"
	read port
	echo "Please enter root usr password:"
	read password

	config_file="/etc/shadowsocks/config.json"

	echo "{"									>>	$config_file
	echo "	\"server\":\"${ip}\","				>>	$config_file
	echo "	\"port_password\": {"				>>	$config_file
	echo "		\"${port}\":\"${password}\""	>>	$config_file
	echo "	},"									>>	$config_file
	echo "	\"timeout\": 600,"					>>	$config_file
	echo "	\"method\": \"aes-256-cfb\""		>>	$config_file
	echo "}"									>>	$config_file
}

set_service() {
	service_file = "/etc/init.d/shadowsocks"
}
