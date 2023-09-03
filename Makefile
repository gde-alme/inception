all:
	@clear
	@echo
	@echo
	@echo "  III  N   N  CCC EEEEE PPPP  TTT  III  OOO  N   N "
	@echo "   I   NN  N C    E     P   P  T    I  O   O NN  N "
	@echo "   I   N N N C    EEE   PPPP   T    I  O   O N N N "
	@echo "   I   N  NN C    E     P      T    I  O   O N  NN "
	@echo "  III  N   N  CCC EEEEE P      T   III  OOO  N   N "
	@echo
	@echo
	@echo "Options:"
	@echo "1) Install"
	@echo "2) SSL"
	@echo "3) Full install - Default"
	@echo "4) Build"
	@echo "5) Stop"
	@echo "6) Purge"
	@echo "7) Quit"
	@echo
	@read choice; \
	case $$choice in \
		1) make install;; \
		2) make ssl;; \
		3) make full-install;; \
		5) make down;; \
		6) make purge;; \
		7) echo "Bye";; \
		*) echo "$(FAIL) $(WHITE)Invalid option$(RESET)";; \
	esac

install:
	@echo
	@mkdir -p /home/${USER}/data/wordpress ; chmod -R 777 /home/${USER}/data/wordpress
	@mkdir -p /home/${USER}/data/mysql ; chmod -R 777 /home/${USER}/data/mysql
	docker-compose -f ./srcs/docker-compose.yml up -d
	@echo

ssl:
	@echo
	@rm -rf ./srcs/requirements/nginx/tools/*
	@chmod +x ./srcs/requirements/tools/setup-ssl.sh
	@bash ./srcs/requirements/tools/setup-ssl.sh

build:
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -a -f

purge:
	-rm -rf ./srcs/requirements/nginx/tools/*
	-docker stop $$(docker ps -qa)
	-docker system prune --all --force --volumes
	-docker network prune --force
	-docker volume prune --force
	-docker volume rm $$(docker volume ls -q | awk '{printf "%s ", $$0}')
	-sudo rm -rf /home/${USER}/data/

full-install: ssl install

re: clean build

redo: purge all


