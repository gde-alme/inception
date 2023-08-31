#!/bin/bash

if [ "${1}" == "fclean" ]; then
	rm -rf ./requirements/nginx/tools/*
	docker stop $(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	docker volume rm $(docker volume ls -q | awk '{printf "%s ", $0}')
	sudo rm -rf /home/${USER}/data/
fi
