NAME = inception

all: prune reload

linux:
	@ sudo echo "127.0.0.1 nhirzel.42.fr" >> /etc/hosts
	
stop:
	@ docker-compose -f srcs/docker-compose.yml down

clean: stop
	@ rm -rf ~/Desktop/data

im:
	@ docker system prune -f
	@ rm -rf ~/Desktop/data
	@ docker rmi -f $$(docker images -qa)

prune: clean
	@ docker system prune -f

reload: 
	@ sudo docker compose -f srcs/docker-compose.yml up --build

.PHONY: linux stop clean prune reload im all
