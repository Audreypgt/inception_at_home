TODO :
- run everything and after php is installed, modify config file
    - add lines: clear_env=no and listen=wordpress:9000
    - copy it from our files to the container's files just like for nginx.conf
- understand better how to run an image, start/stop a cont, and how to not get the latest version of nginx automatically from my dockerfile





sudo docker compose -f docker-compose.yaml up -d --build
