all:
	mkdir -p /home/mobougri/data/mariadb
	mkdir -p /home/mobougri/data/wordpress
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

re: down all

clean:
	docker-compose -f srcs/docker-compose.yml down -v

fclean: clean
	docker system prune -af

.PHONY: all down re clean fclean
