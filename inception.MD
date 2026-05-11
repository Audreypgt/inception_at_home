1st step: 
- install Docker (check Docker documentation)
- start docker `sudo systemctl start docker`

2nd step: 
- write dockerfile for NGINX 
- Build the image : `docker build [path to folder with dockerfile]`  
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
- dockerfile and .env file for mariadb and wordpress

4th step:
- docker-compose file

5th step:
- add cute website to our wordpress container

6th step:
- makefile

# Change your localhost IP to your domain name
    Go to file /etc/hosts
    Add following line : "127.0.0.1 domain_name"




# Resources:
- [Install Docker](https://docs.docker.com/engine/install/debian/#install-using-the-repository)
- [Certificate user info](https://www.ibm.com/docs/en/ibm-mq/7.5.0?topic=certificates-distinguished-names)
- [Write nginx config file](https://nginx.org/en/docs/beginners_guide.html#conf_structure)
