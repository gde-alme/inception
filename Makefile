all:
	@clear
	@echo
	@echo "----------------------------- Inception ----------------------------"
	@echo
	@echo "\tSimple install\t\t->\tmake install"
	@echo "\tSetup ssl\t\t->\tmake ssl"
	@echo "\tSetup ssl & install\t->\tmake full-install"
	@echo "\tBuild containers\t->\tmake build"
	@echo "\tStop containers\t\t->\tmake down"
	@echo
	@echo "--------------------------------------------------------------------"
	@echo
	@echo

install:
	@clear
	@echo
	@echo
	@echo "----------------------------- Start install -----------------------------"
	@echo
	@echo
	mkdir -p /home/${USER}/data/wordpress ; chmod -R 777 /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/mysql ; chmod -R 777 /home/${USER}/data/mysql
	@echo
	docker-compose -f ./srcs/docker-compose.yml up -d
	@echo
	@echo
	@echo "----------------------------- End install -------------------------------"
	@echo
	@echo

ssl:
	chmod +x ./srcs/requirements/tools/setup-ssl.sh ; bash ./srcs/requirements/tools/setup-ssl.sh

full-install: ssl install

build:
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a -f

fclean:
	-rm -rf ./srcs/requirements/nginx/tools/*
	-docker stop $$(docker ps -qa)
	-docker system prune --all --force --volumes
	-docker network prune --force
	-docker volume prune --force
	-docker volume rm $$(docker volume ls -q | awk '{printf "%s ", $$0}')
	-sudo rm -rf /home/${USER}/data/

re: clean build

redo: fclean all


