TODO :
create database
add website to wordpress files
.env file
environments var in docker compose for mariadb and wordpress

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

TO ADD TO Dockerfile for nginx:

RUN chmod 755 /var/www/wordpress
# giving us (root user) all rights needed on our wordpress folder
RUN chown -R www-data:www-data /var/www/wordpress
# chown -R: change a file/folder's owner and group rights recursively (R) for the given folder
# chown user:group to modify both at the same time
# user and group www-data are created by debian by default because the security convention is that a web server shouldn't run on root, this role and group are then created for that, which is a role priviledge only to run web pages, and restricted from anything else on the system (eg dl softwares, read psswds...)

CMD ["nginx", "-g", "daemon off;"]
# tells nginx to run in the foreground instead of the background like a daamon (whence the daemon off) to prevent it from exiting abruptly after turning it on


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

