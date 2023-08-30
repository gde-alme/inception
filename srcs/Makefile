all:
	@chmod +x ./requirements/tools/setup-ssl.sh ; bash ./requirements/tools/setup-ssl.sh
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	docker-compose -f ./docker-compose.yml up -d

build:
	@mkdir -p /home/$(USER)/data/wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	docker-compose -f ./docker-compose.yml up -d --build

down:
	docker-compose -f ./docker-compose.yml down

re: clean build

clean: down
	@rm -rf /home/$(USER)/data/
	@rm -rf ./requirements/nginx/tools/*
	docker system prune -a -f

fclean:
	docker stop $$(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
