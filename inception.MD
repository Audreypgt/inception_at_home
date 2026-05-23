Website:
https://localhost:443/
https://apeuget.42.fr/


1st step DOCKER: 
- install Docker (check Docker documentation)
- start docker `sudo systemctl start docker` or make start

2nd step NGINX: 
- write dockerfile for NGINX  
CMD: instruction to be executed everytime the RUN (meaning docker run I think) command is executed, only if no argument is passed with RUN, otherwise, it is overidden by the arguments
ex:
    ENTRYPOINT ["echo", "Hello from"]
    CMD ["Docker"]
        -->  Hello from Docker
    docker run myimage World
        --> Hello from World
- dockerfile, script and configuration file

3rd step MARIADB:
- docker file and configuration file
- .env and secret files

4th step WORDPRESS:
- docker file, ...

As you go (when needed):
- docker-compose file
- change VM localhost IP to domain name
#### Change your localhost IP to your domain name
    Go to file /etc/hosts
    Add following line : "127.0.0.1 domain_name"
- change the IP adress in /etc/resolv.cnf file to 8.8.8.8
- makefile

# Useful commands

- `docker-compose ps` to find docker conts in that docker compose environment
- `docker image ls` to check images
- `docker run --name [name] [img_name]` to start image
- `docker run -it --name nginx bash` to run a container
- `docker ps -a` to see started and stoppped conts
- `docker container prune` to delete all conts even stopped ones
- `nginx -s reload` if you modify your container after running it or just docker compose up it again with make up

## Test Mariadb is correctly setup

mariadb-check -A
(-A == all databases)

check the DB:
- go into container `docker exec -it mariadb bash`
- check the DB is launched `mariadb-admin ping`
- log into DB `mariadb -u root -p`
- try these commands:
    - `SHOW DATABASES;`
    - `SELECT user, host FROM mysql.user;` (you should see the users we created and the % under host)
    - `SHOW GRANTS FOR 'db_user'@'%';`
- if this fails go back to your container and check your env variables were correctly set:
    - `echo $DB_NAME`
    - `echo $DB_USER`
    - `echo $DB_PASSWORD`
    - `echo $DB_ROOT_PASSWORD`

# Error fixes:

### Error logs:
In case something does not work as expected, you might find out the reason in `access.log` and `error.log` files in the directory `/usr/local/cont_name/logs` or `/var/log/cont_name`

### Permission denied when make up:
https://www.hostinger.com/tutorials/how-to-fix-docker-permission-denied-error
Don't forget to reboot so changes take affect, use `id -nG` (target wordpress: failed to solve: process "/bin/sh -c apt-get update -y && apt-get install -y php php-mysql php-fpm wget && rm -rf /var/lib/apt/lists/*" did not complete successfully: exit code: 100 to check)
If you already added your user to docker group, try changing rights of ~/.docker folder from root to your user

**If it was working before, try executing your command in srcs with using make up (then you can just make clean and try make up again)**

### Network is unreachable:
"target mariadb: failed to solve: debian:bookworm: failed to resolve source metadata for docker.io/library/debian:bookworm: failed to do request: Head "https://registry-1.docker.io/v2/library/debian/manifests/bookworm": dial tcp [2600:1f18:2148:bc00:c80c:3676:30dd:a616]:443: connect: network is unreachable"  
-> change IP adress in file etc/resolv.conf to 8.8.8.8 (DNS) to prevent being blocked

### Problem with env variables:
Check they were correctly setup with:
- `echo $DB_NAME`
- `echo $DB_USER`
- `echo $DB_PASSWORD`
- `echo $DB_ROOT_PASSWORD`


# Resources:

### Docker
- [Install Docker](https://docs.docker.com/engine/install/debian/#install-using-the-repository)

### Setting up mariadb
- [Setting up mariadb](https://oneuptime.com/blog/post/2026-01-16-docker-mysql-mariadb/view)

### Nginx
- [Certificate user info](https://www.ibm.com/docs/en/ibm-mq/7.5.0?topic=certificates-distinguished-names)
- [Write nginx config file](https://nginx.org/en/docs/beginners_guide.html#conf_structure)
- [Nginx daemon off](https://labex.io/questions/what-is-the-purpose-of-the-nginx-g-daemon-off-command-in--871954)
- [Nginx dockerfile example](https://github.com/ADILRAQ/Inception-42-cursus/blob/main/srcs/requirements/nginx/Dockerfile)
- [Understand nginx conf](https://www.nicelydev.com/nginx/comprendre-nginx-conf)
- [Doc](https://nginx.org/en/docs/)

### Inception guide
- [Guide 42](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)

### Network
- [Bridge explanation](https://www.nicelydev.com/docker/reseau-host-bridge)

### Volumes
- [Local driver meaning](https://www.codestudy.net/blog/docker-compose-volumes-driver-local-meaning/)

### Wordpress and wp-config
- [Config create usage](https://make.wordpress.org/cli/handbook/references/config/)
- [Config create usage](https://developer.wordpress.org/cli/commands/config/create/)
- [Core install usage](https://developer.wordpress.org/cli/commands/core/install/)
- [Tuto install wordpress and wp-cli](https://xtom.com/blog/how-to-install-wp-cli-on-debian-12-and-setup-a-new-wordpress-website-via-ssh/)
- [Tuto install wordpress and wp-cli](https://helpdocs.hostmyservers.fr/en/docs/cloud/linux/applications/wordpress-wpcli-install/)


### Not used (retro websites)
git@github.com:Lmendev/CartoonNetwork-2000-Clone.git  
https://wordpress.com/theme/pixl?tab_filter=blog&tier_filter=free