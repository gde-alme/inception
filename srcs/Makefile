all:
	@mkdir -p /tmp/inception
	@./run.sh all


build:
	@mkdir -p /tmp/inception
	@./run.sh build

down:
	@./run.sh down

clean: down
	@./run.sh clean

fclean:
	@./run.sh fclean

re: clean build

redo: fclean all


