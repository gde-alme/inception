#!/bin/bash

clear


if [ "${1}" == "all" ]; then
	chmod +x ./requirements/tools/setup-ssl.sh ; bash ./requirements/tools/setup-ssl.sh
	mkdir -p /home/${USER}/data/wordpress ; chmod -R 777 /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mysql ; chmod -R 777 /home/${USER}/data/mysql
	docker-compose -f ./docker-compose.yml up -d

elif [ "${1}" == "build" ]; then
	mkdir -p /home/${USER}/data/wordpress ; chmod 777 /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mariadb ; chmod 777 /home/${USER}/data/wordpress
	docker-compose -f ./docker-compose.yml up -d --build

elif [ "${1}" == "down" ]; then
	docker-compose -f ./docker-compose.yml down

elif [ "${1}" == "clean" ]; then
	docker system prune -a -f

elif [ "${1}" == "fclean" ]; then
	rm -rf ./requirements/nginx/tools/*
	docker stop $(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	docker volume rm $(docker volume ls -q | awk '{printf "%s ", $0}')
	rm -rf /home/${USER}/data/

fi
