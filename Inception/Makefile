start:
	@systemctl start docker

stop:
	@systemctl stop docker

check:
	@systemctl status docker

up:
	@docker compose -f ./srcs/docker-compose.yaml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yaml down

re:
	@docker compose -f ./srcs/docker-compose.yaml build --no-cache && docker compose -f ./srcs/docker-compose.yaml up -d --build

fclean:
	@cd ./srcs && docker compose down;\
 	docker system prune -a --volumes -f;\
	sudo rm -rf /home/apeuget42/data/mariadb/*\
	sudo rm -rf /home/apeuget42/data/wordpress/*;\

# 	ls home/apeuget42/data/;\
# 	rm home/apeuget42//data/wordpress/*;\ why isnt it working ???

.PHONY: all re down clean

deleted:
# 	docker stop $(docker ps -qa);\
# 	docker rm $(docker ps -qa);\
# 	docker rmi -f $(docker images -qa);\
# 	docker volume rm $(docker volume ls -q);\
# 	docker network rm $(docker network ls -q);\