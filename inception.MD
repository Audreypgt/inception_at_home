1st step: 
- install Docker (check Docker documentation)
- start docker `sudo systemctl start docker`

2nd step: 
- write dockerfile for NGINX  
CMD: instruction to be executed everytime the RUN (meaning docker run I think) command is executed, only if no argument is passed with RUN, otherwise, it is overidden by the arguments
ex:
    ENTRYPOINT ["echo", "Hello from"]
    CMD ["Docker"]
        -->  Hello from Docker
    docker run myimage World
        --> Hello from World

- build the image : `docker build [path to folder with dockerfile]`  
   - you can use -t flag to name it `docker build -t [name] [path]`  
    - to check images: `docker image ls`  
    - to start the image: `docker run --name [name] [img_name]` (add -it flag before name to get the cont's terminal)  
        - (sudo docker run -it --name test nginx bash) idk why bash  
    - to check started conts: docker ps (to see stopped ones too, add -a flag)  
    - to delete all conts even stopped ones: `sudo docker container prune`  
    - if you modify your container after running it, use `nginx -s reload`
    - in case something does not work as expected, you may try to find out the reason in `access.log` and `error.log` files in the directory `/usr/local/nginx/logs` or `/var/log/nginx`
example:  
`sudo docker run -it --name mon_test nginx bash` (use exit when done)  
`sudo docker stop mon_test `  
`sudo docker rm mon_test `  

3nd step:
- dockerfile, .env/txt files, script and configuration file for mariadb

4th step:
- docker file, script and configuration file for wordpress

5th step:
- docker-compose file

6th step:
- link my local machine to my VM to access the wordpress website from outside the VM and change VM localhost IP to domain name
# Change your localhost IP to your domain name
    Go to file /etc/hosts
    Add following line : "127.0.0.1 domain_name"

7th step:
- makefile



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