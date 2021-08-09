#!/bin/bash

VENV=.venv/
FURY=/usr/local/bin/fury


if [[ -d "$VENV" ]]; then
	echo "Entering into your virtualenv"
	source .venv/bin/activate
else
	echo "Creating virtualenv"
	python3 -m venv .venv

	echo "Entering into your virtualenv"
	source .venv/bin/activate
fi

if [[ ! -L "$FURY" ]]; then
	echo "Installing fury cli"
	if pip3 install -i https://pypi.artifacts.furycloud.io/ furycli --upgrade; then
		ln -s /Users/$USER/Library/Python/python3/bin/fury /usr/local/bin
		source ~/.bash_profile
	else 
		echo "something happened :( try again"
	fi		
else 
	echo "furycli already installed!"
fi

if systemctl is-active --quiet docker; then
	echo "Docker is running!"
else
	systemctl start docker
fi

usermod -aG docker $USER

echo "[info] Ctrl+d OR write exit to deactivate the virtualenv"
bash -c ". .venv/bin/activate; exec /usr/bin/env bash"