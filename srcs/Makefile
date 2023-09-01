all:
	chmod +x ./requirements/tools/setup-ssl.sh ; bash ./requirements/tools/setup-ssl.sh
	mkdir -p /home/${USER}/data/wordpress ; chmod -R 777 /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mysql ; chmod -R 777 /home/${USER}/data/mysql
	docker-compose -f ./docker-compose.yml up -d

build:
	docker-compose -f ./docker-compose.yml up -d --build

down:
	docker-compose -f ./docker-compose.yml down

clean: down
	docker system prune -a -f

fclean:
	rm -rf ./requirements/nginx/tools/*
	docker stop $$(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	docker volume rm $$(docker volume ls -q | awk '{printf "%s ", $$0}')
	sudo rm -rf /home/${USER}/data/

re: clean build

redo: fclean all


