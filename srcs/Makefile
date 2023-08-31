all:
	chmod +x ./requirements/tools/setup-ssl.sh ; bash ./requirements/tools/setup-ssl.sh
	mkdir -p /home/${USER}/data/wordpress ; chmod -R 777 /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mysql ; chmod -R 777 /home/${USER}/data/mysql
	docker-compose -f ./docker-compose.yml up -d

build:
	mkdir -p /home/${USER}/data/wordpress ; chmod 777 /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mariadb ; chmod 777 /home/${USER}/data/wordpress
	docker-compose -f ./docker-compose.yml up -d --build

down:
	docker-compose -f ./docker-compose.yml down

clean: down
	docker system prune -a -f

fclean:
	@./run.sh fclean

re: clean build

redo: fclean all


