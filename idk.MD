TODO :
- understand better how to run an image, start/stop a cont, and how to not get the latest version of nginx automatically from my dockerfile
- shell script wordpress
- dockerfile for wordpress
- environments variables in docker compose for mariadb and wordpress
- final check .env file + check txt files
- docker network
- makefile


- refaire VM comme avant mais en cochant gnome quand on coche ce quon isntalle pour avoir interface graphique

docker-compose up (to run it) -d (to have it in the background)
docker-compose down
docker-compose ps to find docker conts in that docker compose environment

CMD: instruction to be executed everytime the RUN (meaning docker run I think) command is executed, only if no argument is passed with RUN, otherwise, it is overidden by the arguments
ex:
    ENTRYPOINT ["echo", "Hello from"]
    CMD ["Docker"]
        -->  Hello from Docker
    docker run myimage World
        --> Hello from World


setting up mariadb: https://oneuptime.com/blog/post/2026-01-16-docker-mysql-mariadb/view
git clone for website: https://github.com/Lmendev/CartoonNetwork-2000-Clone.git
git@github.com:Lmendev/CartoonNetwork-2000-Clone.git
https://wordpress.com/theme/pixl?tab_filter=blog&tier_filter=free
https://labex.io/questions/what-is-the-purpose-of-the-nginx-g-daemon-off-command-in--871954
https://github.com/ADILRAQ/Inception-42-cursus/blob/main/srcs/requirements/nginx/Dockerfile
https://nginx.org/en/docs/
https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671
https://www.nicelydev.com/docker/reseau-host-bridge
https://www.nicelydev.com/nginx/comprendre-nginx-conf
https://www.codestudy.net/blog/docker-compose-volumes-driver-local-meaning/

