Website:  
https://localhost:443/  
https://apeuget.42.fr/


# 1st step DOCKER: 
- install Docker (check Docker documentation)
- start docker `sudo systemctl start docker` or make start

# 2nd step NGINX: 
- write dockerfile for NGINX  
CMD: instruction to be executed everytime the RUN (meaning docker run I think) command is executed, only if no argument is passed with RUN, otherwise, it is overidden by the arguments
ex:
    ENTRYPOINT ["echo", "Hello from"]
    CMD ["Docker"]
        -->  Hello from Docker
    docker run myimage World
        --> Hello from World
- dockerfile, script and configuration file

# 3rd step MARIADB:
- docker file and configuration file
- .env and secret files

# 4th step WORDPRESS:
- docker file, script (to create wp-config.php, 2nd user and install theme) and skip the "famous 5 min installation process", www.conf (modify listen line to the correct port), theme (zip file)
#### Install a theme
- Download the theme files on your host machine, unzip it and take the folder inside it out and rezip this folder
- Add this zipped folder to your files (I put it in the tools folder of the container)
- COPY it to your container in the var/www/wordpress/wp-content/themes folder
- Add the correct commands to the bash configuration script (wp theme install) --> you need this command twice to dezip and install the theme and then to activate it

# As you go (when needed):
- docker-compose file
- change VM localhost IP to domain name
- docker secrets (optional)
#### Change your localhost IP to your domain name
- Go to file /etc/hosts
- Add following line : "127.0.0.1 domain_name"
- Also change the IP adress in /etc/resolv.cnf file to 8.8.8.8
#### Set up Docker secrets
- In docker-compose.yaml add a `secrets` variable to your service image in `services` and add only the variables your container needs 
- Create a `secrets` section at the end of your file and add all the variables with the path to each corresponding file
    - In your .txt file, you can either put the secret directly or format it as SECRET="secret"
- At the top of the file where you need your secret variables,
- Note that you don't need to declare a "env_file" variable in you service image in the services section

# Useful commands

- `docker-compose ps` to find docker conts in that docker compose environment
- `docker image ls` to check images
- `docker run --name [name] [img_name]` to start image
- `docker run -it --name nginx bash` to run a container
- `docker ps -a` to see started and stoppped conts
- `docker container prune` to delete all conts even stopped ones, see whole command in makefile
- `nginx -s reload` if you modify your container after running it or just docker compose up it again with make up
- `service --status-all` check all running services in a container (use docker exec -it to go inside the cont)

### Test Mariadb is correctly setup
check the DB:
- go into container `docker exec -it mariadb bash`
- `mariadb-check -A` (-A == all databases)
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

### Check if container restart policy is as written in compose file (yes the container can disobey you apparently)
`docker inspect cont_name --format="{{.HostConfig.RestartPolicy.Name}}"`

### Check container logs
Use `docker logs [cont name]`

## Notes on volumes:
They don't only allow you to copy your service's files from the container to the host, but also to allow your server to see your wordpress files, therefore, without our wordpress volume, nginx can't access the website's files and therefore we get a 404 error if we try opening it on a web browser


# Error handling:

### Error logs:
In case something does not work as expected, you might find out the reason in `access.log` and `error.log` files in the directory `/usr/local/cont_name/logs` or `/var/log/cont_name`

### Permission denied when make up:
https://www.hostinger.com/tutorials/how-to-fix-docker-permission-denied-error
Don't forget to reboot so changes take affect, use `id -nG` (target wordpress: failed to solve: process "/bin/sh -c apt-get update -y && apt-get install -y php php-mysql php-fpm wget && rm -rf /var/lib/apt/lists/*" did not complete successfully: exit code: 100 to check)
If you already added your user to docker group, try changing rights of ~/.docker folder from root to your user

**If it was working before, try executing your command in srcs without using make up (then you can just make clean and try make up again)**

### Network is unreachable:
"target mariadb: failed to solve: debian:bookworm: failed to resolve source metadata for docker.io/library/debian:bookworm: failed to do request: Head "https://registry-1.docker.io/v2/library/debian/manifests/bookworm": dial tcp [2600:1f18:2148:bc00:c80c:3676:30dd:a616]:443: connect: network is unreachable"  
-> change IP adress in file etc/resolv.conf to 8.8.8.8 (DNS) to prevent being blocked

### Problem with env variables:
Check they were correctly setup with:
- `echo $DB_NAME`
- `echo $DB_USER`
- `echo $DB_PASSWORD`
- `echo $DB_ROOT_PASSWORD`  

or in /run/secrets/ in your container if you're using docker secrets

### Check nginx sees wordpress files:
- get in the container with docker exec
- go to /var/www/html
- use `ls`
- if needed, check /var/log/nginx/error.log

### 502 bad gateway:
Nginx can't communicate with php or the upstream host or the docker container
How to fix it:
- i think the issue was that i didnt have a cmd or entrepoint command in my wordpress dockerfile, so i added this : CMD ["/usr/sbin/php-fpm8.2", "-F"] (this can be removed when the wp-config.php creation script is launched with entrypoint as the script has this command)
- could be that you refreshed the website too fast and the 5 sleep before the wordpress script starts hasn't ended yet

### Error establishing a database connection:
Error caused by a bad wp-config.php file or by a connection problem between wordpress and mariadb, in my case it was caused by a connection problem
In wordpress container's terminal:
- check if wordpress can communicate with mariadb: `ping mariadb`, if you get something, this means networking is fine and the containers can communicate, or skip this step if ping isn't available on the container and you don't want to install it
- check `nc -zv mariadb 3306` or `echo > /dev/tcp/mariadb/3306 && echo 'PORT OPEN' || echo 'PORT CLOSED'` if nc isn't available
In mariadb containers's terminal:
- check if mariadb (the database, the process, not the container) is running with `ps aux`
- here i modified the launch command for mariadb from `mysqld_safe` to `mysqld_safe &`, then ps aux again but nothing changed
- check the mariadb logs with docker logs (here i had this errors : mysqld_safe Logging to syslog.  mysqld_safe Starting mariadbd daemon with databases from /var/lib/mysql)
- check the rights on the /var/lib/mysql folder with `ls -la`, here my rights are okay, but i had a lot of .pid files from previous containers
- clean those pid files and check for a stale socket with `rm -f /var/lib/mysql/*.pid && rm -f /run/mysqld/mysqld.sock` and restart the container with docker restart
- if this didn't fix it, run mysql with logs going to the output `mysqld --user=mysql 2>&1 | head -50`
- try to find solutions according to the errors seen
- in my case, the problem is that the volume folder (data) on the local host is never cleaned even when containers are deleted --> I added the rm commands in my makefile for this
- after fixing the issues, check the previous steps (test port 3306, check the available processes in the mariadb container, check the error logs) and check the database connection from the mariadb container `mariadb -h mariadb -u user -p1234 mariadb`
- if you don't see anything that seems wrong, check the website

# Resources:

### Inception guide
- [Guide 42](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)

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

### Wordpress and wp-config
- [Config create usage](https://make.wordpress.org/cli/handbook/references/config/)
- [Config create usage](https://developer.wordpress.org/cli/commands/config/create/)
- [Core install usage](https://developer.wordpress.org/cli/commands/core/install/)
- [Theme install](https://developer.wordpress.org/cli/commands/theme/install/)
- [Tuto install wordpress and wp-cli](https://xtom.com/blog/how-to-install-wp-cli-on-debian-12-and-setup-a-new-wordpress-website-via-ssh/)
- [Tuto install wordpress and wp-cli](https://helpdocs.hostmyservers.fr/en/docs/cloud/linux/applications/wordpress-wpcli-install/)
- [Docker-compose up vs docker-compose run](https://stackoverflow.com/questions/33066528/should-i-use-docker-compose-up-or-run)

### Volumes
- [Local driver meaning](https://www.codestudy.net/blog/docker-compose-volumes-driver-local-meaning/)

### Network
- [Bridge explanation](https://www.nicelydev.com/docker/reseau-host-bridge)

### Secrets
- [How-to](https://blog.stephane-robert.info/docs/conteneurs/moteurs-conteneurs/docker/secrets/)

### Not used (retro websites)
git@github.com:Lmendev/CartoonNetwork-2000-Clone.git  
https://wordpress.com/theme/pixl?tab_filter=blog&tier_filter=free