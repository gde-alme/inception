all: init_setup
	mkdir -p /home/${USER}/data/wordpress ; chmod -R 777 /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mysql ; chmod -R 777 /home/${USER}/data/mysql
	docker-compose -f ./srcs/docker-compose.yml up -d

init_setup:
	chmod +x ./srcs/requirements/tools/setup-ssl.sh ; bash ./srcs/requirements/tools/setup-ssl.sh

build:
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a -f

fclean:
	rm -rf ./srcs/requirements/nginx/tools/*
	docker stop $$(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	docker volume rm $$(docker volume ls -q | awk '{printf "%s ", $$0}')
	sudo rm -rf /home/${USER}/data/

re: clean build

redo: fclean all


